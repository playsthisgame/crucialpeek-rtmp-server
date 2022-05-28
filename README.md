# Crucial Peek NGINX RTMP Server Config

 Creates a docker container that runs NGINX with the RTMP module installed and the config specific for Crucial Peek.

## Build image

    docker build -t crucial-peak-rtmp-server .

## Run container

    docker run -it -d -p 1935:1935 --name local-crucial-peek crucial-peak-rtmp-server
