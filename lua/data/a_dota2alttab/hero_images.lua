--[[
Hero images for dota2 guides using pictures hosted on dota2alttab.com
This is empty because we use sprites instead.
]]

local Heroes = {}

local d2_heroes = require"data/v_dota2/heroes"

local function H(id, d2_data, data)
  Heroes[id] = data
end

for h_id, d2_data in pairs(d2_heroes) do
  H(h_id, d2_data, {})
end

return Heroes
