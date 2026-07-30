from elasticsearch import Elasticsearch
import urllib3
import onnxruntime as ort
import numpy as np

# --------------------------------------------------------
# Disable SSL warning (Local Cluster Only)
# --------------------------------------------------------
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# --------------------------------------------------------
# Elasticsearch Connection
# --------------------------------------------------------
ES_URL = "https://es1.local:443"

USERNAME = "elastic"
PASSWORD = "8xg7rPhpkLq6a6932gM6Ut41"

es = Elasticsearch(
    ES_URL,
    basic_auth=(USERNAME, PASSWORD),
    verify_certs=False
)

# --------------------------------------------------------
# Load ONNX Model
# --------------------------------------------------------
print("Loading LTR Model...")

session = ort.InferenceSession("ltr.onnx")

print("LTR Model Loaded Successfully")

# --------------------------------------------------------
# Search Query
# --------------------------------------------------------
query = {
    "size": 20,
    "_source": [
        "name",
        "rating",
        "sales",
        "ctr",
        "conversionRate"
    ],
    "query": {
        "match": {
            "name": "iphone"
        }
    }
}

response = es.search(
    index="products",
    body=query
)

hits = response["hits"]["hits"]

print("\n")
print("=" * 100)
print("ORIGINAL BM25 RESULTS")
print("=" * 100)

results = []

rank = 1

for hit in hits:

    source = hit["_source"]

    bm25 = float(hit["_score"])
    rating = float(source.get("rating", 0))
    sales = float(source.get("sales", 0))
    ctr = float(source.get("ctr", 0))
    conversion = float(source.get("conversionRate", 0))

    print(
        f"{rank}. "
        f"{source['name']}"
        f"  BM25={bm25:.3f}"
    )

    feature_vector = [
        bm25,
        rating,
        sales,
        ctr,
        conversion
    ]

    x = np.array(
        [feature_vector],
        dtype=np.float32
    )

    prediction = session.run(
        None,
        {"input": x}
    )

    # Depending on ONNX output shape
    output = prediction[0]

    if output.ndim == 2:
        ltr_score = float(output[0][0])
    else:
        ltr_score = float(output[0])

    results.append(
        {
            "name": source["name"],
            "bm25": bm25,
            "ltr": ltr_score,
            "rating": rating,
            "sales": sales,
            "ctr": ctr,
            "conversion": conversion
        }
    )

    rank += 1

# --------------------------------------------------------
# Sort using LTR Score
# --------------------------------------------------------
results.sort(
    key=lambda x: x["ltr"],
    reverse=True
)

print("\n")
print("=" * 100)
print("LTR RE-RANKED RESULTS")
print("=" * 100)

rank = 1

for r in results:

    print(
        f"{rank}. "
        f"{r['name']}"
    )

    print(f"   BM25 Score      : {r['bm25']:.4f}")
    print(f"   LTR Score       : {r['ltr']:.4f}")
    print(f"   Rating          : {r['rating']}")
    print(f"   Sales           : {r['sales']}")
    print(f"   CTR             : {r['ctr']}")
    print(f"   Conversion Rate : {r['conversion']}")

    print("-" * 100)

    rank += 1