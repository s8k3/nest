# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Implicit definitions for Hasql"
HOMEPAGE="https://github.com/nikita-volkov/hasql-implicits"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/hasql:=[profile?]
	dev-haskell/network-ip:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/uuid:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	default

	sed -i '/license-file/d' hasql-implicits.cabal \
		|| die "sed failed"
}
