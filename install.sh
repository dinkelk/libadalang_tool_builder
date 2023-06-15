#!/bin/sh

dest_dir=$1

if test -z "$dest_dir"
then
    echo "DESTINATION_DIR not specified as the first argument." >&2
    exit 1
fi

install() {
    dir="./alire/cache/dependencies/$1*/bin/"
    for bin in `find $dir -type f`; do
        dest="$dest_dir/`basename $bin`"
        echo "Installing $bin to $dest."
        cp -f $bin $dest
        chmod +x $dest
    done;
}

install libadalang_tools

echo "Done!"
