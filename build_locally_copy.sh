#!/bin/sh

printf "####### RESTFUL-BOOKER-PLATFORM #######
####                               ####
####       PRE FLIGHT CHECKS       ####
####                               ####
#######################################\n"


mvn clean

printf "\n####### RESTFUL-BOOKER-PLATFORM #######
####                               ####
####      BUILDING FRONTEND        ####
####                               ####
#######################################\n"

cd .utilities/rbp-proxy/local
npm install
cd ../../..

cd assets/js
npm install
npm run test
npm run build

printf "\n####### RESTFUL-BOOKER-PLATFORM #######
####                               ####
####       BUILDING BACKEND        ####
####                               ####
#######################################\n"

cd ../..


if [[ -z "${APPLITOOLS_API_KEY}" ]]; then
  printf "Skipping visual checks because no applitools api key has been set. Assign a key to APPLITOOLS_API_KEY to run visual checks"
  mvn install -Dvisual.skip.test=true
else
  mvn install
fi

/bin/bash ./run_locally.sh -e true
