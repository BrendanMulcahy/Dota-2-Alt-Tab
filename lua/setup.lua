require "util"

local strict = require "strict"

strict.forbid_global_variables_except({
    'DOTA_VERSION', 
    'Heroes', 'Items', 'Taverns', 'Guides'
})

return function(version, kw)
    local GUIDE_D_VERSION = ({'v_dota1', 'v_dota2'})[version]
    local GUIDE_D_INFO    = kw.info
    local GUIDE_D_ASSETS  = kw.assets
    local GUIDE_TAVERNS   = kw.taverns
    
    DOTA_VERSION = version

    Heroes = joinDota({
      require( "data/base/heroes" ),
      require( "data/"..GUIDE_D_VERSION.."/heroes" ),
      (GUIDE_D_ASSETS and require( "data/"..GUIDE_D_ASSETS.."/hero_images" ) or {}),
      (GUIDE_D_INFO   and require( "data/"..GUIDE_D_INFO.."/hero_pages"    ) or {}),
    })
    
    Items = joinDota({
      require( "data/base/items" ),
      require( "data/"..GUIDE_D_VERSION.."/items" ),
      (GUIDE_D_ASSETS and require( "data/"..GUIDE_D_ASSETS.."/item_images" ) or {}),
    })
    
    Taverns = joinDota({
      require( "data/"..GUIDE_D_VERSION.."/taverns" ),
      (GUIDE_D_ASSETS and require( "data/"..GUIDE_D_ASSETS.."/taverns" ) or {}),
    })
    
    Guides = require( "data/guides" )
    
    if GUIDE_TAVERNS then
      
      local taverns = {}
      for i, j, t_id in itmatrix(GUIDE_TAVERNS) do
        taverns[i] = taverns[i] or {}
        taverns[i][j] = Taverns[t_id]
      end
      return taverns
      
    else
      
      return nil
      
    end
end
