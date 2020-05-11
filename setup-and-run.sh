#!/usr/bin/env bash

# COLOQUE AQUI SEU USUARIO DOCKERHUB
dockerhub_user=fernandopavan
image_name=devops-jenkins
image_version=0.0.1
jenkins_port=8081
container_name=md-jenkins

docker pull jenkins:2.112

docker stop ${container_name}

docker build --no-cache -t ${dockerhub_user}/${image_name}:${image_version} . 

if [ ! -d m2deps ]; then
    mkdir m2deps
fi
if [ -d jobs ]; then
    rm -rf jobs
fi
if [ ! -d jobs ]; then
    mkdir jobs
fi

docker run -p ${jenkins_port}:8081 \
    -v `pwd`/jobs:/var/jenkins_home/jobs/ \
    -v `pwd`/m2deps:/var/jenkins_home/.m2/repository/ \
    --rm --name ${container_name} \
    ${dockerhub_user}/${image_name}:${image_version}
