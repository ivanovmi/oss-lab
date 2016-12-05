
echo "Pull all images"

docker pull elasticsearch
docker pull seecloud/availability:latest
docker pull seecloud/health:latest
docker pull seecloud/ceagle:latest
docker pull seecloud/fuel-devops-portal:latest

echo "Start Elastic"
mkdir `pwd`/esdata
docker run -d -v `pwd`/esdata:/usr/share/elasticsearch/data elasticsearch

sleep 2

echo "Start all jobs"
docker run -d --name avail-watcher -v `pwd`/lab-config/avail:/etc/availability availability seecloud/availability-watcher
docker run -d --name health-collector -v `pwd`/lab-config/health:/etc/health -e RUN_HEALTH_JOB=True seecloud/health

echo "Start all APIs"
# Start all APIs
docker run -d --name avail-api -v `pwd`/lab-config/avail:/etc/availability -p 5002:5000 seecloud/availability ./entrypoint-api.sh
docker run -d --name health-api -v `pwd`/lab-config/health:/etc/health -e RUN_HEALTH_API=True -p 5001:5000 seecloud/health
docker run -d --name ceagle -v `pwd`/lab-config/ceagle:/etc/ceagle -p  8080:5000 ceagle

echo "Start UI"
docker run --name devops-portal -d --net host seecloud/fuel-devops-portal
