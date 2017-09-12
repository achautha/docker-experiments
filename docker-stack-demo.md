## Demo steps


### Docker UI

```
docker run -d -p 9000:9000 portainer/portainer -H tcp://10.0.40.3:2375

```


### Wordpress site

```
wget https://raw.githubusercontent.com/ajeetraina/docker101/master/play-with-docker/wordpress/example1/docker-stack.yml


networks:
  monitoring:

docker stack deploy -c docker-stack.yml mywordpress

```


### Monitoring application

```
wget https://raw.githubusercontent.com/machzqcq/docker-prometheus-swarm/master/docker-compose.yml
docker stack deploy -c docker-compose.yml monitoring
```

### Add data source for prometheus
```
http://prometheus:9090
```

### Add data source for elk
```
http://elk:9200

index name: logstash-*
```

### Import dashboard

Docker Swarm & Container Overview : 609
