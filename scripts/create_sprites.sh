#! /bin/bash

# Run this file from the images/ folder

# -append concatenates vertically
# +append concatenates horizontally

# For more advanced stuff, it looks like that there is a "montage"
#  command we could be using instead.

set -e

dpath='../results/dota2alttab/Dota2_Alt_Tab'
ipath="$dpath/Images"
spath="$ipath/Sprites"

cd ./Heroes
echo "Big Heroes..."
convert `cat ../0_ids/heroes.txt`				-append "../$spath/heroes_big.jpg"
echo "Small Heroes..."
convert `cat ../0_ids/heroes.txt`	-resize 50%	-append "../$spath/heroes_small.jpg"
cd ..

cd ./Items
echo "Small Items"
convert `cat ../0_ids/items.txt`	-resize 60%	-append "../$spath/items_small.jpg"
cd ..

cd ./Symbols
echo "Symbols"
convert `cat ../0_ids/symbols.txt`				+append "../$spath/symbols.png"
cd ..

cd ./Taverns
echo "Taverns"
convert `cat ../0_ids/taverns.txt`				-append "../$spath/taverns.png"
cd ..

cp favicon.ico "$dpath/"
cp banner.png  "$ipath/"
