#!/bin/bash
echo "Building frontend Docker image..."
docker build -t $DOCKERHUB_USER/click-frontend:latest ./application/frontend

echo "Publishing frontend image to Docker Hub..."
docker push $DOCKERHUB_USER/click-frontend:latest