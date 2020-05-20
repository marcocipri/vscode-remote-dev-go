#!/bin/bash

## loads the global version variables
source ./env.sh
## module name
export NAME=vscode-remote-dev-go
export SNAPSHOT=""
export BASE_IMAGE=moka-java-base

## replace image FROM parameters in Dockerfile.template and generates a Dokerfile.temp
sed -e "s/\${REPO}/$REPO/" -e "s/\${VERSION}/$VERSION/" -e "s/\${BASE_IMAGE}/$BASE_IMAGE/"  Dockerfile.template > Dockerfile


echo 'download tomcat from archive.apache.org'



echo 'build the image'
echo $RELEASE_DATE

docker build -t $REPO/$NAME:$VERSION$SNAPSHOT --force-rm=true   --build-arg=SNAPSHOT=$SNAPSHOT  --build-arg=VERSION=$VERSION --build-arg=RELEASE_DATE=$RELEASE_DATE --build-arg=NAME=$NAME  --build-arg=TOMCAT_VER=$TOMCAT_VER -f Dockerfile .
docker push $REPO/$NAME:$VERSION$SNAPSHOT

rm Dockerfile