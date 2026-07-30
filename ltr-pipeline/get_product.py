from elasticsearch import Elasticsearch
import csv
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

es = Elasticsearch(
    "https://es1.local",
    basic_auth=("elastic", "8xg7rPhpkLq6a6932gM6Ut41"),
    verify_certs=False
)

with open("training_data.csv", "r") as file:

    reader = csv.DictReader(file)

    for row in reader:

        product_id = row["productId"]

        response = es.get(
            index="products",
            id=product_id
        )
        
        product = response["_source"]
        print(
            row["query"],
            product["productId"],
            product["rating"],
            product["sales"],
            product["ctr"],
            product["conversionRate"],
            row["label"]
        )
        