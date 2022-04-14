#!/bin/bash

PROJECT_DIR_REGEX="\d*_.*"
mkdir -p output
for DIR_NAME in $(ls -d */); do
	if [[ $DIR_NAME =~ $PROJECT_DIR_REGEX ]]; then
        cd $DIR_NAME
		pandoc ${DIR_NAME::-1}.md -o ../output/${DIR_NAME::-1}.pdf
        cd ../
	fi;
done;
