#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")

IMAGE="xiangquan/grounding-dino:0.1"

sudo chmod 777 /var/run/docker.sock
docker build --network host -t ${IMAGE} $@ .
