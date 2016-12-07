echo "Start Elastic"
mkdir `pwd`/esdata
docker run --name elastic -d -v `pwd`/esdata:/usr/share/elasticsearch/data -p 9200:9200 elasticsearch
