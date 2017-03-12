# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="An unit tests in Python to test actual state of servers"
HOMEPAGE="https://github.com/philpep/${PN} http://${PN}.readthedocs.io/en/latest/"
SRC_URI="https://github.com/philpep/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ansible docker paramiko salt ssh"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	ansible? ( app-admin/ansible )
	docker? ( app-emulation/docker )
	paramiko? ( dev-python/paramiko[${PYTHON_USEDEP}] )
	salt? ( app-admin/salt )
	ssh? ( virtual/ssh )"

DEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
