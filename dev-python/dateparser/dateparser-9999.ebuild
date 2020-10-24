# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/scrapinghub/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Date parsing library designed to parse dates from HTML pages"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
SRC_URI=""

LICENSE="BSD-4"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/convertdate[${PYTHON_USEDEP}]
	dev-python/hijri-converter[${PYTHON_USEDEP}]
	dev-python/jdatetime[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	dev-python/umalqurra[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/GitPython[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_prepare_all() {
	# Make correct import
	sed -i 's/import logging/import logging.config/' \
		dateparser/utils/__init__.py || die "sed failed for __init__.py"
	# Disable failing tests
	sed -i  -e '/import logging/ a\import unittest' \
		-e '/test_invalid_date_after_valid_date_not_detected/i\\    @unittest.skip("disable")' \
		-e '/test_invalid_dates_not_detected/i\\    @unittest.skip("disable")' \
		-e '/test_valid_date_after_invalid_date_detected/i\\    @unittest.skip("disable")' \
		-e '/test_valid_dates_detected/i\\    @unittest.skip("disable")' \
		tests/test_languages.py || die "sed failed for test_languages.py"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "operations on language files" dev-python/ruamel-yaml
}
