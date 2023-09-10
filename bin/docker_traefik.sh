#!/bin/bash

script=`readlink -f $BASH_SOURCE`
scriptFolder=`dirname $script`
root=`dirname $scriptFolder`

docker ps | grep -q traefik && docker stop traefik
sleep 1

docker run \
    --name=traefik \
    --rm -it -d \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${scriptFolder}/docker_traefik.toml:/traefik.toml \
    --network host \
    --cpus=2 \
    --memory=256M \
    --memory-swap=0 \
    traefik:latest

sleep 2
docker ps | grep -q traefik || echo "Traefik failed to start"
