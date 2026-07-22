# Elastic ECK Setup on Kubernetes

This project installs:

* Elasticsearch
* Kibana
* NGINX Ingress Controller
* Elastic Enterprise Trial License

## Requirements

* Docker Desktop
* Kubernetes Enabled
* kubectl

---

## Project Structure

```text
elksetup_k8s_operator/
│
├── setup.bat
├── install.bat
├── nginx.bat
├── license.bat
│
└── templates/
    ├── elk1/
    ├── elk2/
    └── nginx/
```

---

## Installation

### Step 1

Run:

```powershell
setup.bat
```

This will:

* Check Docker
* Check Kubernetes
* Remove old images
* Download required images

---

### Step 2

Run:

```powershell
install.bat
```

This will install:

* Elastic CRDs
* Elastic Operator
* Elasticsearch
* Kibana

---

### Step 3

Run:

```powershell
nginx.bat
```

This will install:

* NGINX Ingress Controller
* Ingress Resources

---

### Step 4

Run:

```powershell
license.bat
```

This will apply the Elastic Enterprise Trial License.

---

## Installation Order

```text
setup.bat
      ↓
install.bat
      ↓
nginx.bat
      ↓
license.bat
```

---

## Verify Installation

```powershell
kubectl get pods -A

kubectl get svc -A

kubectl get ingress -A
```

---

## Reset Cluster (Optional)

If you want a fresh installation:

1. Reset Kubernetes from Docker Desktop.
2. Run the scripts again in the same order.

---

## License

This project is for learning and testing purposes.


```
PUT _index_template/employees_template
{
  "index_patterns": [
    "employees-*"
  ],
  "template": {
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 1
    },
    "mappings": {
      "properties": {
        "employeeId": {
          "type": "integer"
        },
        "name": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "department": {
          "type": "keyword"
        },
        "salary": {
          "type": "double"
        },
        "joiningDate": {
          "type": "date"
        },
        "active": {
          "type": "boolean"
        }
      }
    }
  },
  "priority": 100
}

POST employees-2026/_doc
{
  "employeeId": 101,
  "name": "Sourabh Sharma",
  "department": "Engineering",
  "salary": 2500000,
  "joiningDate": "2024-01-15",
  "active": true
}

POST _bulk
{"index":{"_index":"employees-2026"}}
{"employeeId":102,"name":"Rahul","department":"Engineering","salary":1800000,"joiningDate":"2023-03-01","active":true}
{"index":{"_index":"employees-2026"}}
{"employeeId":103,"name":"Neha","department":"HR","salary":1200000,"joiningDate":"2022-06-12","active":true}
{"index":{"_index":"employees-2026"}}
{"employeeId":104,"name":"Amit","department":"Finance","salary":1500000,"joiningDate":"2021-10-20","active":false}
{"index":{"_index":"employees-2026"}}
{"employeeId":105,"name":"Priya","department":"Engineering","salary":2000000,"joiningDate":"2025-02-18","active":true}


GET employees-2026/_search

GET elasticsearch2:employees-2026/_search
```