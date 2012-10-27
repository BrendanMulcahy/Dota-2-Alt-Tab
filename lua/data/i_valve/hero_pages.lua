--[[
Hero pages for dota2 guides using pictures from the  official valve website
]]

local Heroes = {}

local d2_heroes = require"data/v_dota2/heroes"

local function H(id, d2_data, data)
  data.heroPage = 
    data.heroPage or
    string.format( "http://dota2.com/hero/%s", d2_data.fullName:gsub(' ', '_'):gsub("'", "") )

  Heroes[id] = data
end

for h_id, d2_data in pairs(d2_heroes) do
  H(h_id, d2_data, {})
end

return Heroes