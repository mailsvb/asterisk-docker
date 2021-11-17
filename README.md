# asterisk-docker

[![GitHub Workflow - CI](https://github.com/mailsvb/asterisk-docker/workflows/build/badge.svg)](https://github.com/mailsvb/asterisk-docker/actions?workflow=build)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/mailsvb/asterisk-docker)](https://github.com/mailsvb/asterisk-docker/releases/latest)
[![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/mailsvb/asterisk?sort=semver)](https://hub.docker.com/repository/docker/mailsvb/asterisk)

## Instructions
###### start the container
`docker run -dit --network=host mailsvb/asterisk:latest /usr/sbin/asterisk -fTvvvvv`

###### custom config
If you want to use your custom asterisk configuration, simply mount it when starting the container

`docker run -dit --network=host -v /path/to/custom/config::/etc/asterisk/ mailsvb/asterisk:latest /usr/sbin/asterisk -fTvvvvv`
