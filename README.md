# Let's Wifi client scripts

This is a simple CLI for administrating the [geteduroam](https://github.com/letswifi/letswifi-portal).
This client is still a work in progress!

Instead, for now, make modifications directly to the database.

## Configure the server

In the server, you must update `etc/letswifi.conf.php` and add the client.
Change the `clientSecret`

	[
		'clientId' => 'eu.letswifi.cli', 
		'redirectUris' => [], 
		'scopes' => ['admin-ca-index', 'admin-ca-revoke', 'admin-user-list', 'admin-user-get'],
		'refresh' => false,
		'clientSecret' => '"s3cret'
	],

## Configure the client

Copy `letswifi.conf.dist-api` to `letswifi.conf` and update the `base_url` and the `client_secret`.

## The CLI

All commands to through the `./letswifi` command.  It will request an OAuth token from the server,
and use that to do the actual request.

### Realms

If your Let's WiFi instance has more than one realm, it will use the realm from the hostname if vhosts are being used.

Otherwise, you can set the realm by adding `--realm=example.com` after the command.

### Commands

The global `--raw` flag prevents pretty-printing of the JSON reply using [`jq`](https://stedolan.github.io/jq/).
Some data is omitted for pretty-printing, so if you want to see the raw response
as returned by the server, use `--raw`.  The flag is implicit if `jq` is not available.

#### `./letswifi [ --raw ] user list`

Returns a list of all users that currently have valid certificates.

#### `./letswifi [ --raw ] user get --user=USERNAME`

Returns a list of certificates for this user.

#### `./letswifi [ --raw ] user get --subject=SUBJECT`

Get a single certificate, this will also show the USERNAME that owns this certificate.

#### `./letswifi ca index --ca=SUBJECT`

Get the CA index.txt file, which can be used to generate a CRL, or run a local OCSP responder.

Since the payload is not JSON, `--raw` will not have any effect.

#### `./letswifi ca revoke --user=USERNAME`

Revoke ALL certificates for USERNAME.

#### `./letswifi [ --raw ] ca revoke --subject=SUBJECT`

Remove the certificate with the given SUBJECT.
