--[[
Item images for dota1 guides using pictures from playdota.com
]]

local Items = {}

local base_items = require "data/base/items"

local function I(pic_id, id, format)

  assert(base_items[id], "Unknown item "..id, 2)
  
  format = format or "jpg"
  
  Items[id] = {
    image = string.format( "http://media.playdota.com/items/%s/thumb.%s", pic_id, format )
  }
end

-- Protectorate

I(   7, 'assault')
I(   8, 'heart')
I( 108, 'black_king_bar')
-- I( 109, 'aegis')
I( 110, 'shivas_guard')
I( 111, 'bloodstone')
I( 112, 'sphere')
I( 113, 'vanguard')
I( 114, 'blade_mail')
I( 115, 'soul_booster')
I( 116, 'hood_of_defiance')
I(  74, 'manta')

-- Arcane Sanctum

I(  99, 'sheepstick')
I( 100, 'orchid')
I( 101, 'cyclone')
I( 102, 'force_staff')
I( 103, 'dagon')
I( 104, 'necronomicon')
I( 106, 'ultimate_scepter')
I( 107, 'refresher')
I( 768, 'veil_of_discord')
I( 778, 'rod_of_atos')

-- Supportive Vestiments

I( 121, 'mekansm')
I( 122, 'vladmir')
I( 763, 'arcane_boots')
I( 780, 'ring_of_aquila')
I( 118, 'buckler')
I( 119, 'ring_of_basilius')
I( 120, 'pipe')
I( 755, 'urn_of_shadows')
I( 117, 'headdress')
I( 766, 'medallion_of_courage')
I( 765, 'ancient_janggo')
I( 779, 'tranquil_boots')

-- Ancient Weaponry

I(  67, 'rapier')
I(  68, 'monkey_king_bar')
I(  69, 'radiance')
I( 125, 'butterfly')
I(  71, 'greater_crit')
I(  72, 'basher')
I(  73, 'bfury')
I( 777, 'abyssal_blade')
I(  75, 'lesser_crit')
I(  76, 'armlet')
I(  77, 'invis_sword')
I( 756, 'ethereal_blade')

-- Enchanted Artifacts

I(  80, 'sange_and_yasha')
I(  83, 'satanic')
I(  86, 'mjollnir')
I(  88, 'skadi')
I(  70, 'sange')
I(  82, 'helm_of_the_dominator')
I(  85, 'maelstrom')
I(  87, 'desolator')
I(  78, 'yasha')
I(  81, 'mask_of_madness')
I(  84, 'diffusal_blade')
I( 781, 'heavens_halberd')

-- Gateway Relics

I(  92, 'travel_boots')
I(  91, 'phase_boots')
I(  66, 'power_treads')
I( 762, 'soul_ring')
I(  95, 'hand_of_midas')
I(  90, 'oblivion_staff')
I(  89, 'pers')
I(  93, 'poor_mans_shield')
I(  97, 'bracer')
I(  98, 'wraith_band')
I(  96, 'null_talisman')
I(  94, 'magic_wand')

-- Cache of the Quel-Thelan

I(  10, 'gloves')
I(  12, 'lifesteal')
I(  13, 'ring_of_regen')
I(  14, 'blink')
I(  15, 'sobi_mask')
I(  16, 'boots')
I(  17, 'gem')
I(  18, 'cloak')
I(  19, 'magic_stick')
I(  20, 'talisman_of_evasion')
I(  21, 'ghost')
I( 783, 'shadow_amulet', 'gif')

-- Ancient of Wonders

I(  22, 'clarity')
I(  23, 'flask')
I(  24, 'tango')
I(  25, 'bottle')
I(  26, 'ward_observer')
I(  27, 'ward_sentry')
I(  28, 'dust')
I(  29, 'courier')
I(  30, 'tpscroll')
I( 767, 'smoke_of_deceit')
I( 124, 'flying_courier')

-- Sena the Accessorizer

I(  31, 'gauntlets')
I(  33, 'slippers')
I(  32, 'mantle')
I(  34, 'branches')
I(  35, 'belt_of_strength')
I(  37, 'boots_of_elves')
I(  36, 'robe')
I(  38, 'circlet')
I(  39, 'ogre_axe')
I(  41, 'blade_of_alacrity')
I(  40, 'staff_of_wizardry')
I(  42, 'ultimate_orb')

-- Weapon Dealer

I(  43, 'blades_of_attack')
I(  44, 'broadsword')
I(  45, 'quarterstaff')
I(  46, 'claymore')
I(  47, 'ring_of_protection')
I(  48, 'stout_shield')
I(  49, 'javelin')
I(  50, 'mithril_hammer')
I(  51, 'chainmail')
I(  52, 'helm_of_iron_will')
I(  53, 'platemail')
I(  54, 'quelling_blade')

-- Secret Shop

I(  55, 'demon_edge')
I(  56, 'eagle')
I(  57, 'reaver')
I(  58, 'relic')
I(  59, 'hyperstone')
I(  60, 'ring_of_health')
I(  61, 'void_stone')
I(  62, 'mystic_staff')
I(  63, 'energy_booster')
I(  64, 'point_booster')
I(  65, 'vitality_booster')
I( 764, 'orb_of_venom')

return Items
