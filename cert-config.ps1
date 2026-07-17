$ErrorActionPreference = "Stop"

$namespace = "elastic"
$scriptDir = $PSScriptRoot

Write-Host "Script directory: $scriptDir"
Write-Host ""

function Export-Certificate {
    param(
        [string]$SecretName,
        [string]$OutputFile
    )

    Write-Host "Reading secret: $SecretName"

    $json = kubectl get secret $SecretName -n $namespace -o json | ConvertFrom-Json

    if ($null -eq $json) {
        throw "Unable to read secret $SecretName"
    }

    if (-not $json.data.PSObject.Properties.Name.Contains("ca.crt")) {
        throw "$SecretName does not contain ca.crt"
    }

    $base64 = $json.data."ca.crt"

    Write-Host "Base64 Length : $($base64.Length)"

    $bytes = [Convert]::FromBase64String($base64)

    Write-Host "Certificate Bytes : $($bytes.Length)"

    $path = Join-Path $scriptDir $OutputFile

    [System.IO.File]::WriteAllBytes($path, $bytes)

    if (!(Test-Path $path)) {
        throw "Failed to create $path"
    }

    Write-Host "Created: $path"
    Write-Host "Size   : $((Get-Item $path).Length) bytes"
    Write-Host ""
}

Export-Certificate `
    -SecretName "elasticsearch1-es-transport-certs-public" `
    -OutputFile "ca1.crt"

Export-Certificate `
    -SecretName "elasticsearch2-es-transport-certs-public" `
    -OutputFile "ca2.crt"

Write-Host "Deleting old secrets..."

kubectl delete secret cluster1-transport-ca -n $namespace --ignore-not-found | Out-Null
kubectl delete secret cluster2-transport-ca -n $namespace --ignore-not-found | Out-Null

Write-Host "Creating cluster1-transport-ca..."
kubectl create secret generic cluster1-transport-ca `
    --from-file=ca.crt="$scriptDir\ca1.crt" `
    -n $namespace

Write-Host "Creating cluster2-transport-ca..."
kubectl create secret generic cluster2-transport-ca `
    --from-file=ca.crt="$scriptDir\ca2.crt" `
    -n $namespace

Write-Host ""
Write-Host "Done."

kubectl get secrets -n $namespace