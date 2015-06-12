VERSION=`awk -F= '/^version/ {print $2}' snap | cut -d= -f2`

PREFIX ?= /usr/local

help:
	@awk 'BEGIN{print "Usage\n====="} /^  -/ {print "*"$$0}' ./snap
	@echo
	@awk 'BEGIN{print ".snaprc options and defaults\n======="} /\(get_conf_var/ {gsub("\x27|\\)", "", $$0); print "* **"$$2"**: " "*"$$5"*"}' ./snap

release:
	@git tag $(VERSION)
	@git push --tags

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 snap $(DESTDIR)$(PREFIX)/bin/snap

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/snap
