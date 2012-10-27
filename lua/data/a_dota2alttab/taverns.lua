--[[
Tavern headers for valve-like Dota2 guides
]]

local Taverns = {}

local function T(id, teamName, statName)
  local data = {}
  data.teamName = teamName
  data.statName = statName
  data.name = teamName.." "..statName
  Taverns[id] = data
end   

T('SentinelStr', "Radiant", "Strength")
T('SentinelAgi', "Radiant", "Agility")
T('SentinelInt', "Radiant", "Intelligence")

T('ScourgeStr', "Dire", "Strength")
T('ScourgeAgi', "Dire", "Agility")
T('ScourgeInt', "Dire", "Intelligence")

return Taverns