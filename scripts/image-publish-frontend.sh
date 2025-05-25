#!/bin/bash
echo "Building frontend Docker image..."
docker build -t danilgutak/click-frontend:latest ../application/frontend

echo "Publishing frontend image to Docker Hub..."
docker push danilgutak/click-frontend:latest