--[[
Item images for dota2 guides using pictures from the official dota2 website.
]]

local Items = {}

local d2_items = require "data/v_dota2/items"

local function I(id, d2_data, data)
  data.image = 
    data.image or
    string.format( "http://media.steampowered.com/apps/dota2/images/items/%s_lg.png", id )

  Items[id] = data
end

for i_id, d2_data in pairs(d2_items) do
  I(i_id, d2_data, {})
end

return Items