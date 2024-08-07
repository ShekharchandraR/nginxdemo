# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Copy the index.html file to the Nginx html directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to access the web server
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
