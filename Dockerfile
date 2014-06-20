FROM debian:jessie
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive

# Fix timezone
RUN ln -sf /usr/share/zoneinfo/CST6CDT /etc/localtime

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody

RUN apt-get update -q
RUN apt-get install -qy nzbget

#Path to a directory that only contains the nzbget.conf
VOLUME /config
VOLUME /downloads

EXPOSE 6789

# For some unknown reason nzbget does not work with ENTRYPOINT
ADD start.sh /start.sh

# Let's not run nzbget as root
USER nobody
CMD ["/bin/bash", "/start.sh"]
