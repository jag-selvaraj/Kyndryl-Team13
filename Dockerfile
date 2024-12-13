# Use the official NGINX base image with a specific version tag (avoid using "latest")
FROM nginx:1.27.3-alpine

# Install necessary utilities and clean up afterwards (reducing image size)
RUN apk add --no-cache --virtual .build-deps bash \
    && rm -rf /var/cache/apk/*

# Set working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the static HTML file to the NGINX HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port TCP/80 (still running as root)
EXPOSE 80

# Set permissions for NGINX to access the copied content (it’s still running as root, so this is more about potential issues with file access)
RUN chown -R root:root /usr/share/nginx/html

# Add a health check to monitor NGINX status
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:80 || exit 1

# Start NGINX server as root
CMD ["nginx", "-g", "daemon off;"]
