# Stage 1: Build Stage
FROM node:16-alpine as builder

ARG REACT_APP_IMAGE_TAG
ENV REACT_APP_IMAGE_TAG=$REACT_APP_IMAGE_TAG

# Create and set the working directory
WORKDIR '/app'

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json .

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .


# Build the application
RUN npm run build

# Stage 2: Production Stage
FROM nginx

# Expose port 80
EXPOSE 80

# Copy the build output from the builder stage to the Nginx html directory
COPY --from=builder /app/build /usr/share/nginx/html
