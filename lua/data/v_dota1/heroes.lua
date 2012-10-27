--[[
Hero data that is specific to Dota 1.
Basically hero and skill names.
]]

local dota_heroes = require'data/base/heroes'

local Heroes = {}

local function H(id, hero)
  assert( dota_heroes[id], "Unrecognized hero "..id, 2)
  
  hero.fullName = hero.name..' the '..hero.class
  if id ~= 'Invoker' then
    hero.S = "Attribute Bonus"
  end
  
  hero.nick = hero.nick or hero.class
  
  Heroes[id] = hero
end

--Sentinel Strength

H('Kunkka', {
  name = "Kunkka",
  class = "Admiral",
  Q = "Torrent",
  W = "Tidebringer",
  E = "X Marks the Spot",
  R = "Ghost Ship", })
H('Beast', {
  name = "Rexxar", class = "Beast Master",
  Q = "Wild Axes",
  W = "Call of the Wild",
  E = "Inner Beast",
  R = "Primal Roar", })
H('Cent', {
  name = "Bradwarden", class = "Centaur Warchief",
  Q = "Hoof Stomp",
  W = "Double Edge",
  E = "Return",
  R = "Stampede", })
H('ES', {
  name = "Raigor Stonehoof", class = "Earthshaker",
  Q = "Fissure",
  W = "Enchant Totem",
  E = "Aftershock",
  R = "Echo Slam", })
  
H('Omni', {
  name = "Purist Thunderwrath", class = "Omninight",
  Q = "Purification",
  W = "Repel",
  E = "Degen Aura",
  R = "Guardian Angel", })
H('Brew', {
  name = "Mangix", class = "Pandaren Brewmaster",
  Q = "Thunder Clap",
  W = "Drunken Haze",
  E = "Drunken Brawler",
  R = "Primal Split", })
H('Sven', {
  name = "Sven", class = "Rogue Knight",
  Q = "Storm Bolt",
  W = "Great Cleave",
  E = "Warcry",
  R = "God's Strength", })
H('Tiny', {
  name = "Tiny", class = "Stone Giant",
  Q = "Avalanche",
  W = "Toss",
  E = "Craggy Exterior",
  R = "Grow!", })

H('TC', {
  name = "Cairne Bloodhoof", class = "Tauren Chieftain",
  Q = "Echo Stomp",
  W = "Ancestral Spirit",
  E = "Natural Order",
  R = "Earth Splitter", })
H('Treant', {
  name = "Rooftrellen", class = "Treant Protector",
  Q = "Nature's Guise",
  W = "Leech Seed",
  E = "Living Armor",
  R = "Overgrowth", })
H('Wisp', {
  name = "Io ", class = "Guardian Wisp",
  Q = "Tether",
  W = "Spirits",
  E = "Overcharge",
  R = "Relocate", })
H('Alch', {
  name = "Razzil Darkbrew", class = "Alchemist",
  Q = "Acid Spray",
  W = "Unstable Concoction",
  E = "Goblin's Greed",
  R = "Chemical Rage", })

H('Clock', {
  name = "Rattletrap", class = "Clockwerk Goblin",
  Q = "Battery Assault",
  W = "Power Cogs",
  E = "Rocket Flare",
  R = "Hookshot", })
H('DK', {
  name = "Knight Davion", class = "Dragon Knight",
  Q = "Breathe Fire",
  W = "Dragon Tail",
  E = "Dragon Blood",
  R = "Elder Dragon Form", })
H('Huskar', {
  name = "Huskar", class = "Sacred Warrior",
  Q = "Inner Vitality",
  W = "Burning Spear",
  E = "Berserker's Blood",
  R = "Life Break", })
H('BB', {
  name = "Rigwarl", class = "Bristleback",
  Q = "Viscous Nasal Goo",
  W = "Quill Spray",
  E = "Bristleback",
  R = "Warpath", })

H('Phoenix', {
  name = "Icarus", class = "Phoenix",
  Q = "Icarus Dive",
  W = "Fire Spirits",
  E = "Sun Ray",
  R = "Supernova", })
H('Tuskarr', {
  name = "Ymir", class = "Tuskarr",
  Q = "Ice Shards",
  W = "Snowball",
  E = "Frozen Sigil",
  R = "Walrus Punch", })
H('Legion', {
  name = "Tresdin", class = "Legion Commander",
  Q = "Overwhelming Odds",
  W = "Press The Attack",
  E = "Moment Of Courage",
  R = "Duel", })
H('Shredder', {
  name = "Rizzrak", class = "Goblin Shredder",
  Q = "Whirling Death",
  W = "Timber Chain",
  E = "Reactive Armor",
  R = "Chakram", })

-- Scourge Strength

H('Axe', {
  name = "Mogul Kahn", class = "Axe",
  Q = "Berserker's Call",
  W = "Battle Hunger",
  E = "Counter Helix",
  R = "Culling Blade", })
H('CK', {
  name = "Nessaj", class = "Chaos Knight",
  Q = "Chaos Bolt",
  W = "Reality Rift",
  E = "Critical Strike",
  R = "Phantasm", })
H('Doom', {
  name = "Lucifer", class = "Doom Bringer",
  Q = "Devour",
  W = "Scorched Earth",
  E = "Lvl? Death",
  R = "Doom", })
H('Naix', {
  name = "N'aix", class = "Lifestealer",
  Q = "Rage",
  W = "Feast",
  E = "Open Wounds",
  R = "Infest", })

H('LoA', {
  name = "Abaddon", class = "Lord of Avernus",
  Q = "Death Coil",
  W = "Aphotic Shield",
  E = "Frostmourne",
  R = "Borrowed Time", })
H('Lycan', {
  name = "Banehallow", class = "Lycanthrope",
  Q = "Summon Wolves",
  W = "Howl",
  E = "Feral Impulse",
  R = "Shapeshift", })
H('NS', {
  name = "Balanar", class = "Night Stalker",
  Q = "Void",
  W = "Crippling Fear",
  E = "Hunter in the Night",
  R = "Darkness", })
H('Pit', {
  name = "Azgalor", class = "Pit Lord",
  Q = "Firestorm",
  W = "Pit of Malice",
  E = "Expulsion",
  R = "Dark Rift", })
  
H('Pudge', {
  name = "Pudge", class = "Butcher",
  Q = "Meat Hook",
  W = "Rot",
  E = "Flesh Heap",
  R = "Dismember", })
H('Leoric', {
  name = "King Leoric", class = "Skeleton King",
  Q = "Helllfire Blast",
  W = "Vampiric Aura",
  E = "Critical Strike",
  R = "Reincarnation", })
H('Slardar', {
  name = "Slardar", class = "Slithereen Guard",
  Q = "Sprint",
  W = "Slithereen Crush",
  E = "Bash",
  R = "Amplify Damage", })
H('Dirge', {
  name = "Dirge", class = "Undying",
  Q = "Decay",
  W = "Soul Rip",
  E = "Tombstone",
  R = "Flesh Golem", })

H('Tide', {
  name = "Leviathan", class = "Tidehunter",
  Q = "Gush",
  W = "Kraken Shell",
  E = "Anchor Smash",
  R = "Ravage", })
H('Magnus', {
  name = "Magnus", class = "Magnataur",
  Q = "Shockwave",
  W = "Empower",
  E = "Skewer",
  R = "Reverse Polarity", })
H('SB', {
  name = "Barathrum", class = "Spiritbreaker",
  Q = "Charge of Darkness",
  W = "Empowering Haste",
  E = "Greater Bash",
  R = "Nether Strike", })
H('SK', {
  name = "Crixalis", class = "Sand King",
  Q = "Burrowstrike",
  W = "Sand Storm",
  E = "Caustic Finale",
  R = "Epicenter", })

-- Sentinel Agility

H('AM', {
  name = "Magina", class = "Anti-Mage",
  Q = "Mana Break",
  W = "Blink",
  E = "Spell Shield",
  R = "Mana Void", })
H('Sniper', {
  name = "Kardel Sharpeye", class = "Dwarven Sniper",
  Q = "Shrapnel",
  W = "Headshot",
  E = "Take Aim",
  R = "Assassinate", })
H('Jugger', {
  name = "Yurnero", class = "Juggernaut",
  Q = "Blade Fury",
  W = "Healing Ward",
  E = "Blade Dance",
  R = "Omnislash", })
H('LD', {
  name = "Syllabear", class = "Lone Druid",
  Q = "Summon Spirit  Bear",
  W = "Rabid",
  E = "Synergy",
  R = "True Form", })

H('Luna', {
  name = "Luna Moonfang", class = "Moonrider",
  Q = "Lucent Beam",
  W = "Moon Glaive",
  E = "Lunar Blessing",
  R = "Eclipse", })
H('Morph', {
  name = "Morphling", class = "Morphling",
  Q = "Waveform",
  W = "Adaptive Strike",
  E = "Morph",
  R = "Replicate", })
H('Naga', {
  name = "Slithice", class = "Naga Siren",
  Q = "Mirror Image",
  W = "Ensnare",
  E = "Rip Tide",
  R = "Song of the Siren", })
H('PL', {
  name = "Azwraith", class = "Phantom Lancer",
  Q = "Spirit Lance",
  W = "Doppelwalk",
  E = "Juxtapose",
  R = "Phantom Edge", })

H('POTM', {
  name = "Mirana Nightshade", class = "Priestess of the Moon",
  Q = "Starfall",
  W = "Elune's Arrow",
  E = "Leap",
  R = "Moonlight Shadow", })
H('Riki', {
  name = "Rikimaru", class = "Stealth Assassin",
  Q = "Smoke Screen",
  W = "Blink Strike",
  E = "Backstab",
  R = "Permanent Invisibility", })
H('Troll', {
  name = "Jah'rakal", class = "Troll Warlord",
  Q = "Berserker Rage",
  W = "Whirling Axes",
  E = "Fervor",
  R = "Battle Trance", })
H('Gyro', {
  name = "Aurel Vlaicu", class = "Gyrocopter",
  Q = "Rocket Barrage",
  W = "Homing Missile",
  E = "Flak Cannon",
  R = "Call Down", })

H('Drow', {
  name = "Traxex", class = "Drow Ranger",
  Q = "Frost Arrows",
  W = "Silence",
  E = "Trueshot Aura",
  R = "Marksmanship", })
H('TA', {
  name = "Lanaya", class = "Templar Assassin",
  Q = "Refraction",
  W = "Meld",
  E = "Psi Blades",
  R = "Psionic Trap", })
H('Ursa', {
  name = "Ulfsaar", class = "Ursa Warrior",
  Q = "Earthshock",
  W = "Overpower",
  E = "Fury Swipes",
  R = "Enrage", })
H('VS', {
  name = "Shendelzare Silkwood", class = "Vengeful Spirit",
  Q = "Magic Missile",
  W = "Wave of Terror",
  E = "Command Aura",
  R = "Nether Swap", })

H('BH', {
  name = "Gondar", class = "Bounty Hunter",
  Q = "Shuriken Toss",
  W = "Jinada",
  E = "Wind Walk",
  R = "Track", })
H('Xin', {
  name = "Xin", class = "Ember Spirit",
  Q = "Searing Chains",
  W = "Sleight of Fist",
  E = "Flame Guard",
  R = "Fire Remnant", })

-- Scourge Agility

H('BS', {
  name = "Strygwyr", class = "Bloodseeker",
  Q = "Bloodrage",
  W = "Blood Bath",
  E = "Strygwyr's Thirst",
  R = "Rupture", })

H('Clinkz', {
  name = "Clinkz",
  class = "Bone Fletcher",
  Q = "Strafe",
  W = "Searing Arrows",
  E = "Wind Walk",
  R = "Death Pact",
})
H('Brood', {
  name = "Black Arachnia", class = "Broodmother",
  Q = "Spawn Spiderlings",
  W = "Spin Web",
  E = "Incapacitating Bite",
  R = "Insatiable Hunger", })
H('NA', {
  name = "Anub'arak", class = "Nerubian Assassin",
  Q = "Impale",
  W = "Mana Burn",
  E = "Spiked Carapace",
  R = "Vendetta", })

H('Weaver', {
  name = "Anub'Seran", class = "Nerubian Weaver",
  Q = "The Swarm",
  W = "Shukuchi",
  E = "Geminate Attack",
  R = "Time Lapse", })
H('PA', {
  name = "Mortred", class = "Phantom Assassin",
  Q = "Stifling Dagger",
  W = "Phantom Strike",
  E = "Blur",
  R = "Coup de Grace", })
H('SF', {
  name = "Nevermore", class = "Shadow Fiend",
  Q = "Shadowraze",
  W = "Necromastery",
  E = "Presence of the Dark Lord",
  R = "Requiem of Souls", })
H('TB', {
  name = "Terrorblade", class = "Soul Keeper",
  Q = "Reflection",
  W = "Zeal",
  E = "Metamorphosis",
  R = "Sunder", })

H('Spectre', {
  name = "Mercurial", class = "Spectre",
  Q = "Spectral Dagger",
  W = "Desolate",
  E = "Dispersion",
  R = "Haunt", })
H('Veno', {
  name = "Lesale Deathbringer", class = "Venomancer",
  Q = "Venomous Gale",
  W = "Poison Sting",
  E = "Plague Ward",
  R = "Poison Nova", })
H('Viper', {
  name = "Viper", class = "Netherdrake",
  Q = "Poison Attack",
  W = "Nethertoxin",
  E = "Corrosive Skin",
  R = "Viper Strike", })
H('Meepo', {
  name = "Meepo", class = "Geomancer",
  Q = "Earthbind",
  W = "Poof",
  E = "Geostrike",
  R = "Divided we Stand", })

H('Razor', {
  name = "Razor", class = "Lightning Revenant",
  Q = "Plasma Field",
  W = "Static Link",
  E = "Unstable Current",
  R = "Eye of the Storm", })
H('Slark', {
  name = "Slark", class = "Murloc Nightcrawler",
  Q = "Dark Pact",
  W = "Pounce",
  E = "Essence Shift",
  R = "Shadow Dance", })
H('Void', {
  name = "Darkterror", class = "Faceless Void",
  Q = "Time Walk",
  W = "Backtrack",
  E = "Time Lock",
  R = "Chonosphere", })
H('Medusa', {
  name = "Medusa", class = "Gorgon",
  Q = "Split Shot",
  W = "Mystic Snake",
  E = "Mana Shield",
  R = "Stone Gaze", })
  
H('Zet', {
  name = "Zet", class = "Arc Warden",
  Q = "Flux",
  W = "Magnetic Field",
  E = "Spark Wraith",
  R = "Tempest Double", })

-- Sentinel Intelligence

H('CM', {
  name = "Rylai Crestfall", class = "Crystal Maiden",
  Q = "Crystal Nova",
  W = "Frostbite",
  E = "Brilliance Aura",
  R = "Freezing Field", })
H('Ench', {
  name = "Aiushtha", class = "Enchantress",
  Q = "Untouchable",
  W = "Enchant",
  E = "Nature's Attendants",
  R = "Impetus", })
H('Puck', {
  name = "Puck", class = "Faerie Dragon",
  Q = "Illusory Orb",
  W = "Waning Rift",
  E = "Phase Shift",
  R = "Dream Coil", })
H('Chen', {
  name = "Chen", class = "Holy Knight",
  Q = "Penitence",
  W = "Test of Faith",
  E = "Holy Persuasion",
  R = "Hand of God", })

H('KOTL', {
  name = "Ezalor", class = "Keeper of the Light",
  Q = "Illuminate",
  W = "Mana Leak",
  E = "Chakra Magic",
  R = "Spirit Form", })
H('Zeus', {
  name = "Zeus", class = "Lord of Olympia",
  Q = "Arc Lightning",
  W = "Lightning Bolt",
  E = "Static Field",
  R = "Thundergod's Wrath", })
H('Prophet', {
  name = "Furion", class = "Prophet",
  Q = "Sprout",
  W = "Teleportation",
  E = "Force of Nature",
  R = "Wrath of Nature", })
H('Silencer', {
  name = "Nortrom", class = "Silencer",
  Q = "Curse of the Silent",
  W = "Glaives of Wisdom",
  E = "Last Word",
  R = "Global Silence", })

H('Lina', {
  name = "Lina Inverse", class = "Slayer",
  Q = "Dragon Slave",
  W = "Light Strike Array",
  E = "Fiery Soul",
  R = "Laguna Blade", })
H('Storm', {
  name = "Raijin Thunderkeg", class = "Storm Spirit",
  Q = "Static Remnant",
  W = "Eletric Vortex",
  E = "Overload",
  R = "Ball Lightning", })
H('WR', {
  name = "Alleria", class = "Windrunner",
  Q = "Shackleshot",
  W = "Powershot",
  E = "Windrunner",
  R = "Focus Fire", })
H('Disruptor', {
  name = "Thrall", class = "Disruptor",
  Q = "Thunder Strike",
  W = "Glimpse",
  E = "Kinetic Field",
  R = "Static Storm", })

H('Ogre', {
  name = "Aggron Stonebreaker", class = "Ogre Magi",
  Q = "Fireblast",
  W = "Ignite",
  E = "Bloodlust",
  R = "Multi Cast", })
H('Techies', {
  name = "Squee, Spleen and Spoon", class = "Goblin Techies",
  Q = "Land Mines",
  W = "Stasis Trap",
  E = "Suicide Squad, Attack!",
  R = "Remote Mines", })
H('Jakiro', {
  name = "Jakiro", class = "Twin Head Dragon",
  Q = "Dual Breath",
  W = "Ice Path",
  E = "Liquid Fire",
  R = "Macropyre", })
H('Tinker', {
  name = "Boush", class = "Tinker",
  Q = "Laser",
  W = "Heat Seeking Missile",
  E = "March of the Machines",
  R = "Rearm", })

H('Rhasta', {
  name = "Rhasta", class = "Shadow Shaman",
  Q = "Ether Shock",
  W = "Voodoo",
  E = "Shackles",
  R = "Mass Serpent Wards", })
H('Rubick', {
  name = "Rubick", class = "Grand Magus",
  Q = "Telekinesis",
  W = "Fade Bolt",
  E = "Null Field",
  R = "Spell Steal", })
H('SM', {
  name = "Dragonus", class = "Skywrath Mage",
  Q = "Arcane Bolt",
  W = "Concusive Shot",
  E = "Ancient Seal",
  R = "Mystic Flare", })

-- Scourge Intelligence

H('Bane', {
  name = "Atropos", class = "Bane Elemental",
  Q = "Enfeeble",
  W = "Brain Sap",
  E = "Nightmare",
  R = "Fiend's Grip", })
H('DS', {
  name = "Ish'Kafel", class = "Dark Seer",
  Q = "Vacuum",
  W = "Ion Shell",
  E = "Surge",
  R = "Wall of Replica", })
H('Krob', {
  name = "Krobelus", class = "Death Prophet",
  Q = "Carrion Swarm",
  W = "Silence",
  E = "Witchcraft",
  R = "Exorcism", })
H('Lion', {
  name = "Lion", class = "Demon Witch",
  Q = "Impale",
  W = "Voodoo",
  E = "Mana Drain",
  R = "Finger of Death", })

H('Enigma', {
  name = "Darchrow", class = "Enigma",
  Q = "Malefice",
  W = "Demonic Conversion",
  E = "Midnight Pulse",
  R = "Black Hole", })
H('Lich', {
  name = "Kel'Thuzad", class = "Lich",
  Q = "Frost Nova",
  W = "Frost Armor",
  E = "Dark Ritual",
  R = "Chain Frost", })
H('Necro', {
  name = "Rotund'jere", class = "Necrolyte",
  Q = "Death Pulse",
  W = "Heartstopper Aura",
  E = "Sadist",
  R = "Reaper's Scythe", })
H('Pugna', {
  name = "Pugna", class = "Oblivion",
  Q = "Nether Blast",
  W = "Decrepify",
  E = "Nether Ward",
  R = "Life Drain", })

H('OD', {
  name = "Harbinger", class = "Obsidian Destroyer",
  Q = "Arcane Orb",
  W = "Astral Imprisonment",
  E = "Essence Aura",
  R = "Sanity's Eclipse", })
H('QoP', {
  name = "Akasha", class = "Queen of Pain",
  Q = "Shadow Strike",
  W = "Blink",
  E = "Scream of Pain",
  R = "Sonic Wave", })
H('Warlock', {
  name = "Demnok Lannik", class = "Warlock",
  Q = "Fatal Bonds",
  W = "Shadow Word",
  E = "Upheaval",
  R = "Rain of Chaos", })
H('SD', {
  name = "Eredar", class = "Shadow Demon",
  Q = "Disruption",
  W = "Soul Catcher",
  E = "Shadow Poison",
  R = "Demonic Purge", })

H('Bat', {
  name = "Jin'zakk", class = "Batrider",
  Q = "Sticky Napalm",
  W = "Flame Break",
  E = "Firefly",
  R = "Flaming Lasso", })
H('Dazzle', {
  name = "Dazzle", class = "Shadow Priest",
  Q = "Poison Touch",
  W = "Shallow Grave",
  E = "Shadow Wave",
  R = "Weave", })
H('Invoker', {
  name = "Kael", class = "Invoker",
  Q = "Quas",
  W = "Wex",
  E = "Exort",
  R = "Invoke", })
H('Visage', {
  name = "Visage", class = "Necro'lic",
  Q = "Grave Chill",
  W = "Soul Assumption",
  E = "Gravekeeper's Cloak",
  R = "Summon Familiars", })

H('Lesh', {
  name = "Leshrac the Malicious", class = "Tormented Soul",
  Q = "Split Earth",
  W = "Diabolic Edict",
  E = "Lightning Storm",
  R = "Pulse Nova", })
H('WD', {
  name = "Vol'jin", class = "Witch Doctor",
  Q = "Paralyzing Cask",
  W = "Voodoo Restoration",
  E = "Maledict",
  R = "Death Ward", })
H('AA', {
  name = "Kaldr", class = "Ancient Apparition",
  Q = "Cold Feet",
  W = "Ice Vortex",
  E = "Chilling Touch",
  R = "Ice Blast", })
H('Auroth', {
  name = "Auroth", class = 'Winter Wyvern',
  Q = "Artic Burn",
  W = "Splinter Blast",
  E = "Cold Embrace",
  R = "Winter's Curse", })

return Heroes
