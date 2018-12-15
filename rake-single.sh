#!/usr/bin/env bash

clear
#---------TESTING ONLY--------
echo "remove existing Albums folder"
rm -rf Albums/
#--------END OF TESTING--------

#read -p "Enter the link to the imgur album you want to rake: " album
#
album=$1
mkdir -p Albums
folder=$(wget -q "$album" -O - |grep 'post-title '| cut -d ">" -f2 | cut -d "<" -f1)
echo "Found some images to rake from $folder @ $album"
mkdir -p Albums/"$folder"
count=`wget -q "$album" -O - |grep 'post-image-container'| cut -d '"' -f2|wc -l`
echo "Found $count images to rake"
wget -e robots=off -q "$album" -O - |grep 'post-image-container'| cut -d '"' -f2|while read id;do echo "Raking $id.jpg";wget -qce robots=off --show-progress "https://i.imgur.com/$id.jpg" -P albums/"$folder"/;done
