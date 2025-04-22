
# Stage 1: Build the frontend
FROM node:16 AS build-stage

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies for the frontend and backend
RUN npm install

# Copy the entire project
COPY . .

# Build the frontend assets
RUN npm run build

# Stage 2: Setup the backend
FROM node:16 AS production-stage

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json for production
COPY package*.json ./

# Install only the production dependencies
RUN npm install --only=production

# Copy the backend code and built frontend assets from the build stage
COPY --from=build-stage /app /app

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
