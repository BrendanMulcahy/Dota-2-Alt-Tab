--[[
Hero images for dota2 guides using pictures from the  official valve website
]]

local Heroes = {}

local d2_heroes = require"data/v_dota2/heroes"

local function H(id, d2_data, data)
  data.image =
    data.image or
    string.format( "http://media.steampowered.com/apps/dota2/images/heroes/%s_sb.png", d2_data.valveNick )

  Heroes[id] = data
end

for h_id, d2_data in pairs(d2_heroes) do
  H(h_id, d2_data, {})
end

return Heroes