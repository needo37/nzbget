This is a Dockerfile setup for nzbget - http://nzbget.net/

To run:

docker run -d --name="nzbget" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -p 6789:6789 needo/nzbget
