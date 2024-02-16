#!/bin/bash

# Enhanced Docker Setup for NewRetirement Rails Application
# Adheres to DevOps best practices for robustness and efficiency.

set -e

echo "Starting enhanced Docker setup for NewRetirement Rails Application..."

# Function to check Docker installation
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed. Please install Docker first."
        exit 1
    else
        echo "Docker is installed. Proceeding with setup."
    fi
}

# Function to create and validate Docker Compose file
create_docker_compose_file() {
    local file_path=$1
    echo "Creating Docker Compose file at $file_path..."

    cat << EOF > "$file_path"
version: '3.8'
services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_DB: newretirement_development
      POSTGRES_PASSWORD: New!Retir3
    ports:
      - "5432:5432"
  redis:
    image: redis:7
    ports:
      - "6379:6379"
EOF

    if [[ -f "$file_path" ]]; then
        echo "Docker Compose file successfully created at $file_path."
    else
        echo "Error: Failed to create Docker Compose file."
        exit 1
    fi
}

# Function to run Docker Compose
run_docker_compose() {
    local file_path=$1
    echo "Running Docker Compose using the file at $file_path..."
    docker-compose -f "$file_path" up -d
    echo "Docker containers for PostgreSQL and Redis are up and running."
}

# Main execution flow
check_docker

DOCKER_COMPOSE_FILE="$HOME/docker-compose.yml"
create_docker_compose_file "$DOCKER_COMPOSE_FILE"
run_docker_compose "$DOCKER_COMPOSE_FILE"
