--[[
Hero images for dota1 guides using assets from the playdota.com website
]]


local Heroes = {}

local base_heroes = require "data/base/heroes"

local function H(id, pic_id, pic_ext)
  assert(base_heroes[id], "Unknown hero "..id, 2)
  Heroes[id] = {
    image = string.format( "http://media.playdota.com/hero/%d/thumb.%s", pic_id, pic_ext )
  }
end
 
-- Sentinel Strength

H('Kunkka'  ,  66, "gif")
H('Beast'   ,  44, "gif")
H('Cent'    ,  17, "gif")
H('ES'      ,  41, "gif")

H('Omni'    ,  47, "gif")
H('Brew'    ,  52, "gif")
H('Sven'    ,  38, "gif")
H('Tiny'    , 105, "gif")

H('TC'      , 116, "jpeg")
H('Treant'  ,  99, "gif")
H('Wisp'    , 130, "jpg")
H('Alch'    ,  48, "gif")
 
H('Clock'   ,  65, "gif")
H('DK'      ,  49, "gif")
H('Huskar'  ,  55, "gif")
H('BB'      ,  39, "jpg")

H('Phoenix' , 133, "gif")
H('Tuskarr' , 134, "jpg")
H('Legion'  , 138, "jpg")
H('Shredder', 136, "jpg")

-- Scourge Strength

H('Axe'     ,  33, "gif")
H('CK'      , 114, "gif")
H('Doom'    ,  37, "gif")
H('Naix'    , 122, "jpg")

H('LoA'     ,  12, "gif ")
H('Lycan'   , 115, "gif")
H('NS'      ,  75, "gif")
H('Pit'     ,  80, "gif")

H('Pudge'   ,  29, "gif")
H('Leoric'  ,  76, "gif")
H('Slardar' ,  81, "gif")
H('Dirge'   ,  95, "gif")

H('Tide'    ,  25, "gif")
H('Magnus'  , 111, "gif")
H('SB'      , 123, "jpg")
H('SK'      ,  14, "gif")

-- Sentinel Agility

H('AM'      , 43, "gif")
H('Sniper'  , 23, "gif")
H('Jugger'  , 71, "gif")
H('LD'      , 67, "gif")

H('Luna'    , 16, "gif")
H('Morph'   , 22, "gif")
H('Naga'    , 40, "gif")
H('PL'      ,104, "gif")

H('POTM'    , 51, "gif")
H('Riki'    , 64, "gif") 
H('Troll'   , 24, "gif")
H('Gyro'    ,129, "gif")

H('Drow'    , 45, "gif") 
H('TA'      , 57, "gif")
H('Ursa'    ,100, "gif")
H('VS'      ,  8, "gif")

H('BH'      , 42, "gif")
H('Xin'     ,137, "jpg")

-- Scourge Agility

H('BS'      , 35, "gif")
H('Clinkz'  , 15, "gif")
H('Brood'   , 89, "gif")
H('NA'      , 79, "gif")

H('Weaver'  , 32, "gif")
H('PA'      , 97, "gif")
H('SF'      , 91, "gif")
H('TB'      ,110, "gif")

H('Spectre' , 50, "gif")
H('Veno'    ,106, "gif")
H('Viper'   , 84, "gif")
H('Meepo'   , 74, "gif")

H('Razor'   , 86, "gif")
H('Slark'   ,124, "gif")
H('Void'    , 83, "gif")
H('Medusa'  , 72, "gif")

-- Sentinel Intelligence

H('CM'      , 34, "jpg")
H('Ench'    , 21, "jpg")
H('Puck'    , 62, "jpg")
H('Chen'    ,108, "jpg")

H('KOTL'    ,121, "jpg")
H('Zeus'    , 18, "jpg")
H('Prophet' ,103, "jpg")
H('Silencer', 96, "jpg")

H('Lina'    , 69, "jpg")
H('Storm'   , 53, "jpg")
H('WR'      , 54, "jpg")
H('Disruptor',131, "gif")

H('Ogre'    ,101, "jpg")
H('Techies' ,107, "jpg")
H('Jakiro'  , 46, "jpg")
H('Tinker'  ,102, "jpg")

H('Rhasta'  , 26, "jpg")
H('Rubick'  ,135, "jpg")
H('SM'      ,139, "jpg")

-- Scourge Intelligence

H('Bane'    , 27, "jpg")
H('DS'      , 93, "jpg")
H('Krob'    ,109, "jpg")
H('Lion'    ,112, "jpg")

H('Enigma'  , 98, "jpg")
H('Lich'    , 92, "jpg")
H('Necro'   , 28, "jpg")
H('Pugna'   , 13, "jpg")

H('OD'      , 70, "jpg")
H('QoP'     , 82, "gif")
H('Warlock' , 58, "jpg")
H('SD'      ,132, "jpg")

H('Bat'     ,117, "jpeg")
H('Dazzle'  , 77, "jpg")
H('Invoker' ,118, "jpg")
H('Visage'  ,113, "jpg")

H('Lesh'    , 90, "jpg")
H('WD'      , 63, "jpg")
H('AA'      ,128, "jpg")

return Heroes