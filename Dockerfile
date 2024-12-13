# Use the official NGINX base image
FROM nginx:alpine

# Create a non-root user and group with a specific UID/GID
RUN addgroup -S nginx_group && adduser -S nginx_user -G nginx_group \
    && mkdir -p /var/cache/nginx /var/run/nginx /usr/share/nginx/html \
    && chown -R nginx_user:nginx_group /var/cache/nginx /var/run/nginx /usr/share/nginx/html

# Set working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the static HTML file to the NGINX HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Remove the conflicting PID directive
RUN sed -i '/pid\s\+\/var\/run\/nginx.pid;/d' /etc/nginx/nginx.conf

# Modify the default NGINX configuration to use a non-privileged port (8081)
RUN sed -i 's/listen       80;/listen       8081;/' /etc/nginx/conf.d/default.conf

# Expose the updated port (8081)
EXPOSE 8081

# Switch to the created non-root user
USER nginx_user

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
