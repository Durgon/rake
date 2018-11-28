#!/usr/bin/env bash

clear
#ask for file
read -p "Specify the file to rake: " list
#create the albums directory if not present
mkdir -p Albums
for line in `cat $list`; do
  #get post title for the link
  label=`wget -q "$line" -O - |grep 'post-title '| cut -d ">" -f2 | cut -d "<" -f1`
  #set target folder for album
  bag="albums/`echo $label|sed 's/\//_/g'`"
  echo "Found album to rake called $label @ $line"
  echo ""
  echo "creating bag for images @ $bag"
  #create target folder for album
  mkdir -p "$bag"
  echo ""
  echo "Raking images into bag"
  #rake through album and get all images
  wget -q "$line" -O - |grep 'post-image-container'| cut -d '"' -f2|while read id;do echo "Raking $id.jpg";wget -qce robots=off --show-progress "https://i.imgur.com/$id.jpg" -P "$bag";done
  echo "done raking $label @ $line"
done
echo "rake complete of $list"
