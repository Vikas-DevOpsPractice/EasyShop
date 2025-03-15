# ---- Build stage ----
    FROM node:20-alpine AS builder

    WORKDIR /app
    
    # Copy package.json and lock file separately to leverage caching
    COPY package.json package-lock.json ./
    
    # Install dependencies including those needed for building
    RUN npm ci
    
    # Copy source code
    COPY . .
    
    # Build the Next.js application
    RUN npm run build
    
    # ---- Production stage (Distroless) ----
    FROM gcr.io/distroless/nodejs20-debian12
    
    WORKDIR /app
    
    # Copy built files from builder
    COPY --from=builder /app/package.json /app/package.json
    COPY --from=builder /app/node_modules /app/node_modules
    COPY --from=builder /app/.next /app/.next
    COPY --from=builder /app/public /app/public
    
    # Expose the port Next.js uses
    EXPOSE 3000
    
    # Start the application
    CMD ["node_modules/.bin/next", "start"]
    