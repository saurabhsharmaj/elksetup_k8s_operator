@echo off
echo ============================================
echo Elastic ECK Installer
echo ============================================
echo.
echo TODO: Main installation script

kubectl version
kubectl get nodes
kubectl create namespace elastic-system
kubectl get ns
kubectl apply -f https://download.elastic.co/downloads/eck/3.1.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/3.1.0/operator.yaml
kubectl get pods -n elastic-system
kubectl create namespace elastic
kubectl apply -f templates\elk1\elasticsearch.yaml
kubectl get elasticsearch -n elastic
kubectl get pods -n elastic
kubectl get svc -n elastic
kubectl apply -f templates\elk2\elasticsearch.yaml
kubectl get elasticsearch -n elastic
kubectl apply -f templates\elk1\kibana.yaml
kubectl apply -f templates\elk2\kibana.yaml

kubectl get kibana -n elastic
kubectl get kibana -n elastic
kubectl get svc -n elastic

start cmd /k "kubectl port-forward svc/elasticsearch1-es-http 9200:9200 -n elastic"
start cmd /k "kubectl port-forward svc/elasticsearch2-es-http 9201:9200 -n elastic"
start cmd /k "kubectl port-forward svc/kibana1-kb-http 5601:5601 -n elastic"
start cmd /k "kubectl port-forward svc/kibana2-kb-http 5602:5601 -n elastic"
pause
