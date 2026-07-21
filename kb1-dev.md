GET /_license
POST /_license/start_trial?acknowledge=true
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


GET  _security

POST /_license/start_trial?acknowledge=true

POST _security/cross_cluster/api_key 
{
  "name": "ccr-api-key",
  "access": {
    "replication": [
      {
        "names": [ "products" ]
      }
    ]
  }
}
