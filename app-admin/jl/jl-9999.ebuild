# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/koenbollen/${PN}"
EGIT_REPO_URI="https://${EGO_PN}.git"

inherit git-r3 go-module

DESCRIPTION="A tool for working with structured JSON logging"
HOMEPAGE="https://github.com/koenbollen/jl"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git-r3_src_unpack
	mkdir "${S}"/vendor || die "mkdir failed"
	go-module_live_vendor
}

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin jl
}
