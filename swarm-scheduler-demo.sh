#!/bin/bash

source ./util.sh
desc "Docker 1.12 Swarm mode scheduling demo"
desc "Setup:"
desc "1. Three EC2 instances on AWS. Each running docker 1.12"
desc "2. One swarm manager, two swarm workers"

run "docker-machine ls"
run "docker-machine ssh swarm-manager sudo  docker node ls"

desc "Part 1:  Engine labels and constraints"
desc "Check engine labels on swarm-manager"
run  "docker-machine ssh swarm-manager sudo  docker info | tail -n 10"

desc "Check engine labels on swarm-worker-1"
run  "docker-machine ssh swarm-worker-1 sudo  docker info | tail -n 10"

desc "Check engine labels on swarm-worker-2"
run  "docker-machine ssh swarm-worker-2 sudo  docker info | tail -n 10"

desc "Check if any service running"
run  "docker-machine ssh swarm-manager sudo  docker service ls"

desc "Example: Deploy redis db only on node with SSD - In our case it is swarm-manager"
run  "docker-machine ssh swarm-manager sudo docker service create --name myredisdb  --replicas=1 --constraint engine.labels.com.storage.class==ssd redis:3.0.6"

desc "Check service status"
run "docker-machine ssh swarm-manager sudo docker service ps myredisdb"

desc "Example: Deploy nginx container on node with HDD - In our case swarm-worker-1 or swarm-worker-2"
run "docker-machine ssh swarm-manager sudo docker service create --name mywebserver  --replicas=1 --constraint engine.labels.com.storage.class==hdd nginx:latest"
run "docker-machine ssh swarm-manager sudo docker service ps mywebserver"

desc "Part 2 :Swarm Spread strategy :  If two nodes have same attributes, spread the containers uniformely."
desc "Example: scale mywebserver service to 2 - Swarm should schedule on other HDD node"
run "docker-machine ssh swarm-manager sudo docker service scale mywebserver=2"
run "docker-machine ssh swarm-manager sudo docker service ps mywebserver"


desc "Part 3: Node labels. Add a node label to swarm-worker-1"
run "docker-machine ssh swarm-manager sudo docker node update --label-add deployment.environment=test swarm-worker-1"

desc "Verify node label on swarm-worker-1"
run "docker-machine ssh swarm-manager sudo docker node inspect swarm-worker-1"

desc "Example: Create rabbitmq service on node where deployment.environment is not test"
run "docker-machine ssh swarm-manager sudo docker service create --name myrabbitmq  --replicas=2 --constraint node.labels.deployment.environment!=test rabbitmq"

run "docker-machine ssh swarm-manager sudo docker service ps myrabbitmq"

desc "End of the demo !"






