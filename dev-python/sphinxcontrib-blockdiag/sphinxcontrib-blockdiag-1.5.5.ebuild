# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_{4,5}} )

inherit distutils-r1

DESCRIPTION="A sphinx extension for embedding block diagrams using blockdiag"

HOMEPAGE="https://github.com/blockdiag/sphinxcontrib-blockdiag"

SRC_URI="https://github.com/blockdiag/${PN}/archive/${PV}.tar.gz -> ${PV}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

DEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
	>=dev-python/blockdiag-1.5.0[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_prepare_all() {
	sed -i -e /build-base/d setup.cfg || die
	distutils-r1_python_prepare_all
}
