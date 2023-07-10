FROM nginx:stable
COPY ./files/proxy/nginx.conf /etc/nginx/nginx.conf
