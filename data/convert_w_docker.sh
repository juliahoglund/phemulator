#!/bin/bash

# currently, plink is not available on MacOs M2 computers
# in that case, this script can be run instead,
# which pulls a docker container with plink2 installed.
# by mounting the local directory inside the image, 
# convert the files, and then places them locally 

docker pull biocontainer/plink2:alpha2.3_jan2020

# if the default OS needs to be changed.
# export DOCKER_DEFAULT_PLATFORM=linux/amd64

# check that is works
docker run biocontainer/plink2:alpha2.3_jan2020 plink2 --help


# convert
docker run -it --name plink --mount type=bind,source="$(pwd)",target=/bgen biocontainer/plink2:alpha2.3_jan2020 \
	bash -c "cd bgen &&
	plink2 \
        --export bgen-1.2 bits=8 \
        --pgen Rum_recoded_repos.bed \
        --pvar Rum_recoded_repos.bim \
        -psam Rum_recoded_repos.fam \
        --maj-ref 'force' \
        --allow-extra-chr \
        --out Rum_recoded_repos \
        --autosome-num 33"

# grab converted files
docker cp plink:/bgen/Rum_recoded_repos.bgen .
docker cp plink:/bgen/Rum_recoded_repos.sample .
docker rm plink