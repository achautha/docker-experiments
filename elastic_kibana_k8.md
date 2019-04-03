## Install Kibana and Elastic on Docker cluster. Expose Kibana to outside world using nodeport


### Elastic  install
```bash
kubectl run elasticsearch --image=elastic/elasticsearch:6.6.2 --port 9200 --port 9300 --env "discovery.type=single-node"
```

### Expose Elastic Service 
```bash
kubectl expose deployment/elasticsearch --port 9200 --target-port 9200 --name elastic --type NodePort
```

### Install Kibana
```
kubectl run kibana --image=elastic/kibana:6.6.2 --env ELASTICSEARCH_URL=http://elastic:9200 --env SERVER_HOST=0.0.0.0 --port 5601
```

### Expose Kibana

```
kubectl expose deployment/kibana --type NodePort
```

