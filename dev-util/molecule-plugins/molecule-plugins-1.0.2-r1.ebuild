# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"
PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )

inherit python-r1

DESCRIPTION="A set fo base plugins for Molecule"
HOMEPAGE="http://www.sabayon.org"
SRC_URI="mirror://sabayon/${CATEGORY}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=dev-util/molecule-core-1.0.1 !<dev-util/molecule-1"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	net-misc/rsync
	sys-fs/squashfs-tools
	sys-process/lsof
	virtual/cdrtools"

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/lib" \
		PREFIX="/usr" SYSCONFDIR="/etc" install
}
