# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/raspberrypi"
CROS_WORKON_PROJECT="linux"
CROS_WORKON_EGIT_BRANCH="rpi-4.4.y"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="7e5b687579186e1769f6264e40df1ad5832b37f0y"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git-2 cros-kernel2 cros-workon

DESCRIPTION="Chrome OS Kernel-raspberrypi2"
KEYWORDS="arm"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_install() {
	cros-kernel2_src_install
	"${D}/../work/raspberrypi-kernel/scripts/mkknlimg" \
                "$(cros-workon_get_build_dir)/arch/arm/boot/zImage" \
                "${T}/kernel.img"

	insinto /firmware/rpi
	doins "${FILESDIR}"/{cmdline,config}.txt
	doins "${T}/kernel.img"
	doins "$(cros-workon_get_build_dir)/arch/arm/boot/dts/bcm2709-rpi-2-b.dtb"
	doins -r "$(cros-workon_get_build_dir)/arch/arm/boot/dts/overlays"
}
