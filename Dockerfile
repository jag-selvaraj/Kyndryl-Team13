# Use the official NGINX base image
FROM nginx:alpine

# Create a non-root user and group with specific UID/GID
RUN addgroup -S nginx_group && adduser -S -G nginx_group nginx_user

# Set working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the static HTML file to the NGINX HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Adjust ownership and permissions for the non-root user
RUN chown -R nginx_user:nginx_group /usr/share/nginx/html

# Expose port TCP/80
EXPOSE 80

# Switch to the created non-root user
USER nginx_user

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
