# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="New Relic sysmond"
HOMEPAGE="http://newrelic.com/docs/server/server-monitor-installation-other-linux"
SRC_URI="http://download.newrelic.com/server_monitor/release/newrelic-sysmond-1.1.0.114-linux.tar.gz"

LICENSE="Apache 2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	local docs="INSTALL.txt"
	insinto /usr/local/newrelic/newrelic-sysmond
	doexe nrsysmond.x64
	doexe nrsysmond-config
	dosym /usr/local/newrelic/newrelic-sysmond/daemon/nrsysmond.x64	/usr/bin/nrsysmond
	dosym /usr/local/newrelic/newrelic-sysmond/scripts/nrsysmond-config /usr/bin/nrsysmond-config
	dodoc -r $(docs}
}
