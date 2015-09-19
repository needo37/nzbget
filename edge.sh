#!/bin/bash

# Stop the script if it's already intalled.
if [[ -e /tmp/edge_installed ]]; then
  exit 0
fi

compile_libpar2(){
  {
    mkdir /tmp/libpar2
    wget -nv https://launchpad.net/libpar2/trunk/0.4/+download/libpar2-0.4.tar.gz -O - | tar --strip-components 1 -C /tmp/libpar2 -zxf - 
    wget -nv http://nzbget.net/files/libpar2-0.4-external-verification.patch -O /tmp/libpar2/libpar2-0.4-external-verification.patch
    cd /tmp/libpar2
    patch < libpar2-0.4-external-verification.patch
    ./configure --prefix=/usr
    make -j5
    make install
    cd /
    rm -rf cd /tmp/libpar2
  } &> /config/libpar2-compile.log
  echo "libpar2 build log exported to /config/libpar2-compile.log"
}

if [[ -n $EDGE ]]; then
  echo "Compiling from source."

  # Install build dependencies
  {
    apt-get update -qq
    apt-get remove -y nzbget libpar2-1
    apt-get install -qy libncurses5-dev sigc++ libssl-dev libxml2-dev sigc++ build-essential git
  } &> /config/nzbget-${EDGE}-compile.log

  # Patch and compile libpar2
  echo "Start building libpar2"
  compile_libpar2
  
  # Compile nzbget
  echo "Start building nzbget"
  {
    # Checkout the source code
    git clone https://github.com/nzbget/nzbget.git /tmp/nzbget-source

    # Build and install the source code
    cd /tmp/nzbget-source

    # Checkout whatever branch/tag/commit was provided
    git checkout $EDGE	

    ./configure --prefix=/usr --enable-parcheck
    make -j5
    make install

    # Do a cleanup
    cd /
    apt-get remove -qy libncurses5-dev sigc++ libssl-dev libxml2-dev sigc++ build-essential subversion
    rm -rf /tmp/nzbget-source
    
    # Copy the config template to the webui path
    cp /usr/share/nzbget/nzbget.conf /usr/share/nzbget/webui/

    # Make sure all runtime dependencies are installed
    apt-get install -y libxml2 sgml-base libsigc++-2.0-0c2a python2.7-minimal xml-core javascript-common \
      libjs-jquery libjs-jquery-metadata libjs-jquery-tablesorter libjs-twitter-bootstrap libpython-stdlib \
      python2.7 python-minimal python

  } &>> /config/nzbget-${EDGE}-compile.log
  echo "nzbget build log exported to /config/nzbget-${EDGE}-compile.log"
fi

# Mark edge as installed
touch /tmp/edge_installed
