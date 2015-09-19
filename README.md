This is a Dockerfile setup for nzbget - http://nzbget.net/

To run:

```
docker run -d --name="nzbget" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -p 6789:6789 needo/nzbget
```

If using nzbget for the first time the sample nzbget.conf will be utilized and the /downloads/nzbget directory will be created. The default username is nzbget and the default password is tegbzn6789

Edge
----
If you would like to run a forthcoming version, please set the EDGE variable with the name of the tag, vXX.X format (e.g. v13.0), see https://github.com/nzbget/nzbget:
```
docker run -d --name="nzbget" -e EDGE="13.0" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -p 6789:6789 needo/nzbget
```

To use a test commit, please set the EDGE variable with the XXXXXXX format (e.g. d48a165):

```
docker run -d --name="nzbget" -e EDGE="d48a165" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -p 6789:6789 needo/nzbget
```
