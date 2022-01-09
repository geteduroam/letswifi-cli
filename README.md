# Let's Wifi client scripts

This is a simple CLI for administrating the [Let's Wi-Fi server](https://github.com/letswifi/letswifi-portal).
It will currently not work with the geteduroam Let's Wi-Fi server.

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

#### ./letswifi user list

Returns a list of all users that currently have valid certificates.

#### ./letswifi user get --user=USERNAME

Returns a list of certificates for this user.

#### ./letswifi ca index --ca=SUBJECT

Get the CA index.txt file, which can be used to generate a CRL, or run a local OCSP responder.

#### ./letswifi ca revoke --user=USERNAME

Revoke ALL certificates for USERNAME.

#### ./letswifi ca revoke --subject=SUBJECT

Remove the certificate with the given SUBJECT.
