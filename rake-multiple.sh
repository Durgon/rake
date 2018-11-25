#!/usr/bin/env bash

clear
#ask for file
read -p "Specify the file to rake: " list
mkdir -p albums
for line in `cat $list`; do
  label=`wget -q "$line" -O - |grep 'post-title '| cut -d ">" -f2 | cut -d "<" -f1`
  bag="albums/`echo $label|sed 's/\//_/g'`"
  echo "Found album to rake: $label"
  echo ""
  echo "creating bag for images @ $bag"
  mkdir -p "$bag"
  echo ""
  echo "Raking images into bag"
  wget -q "$line" -O - |grep 'post-image-container'| cut -d '"' -f2|while read id;do echo "Raking $id.jpg";wget --progress=bar:force -e robots=off -q -c "https://i.imgur.com/$id.jpg" -P "$bag";done
  echo ">done raking $label"
done
echo "rake complete"
