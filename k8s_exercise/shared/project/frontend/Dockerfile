# Use a lightweight web server image, specifically the Alpine Linux version of Nginx
# This image is much smaller than the full-blown Nginx image, but it still provides a full Nginx web server
FROM nginx:alpine

# Copy the HTML and CSS files from the build context to the default Nginx public directory
# This is where Nginx will serve the files from
COPY . /usr/share/nginx/html

# Expose port 80, which is the standard web server port
# This allows a container running this image to be accessed from outside the container
EXPOSE 80

# Command to start Nginx when the container starts
# The "-g" flag specifies the configuration file to use
# The "daemon off;" flag tells Nginx not to run as a daemon process
CMD ["nginx", "-g", "daemon off;"]
