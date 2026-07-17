
Activate the trial license.

check transport nodes
kubectl get svc -n elastic

output:
elasticsearch1-es-transport
elasticsearch2-es-transport

cluster-1 [leader]
POST /_security/cross_cluster/api_key
{
  "name": "es2-ccr",

  "access": {
    "replication": [
      {
        "names": [
          "*"
        ]
      }
    ]
  }
}

kubectl exec -it elasticsearch2-es-default-0 -n elastic -- bash
curl https://elasticsearch1-es-http.elastic.svc:9200 -k
curl -k --user elastic:QYi3u9e354tGYDiL49xw242g https://elasticsearch1-es-http.elastic.svc:9200
curl -vk --user elastic:QYi3u9e354tGYDiL49xw242g https://elasticsearch1-es-http.elastic.svc:9200


##On the follower cluster (elasticsearch2), register the leader (dev tool)
PUT /_cluster/settings
{
  "persistent": {
    "cluster": {
      "remote": {
        "leader": {
          "mode": "sniff",
          "seeds": [
            "elasticsearch1-es-transport.elastic.svc:9300"
          ]
        }
      }
    }
  }
}


#create index into cluster-1

PUT products
{
  "settings": {
    "number_of_shards": 1
  }
}

#insert document.
POST products/_doc/1
{
  "name": "Laptop",
  "price": 1000
}

##on Cluster-2 create follower index:
PUT products_copy/_ccr/follow
{
  "remote_cluster": "leader",
  "leader_index": "products"
}