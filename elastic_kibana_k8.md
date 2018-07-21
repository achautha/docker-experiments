## Install Kibana and Elastic on Docker cluster. Expose Kibana to outside world using nodeport


### Elastic  install
```bash
kubectl run elastic --image=docker.elastic.co/elasticsearch/elasticsearch:6.3.1 --port 9200 --port 9300 --env "discovery.type=single-node"
```

### Expose Elastic Service 
```bash
kubectl expose deployment/elastic --port 9200 --target-port 9200
```

### Install Kibana
```
kubectl run kibana --image=docker.elastic.co/kibana/kibana:6.3.1 --env ELASTICSEARCH_URL=http://elastic:9200 --env SERVER_HOST=0.0.0.0 --port 5601
```

### Expose Kibana

```
kubectl expose deployment/kibana --type NodePort
```

