echo "cleanup mywebserver"
docker-machine ssh swarm-manager sudo docker service rm mywebserver
echo "cleanup myredisdb"
docker-machine ssh swarm-manager sudo docker service rm myredisdb
echo "cleanup mybusybox"
docker-machine ssh swarm-manager sudo docker service rm myrabbitmq

echo "remove test label from swarm-worker-1"
docker-machine ssh swarm-manager sudo docker node update --label-rm deployment.environment swarm-worker-1
