############################################################
# Dockerfile
############################################################

# Set the base image
FROM ubuntu:18.10

############################################################
# Configuration
############################################################
ENV VERSION "2.1.0"
ENV PATH "$PATH:/buck/bin"
ENV JAVA_HOME "/usr/lib/jvm/java-8-openjdk-amd64"

############################################################
# Installation
############################################################

# System Packages
RUN apt-get update &&\
    # CURL and Build Tools
    apt-get install -y -qq curl build-essential cmake &&\
    # Buck Requirements
    apt-get install -y -qq git openjdk-8-jdk ant python2 &&\
    ln -s /usr/bin/python2.7 /usr/bin/python

# Software
RUN echo "Installing Software ..." &&\
    # Buck
    git clone --depth 1 https://github.com/facebook/buck.git &&\
    cd /buck &&\
    ant &&\
    ./bin/buck build --show-output buck &&\
    # Install Buckaroo
    cd / &&\
    curl -o buckaroo.deb -L https://github.com/LoopPerfect/buckaroo/releases/download/v${VERSION}/buckaroo_${VERSION}_amd64.deb &&\
    dpkg -i buckaroo.deb &&\
    rm buckaroo.deb &&\
    # Fetch Cookbooks
    buckaroo update

RUN echo "CleanUp ..." &&\
    # APT
    apt-get clean autoclean &&\
    apt-get autoremove --yes &&\
    rm -rf /var/lib/{apt,dpkg,cache,log}/

############################################################
# Execution
############################################################
