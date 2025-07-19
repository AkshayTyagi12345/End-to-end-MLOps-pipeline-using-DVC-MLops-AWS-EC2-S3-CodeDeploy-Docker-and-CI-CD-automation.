#!/bin/bash
# Login to AWS ECR
aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 051826734860.dkr.ecr.ap-southeast-2.amazonaws.com

# Pull the latest image
docker pull 051826734860.dkr.ecr.ap-southeast-2.amazonaws.com/akshay_ecr:latest

# Check if the container 'akshay-app' is running
if [ "$(docker ps -q -f name=akshay-app)" ]; then
    # Stop the running container
    docker stop akshay-app
fi

# Check if the container 'akshay-app' exists (stopped or running)
if [ "$(docker ps -aq -f name=akshay-app)" ]; then
    # Remove the container if it exists
    docker rm akshay-app
fi

# Run a new container
docker run -d -p 80:5000 -e DAGSHUB_PAT=e691c7193ab61dc9678e31c6b92ded8a65f80697 --name akshay-app 051826734860.dkr.ecr.ap-southeast-2.amazonaws.com/akshay_ecr:latest
