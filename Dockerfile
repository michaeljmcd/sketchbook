FROM nginx
COPY angular-tour-of-heroes/ /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
