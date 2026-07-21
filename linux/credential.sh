
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((kubectl get secret elasticsearch1-es-elastic-user -n elastic -o jsonpath="{.data.elastic}")))