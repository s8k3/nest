# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/domanchi/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Train a model, and detect gibberish strings with it"
HOMEPAGE="https://github.com/domanchi/gibberish-detector"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest
