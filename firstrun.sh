#!/bin/bash

# Check if nzbget.conf exists. If not, copy in the sample config
if [ -f /config/nzbget.conf ]; then
  echo " Using existing nzbget.conf file."
else
  echo "Creating nzbget.conf from template."
  cp /usr/share/nzbget/webui/nzbget.conf /config/
  sed -i -e "s#\(MainDir=\).*#\1/downloads#g" /config/nzbget.conf
  sed -i -e "s#\(ControlIP=\).*#\10.0.0.0#g" /config/nzbget.conf
  sed -i -e "s#\(UMask=\).*#\1000#g" /config/nzbget.conf
  sed -i -e "s#\(ScriptDir=\).*#\1/config/ppscripts#g" /config/nzbget.conf
  chown nobody:users /config/nzbget.conf
  mkdir -p /downloads/dst
  chown -R nobody:users /downloads
fi

# Add some post-processing scripts
if [[ ! -e /config/ppscripts ]]; then
  mkdir -p config/ppscripts
fi

# nzbToMedia
if [[ ! -e /config/ppscripts/nzbToMedia ]]; then
  echo "Downloading nzbToMedia."
  mkdir -p /config/ppscripts/nzbToMedia
  wget -nv https://github.com/clinton-hall/nzbToMedia/archive/master.tar.gz -O - | tar --strip-components 1 -C /config/ppscripts/nzbToMedia -zxf -
fi

# Videosort
if [[ ! -e /config/ppscripts/videosort ]]; then
  echo "Downloading videosort."
  mkdir -p /config/ppscripts/videosort
  wget -nv http://sourceforge.net/projects/nzbget/files/ppscripts/videosort/videosort-ppscript-4.0.zip/download -O /config/ppscripts/videosort-ppscript-4.0.zip
  unzip -qq /config/ppscripts/videosort-ppscript-4.0.zip
  rm /config/ppscripts/videosort-ppscript-4.0.zip
fi

# NotifyXBMC.py
if [[ ! -e /config/ppscripts/NotifyXBMC.py ]]; then
  echo "Downloading NotifyXBMC."
  wget -nv http://nzbget.net/forum/download/file.php?id=193 -O /config/ppscripts/NotifyXBMC.py
fi
