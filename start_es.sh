echo "Start Elastic"
mkdir `pwd`/esdata
docker run -d -v `pwd`/esdata:/usr/share/elasticsearch/data elasticsearch
