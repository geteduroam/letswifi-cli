crl.pem: ca.pem key.pem index.txt
	openssl ca -config openssl.cnf -gencrl -out crl.pem

chain.pem: ca.pem crl.pem
	cat ca.pem crl.pem >chain.pem

index.txt: ../../letswifi.conf
	../../letswifi ca index --ca="CN=example.com Let's Wi-Fi CA" >indexnew.txt
	mv indexnew.txt index.txt

clean:
	rm -f crl.pem chain.pem index.txt indexnew.txt
.PHONY: clean
