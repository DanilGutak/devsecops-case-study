
#!/bin/bash
echo "Building backend Docker image..."
docker build -t danigutak/click-backend:1.0.0 ../application/backend

echo "Publishing backend image to Docker Hub..."
docker push danilgutak/click-backend:1.0.0