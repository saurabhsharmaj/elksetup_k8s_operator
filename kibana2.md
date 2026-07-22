GET _remote/info
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
  "employeeId": 102,
  "name": "Jagdish kumawat",
  "department": "Engineering",
  "salary": 1500000,
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
GET employees-2026/_search

GET elasticsearch1:employees-2026/_search