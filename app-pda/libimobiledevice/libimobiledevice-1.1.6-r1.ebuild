# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit multilib python-single-r1

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

# While COPYING* doesn't mention 'or any later version', all the headers do, hence use +
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/4" # based on SONAME of libimobiledevice.so
KEYWORDS="*"
IUSE="gnutls python static-libs"

RDEPEND=">=app-pda/libplist-1.11
	>=app-pda/libusbmuxd-1.0.9
	gnutls? (
	dev-libs/libgcrypt:0
	>=dev-libs/libtasn1-1.1
	>=net-libs/gnutls-2.2.0
)
   !gnutls? ( dev-libs/openssl:0 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? ( ${PYTHON_DEPS} >=dev-python/cython-0.17[${PYTHON_USEDEP}] )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DOCS=( AUTHORS NEWS README )

pkg_setup() {
	# Prevent linking to the installed copy
	if has_version "<${CATEGORY}/${P}"; then
		rm -f "${EROOT}"/usr/$(get_libdir)/${PN}$(get_libname)
	fi
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use gnutls && myeconfargs+=( --disable-openssl )
	use python || myeconfargs+=( --without-cython )
	econf "${myeconfargs[@]}"
}

src_compile() {
	emake -j1
}

src_install() {
	default
	dohtml docs/html/*

	if use python; then
		insinto /usr/include/${PN}/cython
		doins cython/imobiledevice.pxd
	fi
}