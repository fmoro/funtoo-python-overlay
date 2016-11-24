# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_{6,7},3_{1,2,3,4,5}} )

inherit distutils-r1

DESCRIPTION="Novel evolutionary computation framework"
HOMEPAGE="https://github.com/deap/deap"
SRC_URI="https://github.com/DEAP/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools"
