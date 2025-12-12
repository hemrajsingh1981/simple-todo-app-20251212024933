FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./ 

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the Next.js application
RUN npm run build

# --- Runner Stage ---
FROM node:18-alpine AS runner

# Set working directory
WORKDIR /app

# Set environment variables
ENV NODE_ENV production
ENV PORT 3000

# Create a non-root user and group
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy standalone output from builder stage
COPY --from=builder /app/.next/standalone ./ 

# Copy public directory from builder stage
COPY --from=builder /app/public ./public

# Ensure the app directory is owned by the non-root user
RUN chown -R nextjs:nodejs /app

# Switch to the non-root user
USER nextjs

# Expose the port the application runs on
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]