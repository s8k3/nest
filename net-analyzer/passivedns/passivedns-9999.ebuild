# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 systemd user

DESCRIPTION="Network sniffer that logs all DNS server replies"
HOMEPAGE="https://github.com/gamelinux/passivedns"
EGIT_REPO_URI="https://github.com/gamelinux/${PN}.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug json libressl ssl systemd" #pfring
DOCS=( doc/AUTHORS doc/ChangeLog doc/How-it-works.txt doc/ISSUES )

RDEPEND="net-libs/ldns[ssl?]
	net-libs/libpcap
	json? ( dev-libs/jansson )
	ssl? (
		libressl? ( dev-libs/libressl )
		!libressl? ( dev-libs/openssl:0= )
	)"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_prepare() {
	default

	# Respect CFLAGS
	sed -i '/$(CC)/s/-O3/$(CFLAGS)/' src/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable json)
		#$(use_enable pfring )
}

src_install() {
	default

	use systemd || newinitd "${FILESDIR}"/${PN}.initd ${PN}
	use systemd || newconfd "${FILESDIR}"/${PN}.confd ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/${PN}.service
}
