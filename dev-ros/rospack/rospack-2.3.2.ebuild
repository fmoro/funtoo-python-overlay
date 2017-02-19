# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

ROS_REPO_URI="https://github.com/ros/rospack"
KEYWORDS="~amd64 ~arm"

inherit ros-catkin

# Do it that way to avoid ros-catkin pulling in python-r1
PYTHON_COMPAT=( python{2_7,3_{4,5}} )
inherit python-single-r1

DESCRIPTION="Retrieves information about ROS packages available on the filesystem"
LICENSE="BSD"
SLOT="0"
IUSE=""
PATCHES=( "${FILESDIR}/gentoo.patch" )

RDEPEND="dev-libs/boost:=
	dev-libs/tinyxml
	"
DEPEND="${RDEPEND}
	dev-ros/cmake_modules
	test? (
		dev-cpp/gtest
		dev-python/nose
	)"
