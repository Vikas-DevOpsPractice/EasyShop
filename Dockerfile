# Description: Dockerfile for Next.js application
FROM node:20-alpine as builder

 # Create app directory
RUN mkdir -p /usr/src/app

# set working directory
WORKDIR /usr/src/app

# Install dependencies
COPY package.json /usr/src/app/
RUN npm install

 # Copy source code
COPY . /usr/src/app

# Build the Next.js application
RUN npm run build

# Expose the port Next.js uses
EXPOSE 3000

# Start the application
CMD ["npm", "start"]





# # ---- Build stage ----
#     FROM node:20-alpine AS builder

#     WORKDIR /app
    
#     # Install dependencies
#     COPY package.json package-lock.json ./
#     RUN npm install
    
#     # Copy source code
#     COPY . .
    
#     # Build the Next.js application
#     RUN npm run build
    
#     # ---- Production stage (Distroless) ----
#     FROM gcr.io/distroless/nodejs20-debian12
    
#     WORKDIR /app
    
#     # Copy built files from builder
#     COPY --from=builder /app/package.json /app/package.json
#     COPY --from=builder /app/node_modules /app/node_modules
#     COPY --from=builder /app/.next /app/.next
#     COPY --from=builder /app/public /app/public
    
#     # Expose the port Next.js uses
#     EXPOSE 3000
    
#     # Start the application
#     CMD ["node_modules/.bin/next", "start"]
    
    
    
    
    