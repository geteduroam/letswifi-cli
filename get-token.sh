#!/bin/sh
set -e
. "$(dirname "$0")/letswifi.conf"

SCOPE="$1"
if ! printf %s "$SCOPE" | egrep -q '[a-z][-a-z]+'
then
	echo "Usage:" >&2
	echo "  $0 scope" >&2
	echo >&2
	exit 2
fi

getJson() { # $1 = key
	if jq --version >/dev/null 2>&1
	then
		jq ".$1" | jq --raw-output 'select(type == "string")'
	elif json_pp -v >/dev/null 2>&1
	then
		# This is not a reliable JSON parser, we still get JSON escaped strings,
		# and multiline would fail horribly.
		# But it's good enough for our use.
		json_pp | grep --fixed-strings "   \"${1}\" : " | cut -d\" -f4- | sed -e's/",\{0,1\}$//'
	fi
}

case $method in
	api)
		data="$(curl -sS \
			--data grant_type=client_credentials \
			--data-urlencode "client_id=$client_id" \
			--data-urlencode "client_secret=$client_secret" \
			--data-urlencode "scope=$SCOPE" \
			"$base_url/oauth/token/")"
		if test -n "$(printf %s "$data" | getJson error)"
		then
			printf \#\ %s\\n "$base_url/oauth/token/" >&2
			formatter=cat
			command -v json_pp >/dev/null && formatter=json_pp
			command -v jq >/dev/null && formatter=jq
			printf %s\\n "$data" | $formatter >&2
			exit 1
		fi
		access_token="$(printf %s "$data" | getJson access_token)"
		;;
	*)
		echo Unknown connection method provided>&2
		exit 2
		;;
esac

printf %s\\n "$access_token"
