#!/bin/bash -e

data="$(pwd)/data"

echo "Start Elastic"
docker run --name elastic -d -v $data:/usr/share/elasticsearch/data -p 9200:9200 elasticsearch
