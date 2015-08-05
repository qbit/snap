VERSION=`awk -F= '/^version/ {print $2}' snap | cut -d= -f2`

PREFIX ?= /usr/local

help:
	@awk 'BEGIN{print "Usage\n====="} /^  -/ {print "*"$$0}' ./snap
	@echo
	@awk 'BEGIN{print ".snaprc options and defaults\n======="} /\(get_conf_var/ {gsub("\x27|\\)", "", $$0); print "* **"$$2"**: " "*"$$5"*"}' ./snap

sign:
	@sha256 snap > SHA256
	@signify -S -s ~/signify/snap.sec -m SHA256 -x SHA256.sig -c "signature from snap secret key"
	@cat SHA256 >> SHA256.sig

verify:
	@signify -C -p /etc/signify/snap.pub -x SHA256.sig snap

release:
	@git tag $(VERSION)
	@git push --tags

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 snap $(DESTDIR)$(PREFIX)/bin/snap

