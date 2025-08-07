# Build Stage
FROM ubuntu:latest AS builder

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter channel stable
RUN flutter upgrade

# Copy app source and build
WORKDIR /app
COPY . .
RUN flutter clean
RUN flutter build web

# Serve Stage
FROM nginx:alpine

# Copy built web app from build stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]