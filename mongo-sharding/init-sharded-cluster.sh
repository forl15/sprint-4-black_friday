#!/bin/bash

# Инициализация Config Server
echo "Initializing Config Server..."
docker compose exec configSrv mongosh --port 27017 --eval 'rs.initiate({_id: "config_server", configsvr: true, members: [{_id: 0, host: "configSrv:27017"}]})'

# Инициализация Shard 1
echo "Initializing Shard 1..."
docker compose exec shard1 mongosh --port 27018 --eval 'rs.initiate({_id: "shard1", members: [{_id: 0, host: "shard1:27018"}]})'

# Инициализация Shard 2
echo "Initializing Shard 2..."
docker compose exec shard2 mongosh --port 27019 --eval 'rs.initiate({_id: "shard2", members: [{_id: 0, host: "shard2:27019"}]})'

# Добавление шардов в кластер через mongos_router
echo "Adding shards to the cluster..."
docker compose exec mongos_router mongosh --port 27020 --eval 'sh.addShard("shard1/shard1:27018"); sh.addShard("shard2/shard2:27019")'

echo "Cluster initialization completed"
