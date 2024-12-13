# Use the official NGINX base image
FROM nginx:alpine

# Create a new user and group 'nginx'
RUN addgroup -S nginx && adduser -S nginx -G nginx

# Set working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the static HTML file to the NGINX HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port TCP/80
EXPOSE 80

# Switch to the 'nginx' user before running the container
USER nginx

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
