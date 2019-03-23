#
# Glances Dockerfile for ARM (based on Alpine ARM)
#
# https://github.com/orlikoski/skadi_glances
# Pull base image.
FROM python:2.7-alpine

# Install Glances (develop branch)
RUN apk add --no-cache --virtual .build_deps \
	gcc \
	musl-dev \
	linux-headers \
	&& pip install 'psutil>=5.4.7,<5.5.0' bottle==0.12.13 \
	&& apk del .build_deps
RUN apk add --no-cache git && git clone https://github.com/nicolargo/glances.git /glances
RUN cd /glances && git checkout tags/v3.1.0

# Define working directory.
WORKDIR /glances

# EXPOSE PORT (For Web UI & XMLRPC)
EXPOSE 61208 61209

# Define default command.
CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT
