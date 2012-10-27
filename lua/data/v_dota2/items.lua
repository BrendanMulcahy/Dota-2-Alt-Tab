--[[
Item data that is specific to Dota 2.
Basically, the item name.
]]

local Items = {}

local base_items = require'data/base/items'

local function I(id , name, item)
  assert(base_items[id], "Unknown item "..id, 2)
  assert(not Items[id], "Duplicate item id "..id, 2)
  
  item = item or {}
  item.name = name
  Items[id] = item
end

-- Consumables

I('clarity', "Clarity")
I('tango', "Tango")
I('flask', "Healing Salve")
I('smoke_of_deceit', "Smoke of Deceit")
I('tpscroll', "Town Protal Scroll")
I('dust', "Dust of Appearance")
I('courier', "Animal Courier")
I('flying_courier', "Flying Courier")
I('ward_observer', "Observer Ward")
I('ward_sentry', "Sentry Ward")
I('bottle', "Bottle")

-- Attributes

I('branches', "Iron Branch")
I('gauntlets', "Gauntlets of Strength")
I('slippers', "Slippers of Agility")
I('mantle', "Mantle of Inteligence")
I('circlet', "Circlet")
I('belt_of_strength', "Belt of Strength")
I('boots_of_elves', "Band of Elvenskin")
I('robe', "Robe of the Magi")
I('ogre_axe', "Ogre Club")
I('blade_of_alacrity', "Blades of Alacrity")
I('staff_of_wizardry', "Staff of Wizardry")
I('ultimate_orb', "Ultimate Orb")

-- Armaments

I('ring_of_protection', "Ring of Protection")
I('quelling_blade', "Quelling Blade")
I('stout_shield', "Stout Shield")
I('blades_of_attack', "Blades of Attack")
I('chainmail', "Chainmail")
I('helm_of_iron_will', "Helm of Iron Will")
I('broadsword', "Broadsword")
I('quarterstaff', "Quarterstaff")
I('claymore', "Claymore")
I('javelin', "Javelin")
I('platemail', "Platemail")
I('mithril_hammer', "Mithril Hammer")

-- Arcane

I('magic_stick', "Magic Stick")
I('sobi_mask', "Sage's Mask")
I('ring_of_regen', "Ring of Regen")
I('boots', "Boots of Speed")
I('gloves', "Gloves of Haste")
I('cloak', "Cloak")
I('gem', "Gem of True Sight")
I('lifesteal', "Morbid Mask")
I('ghost', "Ghost Scepter")
I('talisman_of_evasion', "Talisman of Evasion")
I('blink', "Blink Dagger")
I('shadow_amulet', "Shadow Amulet")

-- Common

I('wraith_band', "Wraith Band")
I('null_talisman', "Null Talisman")
I('magic_wand', "Magic Wand")
I('bracer', "Bracer")
I('poor_mans_shield', "Poor Man's Shield")
I('soul_ring', "Soul Ring")
I('phase_boots', "Phase Boots")
I('power_treads', "Power Treads")
I('oblivion_staff', "Oblivion Staff")
I('pers', "Perseverance")
I('hand_of_midas', "Hand of Midas")
I('travel_boots', "Boots of Travel")

-- Support

I('ring_of_basilius', "Ring of Basilius")
I('headdress', "Headdress")
I('buckler', "Buckler")
I('urn_of_shadows', "Urn of Shadows")
I('ring_of_aquila', "Ring of Aquila")
I('tranquil_boots', "Tranquil Boots")
I('medallion_of_courage', "Medallion of Courage")
I('arcane_boots', "Arcane Boots")
I('ancient_janggo', "Drum of Endurance")
I('vladmir', "Vladimir's Offering")
I('mekansm', "Mekansm")
I('pipe', "Pipe of Insight")

-- Caster

I('force_staff', "Force Staff")
I('necronomicon', "Necronomicon")
I('cyclone', "Eul's Scepter of Divinity")
I('dagon', "Dagon")
I('veil_of_discord', "Veil of Discord")
I('rod_of_atos', "Rod of Atos")
I('ultimate_scepter', "Aghanim's Scepter")
I('orchid', "Orchid Malevolance")
I('sheepstick', "Scythe of Vise")
I('refresher', "Refresher Orb")

-- Weapons

I('lesser_crit', "Crystalys")
I('armlet', "Armlet of Mordiggian")
I('basher', "Skull Basher")
I('invis_sword', "Shadow Blade")
I('bfury', "Battle Fury")
I('ethereal_blade', "Ethereal Blade")
I('radiance', "Radiance")
I('monkey_king_bar', "Monkey King Bar")
I('greater_crit', "Daedalus")
I('butterfly', "The Butterfly")
I('rapier', "Divine Rapier")
I('abyssal_blade', "Abyssal Blade")

-- Armor

I('hood_of_defiance', "Hood of Defiance")
I('blade_mail', "Blade Mail")
I('vanguard', "Vanguard")
I('soul_booster', "Soul Booster")
I('black_king_bar', "Black King Bar")
I('shivas_guard', "Shiva's Guard")
I('manta', "Manta Style")
I('bloodstone', "Bloodstone")
I('sphere', "Linken's Sphere")
I('assault', "Assaut Cuirass")
I('heart', "Heart of Tarrasque")
-- I('aegis', "Aegis of the Imortal")

-- Artifacts

I('helm_of_the_dominator', "Helm of the Dominator")
I('mask_of_madness', "Mask of Madness")
I('sange', "Sange")
I('yasha', "Yasha")
I('maelstrom', "Maelstrom")
I('diffusal_blade', "Diffusal Blade")
I('desolator', "Desolator")
I('heavens_halberd', "Heaven's Halberd")
I('sange_and_yasha', "Sange and Yasha")
I('mjollnir', "Mjollnir")
I('skadi', "Eye of Skadi")
I('satanic', "Satanic")

-- Secret Shop

I('demon_edge', "Demon Edge")
I('eagle', "Eaglesong")
I('reaver', "Reaver")
I('relic', "Sacred Relic")
I('hyperstone', "Hyperstone")
I('ring_of_health', "Ring of Health")
I('void_stone', "Void Stone")
I('mystic_staff', "Mystic Staff")
I('energy_booster', "Energy Booster")
I('point_booster', "Point Booster")
I('vitality_booster', "Vitality Booster")
I('orb_of_venom', "Orb of Venom")

return Items
