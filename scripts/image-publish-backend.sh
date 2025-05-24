
#!/bin/bash
echo "Building backend Docker image..."
docker build -t $DOCKERHUB_USER/click-backend:latest ./application/backend

echo "Publishing backend image to Docker Hub..."
docker push $DOCKERHUB_USER/click-backend:latest