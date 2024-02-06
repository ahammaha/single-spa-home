# Use an official Node.js runtime as a base image
FROM node:14 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Use an official Nginx image as a base image
FROM nginx:alpine

# Copy the built React app from the build stage to the Nginx public directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the containe4r runs
CMD ["nginx", "-g", "daemon off;"]