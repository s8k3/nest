# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A sensible starting Prelude template"
HOMEPAGE="https://github.com/protolude/protolude"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/async:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/mtl-compat:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	default

	sed -i '/license-file/d' protolude.cabal \
		|| die "sed failed"
}
