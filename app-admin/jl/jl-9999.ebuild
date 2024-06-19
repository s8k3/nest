# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/koenbollen/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="A tool for working with structured JSON logging"
HOMEPAGE="https://github.com/koenbollen/jl"

LICENSE="ISC"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin jl
}
