# Stage 1: Dependencies
FROM node:26-alpine AS deps
WORKDIR /app

COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev --ignore-scripts

# Stage 2: Build
FROM node:26-alpine AS build
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Stage 3: Production Runner
FROM node:26-alpine AS runner
WORKDIR /app

# Copy dependencies and application code from build stage
COPY --chown=node:node --from=build /app/node_modules ./node_modules
COPY --chown=node:node package.json index.js app.js ./

# Use non-root user for security
USER node

# Expose server port
EXPOSE 4444

# Run the application
CMD ["node", "index.js"]