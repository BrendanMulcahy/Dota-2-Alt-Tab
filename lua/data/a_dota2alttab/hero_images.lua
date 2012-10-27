--[[
Hero images for dota2 guides using pictures hosted on dota2alttab.com
]]

local Heroes = {}

local base_heroes = require"data/base/heroes"

local function H(id, img, data)
  assert(base_heroes[id], "Unrecognized hero "..id)
  
  data = data or {}
  data.image = img
  
  Heroes[id] = data
end

local function p(name)
  return string.format(
    "./Dota2_Alt_Tab/Images/Icons/%s_icon.png",
    name)
end

-- Radiant Strength

H('ES'     , p"Earthshaker")
H('Sven'   , p"Sven")
H('Tiny'   , p"Tiny")
H('Kunkka' , p"Kunkka")
  
H('Beast'  , p"Beastmaster")
H('DK'     , p"DragonKnight")
H('Clock'  , p"Clockwerk")
H('Omni'   , p"Omniknight")
  
H('Huskar' , p"Huskar")
H('Alch'   , p"Alchemist")
H('Brew'   , p"Brewmaster")
H('Treant' , p"TreantProtector")
  
H('Wisp'   , p"Wisp")
  
--Dire Strength

H('Axe'    , p"Axe")
H('Pudge'  , p"Pudge")
H('SK'     , p"SandKing")
H('Slardar', p"Slardar")
  
H('Tide'   , p"Tidehunter")
H('Leoric' , p"SkeletonKing")
H('Naix'   , p"Lifestealer")
H('NS'     , p"NightStalker")
  
H('Doom'   , p"DoomBringer")
H('SB'     , p"SpiritBreaker")
H('Lycan'  , p"Lycanthrope")
H('CK'     , p"ChaosKnight")
  
H('Dirge'  , p"Undying")
H('Magnus' , p"Magnataur")
  
-- Radiant Agility

H('AM'     , p"AntiMage")
H('Drow'   , p"DrowRanger")
H('Jugger' , p"Juggernaut")
H('POTM'   , p"Mirana")
  
H('Morph'  , p"Morphling")
H('PL'     , p"PhantomLancer")
H('VS'     , p"VengefulSpirit")
H('Riki'   , p"Riki")
  
H('Sniper' , p"Sniper")
H('TA'     , p"TemplarAssassin")
H('Luna'   , p"Luna")
H('BH'     , p"BountyHunter")
  
H('Ursa'   , p"Ursa")
H('Gyro'   , p"Gyrocopter")
H('LD'     , p"LoneDruid")
H('Naga'   , p"NagaSiren")

--Dire Agility

H('BS'     , p"Bloodseeker")
H('SF'     , p"ShadowFiend")
H('Razor'  , p"Razor")
H('Veno'   , p"Venomancer")
  
H('Void'   , p"FacelessVoid")
H('PA'     , p"PhantomAssassin")
H('Viper'  , p"Viper")
H('Clinkz' , p"Clinkz")
  
H('Brood'  , p"Broodmother")
H('Weaver' , p"Weaver")
H('Spectre', p"Spectre")
H('NA'     , p"NyxAssassin")
  
--Radiant Intelligence

H('CM'     , p"CrystalMaiden")
H('Puck'   , p"Puck")
H('Storm'  , p"StormSpirit")
H('WR'     , p"Windrunner")
  
H('Zeus'   , p"Zeus")
H('Lina'   , p"Lina")
H('Rhasta' , p"ShadowShaman")
H('Tinker' , p"Tinker")
  
H('Prophet', p"Nature'sProphet")
H('Ench'   , p"Enchantress")
H('Jakiro' , p"Jakiro")
H('Chen'   , p"Chen")
  
H('Silencer' , p"Silencer")
H('Ogre'     , p"OgreMagi")
H('Rubick'   , p"Rubick")
H('Disruptor', p"Disruptor")

H('KOTL'     , p"KeeperOfTheLight")
  
-- Dire intelligence
  
H('Bane'   , p"Bane")
H('Lich'   , p"Lich")
H('Lion'   , p"Lion")
H('WD'     , p"WitchDoctor")

H('Enigma' , p"Enigma")
H('Necro'  , p"Necrolyte")
H('Warlock', p"Warlock")
H('QoP'    , p"QueenofPain")
  
H('Krob'   , p"DeathProphet")
H('Pugna'  , p"Pugna")
H('Dazzle' , p"Dazzle")
H('Lesh'   , p"Leshrac")
  
H('DS'     , p"DarkSeer")
H('Bat'    , p"Batrider")
H('AA'     , p"AncientApparition")
H('Invoker', p"Invoker")

H('OD'     , p"OutworldDestroyer")
H('SD'     , p"ShadowDemon")
H('Visage' , p"Visage")

return Heroes
