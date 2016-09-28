echo "create aws instances"
docker-machine create --driver amazonec2  swarm-manager
docker-machine create --driver amazonec2  swarm-worker-1
docker-machine create --driver amazonec2  swarm-worker-2
docker-machine ls 


echo "initialize swarm cluster"
MANAGER_IP=`docker-machine inspect --format '{{ .Driver.PrivateIPAddress}}' swarm-manager`
docker-machine ssh swarm-manager sudo docker swarm init --advertise-addr "$MANAGER_IP":2377
TOKEN=`docker-machine ssh swarm-manager sudo docker swarm join-token -q worker`
docker-machine ssh swarm-worker-1 sudo docker swarm join --token "$TOKEN" "$MANAGER_IP":2377
docker-machine ssh swarm-worker-2 sudo docker swarm join --token "$TOKEN" "$MANAGER_IP":2377

