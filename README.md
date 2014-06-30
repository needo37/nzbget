This is a Dockerfile setup for nzbget - http://nzbget.net/

To run:

```
docker run -d --name="nzbget" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -p 6789:6789 needo/nzbget
```

If using nzbget for the first time the sample nzbget.conf will be utilized and the /downloads/nzbget directory will be created. The default username is nzbget and the default password is tegbzn6789

It is also possible to specify an alternative nzbget package to be installed when the container runs. Pakacges will be loaded from /config/packages
The package name can be specified by using an environment variable in the run command for the container
```
docker run -d --name="nzbget" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -eNZBGET_PACKAGE=nzbget-13.0-testing-r1045-pb.tar.bz2 -p 6789:6789 needo/nzbget
```

At the moment the only supported format for the package is .tar.bz2
