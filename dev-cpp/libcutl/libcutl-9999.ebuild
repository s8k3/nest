# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://git.codesynthesis.com/${PN}/${PN}.git"

inherit git-r3 multiprocessing toolchain-funcs

DESCRIPTION="A collection of C++ libraries (successor of libcult)"
HOMEPAGE="https://www.codesynthesis.com/projects/libcutl"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

BDEPEND="dev-util/build2"

PATCHES=( "${FILESDIR}/${PN}"-1.10.0-fix-c++14.patch )

src_configure() {
	local myconfigargs=(
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.bin.ar="$(tc-getAR)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.bin.lib="$(usex static-libs both shared)"
		config.install.root="${ED}/usr/"
		config.install.lib="exec_root/$(get_libdir)"
		config.install.doc="data_root/share/doc/${PF}"
	)

	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake "${myconfigargs[@]}" configure
}

src_compile() {
	tc-is-gcc && export CCACHE_DISABLE=1
	set -- b --jobs "$(makeopts_jobs)" --verbose 3 || die "set failed"
	echo "${@}" || die "echo failed"
	"${@}" || die "b failed"
}

src_test() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs)" emake test
}

src_install() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" emake install
	einstalldocs
}
