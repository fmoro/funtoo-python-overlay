# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

SRC_URI="https://github.com/qtile/qtile/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="A pure-Python tiling window manager."
HOMEPAGE="http://www.qtile.org/"

LICENSE="MIT"
SLOT="0"
IUSE="dbus widget-google-calendar widget-imap widget-launchbar widget-mpd widget-mpris widget-wlan widget-keyboardkbdd"

REQUIRED_USE="widget-mpris? ( dbus )
	widget-keyboardkbdd? ( dbus )
	widget-google-calendar? ( python_targets_python2_7 )
	widget-wlan? ( python_targets_python2_7 )
"

RDEPEND="x11-libs/cairo[xcb] x11-libs/pango
	$(python_gen_cond_dep 'dev-python/asyncio[${PYTHON_USEDEP}]' 'python3_3')
	$(python_gen_cond_dep 'dev-python/trollius[${PYTHON_USEDEP}]' 'python2*')
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/xcffib-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/cairocffi-0.7[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.1[${PYTHON_USEDEP}]
	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		>=dev-python/pygobject-3.4.2-r1000[${PYTHON_USEDEP}]
	)
	widget-google-calendar? (
		dev-python/httplib2[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/oauth2client[$PYTHON_USEDEP]
		dev-python/google-api-python-client[python_targets_python2_7]
	)
	widget-imap? ( dev-python/keyring[${PYTHON_USEDEP}] )
	widget-launchbar? ( dev-python/pyxdg[${PYTHON_USEDEP}] )
	widget-mpd? ( dev-python/python-mpd[${PYTHON_USEDEP}] )
	widget-wlan? ( net-wireless/python-wifi[python_targets_python2_7] )
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DOCS=( CHANGELOG README.rst )

src_prepare() {
	if ! use dbus ; then
		(
			sed -i '/self.setup_python_dbus()/d' libqtile/manager.py
		)
	fi
	if ! use widget-google-calendar ; then
		(
			sed -i '/safe_import(".google_calendar", "GoogleCalendar")/d' libqtile/widget/__init__.py
			rm libqtile/widget/google_calendar.py*
		)
	fi
	if ! use widget-imap ; then
		(
			sed -i '/safe_import(".imapwidget", "ImapWidget")/d' libqtile/widget/__init__.py
			rm libqtile/widget/imapwidget.py*
		)
	fi
	if ! use widget-launchbar ; then
		(
			sed -i '/safe_import(".launchbar", "LaunchBar")/d' libqtile/widget/__init__.py
			rm libqtile/widget/launchbar.py*
		)
	fi
	if ! use widget-mpd ; then
		(
			sed -i '/safe_import(".mpdwidget", "Mpd")/d' libqtile/widget/__init__.py
			rm libqtile/widget/mpdwidget.py*
		)
	fi
	if ! use widget-wlan ; then
		(
			sed -i '/safe_import(".wlan", "Wlan")/d' libqtile/widget/__init__.py
			rm libqtile/widget/wlan.py*
		)
	fi
	if ! use widget-mpris ; then
		(
			sed -i '/safe_import(".mpriswidget", "Mpris")/d' libqtile/widget/__init__.py
			sed -i '/safe_import(".mpris2widget", "Mpris2")/d' libqtile/widget/__init__.py
			rm libqtile/widget/mpriswidget.py*
			rm libqtile/widget/mpris2widget.py*
		)
	fi
	if ! use widget-keyboardkbdd ; then
		(
			sed -i '/safe_import(".keyboardkbdd", "KeyboardKbdd")/d' libqtile/widget/__init__.py
			rm libqtile/widget/keyboardkbdd.py
		)
	fi
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /usr/share/xsessions
	doins resources/qtile.desktop

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}
}

pkg_postinst() {
	ewarn "!!! Config breakage !!!"
	ewarn "    - various deprecated commands have been removed:"
	ewarn "        Screen.cmd_nextgroup: use cmd_next_group"
	ewarn "        Screen.cmd_prevgroup: use cmd_prev_group"
	ewarn "        Qtile.cmd_nextlayout: use cmd_next_layout"
	ewarn "        Qtile.cmd_prevlayout: use cmd_prev_layout"
	ewarn "        Qtile.cmd_to_next_screen: use cmd_next_screen"
	ewarn "        Qtile.cmd_to_prev_screen: use cmd_prev_screen"
	ewarn "    - Clock widget: remove fmt kwarg, use format kwarg"
	ewarn "    - GmailChecker widget: remove settings parameter"
	ewarn "    - Maildir widget: remove maildirPath, subFolders, and separator kwargs"
}
