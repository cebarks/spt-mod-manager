#!/usr/bin/env bash

echo Creating fake server for testing...
cp -rv fake_server_data/ fake_server/
cd fake_server

while IFS= read -r path || [[ -n $path ]]; do
    [[ -z "$path" ]] && continue # Skip empty lines
    [[ "$path" =~ ^[[:space:]]*# ]] && continue # Skip comment lines (starting with '#')

    clean_path="${path#/}"
    full_path="${clean_path}"

    # Separate directory and file components
    dir_part="${full_path%/*}"
    file_part="${full_path##*/}"

    # If the path is just a filename (no slash), dir_part will equal the file name
    # In that case we skip directory creation
    if [[ "$dir_part" != "$full_path" ]]; then
        if ! mkdir -p "$dir_part"; then
            echo "Warning: Could not create directory '$dir_part'" >&2
            continue   # skip touching this file
        fi
    fi

    touch "$path"
done < ../test-sptd-files.txt

echo "Done!"
