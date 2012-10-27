== HOW TO RUN THE CODE
Go to the /lua directory and, from there run the scripts in the /pages directory

  cd lua
  lua pages/dota2alttab.lua

The output will be placed somewhere in the results folder.
(In the future we should have some way to automate this better)

== HOW TO VIEW THE HTML FILE LOCALLY

If you have python installed, doing a 

   python -m SimpleHTTPServer

on the dota2alttab folder and going to http:8000//localhost/index.html is a quick way without having to configure anything.

== HOW TO ADD A NEW DOTA 1 HERO

== HOW TO ADD A NEW DOTA 2 HERO

== CODE ROADMAP

scripts/
  -- Some helper scripts I use. May be linux specifiv.

results/
  -- Where generated files are placed

lua/
  
  data/
    -- Data used by the guides (hero and item data, urls, etc)
    -- Things are split in a manner that allows different
    --  versions to be seamlessly mixed together
    
    base/
      -- Root tables for game info that is constant throughout all versions.
      -- Most importantly this is where we define the internal IDs used in the other files:
      --  heroes have IDs I came up with while items use the in-game dota2 ids from valve.
      
      heroes.lua
      items.lua
    
    -- v_XXX are for data that depends on the dota version, but not on what website we will 
    --  host the guide and so on. Basically, names and things like that.
    v_dota1/
    v_dota2
    
    -- a_XXX folders are for "assets" (image urls, etc)
    -- The different versions use images from different websites
    a_dota2alttab/
    a_playdota/
    a_valve/

    -- i_XXX folders are for "info" (urls for hero wiki pages)
    -- we may want to add a i_dota2wiki folder in the future.
    i_playdota/
    i_valve/
    
    guide_urls.lua -- Where we are currently hosting the guides,
                   -- so its easier for things to link to each other
    
    versions.lua -- Dates when the Dota1 versions were released.
                 -- This allows us to determine what version a guide applies to,
                 --  based on the date when it was written.
                 
    guides.lua -- All the actual guide data: skills, item builds and tips for all heroes.
    
  markup/
    -- Basic markup generation libraries used by the actual guides
    bbcode.lua -- For writing things on the playdota forums
    html.lua   -- For generating some common HTML tags.
    
  output/
    -- Functions for serializing the guides to the different output formats we support
    playdota.lua
    dota2alttab.lua
    recommended_items.lua
    
  pages/
    -- The actual published guides. Each of these files corresponds to a separate "webpage".
    dotaalttab.lua        -- dota2alttab.com website
    playdota.lua          -- STR, AGI and INT guides for Dota1
    playdota_main.lua     -- Central "hub" guide for Dota1
    recommended_items.lua -- In-game recommended items
  
  guide.lua
    -- Functions for the guide data format.
  
  setup.lua
    -- Fetching data from the data folders, initialize some global tables with it.
  
  strict.lua
    -- Helper function for detecting the use of undeclared variables
    -- (lua by default returns nil instead of an error when reading an undeclared global)
    
  util.lua
    --Library of useful functions. These are added to the global scope.
