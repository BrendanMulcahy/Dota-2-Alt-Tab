--[[
This file is for item data that is common to both Dota1 and Dota2

Currently this is just for ids but we could all add tooltips, costs, etc.

We use the ids from dota2 because they are already available for all items and
because items don't tend to have easy ids like heroes do. 
]]

local Items = {}

local function I(id ,item)
  assert(not Items[id], "Duplicate item id "..id)
  
  item.id = id
  
  Items[id] = item
end

--Protectorate

I('assault', {})
I('heart', {})
I('black_king_bar', {})
-- I('aegis', {})
I('shivas_guard', {})
I('bloodstone', {})
I('sphere', {})
I('vanguard', {})
I('blade_mail', {})
I('soul_booster', {})
I('hood_of_defiance', {})
I('manta', {})

-- Arcane Sanctum

I('sheepstick', {})
I('orchid', {})
I('cyclone', {})
I('force_staff', {})
I('dagon', {}) --TODO: dagon 1-5
I('necronomicon', {}) -- TODO: necro 1-3
I('ultimate_scepter', {})
I('refresher', {})
I('veil_of_discord', {})
I('rod_of_atos', {})

-- Supportive Vestiments

I('mekansm', {})
I('vladmir', {})
I('arcane_boots', {})
I('ring_of_aquila', {})
I('buckler', {})
I('ring_of_basilius', {})
I('pipe', {})
I('urn_of_shadows', {})
I('headdress', {})
I('medallion_of_courage', {})
I('ancient_janggo', {})
I('tranquil_boots', {})

-- Ancient Weaponry

I('rapier', {})
I('monkey_king_bar', {})
I('radiance', {})
I('butterfly', {})
I('greater_crit', {})
I('basher', {})
I('bfury', {})
I('abyssal_blade', {})
I('lesser_crit', {})
I('armlet', {})
I('invis_sword', {})
I('ethereal_blade', {})

-- Enchanted Artifacts

I('sange_and_yasha', {})
I('satanic', {})
I('mjollnir', {})
I('skadi', {})
I('sange', {})
I('helm_of_the_dominator', {})
I('maelstrom', {})
I('desolator', {})
I('yasha', {})
I('mask_of_madness', {})
I('diffusal_blade', {})
I('heavens_halberd', {})

--Gateway Relics

I('travel_boots', {})
I('phase_boots', {})
I('power_treads', {})
I('soul_ring', {})
I('hand_of_midas', {})
I('oblivion_staff', {})
I('pers', {})
I('poor_mans_shield', {})
I('bracer', {})
I('wraith_band', {})
I('null_talisman', {})
I('magic_wand', {})

-- Cache of Quel-Thelan

I('gloves', {})
I('lifesteal', {})
I('ring_of_regen', {})
I('blink', {})
I('sobi_mask', {})
I('boots', {})
I('gem', {})
I('cloak', {})
I('magic_stick', {})
I('talisman_of_evasion', {})
I('ghost', {})
I('shadow_amulet', {})

-- Ancient of Wonders

I('clarity', {})
I('flask', {})
I('tango', {})
I('bottle', {})
I('ward_observer', {})
I('ward_sentry', {})
I('dust', {})
I('courier', {})
I('tpscroll', {})
I('smoke_of_deceit', {})
I('flying_courier', {})

-- Sena the Accessorizer

I('gauntlets', {})
I('slippers', {})
I('mantle', {})
I('branches', {})
I('belt_of_strength', {})
I('boots_of_elves', {})
I('robe', {})
I('circlet', {})
I('ogre_axe', {})
I('blade_of_alacrity', {})
I('staff_of_wizardry', {})
I('ultimate_orb', {})

-- Weapon Dealer

I('blades_of_attack', {})
I('broadsword', {})
I('quarterstaff', {})
I('claymore', {})
I('ring_of_protection', {})
I('stout_shield', {})
I('javelin', {})
I('mithril_hammer', {})
I('chainmail', {})
I('helm_of_iron_will', {})
I('platemail', {})
I('quelling_blade', {})

-- Secret Shop

I('demon_edge', {})
I('eagle', {})
I('reaver', {})
I('relic', {})
I('hyperstone', {})
I('ring_of_health', {})
I('void_stone', {})
I('mystic_staff', {})
I('energy_booster', {})
I('point_booster', {})
I('vitality_booster', {})
I('orb_of_venom', {})

return Items
