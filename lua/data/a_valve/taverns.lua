--[[
Tavern headers for valve-like Dota2 guides
]]

local Taverns = {}

local function T(id, img, text)
  Taverns[id] = {
    name = text,
    img = img,
  }
end

local str_img = "http://media.steampowered.com/apps/dota2/images/heropedia/overviewicon_str.png"
local agi_img = "http://media.steampowered.com/apps/dota2/images/heropedia/overviewicon_agi.png"
local int_img = "http://media.steampowered.com/apps/dota2/images/heropedia/overviewicon_int.png"
   

T('SentinelStr', str_img, 'Radiant Strength')
T('SentinelAgi', agi_img, 'Radiant Agility')
T('SentinelInt', int_img, 'Radiant Intelligence')

T('ScourgeStr', str_img, 'Dire Strength')
T('ScourgeAgi', agi_img, 'Dire Agility')
T('ScourgeInt', int_img, 'Dire Intelligence')

return Taverns