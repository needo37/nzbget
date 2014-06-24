#!/bin/bash

# Check if nzbget.conf exists. If not, copy in the sample config
if [ -f /config/nzbget.conf ]; then
  echo "nzbget.conf exists"
else
  cp /usr/share/doc/nzbget/examples/nzbget.conf.gz /config/
  gzip -d /config/nzbget.conf.gz
fi

# Check to make sure downloads/nzbget exists
if [ -d /downloads/nzbget ]; then
  echo "downloads folder exists"
else
  mkdir -p /downloads/nzbget
fi

# Start nzbget
nzbget -D -c /config/nzbget.conf
