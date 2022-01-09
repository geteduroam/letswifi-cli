# OCSP

Get a server certificate from the CA, and store it as `ocsp-cert.pem` and `ocsp-key.pem`, and start the OCSP server:

On one terminal

	make start-ocsp

In another terminal, you can test a certificate named `testcert.pem`, you will also need the CA certificate (but not the key) in `ca.pem`.

	openssl ocsp -sha256 -CAfile ca.pem -url http://127.0.0.1:2560 -resp_text -issuer ca.pem -cert testcert.pem

To refresh the OCSP server, run

	make -B index.txt
