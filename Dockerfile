# Stage 1: Build Stage
# FROM node:lts-alpine as builder
FROM node@sha256:db4b1d98b5a92263f2b9221c4d7930ce6b02f9834926c8b6174bfed2913cea16 as builder

# Declare the ARG for use in build-time (if it's coming from .travis.yml)
ARG REACT_APP_IMAGE_TAG

# Set it as an ENV so it's available at runtime in the environment
ENV REACT_APP_IMAGE_TAG=$REACT_APP_IMAGE_TAG

# Create and set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production Stage
# Use a specific version of nginx
FROM nginx:1.26.0 
# FROM nginx

# Expose port 80 for the container
EXPOSE 80

# Copy the build output from the builder stage to the Nginx HTML directory
COPY --from=builder /app/build /usr/share/nginx/html

# Provide a default command for running the container, Nginx runs by default so CMD is not strictly necessary
CMD ["nginx", "-g", "daemon off;"]
