local Guides = {}

local Guide = require "guide"

local Q, W, E, R, S = Guide.Q, Guide.W, Guide.E, Guide.R, Guide.S
local MAX = Guide.MAX

local SEQ, OPT, ALT = Guide.SEQ, Guide.OPT, Guide.ALT

local H, I, THIS = Guide.H, Guide.I, Guide.THIS
local MARKUP = Guide.MARKUP
local NOPERIOD = Guide.NOPERIOD

local GUIDE = Guide.GUIDE
local SKILLBUILD = Guide.SKILLBUILD
local ITEMBUILD  = Guide.ITEMBUILD

local TIP = Guide.Tip
local HERODESC = Guide.HERODESC
local SKILLBUILDNOTE = Guide.SKILLBUILDNOTE
local ITEMBUILDNOTE = Guide.ITEMBUILDNOTE
local TIPS = Guide.TIPS

-------

local function Go(guide)
    Guides[guide.heroid] = GUIDE(guide)
end

local I_STARTING  = "Starting"
local I_EARLY     = "Early Game"
local I_CORE      = "Core"
local I_LUXURY    = "Extension"
local I_OPTIONAL  = "Optional"
local I_FALLBACK  = "Fallback"

local T_BUILD_VARIATIONS = "Build Variations"
local T_BUILD_JUSTIFICATION = "Build Justification"
local T_REFERENCES = "More Guides"

local function tip_version_specific(version, tip)
  return {
    versions = {version},
    '(Dota '..version..' only):', table.unpack(tip)
  }
end

local function tip_ministun(skillname)
  return { skillname, "does a ministun. Use it to cancel channelling spells and TPs."}
end

local function tip_ab_disassemble()
  return {
    "You can disassemble", I'arcane_boots',
    "to get back the", I'energy_booster', "for the", I'bloodstone', "."
  }
end

local function tip_todo()
  return { "This hero has been recently remade or introduced and we haven't updated his guide yet. Check out for an update soon!" }
end

local function tip_orb_lifesteal(item, skill)

  local precedence_explanation = ({
    {"Lifesteal will take precedence unless you put ", skill, " on autocast."},
    {"You do not get the lifesteal effect when you cast", skill, "(either normally or via autocast)."},
  })[DOTA_VERSION]

  return join{
    {"The lifesteal from ", I(item), " does not stack with ", skill, "since both are orb effects."},
    precedence_explanation,
    {"You should prioritize lifesteal most of the time though, since it helps DPSing."},
  }

end

local function tip_phase_boots_crit()

  return {
    versions = {1},
    "Due to engine limitations, it is not possible to bash and get critical hits while under the effects of", I'phase_boots', ". Keep this in mind or just get ", I'power_treads', "instead."
  }

end

local function tip_illusion_vlads()

  return {
    "Don't get", I'vladmir', "on illusion heroes (see the mechanics tab)."
  }

end

local function tips_illusion_mechanics()

  return TIPS{ name="Illusion Mechanics",

    {"Illusions benefit from raw stats (STR, AGI, INT, HP and Mana) and critical hit items."},

    {"Illusions do not benefit from pure damage, auras or orb effects",
      "(so don't get a ", I'vladmir', "!). There are only a few exceptions:",
      MARKUP('ulist', {
        TIP{
          "The", I'radiance', "burn works (but does not stack).",
          "You can use it to farm multiple lanes, jungle camps and to harass."},
        TIP{"Melee illusions get the",I'diffusal_blade', "mana burn.",
          "This is the only orb effect that works (the others only grant the cosmetic effect)"},
      }),
      NOPERIOD,
    }
  }

end

local function tips_orbwalking(skill)
  return TIPS{ name="Orbwalking",
    {"To orbwalk, manually cast", skill, "and immediately issue a move command",
      "to cancel the backswing animation and move closer to your target."},
    {"Orbwalking gives the best chasing DPS early game",
      "and does not draw creep or tower aggro."},
  }
end

local function tips_neutral_creeps()
  return TIPS{ name="Neutral Creeps",
    {"Creeps from the hard camps are never bad:",
      MARKUP('ulist', {
        TIP{"Centaur: AoE stun and IAS aura."},
        TIP{"Ursa Warrior: AoE slow/nuke."},
        TIP{"Dark Troll Warlord: Net for ganking; Skeletons for pushing."},
        TIP{"Wildkin: Order the cyclone to follow and enemy hero (works best in Dota 2)."}
    }), NOPERIOD},

    {"Notable smaller creeps (good auras for lategame):",
      MARKUP('ulist', {
        TIP{"Alpha Wolf: Damage aura."},
        TIP{"Kobold Taskmaster: MS aura."},
        TIP{"Ogre Magi: Frost Armor (good against Roshan)."}
    }), NOPERIOD },
  }
end

-----------------------
-- Sentinel Strength --
-----------------------

Go{
  heroid = 'Kunkka',
  date = {day=14, month=1, year=2013},

  SKILLBUILD{
    Q ,{MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
	{I_STARTING, {3, 'branches'}, 'flask', 'tango', 'stout_shield' },
    {'Survivability Core',
      'magic_wand', 'phase_boots', 'vanguard', 'ancient_janggo'},
    {'Damage Core',
      'phase_boots', 'invis_sword', 'greater_crit'},
    {I_LUXURY,
      'pipe', 'black_king_bar', 'assault', 'heart'}
  },

  HERODESC{
    { THIS, "is an initiator (with his ", Q, "+", R, "combo) and splash damage dealer (with ", W, ")"},

    { "Despite being melee, ", W, "gives reasonable laning potential and ", THIS,
      "has good early damage potential, especially if an ally can set up ", Q, "for you." }
  },

  TIPS{
    {"The ",I'invis_sword'," backstab damage gets splashed by ",W,". Use this offensively"},

    {"Levels 2+ of ", E, "allow for guaranteed ", Q, "hits, if timed right."},

    {R, "always crashes a fixed 1000 units in the direction you cast it.",
      "The cursor is used only to select the direction."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"Consider getting ", Q, "at 1 and ", E, "at 2 and 3 if you have no friendly initiators."}
  }
}

-----

Go{
  heroid = 'Beast',
  date = {day=14, month=1, year=2013},

  SKILLBUILD{
    Q, {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      'soul_ring', 'magic_wand', 'boots', 'vanguard', 'blink'},
    {I_LUXURY,
      'necronomicon', {ALT, 'arcane_boots', 'travel_boots'}, 'vladmir', 'pipe'},
  },

  HERODESC{
    { THIS, "is a ganker and utility hero.",
    "Early on he is a decent laner (with help from his pig and axes) and later on he is a strong ganker/initiator (with his ultimate) and provides a powerful attack speed aura to his team.", }
  },

  TIPS{
    { "You can use ", W, "summons and a ", I'gem', "to destroy wards." },

	{ "At higher levels of play, Beastmaster is often played as a hard-lane solo by stacking the ancients with his ", Q,". Start with sentry wards if you can to prevent blocks on the ancients." },

    { I'travel_boots', " can be used to teleport to your pets. This is especially great if you have a",H'Tinker',"on the team."}
  }
}

-----

Go{
  heroid = 'Cent',
  date = {day=30, month=7, year=2012},

  SKILLBUILD{
    Q, E, {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', 'branches', 'flask', {2, 'tango'} },
    {I_CORE,
      'magic_wand', {ALT, 'hood_of_defiance', 'vanguard'}, 'boots', 'blink'},
    {I_LUXURY,
      'radiance', 'pipe', 'heart', 'shivas_guard', 'assault'},
  },

  HERODESC{
    { THIS, "is very versatile in that he can be played as an initiator/ganker or in a carry-ish role. In any case, his highlights are his blink +", Q, "combo and his solid early game damage with ", W }
  },

  TIPS{
    { "Getting a", I'blink', "is crucial, since everything you do is melee ranged." },
    { "Best combo order: ", Q, ", auto-attack, ",
      W, " (while the attack cooling), another attack. Don't forget to animation cancel!" },
    tip_ministun(W),
  }
}

-----'

Go{
  heroid = 'ES',
  date = {day=14, month=1, year=2013},

  SKILLBUILD{
    {MAX, Q}, {1,E}, W, {MAX, E}, {MAX, W},
  },

  --[=[
  ITEMBUILD{ name = "All Items (for testing)",

    {"Protectorate",
      'assault','heart','black_king_bar', --'aegis',
      'shivas_guard','bloodstone','sphere','vanguard',
      'blade_mail','soul_booster','hood_of_defiance','manta',},

    {"Arcane Sanctum",
      'sheepstick','orchid','cyclone','force_staff','dagon',
      'necronomicon','ultimate_scepter','refresher','veil_of_discord',
      'rod_of_atos',},

    { "Supportive Vestiments",
      'mekansm','vladmir','arcane_boots','ring_of_aquila',
      'buckler','ring_of_basilius','pipe','urn_of_shadows',
      'headdress','medallion_of_courage','ancient_janggo',
      'tranquil_boots', },

    { "Ancient Weaponry",
      'rapier','monkey_king_bar','radiance','butterfly',
      'greater_crit','basher','bfury','abyssal_blade',
      'lesser_crit','armlet','invis_sword','ethereal_blade',},

    { "Enchanted Artifacts",
      'sange_and_yasha','satanic','mjollnir','skadi','sange',
      'helm_of_the_dominator','maelstrom','desolator','yasha',
      'mask_of_madness','diffusal_blade','heavens_halberd',},

    { "Gateway Relics",
      'travel_boots','phase_boots','power_treads','soul_ring',
      'hand_of_midas','oblivion_staff','pers','poor_mans_shield',
      'bracer','wraith_band','null_talisman','magic_wand', },

    { "Cache of Quel-Thelan",
      'gloves','lifesteal','ring_of_regen','blink','sobi_mask',
      'boots','gem','cloak','magic_stick','talisman_of_evasion',
      'ghost', 'shadow_amulet'},

    { "Ancient of Wonders",
      'clarity','flask','tango','bottle','ward_observer','ward_sentry',
      'dust','courier','tpscroll','smoke_of_deceit','flying_courier', },

    { "Sena the Accessorizer",
      'gauntlets','slippers','mantle','branches','belt_of_strength',
      'boots_of_elves','robe','circlet','ogre_axe','blade_of_alacrity',
      'staff_of_wizardry','ultimate_orb', },

    { "Weapon Dealer",
      'blades_of_attack','broadsword','quarterstaff','claymore','ring_of_protection',
      'stout_shield','javelin','mithril_hammer','chainmail','helm_of_iron_will',
      'platemail','quelling_blade', },

    { "Secret Shop",
      'demon_edge','eagle','reaver','relic','hyperstone','ring_of_health',
      'void_stone','mystic_staff','energy_booster','point_booster','vitality_booster',
      'orb_of_venom', },
  },
  --]=]

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, {2, 'tango'}, {2, 'clarity'} },
    {I_CORE,
      'magic_wand', 'arcane_boots', 'blink' },
    {I_LUXURY,
      'ultimate_scepter', 'shivas_guard', 'sheepstick', 'heart' },
    {I_FALLBACK,
      'ward_observer', 'bottle', 'bracer', 'vitality_booster' },
  },

  HERODESC{
    { THIS, "is a support hero with a very long range stun and great initiation ability once he farms a", I'blink', "." },

    { "Early game, ", THIS, "can either support or roam, using ", Q, "to block terrain to secure kills or save allies. Either way, stay hidden in the trees to get the best ", Q, " angles (and to leech XP)" },

    { "Later in the game, try to farm a", I'blink', ". ", R, "deals devastating damage against clumped enemies and you can keep them stunned for a long time by chaining your skills correctly." },
  },

  TIPS{
    { "Unit-targeting ", Q, "is a sure hit, but ground-targeting allows for longer range and finer positioning" },

    { W, "is only really good for triggering", E, ";",
      "Don't get too excited about the damage."},
  }

}

-----

Go{
  heroid = 'Omni',
  date = {day=14, month=1, year=2013},

  SKILLBUILD{
    {MAX, Q}, W, E, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango', {2, 'clarity'} },
    {I_CORE,
      'arcane_boots', 'soul_ring', 'mekansm' },
    {I_LUXURY,
      'orb_of_venom', 'vanguard', 'pipe', 'shivas_guard', 'sheepstick' },
  },

  HERODESC{
    {THIS,"is a tanky support hero and chaser.",
     "His signature skills are",Q,", a strong heal/nuke and",W,", a free BKB for your carry.",     E,"also gives him an useful role in ganks and his ultimate ",
     "makes his entire team safe from physical damage for a while."},
  },

  TIPS{
    {R, "should be used in the heat of a battle (instead of when initiating or escaping). Note that it only prevents physical damage but not magic damage."},
  },

}

-----

Go{
  heroid='Brew',
  date={day=14, month=1, year=2013},

  SKILLBUILD{ {MAX, Q}, {2, S}, {MAX, E}, {MAX, W} },

  ITEMBUILD{
	{I_STARTING, {3, 'branches'}, 'flask', 'tango', 'stout_shield' },
    {I_CORE,
      'magic_wand', 'arcane_boots', 'blink', 'ultimate_scepter'},
    {I_LUXURY,
      'assault', 'heart', 'necronomicon', 'shivas_guard', 'vladmir',
      'ancient_janggo', 'pipe' },
  },

  HERODESC{
    {THIS,"is an initiator and anti-carry.",
      "His playstyle revolves around using",Q,"to gank and initiate (with a Dagger),",
      W,"for crippling an enemy right-click carry (with the miss chance) and",
      R,"for wreaking havoc without fear of dying."},
  },

  TIPS{
    {R,"pandas require micro: Send the Fire Panda to attack a squishy, stun something with the Earth Panda and tell the Storm Panda to cyclone someone else."},

    {"Most extension items are auras because they also work during",R},

    {"The levels in",S,"are to help with the manapool. Getting an early level in",E,
     "is also fine though."},

    {"At the end of",R,",",THIS," will reappear at Earth's place. If it is dead he'll take Storm's or Fire's place, in that order."},
  }
}

-----

Go{
  heroid = 'Sven',
  date = {day=14, month=1, year=2013},

  SKILLBUILD{
    {MAX, Q}, E, {MAX, W}, {MAX, E},
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'flask', 'tango', 'stout_shield'},
    {I_CORE,
      'magic_wand', 'power_treads', {OPT, 'ancient_janggo'}, 'black_king_bar',  'greater_crit'},
    {I_LUXURY,
      {OPT, 'blink', 'invis_sword'}, 'mask_of_madness', 'heart'},
  },

  HERODESC{
    {THIS,"is a versatile hero and can be played as either a support/roamer or as a semi-carry. Either way, his strong AoE stun and ",R," give him great early game potential and relative item independence."},

    { "Sven's reliable AoE stun is a great combo with delayed effect spells.",
      "He and ",H'Lina',"or",H'Lesh',"used to be very popular lane combinations."},
  },

  TIPS{
    {"An early ", I'ancient_janggo', " is an all-around great item for a hero like Sven who needs mana and movespeed."}
  }
}

-----

Go{
  heroid='Tiny',
  date={day=14, month=1, year=2013},

  SKILLBUILD{
    {3, Q}, {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{ name="Carry Items",
	{I_STARTING, {3, 'branches'}, 'flask', 'tango', 'stout_shield' },
    {I_CORE, 'phase_boots', 'ancient_janggo', 'yasha' },
    {'Extension',
      'ultimate_scepter', 'manta', 'assault', 'greater_crit', 'mjollnir'},
  },

  ITEMBUILD{ name="Ganker Items",
    {I_STARTING, {4, 'branches'}, 'flask', {2, 'clarity'} },
    {I_CORE, 'bottle', 'magic_wand', 'arcane_boots', 'blink' },
    {'Extension',
      'force_staff', 'cyclone', 'ethereal_blade', 'shivas_guard', 'sheepstick'},
  },

  HERODESC{
    {"The",Q,"+",W," combination is one of the most damaging combos in the game, making",
      THIS,"one of the scariest early game gankers. However, ",THIS,"is still able to transition to a powerful initiator (with a ",I'blink',") or a carry/pusher (with ",
      I'ultimate_scepter',"and IAS items)."}
  },

  TIPS{
    {"AvaToss combo: for max damage, cast",Q,"and immediately follow up with",W,".",
     Q,"deals double damage to units being tossed."},

    {THIS,"has instant cast time; Always animation cancel."},

    {W,"can throw an initiator (",H'ES',",",H'Tide',",",H'Techies',")",
     "into the other team."},

    {"Don't stack",Q,"and",W,"when you want to maximize disable time (you deal less damage though)."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"Basically any combination of ",Q,",",W,"and",R,"is fine early on.",
     "The suggested build is a balanced default."},

    {"Maxing",W,"over",Q,"is is better for harassing and for lasthitting in though lanes."},

    {R," at 6 gives good movespeed and equivalent AvaToss damage if you can land an auto-attack in.",
     "Delaying",R,"to level 9 gives maximum magical burst though."},

    {"You can skip ",E,"if the enemy team doesn't have lots of physical DPS."}
  },

  TIPS{ name="Toss casting mechanics",
    {"The cursor chooses where to throw the tossed unit to.",
     "You must target another unit (you cannot target ground)."},

    {"The the circle indicates the damage AoE. The dot in the middle is the target."},

    {"The tossed unit is chosen at random among those standing next to Tiny.",
     "For the AvaToss combo, stand right next to your target and throw it at itself."},
  }
}

-----

Go{
  heroid='TC',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'quelling_blade', {3, 'branches'}, {2, 'tango'} },
    {I_CORE,
      'boots', 'magic_wand', 'bottle', 'urn_of_shadows',
      'power_treads', {OPT, 'vanguard'} },
    {I_LUXURY,
      'assault', 'satanic', 'black_king_bar',
      'shivas_guard', 'refresher' },
  },

  HERODESC{
    {THIS, "is part initiator, part damage buffer, part dpser.",
     W,"+",Q,"can allow a lot of set-up time (useful for his ult or allied spells).",
     "His aura, while melee ranged, is devastating and his damage buff from ancestral spirit can make him a temporary dpser."},

  },

  TIPS{
    {"Hero damage wakes up stomped enemies. Coordinate well and be patient."},
  },
}

-----

Go{
  heroid='Treant',
  date={day=14, month=1, year=2013},

  SKILLBUILD{
    {MAX, W}, Q, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
		{ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango', {2, 'clarity'} },
    {I_CORE,
      'soul_ring', 'arcane_boots' },
    {I_LUXURY,
      'necronomicon', 'shivas_guard', 'refresher', 'vladmir', 'blink' }
  },

  HERODESC{
    {THIS,"is a support hero with good defensive laning skills.",
     W,"is great for diving and counter-diving and",Q,"can save allies from ganks.",
     "Finally,",E,"can be used to help allies win any lane and ",R,"is a decent team-fight spell."},
  },

  TIPS{
    {THIS,"can cast spells under",Q,"without breaking invis. (But allies can't)"},
    {Q,"is not only for escaping. Use it as a",I'smoke_of_deceit',"to set up ganks"},
    {R,"will entangle opponents that used BKB before you cast it, but if they cast BKB after they get entangled they will break free."},
  },
}

-----

Go{
  heroid='Wisp',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {4, 'branches'}, {2, 'tango'} },
    {I_CORE,
      'ring_of_basilius', 'boots', 'magic_wand', 'mekansm' },
    {I_LUXURY,
      {2, 'bracer'}, 'arcane_boots', 'vanguard', 'ancient_janggo', 'urn_of_shadows'}
  },

  HERODESC{
    {THIS, "is a very different kind of support hero.",
      "While he doesn't have any direct disable and is very fragile,",
      "he can turn any allied hero into a powerful global ganking (and backdooring) machine."},
  },

  TIPS{
    {Q,"transfers regeneration: tether an ally when you pop a consumable or are waiting in the fountain. (The regen doesn't work if you have full health or mana though)."},

    {R,"works if you aren't tethered. It is possible to go alone and come back with a friend (or vice versa)."},
  },
}

-----

Go{
  heroid='Alch',
  date={day=14, month=1, year=2013},

  SKILLBUILD{ name="Carry Skills",
    W, {MAX, E}, {MAX, Q}, {MAX, W}
  },

  SKILLBUILD{ name="Aggressive Skills",
    {2, W}, {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
	{I_STARTING, {3, 'branches'}, 'flask', 'tango', 'stout_shield' },
    {I_CORE,
      {ALT, 'vanguard', 'hood_of_defiance'},
      'radiance', 'power_treads' },
    {I_LUXURY,
       'mjollnir', 'basher', 'assault', 'heart', 'manta', 'shivas_guard'}
  },

  HERODESC{
    {THIS, "is a versatile hero, but the most popular way to play him is as a tanky",
    I'radiance',"carry. An ",THIS,"with high levels of",R,"is very hard to kill - add some DPS items and the enemy team wil be in a tough spot."},
  },

  TIPS{
    {"Alchemist can get super farmed in a defensive or offensive tri-lane, and get maxed out items by the 30 minute mark; well before most other carries."},

    {R,"gives lots of health and mana back when you cast it. It is OK to use it while farming."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"Feel free to max",E,"first if you can safely freefarm without needing",Q,
      "to counter-push."},

    {"An alternative play-style for",THIS,"is to use him as a support.",
      "Max your long-duration stun early, get cheap items such as",I'soul_ring',
      "and go around ganking."},
  },
}

-----

Go{
  heroid='Clock',
  date={day=14, month=1, year=2013},

  SKILLBUILD{
    {2, E}, W, {2, Q}, {2, E}, {2,Q}, {MAX, W}
  },

  ITEMBUILD{
	{I_STARTING,
	  {3, 'branches'}, 'flask', 'tango', 'stout_shield' },
    {I_CORE,
      'magic_wand', 'phase_boots', 'bottle', 'vanguard' },
    {'Defensive Items',
      'blade_mail', 'hood_of_defiance'},
    {'Aggressive Items',
      'ultimate_scepter', 'shivas_guard', 'necronomicon' }
  },

  HERODESC{
    {THIS,"is an initiator. He can use his",R,"to jump in and his",Q,"and",W,
      "to lock down a priority enemy before the fight starts."},
  },

  TIPS{
    {"The main needs from items are survivability (health and armor) and mana.",
      THIS,"has some of the worst stats in the game."},

    { Q,"ministuns can effectively silence heroes with long cast animations,",
      "such as",H'SF',"or",H'ES',". Be extra agressive against them." },
  },

  TIPS{ name="Rocket Flare",
    {"Scout enemy lanes (just after spawning), runes, Roshan, junglers, etc."},
    {"Last hit against a tough lane."},
    {"Push or counterpush across the map."},
    {"Aid in ganks."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"Get",Q,"for more ganking potential"},
    {"Get",E,"if you are on the hard lane or if you need to counterpush."},
    {"A single level of ",W,"is usually enough early on."},
  },
}

-----

Go{
  heroid='DK',
  date={day=14, month=1, year=2013},

  SKILLBUILD{
    {1, R}, {1, W}, {1, E}, {MAX, Q}, {MAX, E}, {MAX, W}, S, {MAX, R}
  },

  ITEMBUILD{
	{I_STARTING, {3, 'branches'}, 'flask', 'tango', 'stout_shield' },
    {I_CORE,
      {OPT, 'quelling_blade', 'urn_of_shadows', 'soul_ring'},
      'power_treads', 'black_king_bar', 'helm_of_the_dominator' },
    {I_LUXURY,
      'hyperstone', 'greater_crit', 'assault', 'satanic', 'mjollnir' },
  },

  HERODESC{
    {THIS, "is a strength carry that is greatly defined by his ultimate.",
      "The level 1 form (green dragon) is a strong tower razer and the level 3 form (blue dragon) deals devastating slowing damage in an AoE."},
  },

  TIPS{
    {"Level 1 of",R,"is generally considered better then level 2, due to the tower damage.",
    "Some people don't level up anything in level 15 and skip straight to level 3 after that."},
    {"If you get a",I'helm_of_the_dominator',", use a creep to stack ancients; You can farm a stack quickly with your AoE."},
  },
}

-----

Go{
  heroid='Huskar',
  date={day=14, month=1, year=2013},

  SKILLBUILD{
    W, {MAX, E}, {MAX, Q}, {MAX, S}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'gauntlets'}, {2, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      'power_treads', 'helm_of_the_dominator', 'armlet' },
    {'Damage',
      'black_king_bar', 'greater_crit', 'ultimate_scepter'},
    {'Survivability',
      'magic_wand', 'hood_of_defiance', 'urn_of_shadows', 'heavens_halberd'},
  },

  HERODESC{
    {THIS,"is a rambo initiator and anti-tank DPS hero.",
      "He is also a great aggressive laner, since he can use",W,
      "to orbwalk and harass. In a teamfight",THIS,"will deal massive damage if",
      "left unchecked at low life, but he is very vulnerable to burst nukes and disables."},
  },

  TIPS{
    {"The single level in",W,"is for orbwalking and for lowering your HP when jungling.",
      "We don't max it since we go for the ",I'helm_of_the_dominator',"build."},
    tip_orb_lifesteal('helm_of_the_dominator', W),
    {"You can reduce the self-damage from",R,
      "by getting magic resistance items or BKB."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"The idea behind the ",E,"+",Q,"build is to maximize fighting potential with",
      I'helm_of_the_dominator', ". The lifeleech and heal lets you stay alive at low hitpoints while dealing lots of damage with",E},
    {"Popular alternate skill builds are ",W,"+",E,"and",E,"+",S,".",
      "They have more damage potential, but come at a cost in survivability."},
  },
}

-----

Go{
  heroid='BB',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'sobi_mask', 'boots',
      'power_treads', 'vanguard', 'hood_of_defiance' },
    {I_LUXURY,
      'radiance', 'blade_mail', 'assault', 'pipe' }
  },

  HERODESC{
    {THIS, "is an unique kind of carry hero, depending on long drawn out fights to let",
      Q, "and radiance damage rack up.",
      "As such, healers and",H'Dazzle',"(for his ult) go very well with him.",
      "He can also be a very useful chaser with his snot."},
  },

  TIPS{
    {"Don't worry too much about mana. The mana problems quickly go away due to your very high INT gain."},
    {W,"is great for ganking and for getting hero kills, but get levels in $E if you want to survive and push towers."},
  }
}

-----

Go{
  heroid='Phoenix',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    Q, {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {3, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      'ring_of_basilius', 'magic_wand', 'tranquil_boots', 'chainmail',
      'urn_of_shadows', 'soul_ring' },
    {I_LUXURY,
      'medallion_of_courage', 'mekansm', 'hood_of_defiance',
      'shivas_guard', 'ancient_janggo'},
  },

  HERODESC{
    {THIS, "is a slippery initiator and support hero.",
      "He can jump in from a long range, his spirits are a powerful and spammable heal/nuke and his ultimate can be very strong if used correctly."},
    {R,"is a great teamfight skill, especially if comboed with ",Q,"'s disarm."},
  },

  TIPS{
    {"This item build emphasizes survivability and utility.",
      THIS,"has poor natural armor; Pay special attention to this."},
    {"Always try to fully charge the",W,"and then release them at an enemy.",
      "You will still get heal in an AoE around you."},
    {"Some people like getting Soul Ring for maximum spammability."},
  }
}

-----

Go{
  heroid='Legion',
  date={day=30, month=7, year=2012},

  TIPS{
    tip_todo(),
  }
}

-----

Go{
  heroid='Shredder',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    W, E, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', {3, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      'magic_wand', 'arcane_boots', 'ancient_janggo', 'bloodstone'},
    {I_LUXURY,
      'shivas_guard', 'sheepstick', 'pipe', 'heart', 'blade_mail'},
    tips = { tip_ab_disassemble() }
  },

  HERODESC{
    {THIS, "is a tanky ganker/nuker with an arsenal of high damage, low cooldown spells.",
      "He is fairly mobile as his", W, "is a pseudo-blink skill, and his", E, "helps him survive through fights.",
      R, "'s long range and powerful slow can help him keep up with weakened enemies that are trying to flee.",
      "As long as he has the mana regeneration to sustain him in combat, he is a force that needs to be reckoned with."}
  },

  TIPS{
    {Q, "deals pure damage if you use it near trees.",
     "It is also extra strong against STR heroes due to the main stat reduction."},
    {"Keeping", R, "in place is better against low HP enemies, due to the slow.",
     "Recalling", R, "just after its cast is useful for quickly dealing blade travel damage."},
  }
}

----------------------
-- Scourge Strength --
----------------------

Go{
  heroid='Axe',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {MAX, W}, Q, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'tranquil_boots', 'soul_ring', 'vanguard', 'blink', 'hood_of_defiance'},
    {I_LUXURY,
      'pipe', 'blade_mail', 'shivas_guard', 'assault', 'travel_boots' }
  },

  HERODESC{
    {THIS,"is an initiator and DotA's only true tank (since he can force enemies to attack him).",
      "He is also a bestly caster and ganker early game, being able to deal very high damage with",W,"and ",
      E,"making it very dangerous for any enemies that get too close him."},
  },

  TIPS{
    {"Issuing an attack order on an enemy hero draws creep aggro (this useful for ",E,")."},

    {E,"means that its better to jungle multiple stacked creeps at once.",
      "Pull creeps around the 51 second mark to stack the camps."},

    {"If an enemy tries to spam Stop or run away during",Q,"it will only make ",E,"proc more often."},

    {"You might find some older guides telling to skipping ",W,"entirely, getting it at levels 22-25).",
      "Back then it was a really bad skill but it has since been buffed and is quite strong."},
  },
}

-----

Go{
  heroid='CK',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, W}, {MAX, R}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'gauntlets', {3, 'branches'}, 'flask', {2, 'clarity'}},
    {I_CORE,
      {OPT, 'soul_ring'}, 'magic_wand', 'power_treads', 'armlet', 'ancient_janggo',},
    {I_LUXURY,
      'black_king_bar', 'manta', 'assault', 'heart'},
  },

  HERODESC{
    {THIS, "is a ganker, chaser and a strong teamfight brawler.",
      "He is bulky and fast and his low-cooldown skills let him shut down single targets very effectively."},
  },

  TIPS{
    {"You have big mana costs but low INT. Conserve your skills and get some items to help compensate."},

    {"When comboing, use ",W,"before",Q,". It has a bigger range and it also lets you hit the enemy more times."},

    {R,"has a relatively long cooldown, but the images are very bulky.",
      "Think of it as more of a damage boost, a-la Sven, and less of an image skill a-la Naga or PL."},

    {"If you get", I'armlet', ", always activate it juts before casting", R},
  },

  tips_illusion_mechanics(),
}

-----

Go{
  heroid='Doom',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Standard Skills",
    {MAX, Q}, W, {MAX, E}, {MAX, W}
  },

  SKILLBUILD{ name="Jungle Skills",
    {MAX, Q}, {MAX, W}, {MAX, R}, {MAX, E}
  },

  ITEMBUILD{ name="Standard Items",
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'phase_boots', 'vanguard',
      {OPT, 'bottle', 'radiance'}},
    {I_LUXURY,
      'pipe', 'assault', 'shivas_guard', 'heart', 'sheepstick'}
  },

  ITEMBUILD{ name="Jungle Items",
    {I_STARTING,
      'ring_of_protection', 'quelling_blade', 'tango', 'clarity' },
    {I_CORE,
      'ring_of_basilius','hand_of_midas', 'phase_boots', 'vanguard',
      {OPT,'radiance'}},
    {I_LUXURY,
      'pipe', 'assault', 'shivas_guard', 'heart', 'sheepstick'}
  },

  HERODESC{
    {THIS, "is a mix of caster and carry.",
      "He can use his",R,"to nullify an enemy for a whole teamfight and his ",
      E,"is the strongest single-target nuke in the game if you hit the level damage bonus.",
      "Finally, the bonus gold from ",Q,"allows him to farm items in order to shore up his weaknesses or to help him carry a bit."},
  },

  TIPS{
    {"The rule of thumb for ",Q,"creeps is to go for strong passives;",
      "Kobold (speed aura), Alpha Wolf (crit and damage) and Centaur (IAS aura) are some good choices.",
      "The Ogre Magi gives much-needed armor"},

    {R,"'s silence is devastating against enemy casters and heroes that relly on passives or items (lifesteal, evasion, etc)."},

    {"Sometimes it is best to leave unspent skill points in order to get the ",E,"multipliee."},

    {"Your have very low natural armour. Be careful when laning and get items to compensate."},
  },

  TIPS{ name="Jungling Tips",
    {"After you devour your first creep, you need to use the courier to send yourself a Healing Salve."},
    {"Use ", Q, " on large camps to make them easier to take down with less damage."},
	{"Use ", W, " on small camps to take them out quickly and to heal up a bit."},
	{"If you encounter an Ursa camp early game, ", Q, " the big creep, and then come back later and do the same to the smaller one.  It's not worth fighting in the beginning."},
  }
}

-----

Go{
  heroid='Naix',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Jungle Skills",
    {MAX, W}, E, {MAX, Q}, {MAX, E}
  },

  SKILLBUILD{ name="Laning Skills",
    E, Q, {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      {OPT, 'quelling_blade', 'hand_of_midas'},
      'magic_wand', 'power_treads', 'armlet' },
    {I_LUXURY,
      'desolator', 'basher', 'hyperstone',
      'assault', 'mjollnir', 'abyssal_blade', 'blink' },
  },

  HERODESC{
    {THIS, "is a carry.",
      Q,"'s magic immunity gives him a window of time to deal damage unimpeded and ",
      W," adds significant damage to his attacks (especially against low armour and high HP heroes)."},
    --TODO (infest comments):
    -- Heroes with good mobility, like Storm Spirit or ]]..Heroes.Prophet.nick..
  },

  TIPS{

    {W,"deals physical damage, and armour reduction helps a lot."},

    {"Blink Dagger is a nice way to negate your melee range and quickly take down squishies."},

    {"Get ",Q,"at level 1 if you are afraid of ganks."},

    {"While",THIS,"is a great jungler (check out the ",
      MARKUP('link', {
        "http://www.playdota.com/guides/choke-point-jungling",
        TIP{"guide on choke-point jungling"}
      }),
      "), at early levels its better to farm (and gank) in lane."},

    {R,"can be used on enemy creeps (to heal yourself) or on allied heroes (for positioning).",
      "Avoid infesting allied creeps, since that doesn't heal."},
  }

}

-----

Go{
  heroid='LoA',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    {2, W}, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {2, 'branches'}, 'flask', {2, 'tango'} },
    {I_CORE,
      'ring_of_basilius', 'magic_wand', 'arcane_boots', 'mekansm' },
    {I_LUXURY,
      'vladmir', 'ancient_janggo', 'necronomicon', 'sheepstick' },
  },

  HERODESC{
    {THIS, "straddles a fine line between straight support and dps-er (but when in doubt, err on the side of support).",
      "While he lacks straight disables or range, he compensates by having multiple spells that protect his teamates in battle."},
  },

  TIPS{
    {W, "removes debuffs and stuns!"},

    {R, "can be manually casted. Use it when you are getting focused (instead of letting it trigger on its own)."},

    {Q, "will not deal self damage if you are under",W,"(and will actually heal you if",R,"is active)."},
  }

}

-----

Go{
  heroid='Lycan',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {3, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      'ring_of_basilius', 'medallion_of_courage',
      'vladmir', 'power_treads' },
    {I_LUXURY,
      'black_king_bar', 'basher', 'necronomicon',
      'heart', 'assault' }
  },

  HERODESC{
    {THIS, "is a carry who used to be a strong jungler, but got nerfed heavily in 6.75. He is still a strong hero, but not quite the pub-stomper he once was.",
      "He excells at ganking lone heroes and taking down undefended towers with his summons."},
  },

  TIPS{

    {"It is still possible to solo Roshan with wolves, maxed",E,"and",I'vladmir',"; however, you need an additional item such as a Medallion of Courage."},

    {W,"is global and very cheap so don't forget to use it."},
  }

}

-----

Go{
  heroid='NS',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    Q, W, Q, E, Q, E, Q, R, {MAX, R}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'gauntlets'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'power_treads', 'urn_of_shadows', 'point_booster'},
    {I_LUXURY,
      'ultimate_scepter', 'basher', 'black_king_bar', 'vladmir', 'assault'},
    {I_OPTIONAL,
      'bottle', 'orb_of_venom'},
  },

  HERODESC{
    {THIS, "is a natural ganker, and can rack up lots of kills and map control after night falls.",
      "Play aggressively and try to get as many kills as possible in your first night to get the ball rolling."},
  },

  TIPS{
    {"Since ",W,"and",E,"are not useful during the day, leave their skillpoints unused until the first night comes."},

    {"Get an early level of",W,"if you need the silence to gank someone with a big disable or escape mechanism."},

    {R,"stops the day-night clock during its duration.",
      "Spam it during night time, since it just makes the whole night longer then."},

    tip_ministun( Q ),
  }

}

-----

Go{
  heroid='Pit',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    W, {MAX, E}, {MAX, W}, R, {MAX, Q}, {MAX, R}
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', 'branches', 'flask', 'tango' },
    {I_CORE,
      'soul_ring', 'magic_wand', 'arcane_boots', 'vanguard' },
    {I_LUXURY,
      'necronomicon', 'ancient_janggo', {OPT, 'mekansm', 'pipe'},
      'travel_boots', 'shivas_guard' }
  },

  HERODESC{
    {THIS, "is a pusher and counter-pusher.",
      "All his spells are AoE (perfect against enemies trying to push against a chokepoint or ramp)",
      "and ",E,"becomes very deadly after some creep corpses have piled up.",
      R," is best used for safely retreating after a team push."},
  },

  TIPS{
    {"For items, the main needs are some mana regen (but not too much - you have good int gain) and tankyness."},

    {"Avoid overfarming.",THIS,"does not need too many items."},

    {W,"spawns some corpses that you can blow up with ",E,"."},
  }
}

-----

Go{
  heroid='Pudge',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, {2, 'tango'}, {2, 'clarity'} },
    {I_CORE,
      'bottle', 'magic_wand', 'urn_of_shadows',
      {OPT, 'vanguard'}, 'hood_of_defiance', 'ultimate_scepter' },
    {I_LUXURY,
      'pipe', 'force_staff', 'travel_boots', 'ancient_janggo',
      'blade_mail', 'shivas_guard', 'heart' }
  },

  HERODESC{
    {THIS, "is a ganker.",
      "He tries to fish off enemy heroes with his", Q, "(after which he can finish them off with his combo)",
      "and later in the game the extra strength from",E,"allows him to mantain a presence through sheer tankyness."},
  },

  TIPS{
    {"Make sure that",W,"is hitting the enemy before you use ",R,
      "(",R,"has a longer range)."},

    {W,"'s self-damage is magic, and can be reduced with hood or pipe."},

    {"You can kill your self with",W,". You still lose gold, but enemies won't get gold or XP."},

    {"You can toggle ",W,"chanelling ",R,", without interrupting it.",
      "You can also cast ",W," while the",Q," is returning to you (but not when it is flying out)."},
  }

}

-----

Go{
  heroid='Leoric',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {2, S}, {1, W}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      {OPT, 'quelling_blade'}, 'magic_wand', 'armlet', 'power_treads' },
    {I_LUXURY,
      'force_staff', 'desolator', 'black_king_bar', 'assault', 'heavens_halberd'}
  },

  HERODESC{
    {THIS, "is a DPS carry.",
      "Move around the battlefield, casting stuns and stabbing enemies in their face without fear."},
  },

  TIPS{
    {"Managing mana and positioning are key; Don't waste your",Q,"."},

    {I'magic_wand',"and",I'soul_ring',"are nice ways to guarantee mana for",R,"(especially if you are against mana burners)."},

    { "Don't be afraid of getting ",I'armlet',";",
      MARKUP('link', {
        "http://www.playdota.com/guides/epic-return",
        TIP{"You only have only one active skill anyway"}
      }),
      "..."}
  },

}

-----

Go{
  heroid='Slardar',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
	  {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'power_treads', 'magic_wand', 'vanguard',
      {OPT, 'urn_of_shadows'}, 'blink' },
    {I_LUXURY,
      'black_king_bar', 'assault', 'heart' }
  },

  HERODESC{
    {THIS, "is a strength semi-carry, with good chasing and early damage potential.",
      "He is also a good initiator, especially after he gets items, blink and BKB."},
  },

  TIPS{
    {"Get survivability items.",Q,"and your melee range make you squishier than you would think."},

    {R,"gives vision over its target, even if it tries to go invisible. It also makes taking down Roshan much quicker because of the armor debuff."},
  }
}

-----

Go{
  heroid='Dirge',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, Q, {MAX, E}, W, {MAX, Q}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'ring_of_protection', 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'ring_of_basilius', 'vanguard', 'arcane_boots' },
    {I_LUXURY,
      'pipe', 'bloodstone', 'ultimate_scepter',
      'shivas_guard', 'blade_mail' },
  },

  HERODESC{
    {THIS,"'s job is to cause mayhem in team fights.",
      "Most of his skills do (or amplify) AoE damage, he has 3 skills that help him stay alive",
      "and",W,"can be one of the strongest nukes or heals in the games if you are in a crowded location."},
  },

  TIPS{
    {"Get survivability items first and mana regen items latter (the mana costs increase a lot in levels 12-14)."},
    {"Stay in close, to spam",Q,"and amplify damage with",R,".",
      "You are very hard to take down if you can continuously hit good", Q, "s."},
    {W,"can heal your",E,"."},
    tip_ab_disassemble(),
  },

  TIPS{ name="Justification",
    {"The rationale for the skill build is that low levels of",Q,"and",W,"have lower mana costs,",
      "and that there is no point in increasing the",W,"cap during the laning phase, when there are few creeps around.",
      "Finally,",E,"zombies are very strong early game.",
      "Midgame, max",Q,"if you have the mana to support it or max",W,"otherwise."},
  }
}

-----

Go{
  heroid='Tide',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    Q, {MAX, E}, W, {MAX, Q}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango', {2, 'clarity'}},
    {I_CORE,
      'magic_wand', 'arcane_boots', {OPT, 'urn_of_shadows'} },
    {I_LUXURY,
      'pipe', 'ward_observer', 'shivas_guard', 'refresher', {OPT,'blink', 'force_staff'}},
  },

  HERODESC{
    {THIS,"is defined by his extremely powerful ultimate:",
      "He can go for a more supporting build, getting few items but still being able to use ",R,"in team fights",
      "or he can go for a more tanky build, farming some survivability items and leading the charge during a push,",
      "daring the enemy team to come into range of a",R,"..."},
    {"Additionally,",W," removing debuffs and stuns makes it very hard for the enemy team to prevent you from casting your ultimate"},
  },

  TIPS{
    {versions={1},
      "Due to engine limitations, damage block items",
      "(",I'stout_shield',",",I'vanguard',",",I'poor_mans_shield',")",
      "don't stack with",W,"."},
    {I'blink', "is not always required, since ",R,"has a very long range already. It is never bad though."},
  },
}

-----

Go{
  heroid='Magnus',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'bottle', 'magic_wand', 'power_treads', 'blink', 'bfury' },
    {I_LUXURY,
      'mask_of_madness', 'black_king_bar', 'vladmir', 'greater_crit' },
  },

  HERODESC{
    {THIS, "is an initiator and DPSer.",
      "Early on, he can get good lane control with judicious use of",Q,"and bottle (be sure to get those runes!).",
      "Later on, he is all about blink-ulting and then taking powerful, empowered, swings that will cleave onto many helplessly stunned heroes."},
  },

  TIPS{
    {"Switch",I'power_treads',"to AGI when drinking from the ",I'bottle',".",
    "This maximizes the regen."},

    {"Unit-targeting",Q,"makes it easier to hit but ground-targeting allows you to better control the AoE gives a bit more range."},
  }
}

-----

Go{
  heroid='SB',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    Q, E, W, {MAX, E}, {MAX, Q}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'power_treads', 'mask_of_madness' },
    {I_LUXURY,
      'black_king_bar', 'ancient_janggo', 'heavens_halberd',
      'greater_crit', 'assault', 'mjollnir' }
  },

  HERODESC{
    {THIS,"is, at heart, a 1v1 hero that provides strong anti-carry potential with ", E,".",
      "He can gank fantastically (", Q," no longer creates a status debuff)",
      "and has the only bash in DotA that has the potential to be a literal perma-bash."},
  },

  TIPS{

    {"The",I'mask_of_madness',"build has good killing potential early, but get less effective later",
      "and forces you to get a BKB and/or survivability items. Go for ",I'mjollnir'," or ",I'assault',
      "if you want more survivability."},

    {Q,"gives vision, even on invisible heroes (although it doesn't reveal, it still shows where they are). Use this to help ganks."},

    {E," scales with levels now so can't really pass it up and ", W, " doesn't provide as much benefit in the early game as it used to."},
  }

}

-----

Go{
  heroid='SK',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, 'branches', 'flask', {2, 'tango'}, {2, 'clarity'} },
    {I_CORE,
      'magic_wand', 'arcane_boots', 'blink' },
    {I_LUXURY,
      'ultimate_scepter', 'veil_of_discord', 'shivas_guard',
      'sheepstick', 'black_king_bar' }
  },

  HERODESC{
    {THIS, "has decent ganking abilities,",
      "an amazing ult (especially coupled with a blink dagger),",
      "great disabling and mobility (",Q,"+ dagger)",
      "and even good lane clearing power with",E,"."},
  },

  TIPS{

    {"Get",E,"if you are laning against melee heroes (particularly ",H'Brood',")."},

    {"Blink-Epi: channel",R,"from a safe distance and order a blink while pressing shift so that it goes the instant the epicenter starts."},

    {"Don't be too picky about",R,"; Its fine if you only hit 2 or 3 heroes."},

    {"You can be very hard to kill: ",
      Q,",",W,"and",I'blink',"dodge projectiles (such as Magic Missile);",
      W,"can be used as a 3 second Wind Walk, due to the fade time."},
  }
}

----------------------
-- Sentinel Agility --
----------------------

Go{
  heroid='AM',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, Q, E, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
	  {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'ring_of_health', 'power_treads',
      {ALT, 'vanguard', 'bfury'},
      'manta' },
    {I_LUXURY,
      'heart', 'butterfly', 'basher', 'black_king_bar', 'vladmir' },
  },

  HERODESC{
    {THIS, "is a carry hero that also has some early damage potential in the form of",Q,".",
      "However, his greatest asset is definitely the incredible versatility of ",W,":",
      "jump in for a gank, jump out from a gank, quickly farm jungle camps..."},
  },

  TIPS{
    {"For the items, the ",I'vanguard',"is for when you are in trouble or want to fight early.",
      I'bfury',"is for farming (you clear the jungle very fast with it)."},
    tip_ministun(R),
    {"The \"Anti-Mage\" title is misleading;",
      Q,"is actually better against low-mana STR and AGI heroes and",
      E,"only makes you tanky if you also get HP items (lategame)."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"The build is very flexible; A good rule of thumb is to get at least one level of each skill by level 4."},
    {Q,"+",W,"is a good aggressive build."},
    {E,"+",W,"is a  good defensive build."},
    {"One point in each, followed by",S,"is good if you want to focus on farming for the lategame."},
  }
}

-----

Go{
  heroid='Sniper',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, E, {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'slippers'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'wraith_band', 'power_treads', 'manta' },
    {I_LUXURY,
      'helm_of_the_dominator', 'butterfly', 'black_king_bar', 'monkey_king_bar',
      'greater_crit', 'satanic', 'skadi' },
  },

  HERODESC{
    {THIS, "is a stereotypical ranged AGI carry.",
      "He deals outstanding DPS late game if he farms some items,",
      "but he is weak early game and does not have any escape or survivability skills.",
      "That said, he is a good turtler: his spammable AoE helps defend chokepoints",
      "and his range lets him stay far back in a safer position."},
  },

  TIPS{
    {Q,"deals residual damage to towers (Good for pushing and harassing)."},
	{"Some players like to skip putting levels into ", Q, ", instead getting his other skills sooner."},

    {versions={1},
      W,"and MKB's True Strike don't stack.",
      "You can toggle the MKB on and off to choose the effect you prefer."},
  }

}

-----

Go{
  heroid='Jugger',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, S, W, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {2,'branches'}, 'slippers', 'flask', 'tango', {3,'clarity'}},
    {I_CORE,
      'soul_ring', 'poor_mans_shield', 'phase_boots', 'bfury', 'ancient_janggo'},
    {I_LUXURY,
      {ALT, 'manta', 'sange_and_yasha'}, 'desolator', 'assault', 'butterfly' },
  },

  TIPS{
    {"Your tiny early game mana pool can't cast a full combo.",
      "Conserve your mana and get ",S,"to help."},

    {"The",Q,"+",I'tpscroll',"combo is a good way to escape."},

    tip_ministun(R),

    {W,"is a great for pushing. One possibility is to max it early with a",I'soul_ring'},

    {"If have lifesteal, you leach lots of life with",R},
  },

}

-----

Go{
  heroid='LD',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {'Hero Starting',
      {3, 'branches'}, 'flask', 'tango'},
	{'Bear Starting',
      'stout_shield'},
    {'Hero Core',
      'magic_wand', 'tranquil_boots'},
	{'Bear Core',
      'phase_boots', 'orb_of_venom', 'radiance'},
    {I_LUXURY,
      'assault', 'mjollnir', 'pipe', 'heart', 'butterfly' },
  },

  HERODESC{
    {THIS, "is a carry.",
      "Unusually, however, he has solid pushing abilities in mid-game due to",
      "his bear's siege damage and great tanking ability."},
  },

  TIPS{
    {THIS, "is a great laner. Use the Spirit Bear to harass (if on a safe lane) or to lasthit (if on a hard lane)."},

    {"It is OK to jungle instead if you have bad micro. You get slower farm though."},

    {"Early game, put most items go on the Spirit Bear and stay in ranged form;",
      "Late game, move the items to the druid and spend the majority of your time in Bear form."},

    {"The usual item build is going for a Radiance rush on the bear, since it is so tanky.",
      "From that point you continue to get even more survivability and aura items.",
      "The bear also benefits a lot from attack speed, in order to take down towers ",
      "and proc Entangle more often."},
  },

  TIPS{ name="Bear Mechanics",
    { "Get pure damage, IAS and armor items for the bear. It does not receive bonuses from STR, AGI and INT."},
    { "Entangle (level 3+ bear) does not stack with", I'quelling_blade', "." },
  },

}

-----

Go{
  heroid='Luna',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {MAX, Q}, {MAX,E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'ring_of_aquila', 'power_treads',
      'helm_of_the_dominator', 'yasha' },
    {I_LUXURY,
      'black_king_bar', 'manta', 'butterfly',
      'satanic', 'assault' },
  },

  HERODESC{
    {THIS, "is a carry hero with solid nuking potential early game and good AoE damage potential late game. However, she has to deal with her low survivability and attack range.",
      "Maybe she has a place in teams that can take advantage of her early-game damage aura?"},
  },

  TIPS{
    {"Don't get",W,"too early.",
      "It needs items to be effective and pushing may be undesirable."},

    {"Use the ",I'helm_of_the_dominator',"neutral creep to stack ancients.",
      "You farm them very fast with your AoE. (Pull creeps at the 52 second mark to stack)."},
  },

}

-----

Go{
  heroid='Morph',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, {2, 'flask'}, {2 ,'tango'} },
    {I_CORE,
      'ring_of_aquila', 'wraith_band', 'power_treads', {OPT, 'sphere'} },
    {I_LUXURY,
      'ethereal_blade', 'skadi', 'manta', 'butterfly',
      'black_king_bar', 'helm_of_the_dominator', 'heart' },
  },

  HERODESC{
    {THIS,"is a carry with tremendous single-target damage potential,",
      "in both sustained DPS and magical burst."},
    {E," can give you an effective 5 AGI growth per level and",
      "the", I'ethereal_blade', "+", W, "combo can deal massive damage.",
      "Meanwhile,", Q, "and", R, "allow", THIS, "to safely farm all game long",
      "while still being able to show up at important fights."},
  },

  TIPS{
    {"When in a tough spot,", E, "into STR for a strong pseudo-heal."},
    {I'travel_boots', "give you insane mobility for farming,",
      "but only get them if you are going really well."},
    {I'manta', "and", I'sphere', "are nice survivability options"},
  }

}

-----

Go{
  heroid='Naga',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, {MAX, E}, Q, {MAX, W}, {MAX, Q}
  },

  ITEMBUILD{ name="Standard Items",
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'quelling_blade', 'vanguard', 'arcane_boots', 'diffusal_blade'},
    {I_LUXURY,
      'heart', 'manta', 'butterfly', 'greater_crit' },
  },

  ITEMBUILD{ name="Alternate Items",
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'quelling_blade', 'tranquil_boots', 'soul_ring', 'radiance'},
    {I_LUXURY,
      'power_treads', 'heart', 'manta', 'butterfly', 'greater_crit' },
  },

  HERODESC{
    {THIS, "is an illusion carry hero.",
      "Early on she has good nuking and pushing power,",
      "and later in the game she can transition to a Radiance based farmer",
      "or do great DPS with ", I'diffusal_blade', "."},
    {R, "is a great teamfight positioning skill and gives time for heroes like",
      H'Enigma', "or", H'Tide', "to set up ridiculous ultimates."},
  },

  TIPS{
    {"You are great against BKBs:",
      W, "goes through magic imunity and", R, "does not put immune units to sleep,",
      "meaning they can suddenly find themselves in a 1v5 situation."},

    tip_illusion_vlads(),

  },

  tips_illusion_mechanics(),

}

-----

Go{
  heroid='PL',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Standard Skills",
    {MAX, Q}, {MAX, W}, {MAX, R}, {MAX, E}
  },

  SKILLBUILD{ name="Alternate Skills",
	{MAX, Q}, W, {4, S}, {MAX, R}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{ name="Standard Items",
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'tranquil_boots', 'soul_ring', 'vanguard', 'diffusal_blade'},
    {I_LUXURY,
      'heart', 'butterfly', 'manta', 'travel_boots' },
  },

  ITEMBUILD{ name="Alternate Items",
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'power_treads', 'radiance'},
    {I_LUXURY,
      'heart', 'butterfly', 'manta', 'greater_crit', 'travel_boots' },
  },

  HERODESC{
    {THIS, "is an illusion-based hard carry.",
      "Late game, he can can create large armies of expendable illusions",
      "that can be used for DPS or for mass split-pushing"},
  },

  TIPS{
    {"A quick", I'radiance', "is great if you can farm it early;",
      "Use it to farm multiple locations at once and to harass with", Q},

    {"Focus on farming early game.",
      "Use",Q,"to harass enemies away (especially if you have extra mana from,",
      "for example,", H'KOTL', "."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"You can leave", W, "at 1 level and get", S, "instead.",
      "The mana cost is much worse, but stats help farming and carrying"},

    {"Depending on how late the game goes, consider delaying", E, "and", R,
      "a bit for even more", S, "."},

    {"Always get a single level of", R, "earlier, though, for the magic resistance."},
  },

  tips_illusion_mechanics(),

}

-----

Go{
  heroid='POTM',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {1, W}, {1, E}, {MAX, Q}, {MAX, W}, {MAX, R}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'slippers'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'bottle', {2, 'wraith_band'}, 'power_treads'},
    {I_LUXURY,
      'sphere', 'manta', 'butterfly' },
    {"Orb Effects",
      'diffusal_blade', 'desolator', 'helm_of_the_dominator' },
  },

  HERODESC{
    {THIS, "is a classical semi-carry with strong ganking abilities.",
      "Her high burst damage, coupled with her stun and her ability",
      "to catch up with her prey makes her among the best semi-carry gankers in the game.",
      "Later in the game she can transition to a solid dps role but will",
      "be outperformed by true dps carries unless she can take advantage",
      "of an early level or item lead."}
  },

  TIPS{
	{"Your ", R, " is basically a global smoke of deceit for your team that doesn't break when you get near enemies."},
  },

}

-----

Go{
  heroid='Riki',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, Q, E, {MAX, W}, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'slippers'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'poor_mans_shield', 'power_treads', 'diffusal_blade' },
    {I_LUXURY,
      'manta', 'black_king_bar', 'butterfly', 'basher', 'greater_crit' },
  },

  HERODESC{
    {THIS, "is a carry with great burst damage from",E,"a superb AoE silence in the form of",Q,".",
      "As a bonus, he also gets permanent invisibility starting at level 6..."},
    {Q, "is also good against other melee carries,",
      "since they also get affected by the miss chance."},
  },

  TIPS{
    {"Early game, just try to farm without dying.",
      "Go ganking after you get your core items."},
    {I'diffusal_blade', "is great: it gives great damage with",E,
      "and the purge keeps targets inside the",Q,"for longer."},
    { versions={2},
      "You can purge yourself to remove the ", I'dust', "buff. (Dota 2 only)"},
  },

}

-----

Go{
  heroid='Troll',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    Q, {MAX, W}, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'poor_mans_shield',
       If(DOTA_VERSION == 1, 'power_treads', 'phase_boots'),
      'helm_of_the_dominator', 'invis_sword' },
    {I_LUXURY,
      'black_king_bar', 'manta', 'lesser_crit', 'butterfly',
      'satanic', 'monkey_king_bar' },
  },

  HERODESC{
    {THIS, "is a melee carry (yes, he is also ranged but he is more effective in melee form).",
      "While he has good right click damage and can single out enemies with his bash,",
      "he also has a low-cooldown global team damage boosting and pushing skill",
      "to help his team. If you stop to think about it,",
      "its actually very similar to", H'Lycan', "and many of the same principles apply."},
  },

  TIPS{
    {"You have lots of innate attack speed. Get damage items instead of evem more IAS."},

    {"Spend most of your time in melee form.",
      "The ranged form has less bonuses so use it",
      "only for laning, for casting the slowing version of",W,
      "and for when you need that one last hit when chasing."},

    {"You farm neutrals really fast with", E, "and some lifesteal."},

    {"With a ", I'helm_of_the_dominator', "and maxed fervor you can solo Roshan."},

    {"Don't forget to use your", I'helm_of_the_dominator', "domination ability."},

    tip_phase_boots_crit()

  },

}

-----

Go{
  heroid='Gyro',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'ring_of_aquila', 'phase_boots', 'bottle' },
    {I_LUXURY,
      'manta', 'black_king_bar', 'monkey_king_bar',
      'butterfly', 'satanic' },
  },

  HERODESC{
    {THIS, "is a semi-carry with some nuking and ganking potential early game",
      "and some carry and AoE potential lategame.",
      "Early on, get some cheap health and mana regen and try to pull of some ganks.",
      "If you are successful you can carry your advantage into the lategame",
      "and transition into more traditional agi DPS items."},
  },

  TIPS{
    {E, "hits farther then your attack range; You don't always need to target your intended target."},

    {"Depending on the game, it might be a good to delay ",E,"or",Q,"for",S, "."},
  },

}

-----

Go{
  heroid='Drow',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Carry Skills",
    Q, {MAX, E}, {MAX, W}, {MAX, S}
  },
  SKILLBUILD{ name="Ganker Skills",
    {MAX, Q}, E, W, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'slippers'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'power_treads', {ALT, 'helm_of_the_dominator', 'invis_sword'},
      'manta'},
    {I_LUXURY,
      'black_king_bar', 'butterfly', 'greater_crit', 'heart' },
  },

  HERODESC{
    {THIS, "is a ranged agi carry.",
      "Her niche lies in her great midgame damage,",
      "due to her ", R, "and", E, "allowing her to shine earlier than other carries."},
  },

  TIPS{
    {"Abuse your range and orbwalking during laning."},

    {"In clashes, don't charge in; DPS from behind and use", W, "at opportune times."},

    tip_orb_lifesteal('helm_of_the_dominator', Q),
  },

  TIPS{ name = T_BUILD_VARIATIONS,
    {"In the", I'helm_of_the_dominator', "build we leave",Q," at level one.",
      "This still allows orbwalking, but",E,"and",S,"give more damage."},

    {"It is OK to delay one or more levels of", W, "for", S},

    {"If you want to gank more, get more levels in", Q, "and skip the ", I'helm_of_the_dominator'},
  },

  tips_orbwalking(Q),

}

-----

Go{
  heroid='TA',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, E, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, {2, 'flask'} },
    {I_CORE,
      'bottle', 'phase_boots', 'blink', 'desolator' },
    {I_LUXURY,
      'black_king_bar', 'medallion_of_courage', 'assault', 'butterfly' },
  },

  HERODESC{
    {THIS, "is a bursty physical damage \"nuker\" and is usually played as a solo mid ganker and semi-carry."},
  },

  TIPS{
    {"Think of", W, "as an damage skill first and as an invisibility spell second!"},

    {"To avoid whiffing", W, ", position you cursor on top of your target first",
      "and immediately right-click after melding"},

    {Q,"'s damage prevention lets you be very aggressive."},

    {"Having low levels of",E, "is hard, but you need to max your other skills first."}
  },

  -- For future reference:
  --http://www.playdota.com/guides/the-solo-mid-guide
}

-----

Go{
  heroid='Ursa',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {3, W}, {MAX, E}, {MAX, W}, {MAX, Q},
  },

  ITEMBUILD{
    {I_STARTING,
      'branches', 'stout_shield', 'flask', {2, 'tango'} },
    {I_CORE,
      'tranquil_boots', SEQ, 'phase_boots', 'vladmir', 'blink' },
    {I_LUXURY,
      'black_king_bar', 'heart', 'sheepstick', 'blade_mail' },

    tips = {
      {"Disassemble the", I'tranquil_boots', "to build the", I'vladmir'},
    }
  },

  HERODESC{
    {"If", THIS, "can connect his combo he can almost instantly kill any single hero,",
      "provided he doesn't get disabled and they don't have a", I'ghost', ".",
      E,"'s damage grows quadratically and not even the tankiest enemy can be safe.",},

    {THIS, "is also arguably the best Roshan killer in the game,",
      "and can easily solo him as soon as he has ", I'vladmir', "and maxed", E, "."},
  },

  TIPS{
    { W, "lasts longer than its cooldown.",
      "You can cast it, wait a bit and then have 2 full overpowers when you engage ",
      "(This trick is great for Roshan too)."},

    {"Don't be fooled by having AGI as a main stat; Since you have great attack speed and damage already,",
      "get mobility and HP instead."},

    {"An initiation item (", I'blink', "or", I'invis_sword', ")",
      "is crucial - everything you do is melee ranged."},
  },

  --TOOD tip

}

-----

Go{
  heroid='VS',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, W, E, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'flask', {2, 'tango'}, {3, 'clarity'} },
    {I_CORE,
      'magic_wand', 'boots', 'ward_observer', 'ward_sentry' },
    {I_LUXURY,
      'ancient_janggo', 'urn_of_shadows', 'vanguard', 'hood_of_defiance',
      'ultimate_scepter' },
  },

  HERODESC{
    {"Even though she is an agility hero with good stats,",
      THIS, "is traditionally played as a support or roamer",
      "(and has always been one of the top heros in that role, if I may say).",
      "The reason why the support build works is that not only is", Q, "a great stun",
      "but both ",E, "and", W, "actually work for her allies too.",
      "Also, her attack range is not that good and using", R, "can sometimes be too risky",
      "if your team is depending on you to carry them."},
  },

  TIPS{
    {R, "can cancel TPs and channelling spells, even through BKB.",
      "(", H'Enigma', "'s Black Hole is a shining example)."},

    {"You can level up ", E, "later if you want;",
      "Just make sure you have at least one point when fights start happening."},
  },

}

-----

Go{
  heroid='BH',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name = "Hard lane",
    {2, E}, W, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  SKILLBUILD{ name = "Safe lane",
    {2, W}, E, {2, Q}, {MAX, W}, {MAX, Q}, {MAX, E}
  },
  ITEMBUILD{ name="Hard Lane Items",
    {I_STARTING,
      'branches', 'stout_shield', {2, 'clarity'}, 'flask', 'tango' },
    {I_CORE,
      'poor_mans_shield', 'power_treads', 'medallion_of_courage',},
    {I_LUXURY,
      'ancient_janggo', 'black_king_bar', 'desolator', 'monkey_king_bar',
      'butterfly', 'manta' },
  },

  ITEMBUILD{ name="Safe Lane Items",
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'poor_mans_shield', 'power_treads', 'medallion_of_courage',},
    {I_LUXURY,
      'ancient_janggo', 'black_king_bar', 'desolator', 'monkey_king_bar',
      'butterfly', 'manta' },
  },



  HERODESC{
    {THIS, "is a ganker and semi-carry.",
      "His signature skill is", R, "a skill that can give a great gold advantage to his whole team,",
      "but he is also known for his flexible laning possibilities." },
  },

  TIPS{
    {"If you are on a safe lane, harass with", E, "+", W, "and try to dominate your opponent.",
      "If on a hard lane, use", E, "to safely leech XP and lasthits.",
      "If on solo mid, get two levels of", Q, "at 4 and 5 for maximum ganking potential."},

    {"Don't be selfish about", R, " - it gives MS to all your team and it doesn't matter who gets the lasthit."},

    tip_ministun(Q),
  },

  TIPS{ name=T_BUILD_JUSTIFICATION,
    {"The idea behind this item build is to get some mana and survivability early game and lots of damage lategame to work with the", W, " crit."},
    {Q,"has a weird damage scaling. Either rush all 4 levels or leave it at level 2."},
    {W,"is great for lane control and farming, but only if you can safely get in melee range."},
    {E,"has a longer duration then its cooldown starting on level 2. (levels 3 and 4 give less of a benefit)"},
  },

}

-----

Go{
  heroid='Xin',
  date={day=30, month=7, year=2012},

  TIPS{

    tip_todo(),

  },

}

---------------------
-- Scourge Agility --
---------------------

Go{
  heroid='BS',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {2, W}, Q, {MAX, E}, {MAX, W}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      'quelling_blade', 'slippers', 'branches', 'flask' },
    {I_CORE,
      'poor_mans_shield', 'phase_boots', 'radiance', {OPT, 'hand_of_midas'} },
    {I_LUXURY,
      {OPT, 'force_staff'}, 'dagon', 'monkey_king_bar', 'desolator',
      'diffusal_blade', 'black_king_bar', 'butterfly' },
  },

  HERODESC{
    {THIS, "is ganker and dpser.",
      "Early on he can lane relatively safely due to the heal from",
      W, "and afterwards he can gank spellcasters using his long duration silence and", R, "."},
  },

  TIPS{
    {W, "lets you last hit very aggressively. Be sure to get the denies too!"},

    {"If you are having a hard time in lane, get more levels of Bloodbath.",
      "If you are having a great time, consider leaving it at just level 1."},

    {"The idea behind the", I'radiance', "build is that you can passively gain life from creeps that die around you.",
      "It also complements your chasing potential and is an attempt at helping you carry the game a bit."},
  },

}

-----

Go{
  heroid='Clinkz',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {MAX, W}, E, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'circlet', {3, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      'wraith_band', 'magic_wand', 'power_treads', 'orchid' },
    {I_LUXURY,
      'black_king_bar', 'monkey_king_bar', 'butterfly', 'skadi' },
  },

  HERODESC{
    {THIS, "is a ganker and a building razer.",
      "He can use his", E, "to sneak on his target and his other 3 skills do do great burst damage."},
  },

  TIPS{
    {R, "gives more bonuses if you eat a larger jungle creep."},

    {I'orchid', "or", I'sheepstick', "are suggested because you really need the mana and the disables (you already have good damage otherwise)."},

    {"For luxury items, prioritize damage, since you already have great attack speed with", Q, "."},
  },

  tips_orbwalking(W),

}

-----

Go{
  heroid='Brood',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ W, {MAX, Q}, {MAX, W}, {MAX, R}, {MAX, E} },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_regen', {2, 'branches'}, 'flask' },
    {I_CORE,
      'soul_ring', 'power_treads', 'orchid', 'black_king_bar'},
    {I_LUXURY,
      'butterfly', 'manta', 'greater_crit'},
  },

  HERODESC{
    {THIS, "is quite possibly the best solo pusher in the game.",
      "Push a lane while the rest of your team pushes another and the enemy will be in a tough position."},
  },

  TIPS{
    {"The regeneration from your webs coupled with a", I'soul_ring', "allows for nonstop ", Q, "spam (start doing this after level 5)."},

    {"If your lane is clear, take down the tower. If it isn't, nuke your opponent out of the lane or create spiders and send them to farm the jungle."},

    {"Do not feed the spiderlings! They give tons of gold and XP."},

    {W, "destroys trees. Use this to keep a safe line of sight to the jungle when laning."},
  },

}

-----

Go{
  heroid='NA',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, W, {MAX, E}, {MAX, W},
  },

  ITEMBUILD{
    {I_STARTING,
      {3,'branches'}, 'flask', 'tango', {3, 'clarity'}},
    {I_CORE,
      'magic_wand', 'arcane_boots', 'urn_of_shadows', 'dagon'},
    {I_LUXURY,
      'sheepstick', 'ancient_janggo', 'necronomicon', 'ethereal_blade', 'heart'},
  },

  HERODESC{
    {"Nyx is a burst-damage ganker who uses invisibility to sneak up on unsuspecting enemies."}
  },

  TIPS{
    {"A quick", I'dagon', "will allow you to insta-gib most heroes in the mid-game;",
      "Try to make enemies always fear your presence."},

    {"Late game, focus on scouting with", R, "to spot initiation oportunities and spam",
      W, "on high INT heroes."},

    {"Always animation cancel", E},
  },

}

-----

do

local weaver_starting = {I_STARTING, {4 , 'branches'}, 'ring_of_protection', {2, 'tango'} }
local weaver_luxury   = {I_LUXURY,
      'heart', 'black_king_bar', 'butterfly', 'monkey_king_bar', 'rapier'}

Go{
  heroid='Weaver',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, E, {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{ name="Radiance Rush",
    weaver_starting,
    {I_CORE,
      'ring_of_basilius' , 'ring_of_health', 'vitality_booster', 'radiance'},
    weaver_luxury,
  },

  ITEMBUILD{ name="Non-Radiance Build",
    weaver_starting,
    {"Core",
      'ring_of_aquila', 'medallion_of_courage', 'vanguard', 'power_treads' },
    weaver_luxury
  },

  HERODESC{
    {THIS, "can be very elusive and hard to kill hero,",
      "due to his great mobility with", W, " and ability to ignore burst damage with", R, ".",
      "Because of this, he is often played as a", I'radiance', "carry,",
      "although a midgame-focused, tower diving build with minus armour is also fine."},
  },

  TIPS{
    {"The item build should balance defensive and damage items.",
      "You need some HP pool for", R, "but without damage you risk being ignored."},

    {"Be careful about prolonging your game too much and farming excessively.",
      "Weaver can get out-carried if the game goes extremely late."},
  },

}

end

-----

Go{
  heroid='PA',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    Q, W, E, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'poor_mans_shield',
      If(DOTA_VERSION == 1, 'power_treads', 'phase_boots'),
      'bfury', 'helm_of_the_dominator', 'black_king_bar' },
    {I_LUXURY,
      'basher', 'monkey_king_bar', 'satanic', },
  },

  HERODESC{
    {THIS, "is a carry with great chasing ability and the strongest critical strike in the game.",
      "Once she gets a BKB and some damage items, she can almost instantly kill a hero she jumps on."},
  },

  TIPS{
    {"When laning, use", Q, "to lasthit; It deals little damage to heroes so don't bother harassing with it."},

    {"Do not buy evasion (Butterfly or Heaven's Halberd) or critical strike (", I'greater_crit', ").",
      "They don't stack with your skills."},

    tip_phase_boots_crit(),

  },

}

-----

Go{
  heroid='SF',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, {MAX, Q}, {MAX, W}, {MAX, R}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'slippers'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'bottle', SEQ, 'power_treads', 'black_king_bar' },
    {I_LUXURY,
      'manta', 'butterfly', 'desolator', 'greater_crit'},
    {"Mobility",
      'blink', 'invis_sword'},
  },

  HERODESC{
    {THIS, "is a glass-cannon semi-carry.",
      "He can do amazing damage with his ultimate, his 3 cheap AoE nukes and his high attack damage.",
      "He is also a strong mid lane hero, but he is vulnerable to ganks."},
  },

  TIPS{
    {"Bottle rush: leaving the base with just 4 branches and 2 salves leaves enough money to get a bottle by the 2 min mark."},

    {"Mobility items synergize with your spells; Survivability and damage items are for a traditional right-click DPS role."},

    {"Canceling the", Q, "backswing animation speeds your combo by a lot."},
  },

}

-----

Go{
  heroid='TB',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    E, {MAX, W}, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', {3, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      {2, 'wraith_band'}, 'power_treads', {ALT, 'manta', 'sange_and_yasha'} },
    {I_LUXURY,
      'skadi', 'helm_of_the_dominator', 'butterfly', 'heart' },
  },

  HERODESC{
    {THIS, "is an illusion-based carry.",
      "While he doesn't have any nukes or straight disables,",
      "he has very good innate DPS from his skills and his illusions",
      "can deal significant damage making him a relatively good pusher."},
  },

  TIPS{
    {"More early levels of", W, "are good for farming;",
      "Prioritize", E, "if you are doing fine and want to push."},

    {"Prefer getting stats (STR and AGI) items, since those also benefit the illusions."},
  },

  tips_illusion_mechanics(),

}

-----

Go{
  heroid='Spectre',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, E, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'quelling_blade', 'flask', {2, 'tango'} },
    {I_CORE,
      'poor_mans_shield', 'magic_wand', 'power_treads', 'radiance'},
    {I_LUXURY,
      'manta', 'heart', 'diffusal_blade', 'blade_mail', },
  },

  HERODESC{
    {"Spectre is an interesting carry because you build her for beefiness as opposed to raw damage output.",
    "The key is understanding", E, ":",
    "at max level, it rejects 22% of all damage that is dealt to", THIS,
    " and reflects it in an AoE around her. Making", THIS, "last as long as possible maximizes this damage."},

    {"Another important facet of", THIS, "is how she is always able to find farm, ",
     "since she can solo push lanes but still jump to fights with", R, "."},
  },

  TIPS{
    {"While the ", I'radiance', "build is usually optimal, if you farm slowly it might be best to",
      "go for a ganking build with a ", I'diffusal_blade', "."},

    {"Cast", R, "at the start of teamfights. This gives important vision and maximizes damage."},
  },

}

-----

Go{
  heroid='Veno',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ Q, W, {MAX, E}, {MAX, Q}, {MAX, W} },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango', {2, 'clarity'} },
    {I_CORE,
      'magic_wand', 'arcane_boots', 'ward_observer'},
    {I_LUXURY,
      'vanguard', 'pipe', 'force_staff', 'ultimate_scepter'},
    {I_OPTIONAL,
      'ring_of_basilius', 'mekansm' },
  },

  HERODESC{
    {"Although", THIS, "is an agility hero with decent stats,",
      "his skills allow him to be played as a very item independent support.",
      Q, "is one of the most powerful slows in the game at level 1 and is also cheap, mana-wise.",
      E, "are very strong for pushing and counter-pushing and",
      R, "is a strong \"fire and forget\" ultimate."},
  },

  TIPS{
    {E, "is cheap and spammable. Use them to scout in front whenever you enter the fog of war."},

    {"A big", E, "stack is also great for defending pushes."},

    {"You are very item independant; Just get some mana and then go for survivability and wards, dust, etc."},

    {R, "leaves enemies at 1 HP, without killing them. Tag them with", Q, "or", W, "to ensure your kills."},
  },

}

-----

Go{
  heroid='Viper',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {3, Q}, {MAX, W}, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      'circlet', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'power_treads', 'manta', {OPT, 'ultimate_scepter'}},
    {I_LUXURY,
      'black_king_bar', 'butterfly', 'heart', 'monkey_king_bar' },
  },

  HERODESC{
    {THIS, "is a tanky mid game DPS hero and ganker.",
      "He is also a very strong laner, due to his powerful orb-attacks."},
  },

  TIPS{
    {"You already deal good early game damage with your skills; Focus on getting items that let you get in and fight in the first place."},

    {"Gank frequently when you ave your ultimate, but always bring a fried to stop enemies from TP-ing away."},

    {R, "goes through BKB and is a a good debuff against enemy carries in fights."},
  },

  tips_orbwalking(Q),

}

-----

Go{
  heroid='Meepo',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    Q, {MAX, W}, E, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {2, 'branches'}, {2, 'flask'}, 'tango' },
    {I_CORE,
      'ring_of_basilius', 'mekansm', 'travel_boots'},
    {I_LUXURY,
      'pipe', 'vladmir', 'assault' },
    {I_OPTIONAL,
      'blink' },
  },

  HERODESC{
    {THIS, "is a mid-game carry (this is not the same as a semi-carry!).",
      "He depends on getting a significant level advantage early on",
      "and then using his multiple clones to roll face between levels 11 and 16.",
      "Once his clones reach a hero they can keep him permantly slowed or netted",
      "and casting all poofs in quick succession deals massive magical damage.",
    },
  },

  TIPS{
    {"Focus on speed-leveling early game to gain a quick numbers advantage.",
      "(See tab for XP mechanics)."},

    {"Poof combo: move next to a netted enemy, and tell all Meepos to", W,
      "on top of each other."},

    {"Use the TAB key to cycle across the Meepos. This makes it very easy to do",
      Q, 'or', W, 'combos.'},
  },

  TIPS{ name="Divided We Stand Mechanics",
    {"You get 2 total Meepos at level 6, 3 at level 11 and 4 at level 16."},
    {"Each Meepo clone is a fully controlable hero and has separate health, mana and cooldowns."},
    {"Clones also act as a hero for XP gain, but the XP is pooled together.",
      "Having 2 clones, one on each lane, earns 2 lane's worth of XP",
      "and if a lane is shared by two meepo clones and an ally",
      "then the meepos get 2/3 of XP instead of the usual 1/2."
    },
    {"The only items that transfer to Meepo clones are boots and stats",
      "(only 25% of stats gets transferred though)",
     "This is why most suggested items are auras or mobility/initiation items."}
  },

}

-----

Go{
  heroid='Razor',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ {MAX, Q}, W, E, {MAX, W}, {MAX, E} },

  ITEMBUILD{
    {I_STARTING,
      {2, 'slippers'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'poor_mans_shield', 'magic_wand', 'phase_boots',
      'hood_of_defiance', 'vitality_booster' },
    {I_LUXURY,
      'pipe', 'manta', 'mjollnir', 'heart', 'monkey_king_bar' },
  },

  HERODESC{
    {THIS, "is a DPSer, chaser and an anti-carry.",
      "While he has less inherent right-clicking potential then average,",
      "he has a good early-game presence due to his spells and",
      W, "can give a great boost in damage (while crippling an enemy hero at the same time)."},
  },

  TIPS{
    {"Most of your damage comes from your (close-ranged) spells.",
      "Prioritize tankability and the mobility items earlygame",
      "and leave the traditional carry items for latter."},
  },

}

-----

Go{
  heroid='Slark',
  date={day=30, month=7, year=2012},

  SKILLBUILD{ W, E, {MAX, Q}, {MAX, W}, {MAX, E} },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'power_treads', 'vanguard' },
    {I_LUXURY,
      'sange_and_yasha', 'black_king_bar', 'basher', 'armlet',
      'butterfly', 'skadi' },
  },

  HERODESC{
    {THIS, "is a weird kind of ganker and carry -", E,
      "can, over a fight, turn", THIS, "into a fearsome beast",
      "and", R, "allows him to quickly appear anywhere in the map,",
      "with full HP.",
      "However, he is very fragile and has to deal with a pitiful STR gain."
    },
  },

  TIPS{
    {"Get lots of survivability items early. You need the HP for, ", Q,
    "and you already deal good damage anyway."},

    {Q, "dispells buffs!",
      "Timing it right can remove stuns and", I'dust', "."},

    {R, "gets deactivated by enemy wards. This lets you detect when one is present."},
  },

}

-----

Go{
  heroid='Void',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    Q, {MAX, W}, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'stout_shield', 'flask', 'tango' },
    {I_CORE,
      'poor_mans_shield', 'power_treads', 'bfury' },
    {I_LUXURY,
      'black_king_bar', 'butterfly', 'greater_crit', 'satanic' },
    {I_OPTIONAL,
      'vanguard', 'mask_of_madness', 'hand_of_midas', 'necronomicon', 'ultimate_scepter'},
  },

  HERODESC{
    {THIS, "is a hard-carry.",
      "When farmed, he can reliably get rid of one or two heroes during the",
      R, "duration and supports become food to", Q, "coupled with some bashes."},
  },

  TIPS{
    {"If you are focused on the lategame, ", I'bfury', " and", I'hand_of_midas', "are good farming items;",
    "If you want to be useful sooner, ", I'mask_of_madness', "or", I'necronomicon', "give you great",
    R, "damage early on."},

    {"If you are having a hard time, ", W, "with a ", I'vanguard', "can make you very hard to kill."},
  },

}

-----

Go{
  heroid='Medusa',
  date={day=30, month=7, year=2012},

  SKILLBUILD{ {MAX, W}, {2, S}, {MAX, E}, {MAX, Q} },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {4, 'branches'}, {2, 'tango'} },
    {I_CORE,
      'ring_of_aquila', 'power_treads', 'sphere',
      'manta', 'butterfly' },
    {I_LUXURY,
      'satanic', 'skadi', 'travel_boots',
      'rapier', 'mjollnir' },
  },

  HERODESC{
    {THIS, "is one of the hardest hard carries in the game.",
      "If she gets farm and the game goes late she deals significant damage in an AoE,",
      "while being very tanky and hard to kill due to", E, "and", I'sphere', ".",
      "Early game she lacks ganking potential,",
        "but", W, "gives some decent lane control and",
        R, "can act as a \"get out of a gank free\" card."},
  },

  TIPS{

    {"Cast", W, "so that the last bounce hits an enemy hero. Also try to get some last hits with it."},

    {"Activating", I'manta', "will turn off the", E, ".",
      "Remember to turn it back on afterwards."},

    {"Focus on farming safely early on - you need lots of items to be effective."},
  },

}

---------------------------
-- Sentinel Intelligence --
---------------------------

Go{
  heroid='CM',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    Q, W, {2, E}, {MAX, Q}, {MAX, W}, {MAX, E}, {MAX, R}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'branches'}, 'flask', 'tango', 'courier', 'ward_observer' },
    {I_CORE,
      'tranquil_boots', 'magic_wand', 'bracer', 'bracer' },
    {I_LUXURY,
      'urn_of_shadows', 'ancient_janggo', 'point_booster', 'ghost',
      'ward_observer', 'smoke_of_deceit' },
  },

  HERODESC{
    {THIS, "'s two nukes/disables make her a very powerful",
      "supporter and roamer in the early stages of the game.",
      "Her aura can also greatly help mana-starved heroes,",
      "allowing them to spam spells when they normally couldn't."},
  },

  TIPS{
    {"Always cancel your long casting animation backswing."},

    {W, "lasts 10 seconds on creeps; Farm the jungle if there is nothing else to do."},

    {"You have very low movespeed and health - be extra careful."},
  },

  TIPS{ name="Skill Build Variations",
    {"CM's skillbuild is very flexible. Always tailor it to your game."},

    {Q, "is AoE and scales better, so its often maxed before", W, "."},

    {"Get", E, "depending on if your allies need it.",
      "At least two points by level 4 is a good rule of thumb."},

    {R, "is expensive and hard to cast (since CM is slow and squishy).",
      "Only get it at level 6 if you know what you are doing."},
  }
}

-----

Go{
  heroid='Ench',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, W}, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'tango', 'clarity', 'smoke_of_deceit' },
    {I_CORE,
      'ring_of_basilius', 'magic_wand', 'arcane_boots',
      'ultimate_scepter', 'ancient_janggo' },
    {I_LUXURY,
      'mekansm', 'sphere', 'shivas_guard', 'sheepstick', 'heart' },
  },

  HERODESC{
    {THIS, "is an aggressive jungler who can gank and push early on with neutral creeps.",
      "She can be surprisingly tanky in the right situations and can deal lots of damage",
      "mid and lategame with", R, "."}
  },

  TIPS{
    {"Be aggressive with your first 2 or 3 creeps;",
      "Few enemies can deal with them in the first minutes."},

    {Q, "are", W, "great against sustained damage but you will",
      "need HP items against burst damage (and to compensate for your low STR gain."},

    {Q, "makes you a surprisingly good Roshan tank."}
  },

  tips_neutral_creeps(),
}

-----

Go{
  heroid='Puck',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, E, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'mantle'}, {2, 'branches'}, 'flask', 'tango'},
    {I_CORE,
      'magic_wand', 'bottle', 'arcane_boots', 'blink'},
    {I_LUXURY,
      'mekansm', 'cyclone', 'sheepstick', 'shivas_guard', 'ghost', 'skadi' },
  },

  HERODESC{
    {THIS, "is an initiator by design - ",
      "blink into the enemy lines, cause chaos with your silence and",
      "trap them with your ultimate to set up for an allied attack."},
  },

  TIPS{
    { "Use", E, "to avoid harass damage during the laning phase."},

    { "Level 4 of", E, "lasts long enough to re-enable a disabled", I'blink', ". This makes you hard to kill."},

    { "Initiating with", I'blink', "is faster, and lets you use", Q, "to escape."},
  },

}

-----

Go{
  heroid='Chen',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {2, W}, {MAX, E}, {MAX, W}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, 'ring_of_protection', 'flask' },
    {I_CORE,
      'ring_of_basilius', 'arcane_boots', 'mekansm', 'ward_observer' },
    {I_LUXURY,
      'ultimate_scepter', 'ancient_janggo', 'vladmir' },
  },

  HERODESC{
    {THIS, "is a natural jungler,",
      "with tremendous early game power from his converted creeps.",
      "Early game, use them to gank and push towers and",
      "lategame use them to provide powerful auras and disables to your team."},
  },

  TIPS{
    {"Get", Q, "instead of", W, "if you have bad micro;",
      "It deals less damage, but provides an easy to use disable."},

    {E, "can save allies from sticky situations, by sending them back to base!"},

    {"Whenever someone lanes", THIS, "instead of jungling, Icefrog kills a kitten."}
  },

  tips_neutral_creeps(),

}

-----

Go{
  heroid='KOTL',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ Q, {MAX, E}, {MAX, Q}, {MAX, R}, {MAX, W} },

  ITEMBUILD{
    {I_STARTING,
      'courier', 'ward_observer', 'branches', {2, 'tango'} },
    {I_CORE,
      'mekansm', 'ring_of_basilius', 'tranquil_boots' },
    {I_LUXURY,
      'arcane_boots', 'vladmir', 'pipe', 'travel_boots',
      'sheepstick', 'dagon', },
  },

  HERODESC{
    {THIS, "is an item independent support hero.",
      "He excells at pushing and counter-pushing with", Q,
      "and in using", E, "to turn any allied hero with a low CD",
      "spell into a powerful caster."}
  },

  TIPS{
    {"Don't be selfish! Prioritize your teamates with", E,
    "and don't steal farm or overpush with", Q, "."},

    {"You are very item-independent; Prefer utility and aura items."},
  },

}

-----

Go{
  heroid='Zeus',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ Q, E, {MAX, W}, {MAX, E}, {MAX, Q} },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, {2, 'tango'}, {4, 'clarity'} },
    {I_CORE,
      'arcane_boots', 'bottle', 'point_booster', 'magic_wand',
      {OPT, 'bracer', 'null_talisman'} },
    {I_LUXURY,
      'ultimate_scepter', 'mekansm', 'veil_of_discord',
      'force_staff', 'ancient_janggo', 'ultimate_orb' },
  },

  HERODESC{
    {THIS, "is a glass cannon nuker.",
      "He can deal great damage from a distance with his spammable spells",
      "but is squishy and demands careful positioning in battles."},
  },

  TIPS{
    {"Cast", W, "first. It gives truesight vision around its target."},
    {"Use fog, trees, hills, to cast safely from afar."},
    {"Prioritize raw HP and Mana items over regeneration."},
    tip_ministun(W),
  },

  TIPS{ name=T_REFERENCES,
    { MARKUP('link', {
        "http://www.playdota.com/guides/shocking",
        TIP{"Merlini's Zeus guide"}
      }),
      "is a little old but is still very good." }
  },

}

-----

do

local furion_core = {I_CORE,
  'power_treads', 'magic_wand', 'urn_of_shadows',
  {OPT, 'medallion_of_courage', 'hand_of_midas'} }

local furion_luxury = {I_LUXURY,
  'mekansm', 'sheepstick', 'force_staff',
  'necronomicon', 'desolator', 'ultimate_scepter' }

Go{
  heroid='Prophet',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Jungling Skills",
    E, W, Q, {MAX, E}, {MAX, W}, {MAX, Q}
  },

  SKILLBUILD{ name="Laning Skills",
    Q, W, {3, E}, {MAX, W}, E, {MAX, Q}
  },

  ITEMBUILD{ name="Jungle Items",
    {I_STARTING, 'ring_of_basilius', {2, 'clarity'} },
    furion_core,
    furion_luxury,
  },

  ITEMBUILD{ name="Lane Items",
    {I_STARTING, 'circlet', {4, 'branches'}, {2, 'tango'} },
    furion_core,
    furion_luxury,
  },


  HERODESC{
    {THIS, "is characterized by his global presence with", W, ".",
      "Early game he can farm and gain levels while still being able to aid in any gank",
      "and late game he can keep lanes pushed for map control,",
      "while still being able to go back for any teamfight."},
  },

  TIPS{
    {R, "only bounces to visible units.",
      "Wait until enemy creepwaves are at low life to cast it."},

    {"You can freely cancel the", W, "animation to confuse your enemies."},

    {"Don't mindlessly spam", R, ".",
      "Pushing the lanes can make it harder for your team to farm."},
  },

}

end

-----

Go{
  heroid='Silencer',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, W}, S, {MAX, E}, {MAX, S}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      'mantle', {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'power_treads', 'mekansm', 'force_staff' },
    {I_LUXURY,
      'rod_of_atos', 'cyclone', 'pipe', 'sheepstick', 'shivas_guard' },
  },

  HERODESC{
    {THIS, "'s stats and his", W, "point him at a semi-carry role,",
      "while his passive and ultimate have a more utility role as a,",
      "combo-breaker against heroes such as", H'Tiny', "or", H'Storm', ".",
      "All in all, a good", THIS, "player will adapt towards the end of the spectrum",
      "that most helps his team."},
  },

  TIPS{
    {"Get more utility and dps items if going for a carry role;",
      "Prioritize survivability if you supporting with", E, "is more important."},

    {Q, "is a situational laning skill.",
      "It is great against heroes without ways to dispell it or trilanes,",
      "but it gets almost useless lategame."},
  },

}

-----

Go{
  heroid = 'Lina',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, {MAX, Q}, E, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango', {2, 'clarity'} },
    {I_CORE,
      'arcane_boots', 'bottle', 'urn_of_shadows' },
    {I_LUXURY,
      'ward_observer', 'ancient_janggo',
      'force_staff', 'blink', 'sheepstick' },
  },

  HERODESC{
    {THIS, "is a nuker that can also have reasonable physical damage latter in the game",
      "with", E, "."},
  },

  TIPS{
    {"Try to lane with a stunner that can set up", W, "for you."},

    {"Lategame, space you casts in regular intervals",
      "to keep", E, "up, instead of casting in quick succession."},

    {"Don't waste", R, "just to get kills on dying enemies.",
      "However, don't be afraid to use it to speed up a gank if enemies are missing."},
  },

}

-----

Go{
  heroid='Storm',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Overload Build",
    Q, E, {3, W}, {MAX, E}, {MAX, W}, {MAX, Q},
  },

  SKILLBUILD{ name="Remnant Build",
    Q, E, {3, W}, {MAX, Q}, {MAX, W}, {MAX, E},
  },


  ITEMBUILD{
    {I_STARTING,
      {2, 'mantle'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'bottle', 'arcane_boots', {OPT, 'null_talisman', 'null_talisman'} },
    {I_LUXURY,
      'black_king_bar', 'sheepstick', 'bloodstone', 'orchid', 'heart' },
  },

  HERODESC{
    {THIS, "'s", R, "is one of the best mobility skills in the game.",
      "Smart use of it allows", THIS, "to initiate, escape and chase very well."},
  },

  TIPS{
    {"Don't waste", E, "!",
      "Always attack between spell casts."},

    {"Small", R, "jumps can give extra", E, "procs."},

    {"Use your mobility to pick of enemies that are weak or of position."},

    {"Your spells are the strongest at levels 11-14.",
      "Use this window to gank as much as possible."},

    {"You are fragile. Don't initiate without BKB unless you know what you are doing."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"The major choice is whether to max", Q, "or", E, "after level 6.",
      "The", Q, "build has more burst damage",
      "but the", E, "build is less mana intensive."}
  },

}

-----

Go{
  heroid='WR',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ E, {MAX, W}, {MAX, Q}, {MAX, R}, {MAX, E} },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {4, 'branches'}, {2, 'tango'} },
    {I_CORE,
      'ring_of_basilius', 'phase_boots', 'mekansm', 'force_staff' },
    {I_LUXURY,
      'sheepstick', 'monkey_king_bar', 'orchid',
      'maelstrom', 'ultimate_scepter' },
  },

  HERODESC{
    {THIS, "is arguably the most versatile hero in DotA.",
      "Because of this, she will often pick up utility items",
      "and try to fill whatever role her team is missing the most (disabler, initiator, DPS, ...)."},
  },

  TIPS{
    {"The 3.75 seconds", Q, "stun can be game-changing.",
      "Practice and try to get multiple heroes in it."},

    {W, "loses some damage after going through creeps."},

    {R, "is not channeling!",
      "You can move, cast spells and use items",
      "as long as you don't try to attack anyone else."},
  },

}

-----

Go{
  heroid='Disruptor',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Mid Solo",
    R, {MAX, Q}, E, {MAX, W}, {MAX, E}, {MAX, R}
  },

  SKILLBUILD{ name="Support",
    R, {MAX, W}, E, {MAX, Q}, {MAX, E}, {MAX, R}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'flask', {2, 'tango'}, {3, 'clarity'} },
    {I_CORE,
      'bottle', 'magic_wand', 'arcane_boots'},
    {I_LUXURY,
      'mekansm', 'force_staff', 'pipe', 'urn_of_shadows',
      'veil_of_discord', 'sheepstick' },
  },

  HERODESC{
    {THIS, "is a nuker that can be played as a decent mid hero.",
      "While he lacks any direct disables, he has lots of positioning skills",
      "and can cause lots of AoE confusion if he gets his combo off."},
  },

  TIPS{
    {W, "is very versatile;",
      "Interesting uses are sending TP-ing enemies back to base and winning rune races."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"Most people leave", R, "at 1 point, since it scales very badly."},
    {E, "scales extremely well.", "Get it first if you won't have many levels,",
      "or as your second skill if you have solo XP."},
    {"It is OK to leave", E, "for last, since it is already good at level 1."},
  }
}

-----

Go{
  heroid='Ogre',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, W}, {MAX, R}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'mantle'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      {2, 'null_talisman'}, 'bottle', 'arcane_boots' },
    {I_LUXURY,
      'force_staff', 'blade_mail', 'bloodstone',
      'sheepstick', 'shivas_guard' },
  },

  HERODESC{
    {THIS, "is a support that transitions well into the lategame.",
      "His skills are all very strong when you can spam them",
      "(and when you get levels of", R, ") .",
      "His large STR gain also makes him much less vulnerable than other supports.",
      "However, early game he has to deal with his melee range and low mana pool."},
  },

  TIPS{
    {"Your stats gain are like those of a STR hero; Get early INT items for mana."},

    {"Its OK to get", R, "at 6, but that will increase the", Q, "manacost."},
  },

}

-----

Go{
  heroid='Techies',
  date={day=30, month=7, year=2012},

  SKILLBUILD{ {MAX, Q}, E, {MAX, W}, {MAX, S} },

  ITEMBUILD{
    {I_STARTING,
      'tpscroll', {2, 'tango'}, {7, 'clarity'} },
    {I_CORE,
      'arcane_boots', 'void_stone', 'ultimate_scepter', 'soul_ring' },
    {I_LUXURY,
      'bloodstone', 'sheepstick', 'force_staff', 'travel_boots' },
  },

  HERODESC{
    {"The Techies have many tricks in their arsenal.",
      "They can mine just off the creep-path to deny areas for the enemy and get kills if they wander there, they can pull off early ganks with suicide, they can stop creep spawns before the game really starts by eating a tree and placing a mine there, they can provide safe havens for their team with stasis traps, they can ward with remote mines, etc.",
      "An underrated hero that takes practice to master."},
  },

  TIPS{
    {"Use the TP scroll and Clarities to go to a lane and set up a mine stack before the creeps spawn."},

    {"Place mines on top of ramps or in juke paths",
      "to catch heroes by surprise and to protect against gems."},

    {"Abuse", W, "- the stun is the longest in the game."},

    {Q, "also deals damage to towers."},
  },

}

-----

Go{
  heroid='Jakiro',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Skills",
    {MAX, W}, E, Q, {MAX, E}, {MAX, R}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, 'ring_of_protection', 'branches', 'flask', 'tango' },
    {I_CORE,
      'ring_of_basilius', 'arcane_boots', 'mekansm',
      'urn_of_shadows', 'ward_observer' },
    {I_LUXURY,
      'void_stone', 'ultimate_scepter', 'shivas_guard',
      'pipe', 'sheepstick' },
  },

  HERODESC{
    {THIS, "is an item independent support hero with good stats gain",
      "and great pushing power with", E, "(it damages and slows towers!).",
      "However he has to deal with his low attack range and with his long cast animations."},
  },

  TIPS{
	{"Jakiro is a pretty amazing hero in 6.75, and highly recommended for beginners."},
    {"Your main needs from items are armor and mana regen."}
  },

}

-----

do

local tinker_rearm_tip = {
  "Get the first level of", R,
  "when you get your", I'travel_boots', ".",
  "The second and third level increase the manacost so get them when you",
  "acquire more mana items."}

Go{
  heroid='Tinker',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Ganking Skills",
    {MAX, Q}, {MAX, W}, R, {MAX, E}, {MAX, R},
    tips = { tinker_rearm_tip }
  },

  SKILLBUILD{ name="Farming/Pushing Skills",
    Q, {MAX, E}, {3, W}, R, {MAX, W}, {MAX, Q}, {MAX, R},
    tips = { tinker_rearm_tip }
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'mantle'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'bottle', 'travel_boots', 'soul_ring',
      {OPT, 'null_talisman', 'null_talisman'} },
    {I_LUXURY,
      'force_staff', 'sheepstick', 'shivas_guard', SEQ, 'manta',
      'ethereal_blade', 'dagon' },
    tips = {
      {I'travel_boots', "are mandatory.",
        "If you get another upgrade instead, Icefrog kills a kitten."},
    },
  },

  TIPS{
    {"Rearm also works with items:",
      "Use your", I'travel_boots',
      "to go to the fountain and come back to any lane with full health and mana.  Awesome!"},

    {"Early game, use your nukes to gank and farm the BoT.",
      "After that, use your global presence to maintain map control, push and gank."},

    {I'soul_ring', "plus", W, "is great for pushing an enemy farmer away from their lane."},
  },

  --$black_king_bar, $arcane_boots, $helm_of_the_dominator, $hand_of_midas, $refresher, $necronomicon, $mekansm and $pipe

  TIPS{ name="Rearm Mechanics",
    { "Some items don't get rearmed, for balance reasons:",
      MARKUP('ulist', {
        TIP{ I'black_king_bar' },
        TIP{ I'arcane_boots' },
        TIP{ I'helm_of_the_dominator' },
        TIP{ I'hand_of_midas' },
        TIP{ I'refresher' },
        TIP{ I'necronomicon' }
      }),
      NOPERIOD,
    },
    { "Some items don't interact well with rearm:",
      MARKUP('ulist', {
        TIP{ I'mekansm', "(cannot heal twice in less then 25s)" },
        TIP{ I'pipe', "(cannot cast twice in less then 50s)" },
      }),
      NOPERIOD,
    },
  },
}

end

-----

Go{
  heroid='Rhasta',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  SKILLBUILD{ name="Easy Build",
    E, {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, {2, 'tango'}, {3, 'clarity'} },
    {I_CORE,
      'magic_wand', 'bottle', 'arcane_boots',
      'blink', 'ultimate_scepter'},
    {I_LUXURY,
      'black_king_bar', 'bloodstone', 'refresher',
      'necronomicon', 'travel_boots' },
  },

  HERODESC{
    {THIS, "is a very strong pusher and disabler.",
      "He usually lanes solo mid (since he is very level dependent)",
      "but he also works fine with allies to abuse", E, "'s long disable duration."},
  },

  TIPS{
    {"Use", R, "to take down towers quickly;",
      "Make sure you creeps to tank for them though."},

    {"Select and manually control the", R, "wards.",
      "(Especially in fights and if you are dead)."},

    {W, "has a big mana cost.",
      "If its too hard to manage your mana,",
      "get", E, "instead."},

    {"You can trap people inside the", R,".",
      "Two easy cases to pull of are melee heroes attacking you or",
      "shift-queing after a close-range", E, ".",
      I'cyclone', "also works but I find that overkill."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {E, "is already good at level 1 and", W, "gets much better with levels",
      "so the suggested build is good for maximizing disabling power."},
    {"However,", W, "has a large manacost.",
      "Focusing in only one of the disables early might be better if you are not good with your mana."}
  },
}

-----

Go{
  heroid='Rubick',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {2, Q}, {MAX, W}, {MAX, E}, {MAX, Q}, {MAX, W},
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, {2, 'flask'} },
    {I_CORE,
      'bottle', 'magic_wand', 'arcane_boots', {ALT, 'force_staff', 'cyclone'} },
    {I_LUXURY,
      'mekansm', 'urn_of_shadows', 'necronomicon', 'bloodstone', 'sheepstick' },
    {I_FALLBACK,
      'urn_of_shadows', 'ancient_janggo'},

    tips = { tip_ab_disassemble(), },
  },

  HERODESC{
    {THIS, "is a flexible caster,",
      "turning his foes' spells against them with his ultimate,", R, ".",
      "With good positioning it's even possible to get 2+ huge ultimates off in a fight.",
    }
  },

  TIPS{
    {"Strong ultimates are especially desireable,",
      "but don't limit yourself to those, since", R, "has a very low",
      "cooldown and a great cast range."},

    {"You can choose a landing spot for", Q, "targets."},

    {"Feel free to spam", W, "when laning and in team fights, if you have the mana."},

    {"You can use", Q, "to set up stolen skill shots (such as", H'POTM', "'s arrow)"},

    {versions={2},
      Q, "can trap enemies on top of cliffs. (only in Dota2)"},
  },

  TIPS{ name="Spell Steal Mechanics",
    --citations needed:
    {"Certain spells can't be stolen (and this varies a lot between Dota1 and Dota2)."},

    { "Stolen ultimates come with the", I'ultimate_scepter', "upgraded version if",
      "either the enemy hero or", THIS, "have a scepter."},

    {"Stolen spells have instant casting animation, but spells with an aditional cast delay",
      "(such as", H'Sniper', "'s Assassinate", "or", H'Prophet', "'s Teleport", ")",
      "will still have that delay."},
  },
}

-----

Go{
  heroid='SM',
  date={day=30, month=7, year=2012},

  SKILLBUILD{
    W, {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {2, 'mantle'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'null_talisman', 'arcane_boots', 'bloodstone' },
    {I_LUXURY,
      'sheepstick', 'heart', 'shivas_guard' },
  },

  HERODESC{
    {THIS, "is a squishy nuker with very high range spells."},
  },


  TIPS{
    {"Use your high movespeed to stay just out of range during fights,",
      "while still dealing lots of damage with your spammable spells."},

    {"For the item build, the greatest needs are mana regen,",
      "mana pool and survivability."},
  },

}

--------------------------
-- Scourge Intelligence --
--------------------------

Go{
  heroid='Bane',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {MAX, W}, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, 'flask', {2, 'clarity'} },
    {I_CORE,
      'soul_ring', 'arcane_boots', 'magic_wand', 'necronomicon' },
    {I_LUXURY,
      'force_staff', 'sheepstick', 'mekansm', 'pipe' },
  },

  HERODESC{
    {THIS, "is a hero with many single-target disables.",
      "He can use them to be a strong ganker and to dominate some lanes."},
  },

  TIPS{
    {I'soul_ring', "+", W, "is a powerful laning combo."},

    {E, "is good for setting up skillshots like Sacred Arrow or Torrent"},

    {I'necronomicon', "minions can deal significant damage to",
      "enemies under", R, ". (And its not hard to micro when channelling)."},
  },
}

-----

Go{
  heroid='DS',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, W}, E, {MAX, Q}, {MAX, R}, {MAX, E},
  },

  ITEMBUILD{
    {I_STARTING,
      'stout_shield', 'branches', 'flask', {2, 'tango'} },
    {I_CORE,
      'soul_ring', 'vanguard', 'arcane_boots', 'cloak' },
    {I_LUXURY,
      'pipe', 'shivas_guard', 'ultimate_scepter', 'sheepstick' },
  },

  HERODESC{
    {THIS, "is one of the premier utility heroes in Dota.",
      "While not initially apparent, all his skills are very flexible and are",
      "great for setting up combos in teamfights"},
    {THIS, "is also a very good laner.",
      "In particular, he is great at soloing the hard, having an escape skill in",
        E, "and a way to farm from afar in", W},
  },

  TIPS{
    {"Use", Q, "to set up all kinds of combos.",
      "Using", Q, "to push enemies inside", R, "is devastating."},

    {"Building survivability items lets you always be in position to cast spells",
      "and lets you cast them multiple times over a fight."},

    {"If there is a melee carry or initiatior in your team, cast", W, "on him."},

    {"Multiple instances of", W, "on the same unit do not stack."},

    {"You can use", W, "to intercept creeps behind the tower, just like", H'Axe'},
  },

}

-----

do

local krob_starting = {I_STARTING,
  'ring_of_protection', {4, 'branches'}, {2, 'tango'} }

Go{
  heroid='Krob',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, E, W, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{ name="Tanky Caster",
    krob_starting,
    {I_CORE,
      'ring_of_basilius', 'magic_wand', 'arcane_boots', 'bloodstone'},
    {I_LUXURY,
      'mekansm', 'platemail', 'ancient_janggo',
      'travel_boots', 'skadi', },
    tips = { tip_ab_disassemble() },
  },

  ITEMBUILD{ name="MS/Positioning Build",
    krob_starting,
    {I_CORE,
      'ring_of_basilius', 'magic_wand', 'phase_boots', 'ancient_janggo'},
    {I_LUXURY,
      'cyclone', 'travel_boots'},
  },

  HERODESC{
    {THIS, "is a midgame carry.",
      "Just by standing in the middle of a fight,",
      "she can deal large amounts of damage with", R, "and", Q, ".",
      R, "is also a great skill for taking down towers."},
  },

  TIPS{
    {Q, "has a very long range, especially if you target ground."},

    {R, "ghosts move between you and their target",
      "and will tend to focus whoever you attack.",
      "For best results, stand close to your intended target",
      "and be attacking it before you cast the ", R, "."},

    {W, "can be used for confusion. A silenced enemy will have to stop to think what to do next."},

  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {THIS, "needs to stay alive to cast her spells.",
      "There are two common builds to achieve this:",
      MARKUP('ulist', {
        TIP{
          "The tankyness build simply stacks HP and mana regen items,",
          "and survives by \"brute force\"."},
        TIP{
          "The other build exploits the MS bonus from", E,
          "by getting lots of MS items to allow", THIS, "to always be in",
          "a safe position instead.", "Knowing how to use", Q, "from max range is crucial here."},
      }),
      NOPERIOD
    }
  },
}

end

-----

Go{
  heroid='Lion',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, W}, E, {MAX, S},
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, 'mantle', {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      {OPT, 'null_talisman', 'null_talisman', 'magic_wand' },
      'phase_boots', 'blink' },
    {I_LUXURY,
      'ward_observer', 'force_staff', 'sheepstick', 'ghost', 'black_king_bar' },
  },

  HERODESC{
    {THIS, "is a strong burst nuker and ganker and is also a good initiator",
      "and lategame support, due to his many disables."},
  },

  TIPS{
    {"Use", I'blink', "to initiate with", Q, "and", W, "."},

    {"Don't waste", R, "just to steal kills on dying enemies.",
      "However, don't be afraid to use it to speed up a gank if enemies are missing."},

    {W, "and", E, "can both be used to instantly kill illusions."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"While it might tempting to get", E, "in the laning phase,",
      "its almost always better to get",
      Q, "+", W, "instead, since that has much more killing potential.",
      "You will need to conserve your mana well and get bottle charges though."},

    {"It is up to personal choice how many (if any) point in ", E, "to get after level 9."},
  },

}

-----

Go{
  heroid='Enigma',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {3, W}, {MAX, Q}, {MAX, W}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, 'sobi_mask', {2, 'clarity'} },
    {I_CORE,
      'soul_ring', 'boots', 'blink', 'mekansm' },
    {I_LUXURY,
      'black_king_bar', 'travel_boots' },
  },

  HERODESC{
    {THIS, "teamfight hero, characterized by his game-changing", R, "ultimate.",
      "His", W, "also makes him a very strong strong jungler and solo laner",
      "and he can use this to give his team an early gold and XP advantage."},
  },

  TIPS{

    {"When jungling, micro the weak Eidolons back before they die."},

    {"A full army of 6 Eidolons is great for ganking with", R},

    {I'soul_ring', "is the best way to spam", W, "early game.",
      "Don't worry about the health - it regenerates back just fine."},

    {"Try to catch long ranged stunners inside the", R, "to protect the chanelling.",
      "Pay extra attention to heroes such as", H'VS', "or", H'Beast', "that can stun",
      "even through BKB"},
  },

}

-----

Go{
  heroid='Lich',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, {MAX, Q}, E, W, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'boots', 'magic_wand', 'mekansm', 'ward_observer', 'flying_courier' },
    {I_LUXURY,
      'bracer', 'bracer', 'force_staff', 'ultimate_scepter',
      'sheepstick', 'vladmir' },
    {I_OPTIONAL,
      'urn_of_shadows' },
  },

  HERODESC{
    {THIS, "'s main strength is his ability to use", E, "to deny",
      "large amounts of gold and experience from the enemy team in the laning phase",
      "and his strong harassing potential only adds up to that.",
      "Finally,", R, "is a very strong ultimate,",
      "often capable of turning ganks and teamfights around just by itself."},

    {THIS, "is considered by many a great hero for beginners new to the game.",
      "His spells are easy to cast, his ultimate is \"fire-and-forget\"",
      "and he can still help his team even when he is underleveled or underfarmed."},
  },

  TIPS{
    {"Spam", W, "when it is off cooldown; It is very cheap."},

    {R, "is best when there are just 2-4 enemy units clustered together",
      "but don't be too picky waiting for the \"perfect moment\"."},

    {"If you get", E, "at level 1,",
      "eat a creep as soon as the first creepwave spawns in base."},
  },

}

-----

Go{
  heroid='Necro',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, W, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {4, 'branches'}, {2, 'tango'} },
    {I_CORE,
      'ring_of_basilius', 'magic_wand', 'power_treads', 'mekansm' },
    {"Survivability",
      'cloak', 'platemail', 'ancient_janggo', 'ghost', 'vitality_booster' },
    {"Mana and damage",
      'sheepstick', 'shivas_guard', 'assault', 'travel_boots' },
  },

  HERODESC{
    {THIS, "loves a long fight.",
      Q, "and", W, "deal constant DPS to the enemy team,",
      "while", Q, "turns him into a walking fountain for his team."}
  },

  TIPS{
    {"Your mana is tight early game.",
      "Conserve", I'magic_wand', "charges and be a good last-hitter."},

    {R, "kill thresholds:",
      MARKUP('bold', {TIP{"23%"}}),
      " / ",
      MARKUP('bold', {TIP{"31%"}}),
      " / ",
      MARKUP('bold', {TIP{"40%"}}),
      "of max HP."
    },

    {R, "'s damage is calculated after the stun ends. Its OK to cast it a bit early."},

    {"Prioritize survivability items first and mana second."},

    {THIS, "needs lots of gold and levels.",
      "You are not a pure support!"},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"You can get a single point in", W, "at level 2",
      "to negate enemy built-in regen in lane."},

    {"An early", I'soul_ring', "lets you cast", Q, "for free,",
      "at the cost of the self heal.", "This can be good if you are pushing very early."},

    {"Don't buy", I'ultimate_scepter', " - the bonus is too small."},
  },

}

-----

Go{
  heroid='Pugna',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, W, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, {2, 'flask'} },
    {I_CORE,
      'bottle', 'power_treads', 'void_stone', 'mekansm' },
    {I_LUXURY,
      'sheepstick', 'ultimate_scepter', 'travel_boots', 'black_king_bar' },
  },

  HERODESC{
    {THIS, "is a great pusher and can play a reasonable semi-carry role",
      "but his greatest asset is surely his", E, ", as it turns fights",
      "into living hell for enemy spellcasters.", THIS, "is the real Anti Mage."},
  },

  TIPS{
    {Q, "also damages towers."},

    {"Use early levels of", R, "to heal from creeps;",
      "Use the higher levels in fights to \"push\" heroes away from you."},

    {"You can", W, "your own", E, "to protect it from attacks."},

    {"Get HP items to compensate your 1.0 STR gain.",
      "On the other hand, just a few percentage mana regen items",
      "should cover your mana needs (you have the highest INT gain in the game)."},
  },

}

-----

Go{
  heroid='OD',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ {3, W}, {MAX, E}, {MAX, R}, {MAX, Q}, {MAX, W} },

  ITEMBUILD{
    {I_STARTING,
      'mantle', {3, 'branches'}, {2, 'tango'}, 'flask' },
    {I_CORE,
      'magic_wand', 'power_treads', 'force_staff', 'rod_of_atos' },
    {I_LUXURY,
      'sheepstick', 'black_king_bar', 'shivas_guard', 'hyperstone', 'heart' },
  },

  HERODESC{
    {THIS, "is a glass cannon DPS hero.",
      "If he gets good items, his orb adds a pure damage nuke",
      "to each attack and his ultimate deals tons of AoE damage."},
  },

  TIPS{
    {"Spamming", W, "helps you dominate in lane against other solo heroes.",
      "They get reduced mana to cast spells while you get lots of extra attack damage."},

    {"Level 4 of", E, "recovers 10% of your mana pool per cast, on average.",
      "1000 total mana is the magic mark for", Q, "."},

    {R, "is also devastating against heros with high INT, since it drains mana from them."},

    {R, "also hits units hidden by", W, "; They are protected from other spells though."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"You need survivability and INT from items.",
      "The suggested", I'mekansm', "is not out of place:",
      "think of it as a better", I'vanguard', "on OD"},

    {"For skills, the basic idea is that you want one level of", Q, "somewhat early",
      "and some levels in", W, "for lane control.",
      E, "often ends up maxed first, since you need it to freely spam your skills."},

    {"Getting more levels in", W, "leads to better lane control at the cost of",
      "delaying additional levels in", Q,".",
      "Stopping at 3 is a good rule of thumb."},

    {"Don't buy", I'ultimate_scepter', ".",
      "It is better to simply get more INT items instead."},
  },

  tips_orbwalking(Q),
}

-----

Go{
  heroid='QoP',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    W, {2, Q}, {MAX, E}, {MAX, W}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      'mantle', {2, 'tango'}, {3, 'branches'} },
    {I_CORE,
      'bottle', 'power_treads',
      {OPT, 'magic_wand', 'null_talisman', 'null_talisman'} },
    {I_LUXURY,
      'sphere', 'ultimate_scepter',
      'sheepstick', 'travel_boots',
      'skadi', 'veil_of_discord' },
  },

  HERODESC{
    {THIS, "is a fragile caster and her nukes aren't the strongest in the game.",
      "However, the mobility from", W, "more than compensates,",
      "allowing her to quickly close in to any escaping or out of position enemy hero."},
  },

  TIPS{
    {"Wait until you reach the lane to spend your first skill point."},

    {Q, "is a spammable lane-control spell against enemy solo heroes."},

    {"Don't rambo - wait for an ally to initiate before blinking into a group of enemies."},

    {"It is OK to use the", I'ultimate_scepter', " upgraded", R,
      "to clear some large creepwaves; It has a short cooldown."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"Get 0, 1, or 2 levels of", Q, "early, depending on your opponents."},

    {"The itembuild is very flexible and depends on if its best to invest in",
      "disables, magic damage, pushing power or physical DPS"},
  }
}

-----

Go{
  heroid='Warlock',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, W}, {MAX, Q}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango', {3, 'clarity'}},
    {I_CORE,
      'ring_of_basilius', 'power_treads', 'mekansm' },
    {I_LUXURY,
      'necronomicon', 'ultimate_scepter', 'refresher', 'sheepstick' },
  },

  HERODESC{
    {THIS, "'s high base damage, good attack animation,",
      "and heal make him a decent babysitter.",
      "He is also a decent solo laner and", Q, ",", E, "and", R,
      "are all great teamfight spells."}
  },

  TIPS{
    {"In lane, use", Q, "to harass;",
      "In teamfights, it is a strong AoE damage amplifier."},

    {"All your spells are fairly weak on their own but become very strong",
      "if you can combo with more AoE damage and disables from your team."},

    {"Always micro the summoned", R, "Infernal - it deals good damage and is also",
      "a great tower pusher."}
  },

}

-----

Go{
  heroid='SD',
  date={day=30, month=7, year=2012},

  SKILLBUILD{ name = "Support Skills",
    Q, {MAX, W}, {MAX, Q}, {MAX, E}
  },

  SKILLBUILD{ name = "Solo Mid skills",
    Q, {MAX, E}, {MAX, W}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, 'mantle', {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'magic_wand', 'bottle', 'arcane_boots' },
    {I_LUXURY,
      'force_staff', 'ancient_janggo', 'mekansm',
      'urn_of_shadows', 'rod_of_atos' },
  },

  HERODESC{
    {THIS, "is a very good harasser, often seen as a support or solo mid hero.",
      "His", Q, "+", W, "combo great for setting up skill shots such as",
      H'Lesh', "'s stun and", H'Invoker', "'s Sunstrike."},
  },

  TIPS{
    {W, "and", E, "also hit disrupted units.",
      "Use this for some easy combos."},

    {"On teamfights, prioritize", R, "on BKB carries,",
      "enemies with haste or double damage runes,",
      "with big dispellable buffs (like", H'Brood', "'s ultimate)",
      "and channelers."},

    {"You can manually control disruption illusions.",
      "This is great for targeting supports if you disrupt a carry."},

    {"MS and mobility items help you stay at a safe distance",
      "while still dishing out spells."},
  },

}

-----

Go{
  heroid='Bat',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      'ring_of_protection', {4, 'branches'}, {2, 'tango'} },
    {I_CORE,
      'ring_of_basilius', 'bottle', 'boots',
      'urn_of_shadows', 'blink', 'travel_boots' },
    {I_LUXURY,
      'pipe', 'black_king_bar', 'heavens_halberd', 'shivas_guard' },
  },

  HERODESC{
    {THIS, "is a great initiator with", R, ":",
      "with a", I'blink', "he can almost aways pick off one enemy hero before teamfights."},
    {THIS, "is also a very strong laner with", Q, ":",
      "if an enemy is ever foolish to let too many stacks acumulate,",
      "walking over them with", E, "is an almost guaranteed kill."},
  },

  TIPS{
    {"Go for the kill if you get 4 or 5", Q, "stacks on an enemy solo hero."},

    {"Use", W, "to scout before clashes, stop channeling and disable blink daggers."},

    {"You can be use", E, "to farm multiple (stacked) neutral camps very effectively.",
      "(if there is nothing else going on)"},
  },
}

-----

Go{
  heroid='Dazzle',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    E, W, {3, Q}, {MAX, E}, {MAX, R}, {MAX, Q}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, {2, 'tango'}, {2, 'clarity'} },
    {I_CORE,
      'boots', {ALT, 'medallion_of_courage', 'urn_of_shadows'}, 'mekansm' },
    {I_LUXURY,
      'arcane_boots', 'ultimate_scepter',
      'sheepstick', 'orchid', 'necronomicon' },
  },

  HERODESC{
    {THIS, "is usually played as a support,",
      "but his stats also allow him to make good use of gold and levels if those come by."},
    {"Early game, he can use his good base damage to control the lane.",
      "Latter on, he has 3 skills that keep your team alive while his",
      "ultimate turns the enemy into fragile targets over time."},
  },

  TIPS{
    {E, "deals damage in an AoE around each bounce.",
      "For maximum damage, heal a group of units clustered together around an enemy."},

    {"All your skills deal physical damage and combo well with armor reduction."},

    {R, "has a low cooldown. Don't be picky about casting it."},
  },

  TIPS{ name=T_BUILD_VARIATIONS,
    {"Most of the time you want just single level of", W, "maxing it last."},

    {"It is OK to max either", Q, "or", E, "first.",
      "Just keep in mind that", Q, "does a full stun starting from level 3."},
  },
}

-----

do

local function spell(name, x1, x2, x3, tips)
  local tip = {}
  table.insert(tip, MARKUP('bold', {name.." ("}))
  table.insert(tip, x1)
  table.insert(tip, x2)
  table.insert(tip, x3)
  table.insert(tip, MARKUP('bold', {")"}))
  for _, t in ipairs(tips) do
    table.insert(tip, t)
  end
  return tip
end

Go{
  heroid='Invoker',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="QW Disabler", isInvoker=true,
    Q, {MAX, R}, {MAX, W}, {2, Q}, E, {MAX, Q}, {MAX, E},
    tips={ {"Key Abilities: Tornado, EMP, Cold Snap, Ghost Walk"} }
  },

  SKILLBUILD{ name="EQ Carry/Pusher", isInvoker=true,
    E, Q, R, {3, E}, {3, Q}, R, W, {MAX, E}, W, {MAX, R}, {MAX, W}, {MAX, Q},
    tips={ {"Key Abilities: Forged Spirit, Cold Snap, Sun Strike, Ice Wall"} }
  },

  ITEMBUILD{
    {I_STARTING,
      'blades_of_attack', 'branches', 'tango'},
    {I_CORE,
      'phase_boots', 'ancient_janggo', {ALT, 'cyclone', 'force_staff'} },
    {I_LUXURY,
      'ultimate_scepter', 'sheepstick', 'assault', 'black_king_bar', 'skadi' },
  },

  HERODESC{
    {THIS, "is an incredibly flexible Intelligence hero.",
      "His wide variety of spells allow him to fill many different roles on the team,",
      "and later in the game, his access to all of them gives him",
      "great utility on the battlefield."},

    {"Because of his dependence on levels,", THIS, "is almost always played",
      "as a solo mid hero."},
  },

  TIPS{
    {"The regen from", Q, "helps you survive in lane.",
      "(Good against agressive heroes such as", H'Tinker', ")"},

    {"The MS from", W, "helps reach runes and be present in the other lanes."},

    {"The damage from", E, "helps you out CS and harass your opponents.",
      "(Good against melee heroes such as", H'Tiny', "and", H'BS', ")."},

    {"You should probably read something more in-depth then this guide :)", NOPERIOD},
  },

  TIPS{ name="Spell Guide",
    spell("Cold Snap", Q, Q, Q, {
      "A powerful and flexible disable. Use it on targets your team is focusing.",
      "Cold Snap is extra strong against heroes with long casting animations such as", H'Lesh', ".",
      "Also remember that the casting range is very long."
    }),

    spell("Ghost Walk", Q, Q, W, {
      "Your escape mechanism. Note that using Ghost Walk also slows nearby enemies,",
      "so they might be able to detect your presence due to the buff."
    }),

    spell("Tornado", Q, W, W, {
      "An initiating nuke, escape mechanism and general disable.",
      "The travel distance increases with", W, "and goes an incredible 3000 range",
      "at max level."
    }),

    spell("EMP", W, W, W, {
      "Drains mana and deals damage.",
      "Combine it with a Tornado for a guaranteed hit",
      "(note that opponents still in the air from Tornado aren't affected anymore -",
      "they have to land first"
    }),

    spell("Alacrity", W, W, E, {
      "Physical DPS buff. Great for putting on carries and for taking down towers",
      "(it also makes summonssuch as Forge Spirits and Spirit bear extra good pushers).",
      "Damage increases with", E, "IAS increases with", W, "."
    }),

    spell("Meteor", W, E, E, {
      "An AoE nuke. You can conbine it with Deafening Blast to trap enemies in the",
      "damage AoE for longer."
    }),

    spell("Sunstrike", E, E, E, {
      "Global ground-targeted nuke that hits after a 1.6 second delay.",
      "Good for picking off fleeing heroes, particularly if you have a disable",
      "(such as Bane's Nightmare or Shadow Demon's Disruption)."
    }),

    spell("Forge Spirits", E, E, Q, {
      "Armor-reducing summons. Good for pushing and for targeting supports in fights.",
      "If you have at least 4 levels in", Q, "and 4 in", E, "then you get 2 spirits."
    }),

    spell("Ice Wall", E, Q, Q, {
      "Creates an icy wall perpendicular to the direction you are facing.",
      "Enemies going through the wall are severely slowed."
    }),

    spell("Deafening Blast", Q, W, E, {
      "A disabling nuke that disjoints (prevents attacks).",
      "This gets much stronger lategame (when all orbs get maxed), but the disable is useful",
      "the whole game."
    }),
  }
}

end

-----

Go{
  heroid='Visage',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, W}, Q, {MAX, E}, {MAX, Q}
  },

  ITEMBUILD{
    {I_STARTING,
      {2 , 'gauntlets'}, {2, 'branches'}, 'flask', 'tango' },
    {I_CORE,
      'ring_of_basilius', 'arcane_boots', 'mekansm', 'urn_of_shadows' },
    {I_LUXURY,
      'force_staff', 'vladmir', 'hood_of_defiance',
      'ghost', 'shivas_guard', 'sheepstick' },
  },

  HERODESC{
    {THIS, "loves hanging around in the middle of a teamfight,",
      "spamming", W, "for 300+ damage.",
      "He is one of the scariest trilane heroes,",
      "although he can also make do with fast familiars from solo-mid XP."},
  },

  TIPS{
    {Q, "also steals attack speed, so target the enemy carry during clashes."},

    {"Get the most use of your familiars:",
      "scout the runes, and use their stun."},

    {"Don't feed the familiars. They have a 100 gold bounty!"},
  },

}

-----

Go{
  heroid='Lesh',
  date={day=18, month=10, year=2012},

  SKILLBUILD{ name="Skills",
    Q, {MAX, W}, {MAX, Q}, {MAX, R}, {MAX, S}
  },

  ITEMBUILD{
    {I_STARTING,
      {3, 'branches'}, 'circlet', 'flask', 'tango' },
    {I_CORE,
      'magic_wand', {OPT, 'bracer', 'bracer', 'null_talisman'},
      'arcane_boots', 'bloodstone' },
    {I_LUXURY,
      'ancient_janggo', 'ultimate_scepter', 'black_king_bar',
      'travel_boots', 'shivas_guard', 'heart' },
    tips = { tip_ab_disassemble() }
  },

  HERODESC{
    {THIS, "is an AoE damage monster and an insane tower destroyer with", W, ".",
      "However, he desperately needs health, mana pool and mana regeneration from items in order to be fully effective."},
    {"In addition to the a carry role,", THIS, "can also play as more of a support:",
      Q, "is still a stun and you you don't need items to kill towers",
      "like you need to survive in teamfights."},
  },

  TIPS{
    {"The item and skill build is very flexible! (Check out the other tab for details)"},

    {"Level 4 of", W, "can take up to ~75% of a tower's HP!"}
  },

  TIPS{ name=T_BUILD_VARIATIONS,

    {"You probably won't have mana to support all your skills.",
      "Either skip a skill for", S, "or compensate by getting lots of stats",
      "(STR, INT, HP and MP) from items."},

    {"The", W, "+", Q, "+", S, "build has strong pushing power, and lets you get",
      "an early BKB without running out of mana."},

    {"The", Q, "+", E, "+", W, "build has better counter-pushing power",
      "and is also good for solo-pushing in pubs",
      "(where you don't always have someone to help clear the creep waves).",
      "You need more stats items to support the mana though."},
  },
}

-----

Go{
  heroid='WD',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, W, {MAX, E}, {MAX, W}
  },

  ITEMBUILD{
    {I_STARTING,
      {4, 'branches'}, {2, 'tango'}, {2, 'clarity'} },
    {I_CORE,
      'phase_boots', 'magic_wand', 'urn_of_shadows', 'point_booster' },
    {I_LUXURY,
      'medallion_of_courage', 'ultimate_scepter', 'black_king_bar',
      'force_staff', 'blink', 'sheepstick' },
  },

  HERODESC{
    {"There are two main styles of playing", THIS, ".",
    "In the defensive style, you use his cheap heal to protect his fellow laners",
    "and his long-range stun to aid in skirmishes from a safe distance.",
    "In the offensive style, you get levels in", E, "to greatly amplify",
    "the damage dealt to the targets of his ganks."},
  },

  TIPS{
    {"After casting", R, "the ward gets selected and you can choose targets for it.",
      "To cancel the spell early, reselect the doctor and tell him to move away."},

    {"Higher levels of", W, "greatly aid in pushing but have a very large mana cost."},

    {I'invis_sword', "can be used without breaking the", R, "chanelling.",
      "BKB is often a more reliable choice though."},
  },

}

-----

Go{
  heroid='AA',
  date={day=18, month=10, year=2012},

  SKILLBUILD{
    {MAX, Q}, {MAX, W}, {MAX, S}, {MAX, E}
  },

  ITEMBUILD{
    {I_STARTING,
      {ALT, 'courier', 'ward_observer'}, {3, 'branches'}, 'flask', 'tango', {3, 'clarity'}},
    {I_CORE,
      'boots', 'magic_wand', 'mekansm', 'force_staff', 'urn_of_shadows' },
    {I_LUXURY,
      'ancient_janggo', 'travel_boots', 'sheepstick', 'cyclone' },
  },

  HERODESC{
    {THIS, "'s strongest point is his ultimate.",
      "Not only is it a great counter to healing based strategies,",
      "its global range makes it great for ganking and counterpushing.",
      "He is also a reasonable solo mid hero with", Q, "."},
  },

  TIPS{
    {"You can use", W, "to scout fogged areas before entering them."},

    {R, "casting mechanics:",
      "You start by sending an invisible marker in the target direction.",
      "When the marker is where you want it to be, cast the skill again",
      "and the real projectile will travel, exploding in the marked spot.",
      "The actual projectile spreads the chill buff and the explosion also deals damage."},
  },

}

return Guides
