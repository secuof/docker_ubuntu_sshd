#!/usr/bin/env bash

#docker run ubuntu_sshd instance
docker build -t ubuntu_sshd .
docker-compose up -d
