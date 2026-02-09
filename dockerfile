FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy HTML TEMPLATE (not final HTML)
COPY index.html.template /usr/share/nginx/html/index.html.template

# IMPORTANT:
# envsubst runs at CONTAINER START (CMD), not at build time
CMD sh -c '\
  envsubst < /usr/share/nginx/html/index.html.template \
           > /usr/share/nginx/html/index.html && \
  nginx -g "daemon off;"'
