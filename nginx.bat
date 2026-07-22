kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

kubectl get pods -n ingress-nginx

kubectl get svc -n ingress-nginx

kubectl wait ^
  --namespace ingress-nginx ^
  --for=condition=Ready pod ^
  -l app.kubernetes.io/component=controller ^
  --timeout=300s
  
kubectl apply -f templates\nginx\ingress.yaml