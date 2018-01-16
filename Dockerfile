#######################################################################
# Icecast2 Docker
# http://icecast.org/
#######################################################################

# Base image: https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:0.9.22

# Set correct environment variables
ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="C.UTF-8" 
ENV LANG="en_US.UTF-8" 
ENV LANGUAGE="en_US.UTF-8" 

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Upgrading the operating system inside the container
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install Icecast: https://wiki.xiph.org/Icecast_Server/Installing_latest_version_(official_Xiph_repositories)
# Step 1: Add the repository
# Step 2: Import the Multimedia signing key
# Step 3/4: Update your repository index & Install Icecast
RUN echo "deb http://download.opensuse.org/repositories/multimedia:/xiph/xUbuntu_16.04/ ./" > /etc/apt/sources.list.d/icecast.list
RUN apt-get -qq -y update && \
    apt-get -qq -y install wget && \
    wget -qO - http://icecast.org/multimedia-obs.key | apt-key add -
RUN apt-get -qq -y update && \
    apt-get -qq -y install icecast2

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
# copy default icecast.xml to home dir 
COPY icecast.xml /home/icecast.xml	
	
# Adding daemon
RUN mkdir /etc/service/icecast
COPY icecast.sh /etc/service/icecast/run
RUN chmod +x /etc/service/icecast/run

VOLUME /config
EXPOSE 8000