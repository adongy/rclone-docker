# rclone-docker

[rclone](https://rclone.org) docker image, built from release binaries.

# Why

The [official Docker image](https://hub.docker.com/r/rclone/rclone) is built from [source](https://github.com/rclone/rclone/blob/master/Dockerfile), which may or may not have differences with the official release binaries.

As there is also no proof that the Docker image has not been tampered with, I created this Docker image.

It tracks the latest stable release and verifies the tarballs signatures.
It is based on a Debian 10 (buster) OS, AMD64 arch.
