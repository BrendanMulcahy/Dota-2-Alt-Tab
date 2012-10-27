--[[
Hero pages for dota1 guides using assets from the playdota.com website
]]

local Heroes = {}

local d1_heroes = require"data/v_dota1/heroes"

local function H(id, d1_data, data)

  data.heroPage = 
    data.heroPage or
    string.format( "http://playdota.com/heroes/%s", d1_data.class:lower():gsub(' ', '-') )

  Heroes[id] = data
end

for h_id, d1_data in pairs(d1_heroes) do
  H(h_id, d1_data, {})
end

return Heroes