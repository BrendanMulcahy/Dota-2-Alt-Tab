--[[
Item data that is specific to Dota 1.
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

--Protectorate

I('assault', "Assaut Cuirass")
I('heart', "Heart of Tarrasque")
I('black_king_bar', "Black King Bar")
-- I('aegis', "Aegis of the Imortal")
I('shivas_guard', "Shiva's Guard")
I('bloodstone', "Bloodstone")
I('sphere', "Linken's Sphere")
I('vanguard', "Vanguard")
I('blade_mail', "Blademail")
I('soul_booster', "Soul Booster")
I('hood_of_defiance', "Hood of Defiance")
I('manta', "Manta Style")

-- Arcane Sanctum

I('sheepstick', "Guinsoo's Scythe of Vise")
I('orchid', "Orchid Malevolance")
I('cyclone', "Eul's Scepter of Divinity")
I('force_staff', "Force Staff")
I('dagon', "Dagon")
I('necronomicon', "Necronomicon")
I('ultimate_scepter', "Aghanim's Scepter")
I('refresher', "Refresher Orb")
I('veil_of_discord', "Veil of Discord")
I('rod_of_atos', "Rod of Atos")

-- Supportive Vestiments

I('mekansm', "Mekansm")
I('vladmir', "Vladimir's Offering")
I('arcane_boots', "Arcane Boots")
I('ring_of_aquila', "Ring of Aquila")
I('buckler', "Nathrezim Buckler")
I('ring_of_basilius', "Ring of Basilius")
I('pipe', "Khadgar's Pipe of Insight")
I('urn_of_shadows', "Urn of Shadows")
I('headdress', "Headdress of Rejuvenation")
I('medallion_of_courage', "Medallion of Courage")
I('ancient_janggo', "Ancient Janggo of Endurance")
I('tranquil_boots', "Tranquil Boots")

-- Ancient Weaponry

I('rapier', "Divine Rapier")
I('monkey_king_bar', "Monkey King Bar")
I('radiance', "Radiance")
I('butterfly', "The Butterfly")
I('greater_crit', "Buriza-do Kyanon")
I('basher', "Cranium Basher")
I('bfury', "Battlefury")
I('abyssal_blade', "Abyssal Blade")
I('lesser_crit', "Crystalys")
I('armlet', "Armlet of Mordiggian")
I('invis_sword', "Lothar's Edge")
I('ethereal_blade', "Ethereal Blade")

-- Enchanted Artifacts

I('sange_and_yasha', "Sange and Yasha")
I('satanic', "Satanic")
I('mjollnir', "Mjollnir")
I('skadi', "Eye of Skadi")
I('sange', "Sange")
I('helm_of_the_dominator', "Helm of the Dominator")
I('maelstrom', "Maelstrom")
I('desolator', "Stygian Desolator")
I('yasha', "Yasha")
I('mask_of_madness', "Mask of Madness")
I('diffusal_blade', "Diffusal Blade")
I('heavens_halberd', "Heaven's Halberd")

--Gateway Relics

I('travel_boots', "Boots of Travel")
I('phase_boots', "Phase Boots")
I('power_treads', "Power Treads")
I('soul_ring', "Soul Ring")
I('hand_of_midas', "Hand of Midas")
I('oblivion_staff', "Oblivion Staff")
I('pers', "Perseverance")
I('poor_mans_shield', "Poor Man's Shield")
I('bracer', "Bracer")
I('wraith_band', "Wraith Band")
I('null_talisman', "Null Talisman")
I('magic_wand', "Magic Wand")

-- Cache of Quel-Thelan

I('gloves', "Gloves of Haste")
I('lifesteal', "Mask of Death")
I('ring_of_regen', "Ring of Regeneration")
I('blink', "Kelen's Dagger")
I('sobi_mask', "Sobi Mask")
I('boots', "Boots of Speed")
I('gem', "Gem of True Sight")
I('cloak', "Planeswalker's Cloak")
I('magic_stick', "Magic Stick")
I('talisman_of_evasion', "Talisman of Evasion")
I('ghost', "Ghost Scepter")
I('shadow_amulet', "Shadow Amulet")

-- Ancient of Wonders

I('clarity', "Clarity Potion")
I('flask', "Healing Salve")
I('tango', "Ancient Tango of Essifation")
I('bottle', "Empty Bottle")
I('ward_observer', "Observer Wards")
I('ward_sentry', "Sentry Wards")
I('dust', "Dust of Appearance")
I('courier', "Animal Courier")
I('tpscroll', "Scroll of Town Protal")
I('smoke_of_deceit', "Smoke of Deceit")
I('flying_courier', "Flying Courier")

-- Sena the Accessorizer

I('gauntlets', "Gauntlets of Strength")
I('slippers', "Slippers of Agility")
I('mantle', "Mantle of Inteligence")
I('branches', "Ironwood Branch")
I('belt_of_strength', "Belt of Giant Strength")
I('boots_of_elves', "Boots of Elvenskin")
I('robe', "Robe of the Magi")
I('circlet', "Circlet of Nobility")
I('ogre_axe', "Ogre Axe")
I('blade_of_alacrity', "Blades of Alacrity")
I('staff_of_wizardry', "Staff of Wizardry")
I('ultimate_orb', "Ultimate Orb")

-- Weapon Dealer

I('blades_of_attack', "Blades of Attack")
I('broadsword', "Broadsword")
I('quarterstaff', "Quarterstaff")
I('claymore', "Claymore")
I('ring_of_protection', "Ring of Protection")
I('stout_shield', "Stout Shield")
I('javelin', "Javelin")
I('mithril_hammer', "Mithril Hammer")
I('chainmail', "Chain Mail")
I('helm_of_iron_will', "Helm of Iron Will")
I('platemail', "Plate Mail")
I('quelling_blade', "Quelling Blade")

-- Secret Shop

I('demon_edge', "Demon Edge")
I('eagle', "Eaglehorn")
I('reaver', "Messerschmidt's Reaver")
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
