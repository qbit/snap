#	$OpenBSD$

PREFIX ?=	/usr/local
SCRIPT =	snap
MAN =		snap.8
MANDIR ?=	${PREFIX}/man/man

README.md:
	mandoc -T lint snap.8
	mandoc -T markdown snap.8 >$@

snap.8:
	mandoc -T lint snap.8
	mandoc -T ascii snap.8 >$@

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

realinstall:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 snap $(DESTDIR)$(PREFIX)/bin/snap

.include <bsd.prog.mk>
