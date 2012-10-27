--[[
Tavern headers fromplaydota.com
]]

local Taverns = {}

local function T(id, img)
  Taverns[id] = {
    img = img
  }
end


T('SentinelStr', "http://media.playdota.com/site/hero/sentinel%20strength.gif")
T('SentinelAgi', "http://media.playdota.com/site/hero/sentinel%20agility.gif")
T('SentinelInt', "http://media.playdota.com/site/hero/sentinel%20intelligence.gif")

T('ScourgeStr', "http://media.playdota.com/site/hero/scourage%20strength.gif")
T('ScourgeAgi', "http://media.playdota.com/site/hero/scourage%20agility.gif")
T('ScourgeInt', "http://media.playdota.com/site/hero/scourage%20intelligence.gif")

return Taverns