#!/bin/sh
# Bootstrap script for Agnes OS

# Root directory of Agne's project sources:
AGNES_ROOT="$( cd -- "$(dirname "$0")" > /dev/null 2>&1 ; pwd -P)"
VENDOR_ROOT="${AGNES_ROOT}/vendor"
BMAKE_ROOT="${VENDOR_ROOT}/bmake"
FASMG_ROOT="${VENDOR_ROOT}/fasmg"
BUILD_ROOT="${AGNES_ROOT}/.build"
VENDOR_PREFIX="${BUILD_ROOT}/usr"
VENDOR_BINDIR="${VENDOR_PREFIX}/bin"
BMAKE_FLAGS="-m ${VENDOR_PREFIX}/share/mk"
FASMG_BIN="fasmg.x64"

# Build path (PATH)
PATH="${BUILD_ROOT}/usr/bin:${PATH}"

# compiler toolchain related things:
export CC=clang
export INCLUDE="${VENDOR_ROOT}/usr/include" # fasmg

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

install_fasmg () {
    # TODO: build fasmg if possible, and do some fancy OS detection to help with this.
    cp -v ${FASMG_ROOT}/core/${FASMG_BIN} ${BUILD_ROOT}/usr/bin/fasmg
    cp -vR ${FASMG_ROOT}/packages/x86/include ${BUILD_ROOT}/usr/include
}

build_vendor () {
	if [ ! $(command -v bamake ) ]
	then
		build_bmake
	fi

    install_fasmg
}

fetch_submodules() {
    git submodule update --init --recursive
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
    fetch_submodules
	build_vendor
	create_builder
	build_ready
}

run
exit
