--[[
Tavern layout for Dota2
]]

local Taverns = {}

local heroes = require "data/v_dota2/heroes"

local function T(id, rows)
  assert(not Taverns[id], "Duplicate tavern id "..id)
  for _, row in ipairs(rows) do
    for _, h_id in ipairs(row) do
      assert(heroes[h_id], "Unrecognized hero id "..h_id)
    end
  end
  rows.id = id
  Taverns[id] = rows
end
   

T('SentinelStr', {
    stat='str', team='sentinel',
    { 'ES', 'Sven', 'Tiny', 'Kunkka' },
    { 'Beast', 'DK', 'Clock', 'Omni' },
    { 'Huskar', 'Alch', 'Brew', 'Treant' },
    { 'Wisp' },
})

T('SentinelAgi', {
    stat='agi', team='sentinel',
    { 'AM', 'Drow', 'Jugger', 'POTM' },
    { 'Morph', 'PL', 'VS', 'Riki' },
    { 'Sniper', 'TA', 'Luna', 'BH' },
    { 'Ursa', 'Gyro', 'LD', 'Naga' },
})

T('SentinelInt', {
    stat='int', team='sentinel',
    { 'CM', 'Puck', 'Storm', 'WR' },
    { 'Zeus', 'Lina', 'Rhasta', 'Tinker' },
    { 'Prophet', 'Ench', 'Jakiro', 'Chen' },
    { 'Silencer', 'Ogre', 'Rubick', 'Disruptor' },
    { 'KOTL' },
})

T('ScourgeStr', {
    stat='str', team='scourge',
    { 'Axe', 'Pudge', 'SK', 'Slardar' },
    { 'Tide', 'Leoric', 'Naix', 'NS' }, 
    { 'Doom', 'SB', 'Lycan', 'CK' },
    { 'Dirge', 'Magnus' },
})

T('ScourgeAgi', {
    stat='agi', team='scourge',
    { 'BS', 'SF', 'Razor', 'Veno' },
    { 'Void', 'PA', 'Viper', 'Clinkz' },
    { 'Brood', 'Weaver', 'Spectre', 'Meepo'},
    { 'NA' },
})

T('ScourgeInt', {
    stat='int', team='scourge',
    { 'Bane', 'Lich', 'Lion', 'WD' },
    { 'Enigma', 'Necro', 'Warlock', 'QoP' },
    { 'Krob', 'Pugna', 'Dazzle', 'Lesh' },
    { 'DS', 'Bat', 'AA', 'Invoker' },
    { 'OD', 'SD', 'Visage'},
})

return Taverns
