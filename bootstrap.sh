#!/bin/sh
# Bootstrap script for Agnes OS

# Root directory of Agne's project sources:
AGNES_ROOT="$( cd -- "$(dirname "$0")" > /dev/null 2>&1 ; pwd -P)"
VENDOR_ROOT="${AGNES_ROOT}/vendor"
BMAKE_ROOT="${VENDOR_ROOT}/bmake"
BUILD_ROOT="${AGNES_ROOT}/.build"
VENDOR_PREFIX="${BUILD_ROOT}/usr"
VENDOR_BINDIR="${VENDOR_PREFIX}/bin"
BMAKE_FLAGS="-m ${VENDOR_PREFIX}/share/mk"

# Build path (PATH)
PATH="${BUILD_ROOT}/usr/bin:${PATH}"

# compiler toolchain related things:
export CC=clang

create_builder () {
	cd ${AGNES_ROOT}
	cat > build <<- EOF
		BMAKE_FLAGS="${BMAKE_FLAGS}"
		PATH="${PATH}"
		bmake \${BMAKE_FLAGS} \$1
	EOF

	chmod +x build
}

build_bmake () {
	cd ${BMAKE_ROOT} \
	&& sh ./configure --prefix=${VENDOR_PREFIX} \
	&& sh ./make-bootstrap.sh
	chmod +x ./bmake \
	&& make install clean
	# Using ./bmake here will likely fail.

	ln -sv ${VENDOR_BINDIR}/bmake ${VENDOR_BINDIR}/make
}

build_vendor () {
	if [ ! $(command -v bamake ) ]
	then
		build_bmake
	fi
}


build_ready () {
	echo ""
	echo "	******************************************"
	echo "	* YOU ARE NOW READY TO BUILD THE SYSTEM. *"
	echo "	* YOU CAN START THE PROCESS BY RUNNING   *"
	echo "	* THE FOLLOWING COMMAND:                 *"
	echo "	*                                        *"
	echo "	*            ./build world               *"
	echo "	*                                        *"
	echo "	* Do not forget to report any bugs!!!    *"
	echo "	******************************************"
	echo ""
}

run () {
	build_vendor
	create_builder
	build_ready
}

run
exit

