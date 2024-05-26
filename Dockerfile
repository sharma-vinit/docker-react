# Stage 1: Build Stage
FROM node:lts-alpine3.20 as builder

# Set the user to 'node' for better security
USER node

# Create and set the working directory
WORKDIR '/app'

# Copy the package.json and package-lock.json files to the working directory
COPY --chown=node:node package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY --chown=node:node . .

# Build the application
RUN npm run build

# Stage 2: Production Stage
FROM nginx:1.26.0

# Expose port 80
EXPOSE 80

# Copy the build output from the builder stage to the Nginx html directory
COPY --from=builder /home/node/app/build /usr/share/nginx/html

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
