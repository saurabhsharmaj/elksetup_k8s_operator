kubectl delete secret eck-trial-license -n elastic-system

kubectl create secret generic eck-trial-license -n elastic-system
kubectl label secret eck-trial-license -n elastic-system license.k8s.elastic.co/type=enterprise_trial
kubectl annotate secret eck-trial-license -n elastic-system elastic.co/eula=accepted