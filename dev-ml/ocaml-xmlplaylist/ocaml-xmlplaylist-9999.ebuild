# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/savonet/${PN}.git"
EGIT_SUBMODULES=()

inherit autotools findlib git-r3

DESCRIPTION="OCaml module to parse various RSS playlist formats"
HOMEPAGE="https://github.com/savonet/ocaml-xmlplaylist"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+camlp4 debug +ocamlopt profiling"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	dev-ml/xmlm:=
	camlp4? ( dev-ml/camlp4:= )"
DEPEND="${RDEPEND}
	dev-ml/findlib"

DOCS=( CHANGES README )

src_prepare() {
	default

	m4/bootstrap || die "bootstrap failed"
	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "Failed editing m4/ocaml.m4!"
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf "$(use_enable camlp4)" \
		"$(use_enable debug debugging)" \
		"$(use_enable ocamlopt nativecode)" \
		"$(use_enable profiling)"
}

src_install() {
	einstalldocs
	findlib_src_install
}
