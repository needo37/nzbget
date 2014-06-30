#!/bin/bash

PACKAGESDIR=/config/packages
NZBGET_DESTDIR=/usr

# Check if nzbget.conf exists. If not, copy in the sample config
if [ -f /config/nzbget.conf ]; then
  echo "nzbget.conf exists"
else
  cp /tmp/nzbget.conf /config/
  chown nobody:users /config/nzbget.conf
  mkdir -p /downloads/dst
  chown -R nobody:users /downloads
fi

# Check to see if there is a specific set of nzbget binaries to install
#if [ -f /config/bin/nzbget.tar.bz2 ]; then
#  echo "installing nzbget from /config/bin/nzbget.tar.bz2"
#  tar -C /usr -xjf /config/bin/nzbget.tar.bz2
#fi

if [ -z "$NZBGET_PACKAGE" ]; then
    echo "NzbGet package not specified."
else
    if [ -d $PACKAGESDIR ]; then
        if [ -f $PACKAGESDIR/$NZBGET_PACKAGE ]; then
            tar -C $NZBGET_DESTDIR -xjf $PACKAGESDIR/$NZBGET_PACKAGE 2>/dev/null
            if [ "$?" -eq 0 ]; then
                echo "Installed $NZBGET_PACKAGE!"
            else
                echo "Could not install $NZBGET_PACKAGE!"
            fi
        else
            echo "Can't find $PACKAGESDIR/$NZBGET_PACKAGE!"
        fi
    else
        echo "$PACKAGESDIR doesn't exist!"
    fi
fi

