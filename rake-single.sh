#!/usr/bin/env bash

clear
read -p "Enter the imgur album link you would like to download: " album
mkdir -p albums
folder=$(wget -q "$album" -O - |grep 'post-title '| cut -d ">" -f2 | cut -d "<" -f1)
echo "Found an album called '$folder'"
mkdir -p albums/"$folder"
wget -e robots=off -q "$album" -O - |grep 'post-image-container'| cut -d '"' -f2|while read id;do echo "Downloading $id.jpg";wget -q -c "https://i.imgur.com/$id.jpg" -P albums/"$folder"/;done
