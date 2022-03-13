# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/uroni/urbackup_backend.git"
WX_GTK_VER="3.0-gtk3"

inherit autotools git-r3 systemd wxwidgets

DESCRIPTION="Client Server backup system"
HOMEPAGE="https://urbackup.org"
SRC_URI=""

LICENSE="AGPL-3+"
KEYWORDS=""
SLOT="0"
IUSE="debug hardened nls X"

RDEPEND="acct-user/urbackup
	app-arch/zstd:=
	dev-db/sqlite:3
	dev-libs/crypto++:0=
	dev-libs/icu:0=
	sys-libs/zlib:0=
	X? ( x11-libs/wxGTK:${WX_GTK_VER}[X] )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	default

	# Prepare files for server build
	cp "${S}"/Makefile.am_client "${S}"/Makefile.am \
		|| die "cp failed for Makefile.am_server"
	cp "${S}"/configure.ac_client "${S}"/configure.ac \
		|| die "cp failed for configure.ac_server"

	# Remove key, version file for client autoupdate
	sed -i  -e '/\/client\/data\/urbackup_ecdsa409k1.pub/d' \
		-e 's|client/data/urbackup_ecdsa409k1.pub ||' \
		-e '/\/client\/version.txt/d' \
		-e 's|client/version.txt ||' \
		-e '/\/client\/info.txt/d' \
		-e 's|client/info.txt ||' \
		Makefile.am || die "sed failed for Makefile.am"

	eautoreconf
}

src_configure() {
	econf "$(usex hardened --enable-fortify "")" \
		"$(use_enable debug assertions)" \
		"$(use_enable !X headless)" \
		--without-embedded-sqlite3 \
		--disable-clientupdate
}

src_install() {
	default

	doman docs/urbackupclientbackend.1

	keepdir /var/lib/urbackup/data

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/urbackup-client.logrotate urbackup-client

	newinitd "${FILESDIR}"/urbackup-client.initd urbackup-client
	newconfd "${FILESDIR}"/urbackup-client.confd urbackup-client
	systemd_dounit "${FILESDIR}"/urbackup-client.service

	insinto /etc/urbackup
	doins "${FILESDIR}"/urbackup-client
}
