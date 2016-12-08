#!/bin/bash -e

conf="$(pwd)/configs"

echo "Start all jobs"
docker run -d --net oss-dev --name availability-watcher -v $conf/availability:/etc/availability seecloud/availability availability-watcher
docker run -d --net oss-dev --name health-collector -v $conf/health:/etc/health -e RUN_HEALTH_JOB=True seecloud/health

echo "Start all APIs"
# Start all APIs
docker run -d --net oss-dev --name availability-api -v $conf/availability:/etc/availability seecloud/availability ./entrypoint-api.sh
docker run -d --net oss-dev --name health-api -v $conf/health:/etc/health -e RUN_HEALTH_API=True seecloud/health
docker run -d --net oss-dev --name ceagle -v $conf/ceagle:/etc/ceagle seecloud/ceagle

echo "Start UI"
docker run -d --net oss-dev --name devops-portal -p 80:80 -p 443:443 seecloud/fuel-devops-portal
