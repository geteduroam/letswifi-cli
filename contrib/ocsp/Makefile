run-ocsp: ocsp-key.pem ocsp-cert.pem index.txt
	openssl ocsp -port 127.0.0.1:2560 -text -sha256 \
		-index index.txt \
		-CA ca.pem \
		-rkey ocsp-key.pem \
		-rsigner ocsp-cert.pem
.PHONY: run-ocsp

ocsp-key.pem:
	echo 'Copy ocsp-key.pem in from another location'
	-false
ocsp-cert.pem:
	echo 'Copy ocsp-cert.pem in from another location'
	-false

index.txt: ../../letswifi.conf
	../../letswifi ca index --ca="CN=example.com Let's Wi-Fi CA" >indexnew.txt
	mv indexnew.txt index.txt

clean:
	rm -f index.txt indexnew.txt
.PHONY: clean
