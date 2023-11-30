#!/bin/bash

#  if bgen cannot be installed locally, 
# or is not available 
# (eg is not available on MacOs M2 (arm54) computers)
# this script can be run instead,
# which pulls a docker container with bgen(ix) installed.
# by mounting the local directory inside the image, 
# index the files, and then places them locally
 

docker pull lifebitai/bgenix:latest

# if the default OS needs to be changed.
# export DOCKER_DEFAULT_PLATFORM=linux/amd64

# check that is works
docker run lifebitai/bgenix:latest bgenix

# index
docker run -it --name bgen --mount type=bind,source="$(pwd)",target=/index lifebitai/bgenix:latest \
    bgenix -g index/Rum_recoded_repos.bgen -index

# grab converted files
docker cp bgen:/index/Rum_recoded_repos.bgen.bgi .
docker rm bgen