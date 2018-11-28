#!/usr/bin/env bash

clear
read -p "Enter the link to the imgur album you want to rake: " album
mkdir -p albums
folder=$(wget -q "$album" -O - |grep 'post-title '| cut -d ">" -f2 | cut -d "<" -f1)
echo "Found some images to rake $folder @ $album"
mkdir -p albums/"$folder"
wget -e robots=off -q "$album" -O - |grep 'post-image-container'| cut -d '"' -f2|while read id;do echo "raking $id.jpg";wget -qce robots==off --show-progress "https://i.imgur.com/$id.jpg" -P albums/"$folder"/;done
