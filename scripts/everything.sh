#! /bin/bash

echo '== Creating folders =='

mkdir -p ../results/dota2alttab/
mkdir -p ../results/dota2alttab/Dota2_Alt_Tab/Images/Sprites
mkdir -p ../images/0_ids

mkdir -p ../results/itembuilds

mkdir -p ../results/playdota_dota1

echo '== Dota2 guides =='
lua pages/dotaalttab.lua


echo '-- Sprites --'
cd ../images
../scripts/create_sprites.sh
cd ../lua

echo '== Dota 1 guides =='
lua pages/playdota_main.lua
lua pages/playdota.lua

echo '== Dota2 ingame builds =='
lua pages/recommended_items.lua
cd ../results
zip -r ii itembuilds
mv ii.zip dota2alttab/itembuilds.zip
cd ../lua

echo '== Markdown guides =='
lua pages/markdown.lua
