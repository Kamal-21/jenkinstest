!/bin/bash

# Variables
JENKINS_IMAGE="jenkins/jenkins:lts"
CONTAINER_NAME="jenkins_container"
HOST_PORT=8080
DOCKER_SOCKET="/var/run/docker.sock"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker before running this script."
    exit 1
fi

# Pull the Jenkins Docker image
docker pull $JENKINS_IMAGE

# Create a Docker network for Jenkins
docker network create $CONTAINER_NAME-network

# Run Jenkins in a Docker container
docker run -d \
    --name $CONTAINER_NAME \
    --network $CONTAINER_NAME-network \
    -p $HOST_PORT:8080 \
    -p 50000:50000 \
    -v jenkins_home:/var/jenkins_home \
    -v $DOCKER_SOCKET:/var/run/docker.sock \
    $JENKINS_IMAGE

# Wait for Jenkins to start
echo "Waiting for Jenkins to start..."
sleep 30
# Retrieve the Jenkins initial admin password
echo "Jenkins initial admin password:"
docker exec $CONTAINER_NAME cat /var/jenkins_home/secrets/initialAdminPassword

# Print Jenkins URL
echo "Jenkins URL: http://localhost:$HOST_PORT"
sleep 15

ngrok http --domain=usable-nearby-cardinal.ngrok-free.app 8080
