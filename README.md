This is a Dockerfile setup for nzbget - http://nzbget.net/

To run:

docker run -d --name="nzbget" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -p 6789:6789 needo/nzbget

If using nzbget for the first time please download this sample configuration file, rename it to nzbget.conf and put it in /path/to/dir/with/nzbget.conf/ - https://raw.githubusercontent.com/needo37/nzbget/master/nzbget.conf.sample
