local setupGuide = require "setup"

local PAGE_TITLE  = "Dota 2 Alt-Tab Guides"
local GUIDE_TITLE = "The Pretty Alt-Tab Guide to Every Dota2 Hero"
local GUIDE_TAVERNS = setupGuide(2, {
  info = 'i_dota2wiki',
  assets = 'a_dota2alttab',
  taverns = {
    { 'SentinelStr', 'SentinelAgi', 'SentinelInt' },
    { 'ScourgeStr' , 'ScourgeAgi' , 'ScourgeInt'  },
  },
})

local Output = require 'output/dotaalttab'
local Markup = require 'markup/html'


-- NOTE: Version numbers should be increassed whenever we update the sprites,
--       in order to avoid users getting wrong images due to caching.

local RESULT_DIR = '../results/dota2alttab'

local FILENAME_HTML = 'index.html'
local FILENAME_CSS  = 'guide.css'
local FILENAME_JS   = 'guide.js'
local FILENAME_DATA = 'data.js'

local VERSION_CSS    = 7
local VERSION_JS     = 2
local VERSION_DATA   = 3
local VERSION_SPRITE = 6

local INCLUDE_CSS  = FILENAME_CSS  .. "?v=" .. VERSION_CSS
local INCLUDE_JS   = FILENAME_JS   .. "?v=" .. VERSION_JS
local INCLUDE_DATA = FILENAME_DATA .. "?v=" .. VERSION_DATA

local FILE_HERO_BIG_SPRITE   = "./Dota2_Alt_Tab/Images/Sprites/heroes_big.jpg?v="..VERSION_SPRITE
local FILE_HERO_SMALL_SPRITE = "./Dota2_Alt_Tab/Images/Sprites/heroes_small.jpg?v="..VERSION_SPRITE
local FILE_ITEM_SPRITE       = "./Dota2_Alt_Tab/Images/Sprites/items_small.jpg?v="..VERSION_SPRITE
local FILE_SYMBOL_SPRITE     = "./Dota2_Alt_Tab/Images/Sprites/symbols.png?v="..VERSION_SPRITE
local FILE_TAVERN_SPRITE     = "./Dota2_Alt_Tab/Images/Sprites/taverns.png?v="..VERSION_SPRITE

local DEFAULT_HERO_IMG = '../defaults/heroes.png'
local DEFAULT_ITEM_IMG = '../defaults/items.png'

local FILE_HERO_SPRITE_IDS   = '../images/0_ids/heroes.txt'
local FILE_ITEM_SPRITE_IDS   = '../images/0_ids/items.txt'
local FILE_SYMBOL_SPRITE_IDS = '../images/0_ids/symbols.txt'
local FILE_TAVERN_SPRITE_IDS = '../images/0_ids/taverns.txt'

local SYMBOL_IMG_DIMENSIONS     = {              height = 32 }
local TAVERN_IMG_DIMENSIONS     = { width =  24, height = 24 }
local HERO_SMALL_IMG_DIMENSIONS = { width =  64, height = 36 }
local HERO_BIG_IMG_DIMENSIONS   = { width = 127, height = 71 }
local ITEM_IMG_DIMENSIONS       = { width =  51, height = 38 }

local SYMBOL_SPRITE_IDS = {
  { id = 'Arrow'   , width = 38 },
  { id = 'Slash'   , width = 10 },
  { id = 'LBracket', width =  7 },
  { id = 'RBracket', width =  7 },
}

local TAVERN_SPRITE_IDS = {
  { id = 'stat_agi' },
  { id = 'stat_int' },
  { id = 'stat_str' },
  { id = 'team_scourge' },
  { id = 'team_sentinel' },
}

local FULL_TAVERN_WIDTH = '900px'

local GUIDE_HOW_TO_USE = [=[
<p>Choose your guide using the search bar or by clicking on the hero taverns. You can use arrow keys to navigate and enter to select the options given by the search bar.</p>
<p>To pick another hero use the "Go to top" link or use the back button of your browser.</p>
<p><strong>For faster access to the guides from within the game, we recommend using the Steam web browser</strong>. It is available from inside Dota2 via the Shift-Tab shortcut and avoids the usual delay from alt-tabbing.</p>
<p>You can replace the ingame recommended items lists with ours. <a href="http://www.dota2alttab.com/itembuilds.zip">Click here</a> to download the files.</p>
<p>The skill and item builds in this guide are typically "standard" or "dependable" builds, since we have little time to explain things and since we err on the side of making builds that can also help beginning and intermediate players. Do not assume that these builds are the only way to play the heroes and <strong>always adapt them to your game</strong>!</p>
<p>I particular, feel free to pick up some extra early game items, such as TP scrolls or bracers, even if they aren't explicitly listed in the guides.</p>
<p>Skills are color coded:</p>
<ul>
<li><span class="Q">The first skill is green.</span></li>
<li><span class="W">The second skill is tan.</span></li>
<li><span class="E">The third skill is blue.</span></li>
<li><span class="R">The ultimate is red.</span></li>
<li><span class="S">Attribute Bonus is yellow.</span></li>
</ul>
<p>The following symbols are used in these guides:
<table>
  <tr>
  	<th style="width:30px">]=]..Markup.sprite('symbol', 'Slash')..[=[</th>
  	<td>Pick either item to the immediate left or right of a slash, but typically don't get both.</td>
  </tr>
  <tr>
  	<th>]=]..Markup.sprite('symbol', 'Arrow')..[=[</th>
  	<td>Prioritize items to the left of an arrow before getting the items on the right.</td>
  </tr>
  <tr>
  	<th>]=]..Markup.sprite('symbol', 'LBracket')..Markup.sprite('symbol', 'RBracket')..[=[</th>
  	<td>Items in brackets are situational and are up to player judgement. For example, only buy a bottle if you are mid or no one else has one.</td>
  </tr>
</table>
]=]

local GUIDE_NOTES = [=[
<p>Last updated: January 14, 2013. Updated skill and item builds for all heroes.</p>
<p>Suggestions, typos, bugs? Contact me at deathcalibur@dota2alttab.com</p>
<p>Submitting a guide? Send to guides@dota2alttab.com</p>
]=]

local GUIDE_CREDITS = [=[
<p>Special thanks to Val for writing and organizing the community for the first versions of this guide on Playdota, and Lycan, for creating the first version of the new guide layout as well as providing lots of feedback.
<p>The current version is being maintained by Ninguem and DeathCalibur. We wish to thank he following people for helping us write the guides:
<p>Decency, deathpie, Gregarious, Valiant Penguin
<p>Ninguem would also want to thank the following people:
<p>grimlock123 and Homer00, for hosting the weekly hero discussions in the dota2 subreddit. They have been a great source of info on the current metagame and have served the same purpose as the treads Val used to run on Playdota back in the day.
<p>Shred_kid, for writing so many insightful posts in those said discussion treads and
<p>Adm_Chookington, albaek, Blitzmael, capgrass, corporate_g, KnightingGale, orgodemir, Stop_Sign for also giving valuable tips on some heroes.
<p>fireblaze762, No_Worries and Bude for giving valuable feedback on the guide itself
<p>Throught the long history of this guide, many people have also given valuable feedback in suggestion. In alphabetical order:
<p>3955elits, -3d, 817, Ab0rti0N, alick12345, Ali Radicali, Althorin, Amiag, Anaroth, Antifate, Apparentlynew, ArcheKleine, AzureD,
B4Nick, BabuinulVerde, Baconnaise, banjkan3, begy, Bengal_Tigger, billly, blaow, bountyface, Cenerae, Cerealmaniac, CooLah, Cosmic,
CounterGambit, Cross-Hair, DarkArcana, darkmega, DarK_MischieF, de_end, dondy, Doppelnull, DrDragun, Entlee, ^Eternity^, EternityPala,
ETurn, feral_nature, fevgatos, fgivme, FightF4te, fodminah, FUSE, Gheizen64, GoD_Tyr, green.bear, HappyCat, iKrivetko, Isa, iser, JaCKaSS_69,
Jay.J, JimRaynor55, JukeboxDragon, Karst, kawumm, Killer Draco, kitsune1255, Kris, Leadblast, leathality, leomon235, Logo, Lycan, Manta, Mercy,
MonsterFEED, Monsterlord, Motas, mrmemories, MurazorOFAngmar, Nae ireun, Nights16, nix, Pepsi-Plunge, Phantom_IV, pipser, pnoize, PNutz, progenitus, rayMi,
reh, Senkon, Shadow-Seeker, SirDumpling, sLiff, Sohl, Solistus, Sonicspear, Steric, -]stOka[-, SuperSheep, Swiftkick, Syaska, teStud0,
The Oreo, The Other Guy, TheTrickster2, (TK)WhiteWolf, Val, Vienna, Vindicate, Visnger, Vlricus, Vot1_Bear, WGDB|SCC, wutwat, XJDevil, Zesty_Pancakes,
Zieth, Ziodex
</p>
]=]

local GA_CODE = [=[
  <script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-34781660-1']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
  </script>
]=]

-- HTML --

withOutput(RESULT_DIR .. "/" .. FILENAME_HTML, 'w', function()

io.write([=[
<!doctype html>
<!-- This is a computer generated file. Do not edit it by hand! -->
<html>
<head>
  <meta name="description" content="Dota 2 Alt-Tab is a simple site with quick and easy guides to every hero in Dota 2.  Great for players to learn the standard skill and item builds.">
  <meta name="keywords" content="dota2, dota 2, guides, guide, alt-tab, alttab, builds, skills, items, dota, playdota, hero, heroes, defense, ancients">
  <meta name="author" content="Brendan Mulcahy">
  <meta charset="utf-8">
  <title>]=]..PAGE_TITLE..[=[</title>
  <link rel="shortcut icon" href="/favicon.ico" >
  <link rel="stylesheet" href="]=]..INCLUDE_CSS..[=[" >
]=]..GA_CODE..[=[
</head>
<body>
]=])

io.write([[
<h1 class="title"><a href="./#"><img src="./Dota2_Alt_Tab/Images/banner.png"></a></h1>
<script>
  document.write(
    '<div id="autocomplete" class="autocomplete">' +
      '<table class="autocomplete-input">' +
        '<tr>' +
          '<td class="label"><label for="hero_search">Find your hero:</label></td>' +
          '<td><input type="text" id="hero_search"></td>' +
        '</tr>' +
      '</table>' +
    '</div>'
  );
</script>
]])

Output.print_taverns(GUIDE_TAVERNS)

io.write([=[
<div class="section">
<h1>How to Use</h1>
]=]..GUIDE_HOW_TO_USE..[=[
<h1>Notes</h1>
]=]..GUIDE_NOTES..[=[
<h1>Acknowledgements</h1>
<button id="toggleAcks" data-alt="Hide acknowledgements">Show acknowledgements</button>
<div id="acks" class="hidden">]=]..GUIDE_CREDITS..[=[</div>
<h1>Hero Guides</h1>
]=])

local n=0
for _, _, tavern in itmatrix(GUIDE_TAVERNS) do
  for _, _, h in itmatrix(tavern) do
    if(Guides[h]) then
      print(Guides[h].heroid); n = n + 1
      Output.print_hero_guide( Guides[h] )
    end
  end
end
print("Wrote "..n.." guides.")

io.write([=[
</div>
<p class="copyright">
&copy; Brendan Mulcahy 2012-2013. Dota 2 content and materials are trademarks and copyrights of Valve or its licensors.
This site is not affiliated with Valve.
</p>
<script src="]=]..INCLUDE_DATA..[=["></script>
<script src="]=]..INCLUDE_JS..[=["></script>
</body>
</html>]=])

end)

-----------------------------

withOutput(RESULT_DIR .. "/" .. FILENAME_CSS, 'w', function()

--[==[
RGB codes and saturation values for the colors we used,
in case we need to tweak something.

background
080b0d 5
0d1114 8
11151a 10
192026 15
1f2b33 20
273640 25
2f414c 30
374c59 35
3f5666 40
7eaccc 80

text
b4ccb6 80
cbe6cd 90
d6f2d8 95
e1ffe3 100

str taverns
411602 25
812b05 50
a83806 66

agi taverns
2b4003 25
567e07 50
598307 51

int taverns
0c1c40 25
193780 50
2149a8 66
2b60de 87
--]==]

local main_bgcolor   = [[#080b0d]]
local lighter_bgcolor = [[#11151a]]

local main_fontcolor   = [[#b4ccb6]]
local header_fontcolor = [[#edffd9]]

local guide_border_color = [[#1f2b33]]

local tab_active_bgcolor = guide_border_color
local tab_inactive_bgcolor_hover = [[#374c59]]
local tab_inactive_bgcolor       = [[#11151a]]

local q_color = [[#9acd32]] -- Yellow Green
local w_color = [[#f4a460]] -- Sandy Brown
local e_color = [[#4169e1]] -- Royal Blue
local r_color = [[#ff0000]] -- Red
local s_color = [[#ffff00]] -- Yellow

local str_color_light = [[#812b05]]
local str_color_dark  = [[#411602]]

local agi_color_light = [[#567e07]]
local agi_color_dark  = [[#2b4003]]

local int_color_light = [[#193780]]
local int_color_dark  = [[#0c1c40]]

local img_hover_border_width = 2
local img_hover_border_color = [[#7eaccc]]

local function v_gradient(bc, ec)
  return [[
  background-color: ]]..ec..[[;
  background-image: -moz-linear-gradient(right,]]..bc..[[,]]..ec..[[);
  background-image: -ms-linear-gradient(right,]]..bc..[[,]]..ec..[[);
  background-image: -o-linear-gradient(right,]]..bc..[[,]]..ec..[[);
  background-image: -webkit-gradient(linear, right top, left top, from(]]..bc..[[), to(]]..ec..[[));
  /*TODO: add unprefixed gradients too*/
]]
end

io.write([[
/* This is a computer generated file. Do not edit it by hand! */

/* General body */

body {
  background-color: ]]..main_bgcolor..[[;
  color: ]]..main_fontcolor..[[;
  font-family: "Arial";
}

h1, h2 {
  color: ]]..header_fontcolor..[[;
}

a:link, a:visited, a:hover, a:active {
  color: inherit;
}

.hidden { display: none }

.title {
  text-align: center;
}

.section {
  margin: 0 auto;
  min-width: 20em;
  max-width: 45em;
}

.section h1 {
  margin-left: 1em;
}

.copyright {
  margin-top: 20em;
  font-size: smaller;
  color:silver;
}

/* Tavern selector */

.taverns{
  max-width: ]]..FULL_TAVERN_WIDTH..[[;
}

.tavern {
  display: inline-block;
  margin: 0 5px;
}

.tavern .s_tavern{
  vertical-align: middle;
  margin: 0 0.5em;
}

.tavern table {
  margin: 0 auto;
}

.tavern td {
  border-spacing: 0
}

.tavern a{
  display: block;
  height: ]]..HERO_SMALL_IMG_DIMENSIONS.height..[[px;
}

.tavern a, .s_item {
  border-collapse: collapse;
  border: ]]..img_hover_border_width..[[px solid ]]..main_bgcolor..[[;
  cursor: pointer;
}


.tavern a:hover /*,.s_item:hover*/ {
  border: ]]..img_hover_border_width..[[px solid ]]..img_hover_border_color..[[;
  opacity: 0.8;
}

.tavern h3{
  color: white;
  text-align: center;
}

.tavern h3.str {
]]..v_gradient(str_color_light, str_color_dark)..[[
}

.tavern h3.agi {
]]..v_gradient(agi_color_light, agi_color_dark)..[[
}

.tavern h3.int {
]]..v_gradient(int_color_light, int_color_dark)..[[
}


.Q { color: ]]..q_color..[[; }
.W { color: ]]..w_color..[[; }
.E { color: ]]..e_color..[[; }
.R { color: ]]..r_color..[[; }
.S { color: ]]..s_color..[[; }

/* Guide titles */

.guide{
  border-width: 4px 0px 0px;
  border-style: solid;
  border-color: ]]..guide_border_color..[[;
  margin: 2em 0
}

.guideHeader {
  margin: 1em 1.5em;
  overflow: auto;
}

.guideHeader .s_herobig {
  float: left;
  margin-right: 1em;
}

.guideHeader h2 {
  float: left;
}

.guideHeader .nav {
  float: right;
}

.guideHeader .nav a {
  display: block;
}

/* Guide bodies */

.guideBody {
  margin: 1em;
}

.guideBody h3 {
  margin-left: 1em;
}

.skillBuild {
  width: 100%;
}

.tn {
  text-align: right;
}

.itemBuild {
  text-align: left;
}

.itemBuild .s_item,
.itemBuild .s_symbol
{
  margin-left: 2px;
  margin-right: 2px;
}

.tip {
  margin-top: 1em;
  margin-bottom: 1em;
}

/* Tabs */

.tabs {
  margin: 0.5em 0;
}

.tab {
  display: inline-block;
  margin-right: 5px;
  border-radius: 10px 10px 0px 0px;
  padding: 0px 7px;

  cursor: pointer;
  background-color: ]]..tab_inactive_bgcolor..[[;
}

.tab:hover {
  background-color: ]]..tab_inactive_bgcolor_hover..[[;
}

.tab h3 {
  margin: 0px;
}

.tab.inactive {

}

.tab.active {
  background-color: ]]..tab_active_bgcolor..[[;
}

.pane {
  padding: 2px;
  background-color: ]]..tab_active_bgcolor..[[;
}

.paneContents {
  padding: 0.5em;
  background-color: ]]..main_bgcolor..[[;
}

/*Autocomplete*/

.autocomplete,
.autocomplete .autocomplete-results {width: 540px;}

.autocomplete {
  font-size: larger;
  margin: 0 auto;
}

.autocomplete input {
  background-color: ]]..lighter_bgcolor..[[;
  color: ]]..header_fontcolor..[[;
}

.autocomplete .autocomplete-input {width: 100%;}
.autocomplete .autocomplete-input td.label {width: 7em;}
.autocomplete .autocomplete-input input    {
  width: 100%;
  font-size: larger;
  padding: 0 5px;
}

.autocomplete .autocomplete-results {
  position: absolute;
  background-color: #11151a;
  border-collapse: collapse;
}
.autocomplete .autocomplete-results .image_column { width: 1px; }
.autocomplete .autocomplete-results .pattern    { text-decoration : underline; }
.autocomplete .autocomplete-results tr.selected { background-color: #458B74; }
.autocomplete .autocomplete-results tr:hover    { background-color: #58b193; }


.autocomplete .autocomplete-results .navigation {
  float:right;
  margin-right: 1em;
  font-size: small;

  visibility: hidden;
}

.autocomplete .autocomplete-results tr.selected .navigation,
.autocomplete .autocomplete-results tr:hover .navigation{
  visibility: visible;
}

.autocomplete .not-found{
  background-color: #7e5400;
  height: 36px;
  text-align: center
}

/* CSS sprites */

]])

local function make_sprite(spriteType, direction, dimensions,
    image,
    idsfilename, default_id,
    sprites
)

  withOutput(idsfilename, 'w', function()
    if default_id then
      io.write(default_id, '\n')
    end
    for _, s in ipairs(sprites) do
      io.write(s.id, '.png\n')
    end
  end)

  local rules = {}
  table.insert(rules, {'background-image', 'url('..image..')'})
  table.insert(rules, {'background-repeat', 'no-repeat'})
  table.insert(rules, {'display', 'inline-block'})
  for _, dim in ipairs{'width', 'height'} do
    if dimensions[dim] then
      table.insert(rules, {dim, dimensions[dim]..'px'})
    end
  end

  fwrite('.s_%s {\n', spriteType)
  for _, rule in ipairs(rules) do
    fwrite('\t%s: %s;\n', rule[1], rule[2])
  end
  fwrite('}\n')

  local delta = 0

  if default_id then
    if direction == 'V' then
      delta = delta - dimensions.height
    elseif direction == 'H' then
      delta = delta - dimensions.width
    end
  end

  for _, s in ipairs(sprites) do
    fwrite('.s_%s.si_%s {', spriteType, s.id)
    if s.width  then fwrite(' width: %dpx;', s.width) end
    if s.height then fwrite(' height: %dpx;', s.height) end

    if direction == 'V' then
      fwrite( ' background-position: 0 %dpx;', delta )
      delta = delta - (s.height or dimensions.height)
    elseif direction == 'H' then
      fwrite( ' background-position: %dpx 0;', delta )
      delta = delta - (s.width or dimensions.width)
    end

    fwrite('}\n')
  end

  fwrite('\n')

end

local function sprite_ids_from_datatable(datatable, filter_dota2)
  local ids = {}

  for id, data in pairs(datatable) do
    if (not filter_dota2) or data.valveNick then
      table.insert(ids, {id = id })
    end
  end

  local function k(x) return string.upper(x.id) end
  table.sort(ids, function(x1, x2) return k(x1) < k(x2) end)

  return ids
end

make_sprite('symbol', 'H',  SYMBOL_IMG_DIMENSIONS,
  FILE_SYMBOL_SPRITE,
  FILE_SYMBOL_SPRITE_IDS,
  nil,
  SYMBOL_SPRITE_IDS
)

make_sprite('tavern', 'V',  TAVERN_IMG_DIMENSIONS,
  FILE_TAVERN_SPRITE,
  FILE_TAVERN_SPRITE_IDS, nil,
  TAVERN_SPRITE_IDS
)


local hero_ids = sprite_ids_from_datatable(Heroes, true)
local item_ids = sprite_ids_from_datatable(Items, false)

make_sprite('hero', 'V', HERO_SMALL_IMG_DIMENSIONS,
  FILE_HERO_SMALL_SPRITE,
  FILE_HERO_SPRITE_IDS, DEFAULT_HERO_IMG,
  hero_ids,
  { }
)

make_sprite('herobig', 'V', HERO_BIG_IMG_DIMENSIONS,
  FILE_HERO_BIG_SPRITE,
  FILE_HERO_SPRITE_IDS, DEFAULT_HERO_IMG,
  hero_ids,
  { }
)

make_sprite('item', 'V', ITEM_IMG_DIMENSIONS,
  FILE_ITEM_SPRITE,
  FILE_ITEM_SPRITE_IDS, DEFAULT_ITEM_IMG,
  item_ids,
  { }
)

end)

--Static JS file
os.execute('cp ' .. './pages/dotaalttab.js ' .. RESULT_DIR .. "/" .. FILENAME_JS)

--Hero abreviations

withOutput(RESULT_DIR .. "/" .. FILENAME_DATA, 'w', function()

local abbreviations = {
  {'AA', 'AA'},
  {'AM', 'AM'},
  {'AP', 'Kunkka', 'Admiral Proudmoore'},
  {'AW', 'Zet'},

  {'BB', 'BB'},
  {'BH', 'BH'},

  {'BM', 'Brood'},
  {'BM', 'Beast'},
  {'BM', 'Brew'},

  {'BS', 'BS'},

  {'CK', 'CK'},
  {'CM', 'CM'},

  {'CW', 'Clock'},
  {'CW', 'Cent'},

  {'DB', 'Doom'},
  {'DR', 'Drow'},

  {'ES', 'ES'},
  {'ES', 'Xin'},

  {'DS', 'DS'},
  {'DS', 'Sniper'},

  {'DK', 'DK'},

  {'FV', 'Void'},
  {'FD', 'Puck'},

  {'GS', 'Shredder'},
  {'GW', 'Wisp'},

  {'HK', 'Chen'},

  {'KOTL', 'KOTL'},

  {'LC', 'Legion'},
  {'LD', 'LD'},
  {'LR', 'Razor'},
  {'LS', 'Naix'},

  {'NA', 'NA'},
  {'NP', 'Prophet'},

  {'NS', 'NS'},
  {'NS', 'Naga'},

  {'NW', 'Weaver'},

  {'OD', 'OD'},
  {'OM', 'Ogre'},
  {'OK', 'Omni'},

  {'PA', 'PA'},

  {'PL', 'PL'},
  {'PL', 'Pit'},

  {'POTM', 'POTM'},

  {'QoP', 'QoP'},

  {'RK', 'Sven', 'Rogue Knight'},

  {'SA', 'Riki'},
  {'SB', 'SB'},
  {'SD', 'SD'},
  {'SF', 'SF'},
  {'SG', 'Slardar'},
  {'SG', 'Tiny'},
  {'SM', 'SM'},

  {'SK', 'SK'},
  {'SK', 'Leoric'},
  {'SK', 'TB', 'Soul Keeper'},

  {'SP', 'Dazzle', 'Shadow Priest'},

  {'SS', 'Storm'},
  {'SS', 'Rhasta'},

  {'SW', 'Huskar', 'Sacred Warrior'},

  {'TA', 'TA'},
  {'TB', 'TB'},
  {'TC', 'TC'},
  {'TH', 'Tide'},
  {'THD', 'Jakiro'},
  {'TP', 'Treant'},

  {'TS', 'Shredder'},
  {'TS', 'Lesh', 'Tormented Soul'},

  {'TW', 'Troll'},

  {'UW', 'Ursa'},

  {'VS', 'VS'},

  {'WD', 'WD'},
  {'WR', 'WR'},
  {'WW', 'Auroth'},
}

local nicknames = {
  {'Carl', 'Invoker'},
  {'Tree', 'Treant'},
  {'Zues', 'Zeus'},
}

------------------------------
-- End of Big List -----------
------------------------------

local function to_list(tbl)
  local res = {}
  for k, v in pairs(tbl) do
    v.id = k
    table.insert(res, v)
  end
  return res
end


local d1_heroes = require( "data/v_dota1/heroes" )
local d2_heroes = require( "data/v_dota2/heroes" )

local d1_list = to_list(d1_heroes)
local d2_list = to_list(d2_heroes)

local escape_js_string = function(str)
  local s = str:gsub(".", {
    ["'"] = [[\']],
    ['"'] = [[\"]],
  })
  return '"' .. s .. '"'
end

--non nested json only
local print_json = function(id, keys, values)

  if(id ~= nil) then
    io.write('{\n')
  else
    io.write('[\n')
  end

  local i = 1
  for _, row in ipairs(values) do
    if type(row) == "string" then
      io.write("  //", row, "\n")
    else
      if (i == 1) then io.write("  ") else io.write(" ,") end
      i = i + 1

      if(id ~= nil) then
        io.write( escape_js_string(row[id]), ":")
      end

      local jj = 1
      io.write("{")
      for j, k in ipairs(keys) do
        if j ~= id then
          if(jj > 1) then io.write(",") end
          jj = jj + 1
          io.write( k, ":", escape_js_string(row[j]) )
        end
      end
      io.write("}\n")

    end
  end

  if(id ~= nil) then
    io.write('}')
  else
    io.write(']')
  end

end

local sort_by = function(tbl, f)
  table.sort(tbl, function(x1, x2)
    return f(x1) < f(x2)
  end)
end

local sort_patterns = function(pats)
  for i, pat in ipairs(pats) do
    pat.i = i
  end

  table.sort(pats, function(p1, p2)
    if p1[1] ~= p2[1] then return p1[1] < p2[1]
    else return p1.i < p2.i end
  end)
end

local patterns = {}

table.insert(patterns, [[Abbreviations and nicknames, alphabetically and then by importance:]])
table.insert(patterns, [[ For Dota 2 heroes the reminder should be the dota2 name, unless specified.]])
table.insert(patterns, [[ For Dota 1 heroes the reminder is "$name the $class"]])
local ab_patterns = {}
for _, row in ipairs(abbreviations) do
  local ab, id, rem = row[1], row[2], row[3]
  assert(d1_heroes[id], "bad id "..id)
  if not rem then
    if d2_heroes[id] then
      rem = d2_heroes[id].fullName
    else
      --rem = d1_heroes[id].fullName
    end
  end
  if d2_heroes[id] then --hide non ported heroes
    table.insert(ab_patterns, {ab, id, rem})
  end
end
for _, row in ipairs(ab_patterns) do
  table.insert(patterns, row)
end


table.insert(patterns, [[Dota 2 names, alphabetically]])
table.insert(patterns, [[  (no reminder)]])
sort_by(d2_list, function(h) return h.fullName end)
for _, h in ipairs(d2_list) do
  table.insert(patterns, {h.fullName, h.id, ""})
end

table.insert(patterns, [[Dota 1 names and classes, alphabetically:]])
table.insert(patterns, [[ For Dota 2 heroes, the reminder is the dota2 name]])
table.insert(patterns, [[ For Dota 1 heroes, the reminder is the other part of the name.]])

local d1_patterns = {}
for _, h in ipairs(d1_list) do
  local h2 = d2_heroes[h.id]
  if h2 then
    table.insert(d1_patterns , {h.name,  h.id, (h2 and h2.fullName or h.class) })
    table.insert(d1_patterns , {h.class, h.id, (h2 and h2.fullName or h.name ) })
  end
end
sort_patterns(d1_patterns)
for _, row in ipairs(d1_patterns) do
  table.insert(patterns, row)
end

----

local markup = require "markup/html"

local hero_data = {}
for _, h in ipairs(d1_list) do
  table.insert(hero_data, { h.id, h.id,  markup.sprite('hero', h.id, h.fullName)})
end
sort_by(hero_data, function(row) return row[1] end)

io.write('DATA = {\n')

io.write(' heroes:')
print_json(1,  {"id", "hash", "sprite"}, hero_data)
io.write(',\n')

io.write(' patterns:')
print_json(nil,  {"pat", "id", "rem"}, patterns)
io.write('\n')

io.write('};\n')

end)
