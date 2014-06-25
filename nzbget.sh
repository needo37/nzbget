#!/bin/bash

exec /sbin/setuser nobody nzbget -D -c /config/nzbget.conf
