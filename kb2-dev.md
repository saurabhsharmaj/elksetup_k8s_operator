GET /_license
POST /_license/start_trial?acknowledge=true

GET _nodes/settings?pretty

GET /_remote/info

##on Cluster-2 create follower index:
PUT products_copy/_ccr/follow
{
  "remote_cluster": "elasticsearch1",
  "leader_index": "products"
}