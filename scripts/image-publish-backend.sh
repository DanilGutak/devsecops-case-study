
#!/bin/bash
echo "Building backend Docker image..."
docker build -t danigutak/click-backend:latest ../application/backend

echo "Publishing backend image to Docker Hub..."
docker push danigutak/click-backend:latest