--[[
Hero pages from dota2wiki.com
]]

local Heroes = {}

local d2_heroes = require"data/v_dota2/heroes"

local function H(id, fullName)
  
  Heroes[id] = {
    heroPage = string.format( "http://dota2wiki.com/wiki/%s", fullName:gsub(' ', '_') )
  }
  
end

for h_id, d2_data in pairs(d2_heroes) do
  H(h_id, d2_data.fullName)
end

return Heroes