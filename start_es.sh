#!/bin/bash -e

data="$(pwd)/data"

echo "Start Elastic"
docker run --name elasticsearch --network oss-dev -d -v $data:/usr/share/elasticsearch/data elasticsearch
