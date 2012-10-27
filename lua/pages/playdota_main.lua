
local Output = require 'output/playdota'
local Markup = require "markup/bbcode"
local BB = Markup

local data_links = require "data/guide_urls" 

--

local function doGuide(TAV_IMAGES, GUIDE_URLS, GUIDE_TAVERNS) 

local GUIDE_NAME = "The Alt-Tab Guide to Every Hero"

local dota2alttab = BB.link( data_links.dota2alttab_main, "here" )
local feedback = BB.link( data_links.playdota_feedback_thread_1, "in this thread" )


io.write([=[
[ANCHOR=]top[/ANCHOR]
[nqb][indent][size="2"][b]A [color="Lime"]Dota2[/color] version of this guide is available ]=]..dota2alttab..[=[[/b][/size][/indent]
[indent][size="2"][b][color="red"]Update in progress![/color] Please give us your feedback ]=]..feedback..[=[[/b][/size][/indent][/nqb]
[CENTER][B][COLOR="Royalblue"][SIZE="6"]]=]..GUIDE_NAME..[=[[/SIZE][/COLOR][/B][/CENTER]

]=])

Output.print_taverns(GUIDE_TAVERNS, function(hero, tavern)
  local url = GUIDE_URLS[tavern.id].."#"..hero.id
  return Markup.link( url, Markup.img(hero.image) )
end)

io.write([=[
[SIZE="3"][COLOR="Royalblue"]Credits[/COLOR][/SIZE]
[INDENT]This Guide has only been made possible through the helpful contributions of many people. You can find a detailed list [URL="http://www.playdota.com/forums/blogs/drafter/2775/credits-alt-tab-guide-every-hero/"][U]here[/U][/URL][/INDENT]


[SIZE="3"]Due to a Playdota restriction on the number of images allowed per guide, this guide's content is split by main hero attribute. You can find the individual parts at:[/SIZE]

]=])

fwrite([=[
[CENTER][TABLE]%s|[Size="4"]%s[/SIZE]
%s|[Size="4"]%s[/SIZE]
%s|[Size="4"]%s[/SIZE][/TABLE][/CENTER]
]=],
    Markup.img(TAV_IMAGES.str),
    Markup.link(GUIDE_URLS.SentinelStr.."#top", [=[[COLOR="Royalblue"]Alt-Tab Guide to Strength Heroes[/COLOR]]=]),
    
    Markup.img(TAV_IMAGES.agi),
    Markup.link(GUIDE_URLS.SentinelAgi.."#top", [=[[COLOR="Royalblue"]Alt-Tab Guide to Agility Heroes[/COLOR]]=]),
    
    Markup.img(TAV_IMAGES.int),
    Markup.link(GUIDE_URLS.SentinelInt.."#top", [=[[COLOR="Royalblue"]Alt-Tab Guide Intelligence Heroes[/COLOR]]=])
)

end

----------

local setupGuide = require "setup"

withOutput( '../results/playdota_dota1/main.bbcode', 'w', function()
  doGuide(
    {
      str = "http://www.playdota.com/img/site/strength.jpg",
      agi = "http://www.playdota.com/img/site/agility.jpg",
      int = "http://www.playdota.com/img/site/intelligence.jpg",
    },
    {
      SentinelStr = data_links.playdota_dota1_str,
      ScourgeStr  = data_links.playdota_dota1_str,
      SentinelAgi = data_links.playdota_dota1_agi,
      ScourgeAgi  = data_links.playdota_dota1_agi,
      SentinelInt = data_links.playdota_dota1_int,
      ScourgeInt  = data_links.playdota_dota1_int,
    },
    setupGuide(1, {
      output = "output/playdota",
      assets = 'a_playdota',
      info = 'i_playdota',
      taverns = {
        { 'SentinelStr' , 'SentinelAgi', 'SentinelInt' },
        { 'ScourgeStr'  , 'ScourgeAgi' , 'ScourgeInt'  },
      }
    })
  )
end)