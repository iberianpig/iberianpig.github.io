#!/bin/bash

echo -e "\033[0;32mCreating new post...\033[0m"

if [ $# -eq 1 ]; then
  title="_$1"
else
  title=""
fi

formatted_date=$(date "+%Y-%m-%d")

path="posts/${formatted_date}${title}.md" 

hugo new $path

vi "content/$path"
