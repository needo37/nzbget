FROM phusion/baseimage:0.9.11
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
RUN add-apt-repository "deb http://ppa.launchpad.net/jon-severinsson/ffmpeg/ubuntu trusty main"
RUN apt-get update -q
RUN apt-get install -qy unrar nzbget ffmpeg

#Path to a directory that only contains the nzbget.conf
VOLUME /config
VOLUME /downloads

EXPOSE 6789

# Install sample nzbget.conf if needed
ADD nzbget.conf /tmp/nzbget.conf

# Add firstrun.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh

# Add nzbget to runit
RUN mkdir /etc/service/nzbget
ADD nzbget.sh /etc/service/nzbget/run
RUN chmod +x /etc/service/nzbget/run
