# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..6}} )

inherit distutils-r1 eutils

DESCRIPTION="Django REST framework"
HOMEPAGE="https://django-rest-framework.org/"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/coreapi[${PYTHON_USEDEP}]
		dev-python/django-guardian[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		virtual/python-typing[${PYTHON_USEDEP}] )"

python_test() {
	./runtests.py -v --nolint || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with Core API" dev-python/coreapi
	optfeature "integration with Core API schema generation" dev-python/coreschema
	optfeature "integration with filtering backend" dev-python/django-filter
	optfeature "integration with permission backend" dev-python/django-guardian
	optfeature "support for markdown syntax" dev-python/markdown
	optfeature "support for PostgreSQL" dev-python/psycopg:2
}
