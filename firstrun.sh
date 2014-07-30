#!/bin/bash

# Check if nzbget.conf exists. If not, copy in the sample config
if [ -f /config/nzbget.conf ]; then
  echo "nzbget.conf exists"
else
  cp /usr/share/nzbget/webui/nzbget.conf /config/
  sed -i -e "s#\(MainDir=\).*#\1/downloads#g" /config/nzbget.conf
  sed -i -e "s#\(ControlIP=\).*#\10.0.0.0#g" /config/nzbget.conf
  sed -i -e "s#\(UMask=\).*#\1000#g" /config/nzbget.conf
  chown nobody:users /config/nzbget.conf
  mkdir -p /downloads/dst
  chown -R nobody:users /downloads
fi
