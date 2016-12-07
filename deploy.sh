echo "Start all jobs"
docker run -d --name avail-watcher -v `pwd`/avail:/etc/availability seecloud/availability availability-watcher
docker run -d --name health-collector -v `pwd`/health:/etc/health -e RUN_HEALTH_JOB=True seecloud/health

echo "Start all APIs"
# Start all APIs
docker run -d --name avail-api -v `pwd`/avail:/etc/availability -p 5002:5000 seecloud/availability ./entrypoint-api.sh
docker run -d --name health-api -v `pwd`/health:/etc/health -e RUN_HEALTH_API=True -p 5001:5000 seecloud/health
docker run -d --name ceagle -v `pwd`/ceagle:/etc/ceagle -p  8080:5000 seecloud/ceagle

echo "Start UI"
docker run --name devops-portal -d --net host seecloud/fuel-devops-portal
