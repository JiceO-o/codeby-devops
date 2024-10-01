FROM debian:11

RUN apt-get update && apt-get install -y nginx && apt-get clean

RUN mkdir -p /opt/www

RUN echo "<h1>Welcome to nginx on Debian!</h1>" > /opt/www/index.html

RUN echo "server { \
    listen 80; \
    location / { \
        root /opt/www; \
        index index.html; \
    } \
}" > /etc/nginx/sites-available/default

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
