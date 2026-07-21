kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

kubectl get pods -n ingress-nginx

kubectl get svc -n ingress-nginx

:WAIT_REMOTE
kubectl get svc ingress-nginx-controller -n ingress-nginx >nul 2>&1

if errorlevel 1 (
    echo Waiting for Ingress nginx...
    timeout /t 5 >nul
    goto WAIT_REMOTE
)
kubectl apply -f templates\nginx\ingress.yaml