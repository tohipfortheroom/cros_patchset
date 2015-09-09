# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2
# Copyright 1999-2015 Gentoo Foundation (media-libs/raspberrpi-userland)

EAPI=4

CROS_WORKON_REPO="git://github.com/raspberrypi"
CROS_WORKON_PROJECT="userland"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="fb11b39d97371c076eef7c85bbcab5733883a41e"

inherit git-2 cros-workon cmake-utils

DESCRIPTION="OpenGLES libraries for Raspberry Pi"
LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="!x11-drivers/opengles-bin"

src_unpack() {
	cros-workon_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/piglit.patch"
}

src_configure() {
	tc-export CC CXX LD AR RANLIB NM
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	pushd build/lib
	dolib.so libEGL.so libGLESv2.so
	dolib.so libbcm_host.so libvchiq_arm.so libvcos.so libcontainers.so
	popd

	dosym libEGL.so /usr/lib/libEGL.so.1
	dosym libGLESv2.so /usr/lib/libGLESv2.so.2

	insinto /usr/share/pkgconfig
	doins "${FILESDIR}/egl.pc"
	doins "${FILESDIR}/glesv2.pc"
	doins "${FILESDIR}/bcm_host.pc"

	dosym ../../opt/vc/include/EGL    /usr/include/EGL
	dosym ../../opt/vc/include/GLES   /usr/include/GLES
	dosym ../../opt/vc/include/KHR    /usr/include/KHR
	dosym ../../opt/vc/include/interface  /usr/include/interface
	dosym ../../opt/vc/include/vcinclude  /usr/include/vcinclude
	dosym ../../opt/vc/include/bcm_host.h /usr/include/bcm_host.h

	dosym pthreads/vcos_futex_mutex.h    /opt/vc/include/interface/vcos/vcos_futex_mutex.h 
	dosym pthreads/vcos_platform.h       /opt/vc/include/interface/vcos/vcos_platform.h
	dosym pthreads/vcos_platform_types.h /opt/vc/include/interface/vcos/vcos_platform_types.h
}

