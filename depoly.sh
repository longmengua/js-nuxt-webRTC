#!/bin/bash

# Function to display an error message and exit
function display_error {
    echo "Error: $1"
    exit 1
}

# Function to perform deployment steps
function deploy_steps {
    PORT=80
    NAME=webrtc
    DOCKERFILE_NAME=dockerfile

    # Step 3
    echo "===> Start building"
    docker build \
        -f $DOCKERFILE_NAME \
        -t $NAME .

    # Check if docker build failed
    if [ $? -ne 0 ]; then
        display_error "Docker build failed. Check the error message above for details."
    fi

    # Step 4
    echo "===> Start deploying"
    docker rm -f $NAME \
        && docker run -d -p $PORT:3000 --name $NAME $NAME
}

# Perform environment-specific steps
deploy_steps