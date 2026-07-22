Write-Host "Cluster1..." -ForegroundColor Green
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((kubectl get secret elasticsearch1-es-elastic-user -n elastic -o jsonpath="{.data.elastic}")))

Write-Host "Cluster2..." -ForegroundColor Green
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((kubectl get secret elasticsearch2-es-elastic-user -n elastic -o jsonpath="{.data.elastic}")))