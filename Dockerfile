############################################################
# Dockerfile
############################################################

# Set the base image
FROM ubuntu:18.10

############################################################
# Configuration
############################################################
ENV VERSION "1.3.1"

############################################################
# Installation
############################################################

RUN apt-get update &&\
    apt-get install -y curl &&\
    # Install Buckaroo
    curl -o buckaroo.deb -L https://github.com/LoopPerfect/buckaroo/releases/download/v${VERSION}/buckaroo_${VERSION}_amd64.deb &&\
    dpkg -i buckaroo.deb &&\
    rm buckaroo.deb &&\
    # Fetch Cookbooks
    buckaroo update

############################################################
# Execution
############################################################
