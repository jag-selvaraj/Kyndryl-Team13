# Use the official NGINX base image
FROM nginx:alpine

# Set working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the static HTML file to the NGINX HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

