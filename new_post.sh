#!/bin/bash

read -ep "blog title: " title

echo -e "\033[0;32mCreating new post...\033[0m"

formatted_date=$(date "+%Y-%m-%d")

underscore_tilte=$(echo $title | sed -e "s/ /_/g")

path="posts/${formatted_date}_${underscore_tilte}.md" 
echo $path

hugo new $path

$EDITOR "content/$path"
