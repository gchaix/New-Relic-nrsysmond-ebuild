# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_P="${P}-linux"
DESCRIPTION="New Relic sysmond"
HOMEPAGE="http://newrelic.com/docs/server/server-monitor-installation-other-linux"
SRC_URI="http://download.newrelic.com/server_monitor/release/${P}-linux.tar.gz"

LICENSE="Apache 2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# create daemon user
	enewuser newrelic -1 /bin/false /usr/local/newrelic/newrelic-sysmond/
}

src_install() {
	# daemon and config binaries
	exeinto /usr/local/newrelic/newrelic-sysmond
	doexe daemon/nrsysmond.x64 || die
	doexe scripts/nrsysmond-config || die
	dosym /usr/local/newrelic/newrelic-sysmond/nrsysmond.x64	/usr/bin/nrsysmond
	dosym /usr/local/newrelic/newrelic-sysmond/nrsysmond-config /usr/bin/nrsysmond-config
	
	# config file
	insinto /etc/newrelic
	newins nrsysmond.cfg nrsysmond.cfg || die

	# init
	newinitd "${FILESDIR}"/nrsysmond.initd nrsysmond

    # defaults (to set runas user)
    insinto /etc/default
    newins "${FILESFIR}"/newrelic-sysmond.defaults newrelic-sysmond

	# docs
	dodoc INSTALL.txt LICENSE.txt
}

pkg_postinst() {
	# Warnings and notes
	einfo "If you are using a grsec kernel, you will likely need to grant the newrelic
	user access to /proc by setting 'CONFIG_GRKERNSEC_PROC_GID' and adding the
	newrelic user to the appropriate group."
	einfo "Please run /usr/bin/nrsysmond-config to designate the log file path
	and enter your New Relic license key."
}
