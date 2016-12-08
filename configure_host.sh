#!/bin/bash -x

sudo sysctl -w vm.max_map_count=262144

docker network inspect oss-dev > /dev/null || \
    docker network create --driver bridge oss-dev
