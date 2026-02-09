FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html.template /usr/share/nginx/html/index.html.template

CMD sh -c '\
  export POD_NAME="${POD_NAME:-$HOSTNAME}"; \
  envsubst < /usr/share/nginx/html/index.html.template \
           > /usr/share/nginx/html/index.html && \
  nginx -g "daemon off;"'
