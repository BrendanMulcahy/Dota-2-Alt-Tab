#! /bin/bash

#stop script on errors:
set -e

echo '== Creating folders =='
mkdir -p ../results/dota2alttab/
mkdir -p ../results/dota2alttab/Dota2_Alt_Tab/Images/Sprites
mkdir -p ../images/0_ids
mkdir -p ../results/itembuilds
mkdir -p ../results/playdota_dota1
echo '== Folders created! =='

echo '== Dota2 guides =='
cd ../lua
lua pages/dotaalttab.lua
echo '== Dota2 guides created! =='

echo '== Sprites =='
cd ../images
../scripts/create_sprites.sh
echo '== Sprites created! =='

echo '== Dota 1 guides =='
cd ../lua
lua pages/playdota_main.lua
lua pages/playdota.lua
echo '== Dota 1 guides created! =='

echo '== Dota2 ingame builds =='
cd ../lua
lua pages/recommended_items.lua
cd ../results
zip -r ii itembuilds
mv ii.zip dota2alttab/itembuilds.zip
echo '== Dota2 ingame builds created! =='

echo '== Markdown guides =='
cd ../lua
lua pages/markdown.lua
echo '== Markdown guides finished! =='

echo '== Script Finished! =='