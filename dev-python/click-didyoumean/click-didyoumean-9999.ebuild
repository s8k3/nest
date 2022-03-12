# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/click-contrib/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Enable git-like did-you-mean feature in click"
HOMEPAGE="https://github.com/click-contrib/click-didyoumean"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
