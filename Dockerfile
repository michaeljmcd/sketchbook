FROM nginx
COPY angular-tour-of-heroes/ /usr/share/nginx/html
COPY proxy.conf /etc/nginx/conf.d/proxy.conf
