# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_{3,4,5}} pypy )

inherit distutils-r1

DESCRIPTION="Django test runner that uses nose"
HOMEPAGE="https://github.com/jbalogh/django-nose"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#RESTRICT="test"  # The testsuite currently broken See notes below

RDEPEND="
	>=dev-python/nose-1.2.1[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		>=dev-python/dj-database-url-0.3.0[${PYTHON_USEDEP}]
	)"

python_test() {
	./runtests.sh --verbose || die
}
