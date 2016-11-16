# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=(python{2_7,3_{4,5}})

inherit distutils-r1

DESCRIPTION="Simple command line utility to interact with your jira instance"
HOMEPAGE="https://github.com/alisaifee/jira-cli"
SRC_URI="https://github.com/alisaifee/jira-cli/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

CDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/jira[${PYTHON_USEDEP}]
	dev-python/suds[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]"

DEPEND="${CDEPEND}
	test? (	${RDEPEND}
		>=dev-python/coverage-4.0.3[${PYTHON_USEDEP}]
		dev-python/hiro[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		>=dev-python/vcrpy-1.7.4[${PYTHON_USEDEP}] )"

RESTRICT="test"

python_test() {
	nosetests || die
}
