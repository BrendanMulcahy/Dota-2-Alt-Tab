--[[
Tavern layout for Dota1
]]

local Taverns = {}

local heroes = require "data/v_dota1/heroes"

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
  { 'Kunkka', 'Beast', 'Cent', 'ES' },
  { 'Omni', 'Brew', 'Sven', 'Tiny' },
  { 'TC', 'Treant', 'Wisp', 'Alch' },
  { 'Clock', 'DK', 'Huskar', 'BB' },
  { 'Phoenix', 'Tuskarr', 'Legion', 'Shredder' },
})

T('SentinelAgi', {
  stat='agi', team='sentinel',
  { 'AM', 'Sniper', 'Jugger', 'LD' },
  { 'Luna', 'Morph', 'Naga', 'PL' },
  { 'POTM', 'Riki', 'Troll', 'Gyro' },
  { 'Drow', 'TA', 'Ursa', 'VS' },
  { 'BH', 'Xin' },
})

T('SentinelInt', {
  stat='int', team='sentinel',
  { 'CM', 'Ench', 'Puck', 'Chen' },
  { 'KOTL', 'Zeus', 'Prophet', 'Silencer' },
  { 'Lina', 'Storm', 'WR', 'Disruptor' },
  { 'Ogre', 'Techies', 'Jakiro', 'Tinker' },
  { 'Rhasta', 'Rubick', 'SM' },
})

T('ScourgeStr', {
  stat='str', team='scourge',
  { 'Axe', 'CK', 'Doom', 'Naix' },
  { 'LoA', 'Lycan', 'NS', 'Pit' },
  { 'Pudge', 'Leoric', 'Slardar', 'Dirge' },
  { 'Tide', 'Magnus', 'SB', 'SK' },
})

T('ScourgeAgi', {
  stat='agi', team='scourge',
  { 'BS', 'Clinkz', 'Brood', 'NA' },
  { 'Weaver', 'PA', 'SF', 'TB' },
  { 'Spectre', 'Veno', 'Viper', 'Meepo' },
  { 'Razor', 'Slark', 'Void', 'Medusa' },
  { 'Zet' },
})
    
T('ScourgeInt', {
  stat='int', team='scourge',
  { 'Bane', 'DS', 'Krob', 'Lion' },
  { 'Enigma', 'Lich', 'Necro', 'Pugna' },
  { 'OD', 'QoP', 'Warlock', 'SD' },
  { 'Bat', 'Dazzle', 'Invoker', 'Visage' },
  { 'Lesh', 'WD', 'AA', 'Auroth' },
})

return Taverns
