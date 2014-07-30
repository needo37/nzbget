#!/bin/bash

# Stop the script if it's already intalled.
if [[ -e /tmp/edge_installed ]]; then
  exit 0
fi

compile_libpar2(){
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
}

if [[ -n $EDGE ]]; then

  # Set SVN to version, revision or trunk
  regex_version="[0-9]{2}\.[0-9]*?"
  regex_revision="[0-9]{4}"
  if [[ $EDGE =~ $regex_version ]]; then
    SVN="svn://svn.code.sf.net/p/nzbget/code/tags/${EDGE}"
    echo "Checking out version ${EDGE}"
  elif [[ $EDGE =~ $regex_revision ]]; then
    SVN="-r ${EDGE} svn://svn.code.sf.net/p/nzbget/code/trunk"
    echo "Checking out revision $EDGE"
  else
    SVN="svn://svn.code.sf.net/p/nzbget/code/trunk"
    echo "Checking out the trunk version"
  fi

  # Update sources
  apt-get update -qq

  # Remove libpar2 and nzbget
  apt-get remove -y nzbget libpar2-1

  # Install build dependencies
  apt-get install -qy libncurses5-dev sigc++ libssl-dev libxml2-dev sigc++ build-essential subversion wget

  # Patch and compile libpar2
  compile_libpar2

  # Checkout the source code
  svn checkout ${SVN} /tmp/nzbget-source

  # Build and install the source code
  cd /tmp/nzbget-source
  ./configure --prefix=/usr --enable-parcheck
  make -j5
  make install

  # Do a cleanup
  cd /
  apt-get remove -qy libncurses5-dev sigc++ libssl-dev libxml2-dev sigc++ build-essential subversion wget
  rm -rf /tmp/nzbget-source

  # Copy the config template to the webui path
  cp /usr/share/nzbget/nzbget.conf /usr/share/nzbget/webui/

  # install runtime dependencies
  apt-get install -y libxml2 sgml-base libsigc++-2.0-0c2a python2.7-minimal xml-core javascript-common \
    libjs-jquery libjs-jquery-metadata libjs-jquery-tablesorter libjs-twitter-bootstrap libpython-stdlib \
    python2.7 python-minimal python
fi

# Mark edge as installed
touch /tmp/edge_installed
