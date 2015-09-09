# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/raspberrypi"
CROS_WORKON_PROJECT="linux"
CROS_WORKON_EGIT_BRANCH="rpi-4.2.y"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="7acc822215"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git-2 cros-kernel2 cros-workon

DESCRIPTION="Chrome OS Kernel-raspberrypi"
KEYWORDS="arm"
KERNEL="kernel7"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_install() {
	cros-kernel2_src_install

	insinto /boot
	doins "${FILESDIR}"/{cmdline,config}.txt
}
