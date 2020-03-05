#!/usr/bin/env bash

docker stop ubuntu_sshd
docker rm ubuntu_sshd
docker rmi ubuntu_sshd
