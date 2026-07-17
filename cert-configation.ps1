kubectl get secret elasticsearch1-es-http-certs-public `
-n elastic `
-o jsonpath="{.data.ca\.crt}" > ca.b64

certutil -decode ca.b64 ca.crt