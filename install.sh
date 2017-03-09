#!/usr/bin/env sh

autoconf_src=ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
automake_src=ftp://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
libtool_src=ftp://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz

INSTALL_DIR=$HOME/local

DoInstall()
{
    name=$1
    src=$2
    dist=$3
    pkt=$(basename "$src")

    # clean up existing package
    rm -f $pkt
    rm -rf $name

    echo "===================================="
    echo "Installing $name to $dist..."
    echo "===================================="

    wget $src
    if [ ! -f "$pkt" ]; then
        echo "Cannot find $pkt for tool [$name]\n"
        exit 1
    fi

    mkdir -p $dist
    mkdir -p $name
    tar xf $pkt -C $name --strip 1

    pushd $name
    ./configure --prefix=$dist && make -j8 && make install
    popd

    echo "===================================="
    echo "$name installation done"
    echo "===================================="
    echo ""
}

DoInstall "autoconf" $autoconf_src $INSTALL_DIR
DoInstall "automake" $automake_src $INSTALL_DIR
DoInstall "libtool" $libtool_src $INSTALL_DIR
