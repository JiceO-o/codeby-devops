FROM alpine:latest

RUN apk add --no-cache nginx

RUN mkdir -p /opt/www

RUN echo "<h1>Welcome to nginx on Alpine!</h1>" > /opt/www/index.html

RUN echo "server { \
    listen 80; \
    location / { \
        root /opt/www; \
        index index.html; \
    } \
}" > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
