# Create Products Index template
```
PUT products
{
  "mappings": {
    "properties": {
      "productId": {
        "type": "integer"
      },
      "name": {
        "type": "text"
      },
      "brand": {
        "type": "keyword"
      },
      "category": {
        "type": "keyword"
      },
      "description": {
        "type": "text"
      },
      "price": {
        "type": "float"
      },
      "rating": {
        "type": "float"
      },
      "reviewCount": {
        "type": "integer"
      },
      "sales": {
        "type": "integer"
      },
      "ctr": {
        "type": "float"
      },
      "conversionRate": {
        "type": "float"
      },
      "inventory": {
        "type": "integer"
      }
    }
  }
}
```

# Bluk Insert the docs into Product index
```
POST products/_bulk 
{"index":{"_id":16}}{"productId":16,"name":"Apple iPhone 16 Plus","brand":"Apple","category":"Mobile","description":"Large display Apple smartphone with A18 chip","price":1199,"rating":4.8,"reviewCount":3500,"sales":17000,"ctr":0.26,"conversionRate":0.18,"inventory":42} {"index":{"_id":17}}{"productId":17,"name":"Apple iPhone 15","brand":"Apple","category":"Mobile","description":"Previous generation Apple smartphone","price":899,"rating":4.7,"reviewCount":5400,"sales":29000,"ctr":0.29,"conversionRate":0.21,"inventory":85} {"index":{"_id":18}} {"productId":18,"name":"Apple iPhone 15 Pro","brand":"Apple","category":"Mobile","description":"Professional Apple smartphone","price":1099,"rating":4.8,"reviewCount":5100,"sales":24000,"ctr":0.27,"conversionRate":0.19,"inventory":53} {"index":{"_id":19}} {"productId":19,"name":"Samsung Galaxy S24 Ultra","brand":"Samsung","category":"Mobile","description":"Premium Android flagship smartphone","price":1299,"rating":4.8,"reviewCount":4300,"sales":18500,"ctr":0.24,"conversionRate":0.17,"inventory":49} {"index":{"_id":20}} {"productId":20,"name":"Google Pixel 10 Pro","brand":"Google","category":"Mobile","description":"Google AI powered smartphone","price":1099,"rating":4.8,"reviewCount":2600,"sales":11000,"ctr":0.23,"conversionRate":0.16,"inventory":61} {"index":{"_id":21}} {"productId":21,"name":"Apple Lightning Cable","brand":"Apple","category":"Accessory","description":"Original charging cable for iPhone","price":29,"rating":4.5,"reviewCount":8100,"sales":61000,"ctr":0.38,"conversionRate":0.30,"inventory":520} {"index":{"_id":22}} {"productId":22,"name":"Apple USB-C Cable","brand":"Apple","category":"Accessory","description":"USB-C charging cable","price":35,"rating":4.6,"reviewCount":4800,"sales":45000,"ctr":0.35,"conversionRate":0.26,"inventory":430} {"index":{"_id":23}} {"productId":23,"name":"Apple AirTag","brand":"Apple","category":"Accessory","description":"Bluetooth item tracker","price":39,"rating":4.8,"reviewCount":6300,"sales":39000,"ctr":0.31,"conversionRate":0.23,"inventory":350} {"index":{"_id":24}} {"productId":24,"name":"Apple Magic Keyboard","brand":"Apple","category":"Keyboard","description":"Wireless keyboard","price":149,"rating":4.7,"reviewCount":2800,"sales":12000,"ctr":0.22,"conversionRate":0.15,"inventory":95} {"index":{"_id":25}} {"productId":25,"name":"Apple Magic Mouse","brand":"Apple","category":"Mouse","description":"Wireless Apple mouse","price":99,"rating":4.5,"reviewCount":1900,"sales":9500,"ctr":0.18,"conversionRate":0.12,"inventory":102} {"index":{"_id":26}} {"productId":26,"name":"Sony WF-1000XM6 Earbuds","brand":"Sony","category":"Audio","description":"Noise cancelling wireless earbuds","price":279,"rating":4.8,"reviewCount":2100,"sales":13000,"ctr":0.26,"conversionRate":0.18,"inventory":70} {"index":{"_id":27}} {"productId":27,"name":"Bose QuietComfort Ultra","brand":"Bose","category":"Headphones","description":"Premium noise cancelling headphones","price":429,"rating":4.9,"reviewCount":1800,"sales":8500,"ctr":0.21,"conversionRate":0.15,"inventory":38} {"index":{"_id":28}} {"productId":28,"name":"JBL Flip 7 Speaker","brand":"JBL","category":"Audio","description":"Portable Bluetooth speaker","price":149,"rating":4.6,"reviewCount":2400,"sales":14500,"ctr":0.24,"conversionRate":0.17,"inventory":90} {"index":{"_id":29}} {"productId":29,"name":"Dell Inspiron 15","brand":"Dell","category":"Laptop","description":"Affordable Windows laptop","price":799,"rating":4.5,"reviewCount":1500,"sales":8300,"ctr":0.17,"conversionRate":0.10,"inventory":41} {"index":{"_id":30}} {"productId":30,"name":"HP Spectre x360","brand":"HP","category":"Laptop","description":"Convertible premium laptop","price":1699,"rating":4.7,"reviewCount":1200,"sales":7200,"ctr":0.18,"conversionRate":0.12,"inventory":26}
```