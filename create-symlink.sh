#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <config_folder_path>"
  exit 1
fi

config_folder_path=$1

script_dir=$(dirname "$(realpath "$0")")
script_name=$(basename "$0")

for item in "$script_dir"/*; do
  item_name=$(basename "$item")

  if [ "$item_name" == ".git" ] || [ "$item_name" == ".gitignore" ] || [ "$item_name" == "$script_name" ]; then
    continue
  fi

  ln -s "$item" "$config_folder_path/$item_name"
done

echo "Symlinks created successfully in $config_folder_path."
