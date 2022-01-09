# CRL

Make sure that `ca.pem` and `key.pem` are in the current directory.
You'll have to grab these from the database, the API won't give you the key.

We will test the certificate `testcert.pem`

	make crl.pem
	cat ca.pem crl.pem >chain.pem
	openssl verify -CAfile chain.pem -crl_check testcert.pem

Or, slightly shorter, but identical result

	make chain.pem
	openssl verify -CAfile chain.pem -crl_check testcert.pem
