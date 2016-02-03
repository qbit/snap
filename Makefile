PREFIX ?= /usr/local

help:
	@awk 'BEGIN{print "Usage\n====="} /^  -/ {print "*"$$0}' ./snap
	@echo
	@awk 'BEGIN{print ".snaprc options and defaults\n======="} /\(get_conf_var/ {gsub("\x27|\\)", "", $$0); print "* **"$$2"**: " "*"$$5"*"}' ./snap

sign:
	@sha256 snap > SHA256
	@signify -S -s ~/signify/snap.sec -m SHA256 -x SHA256.sig
	@cat SHA256 >> SHA256.sig

verify:
	@signify -C -p /etc/signify/snap.pub -x SHA256.sig snap

bump:
	@vi ./snap

release: bump sign
	VERSION=$$(awk -F= '/^version/ {print $$2}' snap); \
	git add snap SHA256 SHA256.sig; \
	git commit -m '$${VERSION}'; \
	git tag $${VERSION}; \
	git push --tags

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 snap $(DESTDIR)$(PREFIX)/bin/snap

