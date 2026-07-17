
Activate the trial license.

## Supported POC flow on ECK 9.1

This repo should use the API key remote-cluster model instead of manual transport sniffing.

The follower cluster manifest is already wired to the leader cluster through ECK:

- elasticsearch1 exposes the remote cluster server
- elasticsearch2 declares a remote cluster alias named leader
- ECK creates the cross-cluster API key and the remote-cluster connection for you

That avoids the SSL handshake problem you were seeing with two separate transport CAs.

kubectl get elasticsearch -n elastic
kubectl get svc -n elastic

Use the elastic password from credentials.ps1 when you test the leader API.

# create index into cluster-1

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

If you want two-way replication for a POC, create a second index pair in the opposite direction. Do not try to replicate the same index name in both directions at the same time.