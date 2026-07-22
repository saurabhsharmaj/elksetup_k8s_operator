@echo off

echo Installing ECK...

kubectl create namespace elastic-system

kubectl apply -f https://download.elastic.co/downloads/eck/3.1.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/3.1.0/operator.yaml

timeout /t 20

kubectl create namespace elastic

echo Creating ECK Trial License...
call license.bat

echo Deploy Elasticsearch 1

kubectl apply -f templates\elk1\elasticsearch.yaml

echo Waiting for elasticsearch1...

:WAIT_ES1

for /f %%i in ('kubectl get elasticsearch elasticsearch1 -n elastic -o jsonpath^="{.status.phase}"') do set STATUS=%%i

echo Current Status: %STATUS%

if /I NOT "%STATUS%"=="Ready" (
    timeout /t 10 >nul
    goto WAIT_ES1
)

echo Elasticsearch1 is Ready.
:WAIT_REMOTE

kubectl get svc elasticsearch1-es-http -n elastic >nul 2>&1

if errorlevel 1 (
    echo Waiting for Remote Elasticsearch1 Server...
    timeout /t 5 >nul
    goto WAIT_REMOTE
)

echo Remote Elasticsearch1 Server Ready.

echo Deploy Elasticsearch 2

kubectl apply -f templates\elk2\elasticsearch.yaml

echo Deploy Kibana

kubectl apply -f templates\elk1\kibana.yaml
kubectl apply -f templates\elk2\kibana.yaml

kubectl get elasticsearch -n elastic
kubectl get kibana -n elastic
kubectl get pods -n elastic

pause

call nginx.bat

echo ECK Installation Completed.
