COMMENT=	OpenBSD upgrade tool
CATEGORIES=	sysutils

VERSION=	1.1.3
REVISION=	0
NO_BUILD=	Yes
PKG_ARCH=	*
PKGNAME=	snap-${VERSION}

GH_ACCOUNT=	qbit
GH_PROJECT=	snap
GH_TAGNAME=	${VERSION}

PERMIT_PACKAGE_CDROM=	Yes

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/snap ${PREFIX}/bin/snap
	${INSTALL_MAN} ${WRKSRC}/snap.8 ${PREFIX}/man/man8/snap.8

.include <bsd.port.mk>
