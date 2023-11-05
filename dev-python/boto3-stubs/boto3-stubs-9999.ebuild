# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/youtype/mypy_boto3_builder.git"

inherit distutils-r1 git-r3

DESCRIPTION="Type annotations for boto3"
HOMEPAGE="https://github.com/youtype/mypy_boto3_builder"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/botocore-stubs[${PYTHON_USEDEP}]
	dev-python/types-s3transfer[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
