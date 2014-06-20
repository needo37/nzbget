FROM debian:jessie
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive

# Fix timezone
RUN ln -sf /usr/share/zoneinfo/CST6CDT /etc/localtime

RUN apt-get update -q
RUN apt-get install -qy nzbget

#Path to a directory that only contains the nzbget.conf
VOLUME /config
VOLUME /downloads

EXPOSE 6789

ENTRYPOINT ["/usr/bin/nzbget", "-c", "/config/nzbget.conf"]
