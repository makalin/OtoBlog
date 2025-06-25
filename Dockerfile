# Build stage
FROM klakegg/hugo:ext-alpine AS builder

WORKDIR /src
COPY . .

# Build the site
RUN hugo --minify

# Production stage
FROM nginx:alpine

# Copy built site to nginx
COPY --from=builder /src/public /usr/share/nginx/html

# Copy custom nginx config if needed
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 