@echo off

echo Installing ECK...

kubectl create namespace elastic-system

kubectl apply -f https://download.elastic.co/downloads/eck/3.1.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/3.1.0/operator.yaml

timeout /t 20

kubectl create namespace elastic

echo Deploy Elasticsearch 1

kubectl apply -f templates\elk1\elasticsearch.yaml

echo Deploy Elasticsearch 2

kubectl apply -f templates\elk2\elasticsearch.yaml

echo Deploy Kibana

kubectl apply -f templates\elk1\kibana.yaml
kubectl apply -f templates\elk2\kibana.yaml

kubectl get elasticsearch -n elastic
kubectl get kibana -n elastic
kubectl get pods -n elastic

pause