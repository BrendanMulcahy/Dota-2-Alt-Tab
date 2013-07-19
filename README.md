## Prerequisites
- The ability to execute Unix shell scripts (CygWin or native *nix)
- Lua
- Python
- ImageMagick

## How to run the code
Go to the /lua directory and, from there run the scripts in the /pages directory

    cd lua
    lua pages/dotaalttab.lua

The output will be placed somewhere in the results folder.
(In the future we should have some way to automate this better)

## How to view the html file locally

If you have python installed, doing a 

    python -m SimpleHTTPServer

on the dota2alttab folder and going to *http:8000//localhost/index.html* is a quick way without having to configure anything.

## How to add a new Dota 1 hero

1. Add the hero to data/base/heroes.lua
    - Just choose a short and easy to remember nickname
2. Add the hero to data/v_dota1/heroes.lua
3. Add the hero to data/v_dota1/taverns.lua
4. Update data/a_playdota/hero_images
    - Get the image URL over on playdota.com/heroes
5. Add relevant hero abbreviations so the search bar knows about them.
   Currently this is directly in the dotaalttab.lua file but it would be better if
   this information were moved to the data folder.

## How to add a new Dota 2 hero

1. Make sure the hero was already added to dota 1
2. Add an entry for the hero over at data/v_dota2/heroes.lua
    - The first field is our own hero ids
    - The second field is the dota2 hero id. You can get this from game files or from the image urls at dota2.com/heroes
    - That last table is for overwriting default values. Basically used for cases when a skill name is changed between dota1 and dota2.
3. Update the dota2 tavern file at data/v_dota2/taverns.lua
4. Add the hero's image to images/Heroes, renaming it to the internal hero id.
    - I get the "hphover" images from dota2.com/heroes. I think those could be extracted from game files too though.
5. Bump version numbers for the css stylesheet and for the hero sprite images.
6. Check if new abbreviations need to be added (in case the initials changed, like they did with Shredder/Timbersaw)

## Code roadmap

    scripts/
    - Some helper scripts I use. May be linux specific.

    results/
    - Where generated files are placed

    lua/
      
        data/
        - Data used by the guides (hero and item data, urls, etc)
        - Things are split in a manner that allows different 
        -  versions to be seamlessly mixed together
        
            base/
            - Root tables for game info that is constant throughout all versions.
            - Most importantly this is where we define the internal IDs used in the other files:
            -  heroes have IDs I came up with while items use the in-game dota2 ids from valve.
              
              heroes.lua
              items.lua
            
            - v_XXX are for data that depends on the dota version, but not on what website we will 
            -  host the guide and so on. Basically, names and things like that.
            v_dota1/
            v_dota2
            
            - a_XXX folders are for "assets" (image urls, etc)
            - The different versions use images from different websites
            a_dota2alttab/
            a_playdota/
            a_valve/

            - i_XXX folders are for "info" (urls for hero wiki pages)
            - we may want to add a i_dota2wiki folder in the future.
            i_playdota/
            i_valve/
            
            guide_urls.lua - Where we are currently hosting the guides,
                           - so its easier for things to link to each other
            
            versions.lua - Dates when the Dota1 versions were released.
                         - This allows us to determine what version a guide applies to,
                         -  based on the date when it was written.
                         
            guides.lua - All the actual guide data: skills, item builds and tips for all heroes.
        
        markup/
        - Basic markup generation libraries used by the actual guides
            bbcode.lua - For writing things on the playdota forums
            html.lua   - For generating some common HTML tags.
        
        output/
        - Functions for serializing the guides to the different output formats we support
            playdota.lua
            dota2alttab.lua
            recommended_items.lua
            
        pages/
        - The actual published guides. Each of these files corresponds to a separate "webpage".
            dotaalttab.lua        - dota2alttab.com website
            playdota.lua          - STR, AGI and INT guides for Dota1
            playdota_main.lua     - Central "hub" guide for Dota1
            recommended_items.lua - In-game recommended items
          
        guide.lua
        - Functions for the guide data format.
          
        setup.lua
        - Fetching data from the data folders, initialize some global tables with it.
          
        strict.lua
        - Helper function for detecting the use of undeclared variables
        - (lua by default returns nil instead of an error when reading an undeclared global)
            
        util.lua
        - Library of useful functions. These are added to the global scope.
