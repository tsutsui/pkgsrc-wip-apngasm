# $NetBSD$

DISTNAME=	apngasm-3.1.6
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=apngasm/}
GITHUB_PROJECT=	${DISTNAME:S/-${PKGVERSION_NOREV}//}
GITHUB_TAG=	${PKGVERSION_NOREV}

MAINTAINER=	tsutsui@NetBSD.org
HOMEPAGE=	https://github.com/apngasm/apngasm
COMMENT=	APNG Aseembler
LICENSE=	zlib AND png-license

USE_LANGUAGES=	c c++
USE_TOOLS+=	cmake
WRKSRC=		${WRKDIR}/${DISTNAME}/build

INSTALLATION_DIRS+=	bin lib ${PKGMANDIR}/man1

.include "../../mk/bsd.prefs.mk"

do-configure:
	${MKDIR} ${WRKSRC}
	cd ${WRKSRC} && ${CMAKE} ..

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/cli/apngasm ${DESTDIR}${PREFIX}/bin
	${INSTALL_LIB} ${WRKSRC}/lib/libapngasm.so ${DESTDIR}${PREFIX}/lib
	${INSTALL_MAN} ${WRKSRC}/../docs/man/apngasm.1 \
	    ${DESTDIR}${PREFIX}/${PKGMANDIR}/man1

.include "../../graphics/png/buildlink3.mk"
.include "../../devel/boost-libs/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
