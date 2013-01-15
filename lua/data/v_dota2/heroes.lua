--[[
Hero data that is specific to Dota 2.
Basically hero and skill names.
]]


local dota_heroes  = require"data/base/heroes"
local dota1_heroes = require"data/v_dota1/heroes"

local Heroes = {}

local function H(id, valveNick, hero)
  assert( dota_heroes[id], "Unrecognized hero "..id )

  local d1Hero = dota1_heroes[id]

  hero.fullName = hero.fullName or capitalize(valveNick):gsub('_', ' ')

  --Most heros have the same skill names as in dota1:
  for _, s in ipairs{'Q', 'W', 'E', 'R', 'S'} do
      hero[s] = hero[s] or d1Hero[s]
  end

  hero.valveNick  = valveNick
  hero.valveGuide = string.format( "default_%s.txt", valveNick )
  hero.valveId    = string.format( "npc_dota_hero_%s", valveNick )

  hero.nick = hero.nick or hero.fullName

  Heroes[id] = hero
end

-- Radiant Strength

H('ES'     , 'earthshaker', {})
H('Sven'   , 'sven', { Q = "Storm Hammer" })
H('Tiny'   , 'tiny', { R = "Grow" })
H('Kunkka' , 'kunkka', { R = "Ghostship" })

H('Beast'  , 'beastmaster', {})
H('DK'     , 'dragon_knight', {})
H('Clock'  , 'rattletrap', {fullName = 'Clockwerk'})
H('Omni'   , 'omniknight', {})

H('Huskar' , 'huskar', {})
H('Alch'   , 'alchemist', {})
H('Brew'   , 'brewmaster', {})
H('Treant' , 'treant', {fullName = 'Treant Protector'})

H('Wisp'   , 'wisp', {})
H('Cent'   , 'centaur', {fullName = 'Centaur Warunner'})
H('Shredder', 'shredder', {fullName = 'Timbersaw'})

--Dire Strength

H('Axe'    , 'axe', {})
H('Pudge'  , 'pudge', {})
H('SK'     , 'sand_king', {})
H('Slardar', 'slardar', {})

H('Tide'   , 'tidehunter', {})
H('Leoric' , 'skeleton_king', {})
H('Naix'   , 'life_stealer', {fullName = 'Lifestealer'})
H('NS'     , 'night_stalker', {})

H('Doom'   , 'doom_bringer', {fullName = "Doom"})
H('SB'     , 'spirit_breaker', {})
H('Lycan'  , 'lycan', {fullName = 'Lycanthrope'})
H('CK'     , 'chaos_knight', {})

H('Dirge'  , 'undying', {})
H('Magnus' , 'magnataur', {fullName = 'Magnus'})

-- Radiant Agility

H('AM'     , 'antimage', {fullName = 'Anti-Mage'})
H('Drow'   , 'drow_ranger', { E = "Precision Aura" })
H('Jugger' , 'juggernaut', {})
H('POTM'   , 'mirana', { Q = "Starstorm", W = "Sacred Arrow" })

H('Morph'  , 'morphling', {})
H('PL'     , 'phantom_lancer', {})
H('VS'     , 'vengefulspirit', {fullName = "Vengeful Spirit", E = "Vengeance Aura" })
H('Riki'   , 'riki', {})

H('Sniper' , 'sniper', {})
H('TA'     , 'templar_assassin', {})
H('Luna'   , 'luna', {})
H('BH'     , 'bounty_hunter', { E = "Shadow Walk" })

H('Ursa'   , 'ursa', {})
H('Gyro'   , 'gyrocopter', {})
H('LD'     , 'lone_druid', {})
H('Naga'   , 'naga_siren', {})

--Dire Agility

H('BS'     , 'bloodseeker', { E = "Thirst" })
H('SF'     , 'nevermore', {fullName = "Shadow Fiend"})
H('Razor'  , 'razor', {})
H('Veno'   , 'venomancer', {})

H('Void'   , 'faceless_void', {})
H('PA'     , 'phantom_assassin', {})
H('Viper'  , 'viper', {})
H('Clinkz' , 'clinkz', { E = "Skeleton Walk" })

H('Brood'  , 'broodmother', {})
H('Weaver' , 'weaver', {})
H('Spectre', 'spectre', {})
H('Meepo'  , 'meepo', {})

H('NA'     , 'nyx_assassin', {})
H('Slark'  , 'slark', {})
H('Medusa' , 'medusa', {})

--Radiant Intelligence

H('CM'     , 'crystal_maiden', { E = "Arcane Aura" })
H('Puck'   , 'puck', {})
H('Storm'  , 'storm_spirit', {})
H('WR'     , 'windrunner', { E = "Windrun" })

H('Zeus'   , 'zuus', {fullName = "Zeus"})
H('Lina'   , 'lina', {})
H('Rhasta' , 'shadow_shaman', { W = "Hex" })
H('Tinker' , 'tinker', { W = "Heat-Seeking Missile" })

H('Prophet', 'furion', { fullName = "Nature's Prophet", E = "Nature's Call" })
H('Ench'   , 'enchantress', {})
H('Jakiro' , 'jakiro', {})
H('Chen'   , 'chen', {})

H('Silencer' , 'silencer', {})
H('Ogre'     , 'ogre_magi', { R = "Multicast" })
H('Rubick'   , 'rubick', {})
H('Disruptor', 'disruptor', {})

H('KOTL'     , 'keeper_of_the_light', {fullName = "Keeper of the Light"})

--H('Techies'  , nil, {fullName="Techies"})

-- Dire intelligence

H('Bane'   , 'bane', {})
H('Lich'   , 'lich', { Q = "Frost Blast", W = "Ice Armor", E = "Sacrifice" })
H('Lion'   , 'lion', { Q = "Earth Spike", W = "Hex" })
H('WD'     , 'witch_doctor', {})

H('Enigma' , 'enigma', {})
H('Necro'  , 'necrolyte', {})
H('Warlock', 'warlock', { R = "Chaotic Offering" })
H('QoP'    , 'queenofpain', {fullName = "Queen of Pain"})

H('Krob'   , 'death_prophet', { Q = "Crypt Swarm" })
H('Pugna'  , 'pugna', {})
H('Dazzle' , 'dazzle', {})
H('Lesh'   , 'leshrac', {})

H('DS'     , 'dark_seer', {})
H('Bat'    , 'batrider', { W = "Flamebreak" })
H('AA'     , 'ancient_apparition', {})
H('Invoker', 'invoker', {})

H('OD'     , 'obsidian_destroyer', {fullName = "Outworld Destroyer"})
H('SD'     , 'shadow_demon', {})
H('Visage' , 'visage', {})

return Heroes
