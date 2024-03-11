proxy_http_version 1.1;

location /api/ { proxy_pass http://172.31.5.158:8080/; }

location /health {
  stub_status on;
  access_log off;
}