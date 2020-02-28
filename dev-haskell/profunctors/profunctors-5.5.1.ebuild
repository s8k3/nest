# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Profunctors"
HOMEPAGE="https://github.com/ekmett/profunctors"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-orphans-0.4:=[profile?]
	>=dev-haskell/bifunctors-5.2:=[profile?]
	>=dev-haskell/comonad-4:=[profile?]
	>=dev-haskell/contravariant-1:=[profile?]
	>=dev-haskell/distributive-0.4.4:=[profile?]
	>=dev-haskell/semigroups-0.11:=[profile?]
	>=dev-haskell/tagged-0.4.4:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"