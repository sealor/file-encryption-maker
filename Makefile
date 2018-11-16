.PHONY: init clean_cache encrypt_all decrypt_all

init: encrypted-secret

encrypted-secret:
	@ssh-keygen -f key-pair
	@cat key-pair key-pair.pub > key-pair.pem
	@rm key-pair key-pair.pub
	@openssl rand -base64 128 | openssl rsautl -encrypt -inkey key-pair.pem | base64 > encrypted-secret

secret: encrypted-secret
	base64 -d $< | openssl rsautl -decrypt -inkey key-pair.pem -out $@

clean_cache:
	rm secret

ifeq ($(MAKECMDGOALS),$(filter %.crypt encrypt_all,$(MAKECMDGOALS)))
%.crypt: % secret
	openssl enc -e -aes-256-cbc -base64 -salt -pass file:secret -in $< -out $@
else
%: %.crypt secret
	openssl enc -d -aes-256-cbc -base64 -salt -pass file:secret -in $< -out $@
endif

encrypt_all: greeting.txt.crypt
decrypt_all: greeting.txt
