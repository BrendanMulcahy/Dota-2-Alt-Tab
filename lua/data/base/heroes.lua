--[[
Hero data that is common to both Dota1 and Dota2

Currently this is just for ids but we could all add tooltips, and other stuff.

We might want to use dota2 ids here ot simplify stuff in the future but right now I think
my Ids are more intuitiv and we don't yet have ids for all the dota1 heroes anyways.
]]


local Heroes = {}

local function H(id, hero)
  assert(not Heroes[id], "Duplicate hero id "..id)
  
  hero.id = id
  
  Heroes[id] = hero
end

--Sentinel Strength

H('Kunkka', {})
H('Beast', {})
H('Cent', {})
H('ES', {})
  
H('Omni', {})
H('Brew', {})
H('Sven', {})
H('Tiny', {})

H('TC', {})
H('Treant', {})
H('Wisp', {})
H('Alch', {})

H('Clock', {})
H('DK', {})
H('Huskar', {})
H('BB', {})

H('Phoenix', {})
H('Tuskarr', {})
H('Legion', {})
H('Shredder', {})

-- Scourge Strength

H('Axe', {})
H('CK', {})
H('Doom', {})
H('Naix', {})

H('LoA', {})
H('Lycan', {})
H('NS', {})
H('Pit', {})
  
H('Pudge', {})
H('Leoric', {})
H('Slardar', {})
H('Dirge', {})

H('Tide', {})
H('Magnus', {})
H('SB', {})
H('SK', {})

-- Sentinel Agility

H('AM', {})
H('Sniper', {})
H('Jugger', {})
H('LD', {})

H('Luna', {})
H('Morph', {})
H('Naga', {})
H('PL', {})

H('POTM', {})
H('Riki', {})
H('Troll', {})
H('Gyro', {})

H('Drow', {})
H('TA', {})
H('Ursa', {})
H('VS', {})

H('BH', {})
H('Xin', {})

-- Scourge Agility

H('BS', {})
H('Clinkz', {})
H('Brood', {})
H('NA', {})

H('Weaver', {})
H('PA', {})
H('SF', {})
H('TB', {})

H('Spectre', {})
H('Veno', {})
H('Viper', {})
H('Meepo', {})

H('Razor', {})
H('Slark', {})
H('Void', {})
H('Medusa', {})
H('Zet', {})

-- Sentinel Intelligence

H('CM', {})
H('Ench', {})
H('Puck', {})
H('Chen', {})

H('KOTL', {})
H('Zeus', {})
H('Prophet', {})
H('Silencer', {})

H('Lina', {})
H('Storm', {})
H('WR', {})
H('Disruptor', {})

H('Ogre', {})
H('Techies', {})
H('Jakiro', {})
H('Tinker', {})

H('Rhasta', {})
H('Rubick', {})
H('SM', {})

-- Scourge Intelligence

H('Bane', {})
H('DS', {})
H('Krob', {})
H('Lion', {})

H('Enigma', {})
H('Lich', {})
H('Necro', {})
H('Pugna', {})

H('OD', {})
H('QoP', {})
H('Warlock', {})
H('SD', {})

H('Bat', {})
H('Dazzle', {})
H('Invoker', {})
H('Visage', {})

H('Lesh', {})
H('WD', {})
H('AA', {})
H('Auroth', {})

return Heroes
