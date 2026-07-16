kubectl get secret elasticsearch1-es-elastic-user -n elastic -o go-template='{{.data.elastic | base64decode}}'
kubectl get secret elasticsearch2-es-elastic-user -n elastic -o go-template='{{.data.elastic | base64decode}}'

curl -k -u elastic:PASSWORD https://localhost:9200
curl -k -u elastic:PASSWORD https://localhost:9201

[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((kubectl get secret elasticsearch1-es-elastic-user -n elastic -o jsonpath="{.data.elastic}")))
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((kubectl get secret elasticsearch2-es-elastic-user -n elastic -o jsonpath="{.data.elastic}")))