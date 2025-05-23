# Multi-stage build for QuizMaster application
# Stage 1: Build React frontend
FROM node:18-alpine AS frontend-build

WORKDIR /app/frontend

# Copy frontend package files
COPY quiz-maker/package*.json ./
RUN npm ci

# Copy frontend source code
COPY quiz-maker/src ./src
COPY quiz-maker/public ./public
COPY quiz-maker/tailwind.config.js ./

# Set environment variable for React build
ENV REACT_APP_BACKEND_URL=/api

# Build React app
RUN npm run build

# Stage 2: Setup backend and serve both frontend and backend
FROM node:18-alpine AS production

WORKDIR /app

# Install backend dependencies
COPY backend/package*.json ./
RUN npm ci --only=production

# Copy backend source code
COPY backend/ ./

# Copy built frontend from previous stage
COPY --from=frontend-build /app/frontend/build ./public

# Create logs directory
RUN mkdir -p logs

# Expose port
EXPOSE 5000

# Start the application
CMD ["npm", "start"] 