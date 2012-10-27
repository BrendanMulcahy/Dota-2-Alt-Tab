local setupGuide = require "setup"

local Output = require 'output/playdota'
local Markup = require "markup/bbcode"
local BB = Markup

local data_links = require "data/guide_urls"

local nguides
local skipped_guides = {}

---------

local function doGuide(GUIDE_TITLE, MAIN_GUIDE_URL, GUIDE_TAVERNS)

  local main_guide = BB.link(MAIN_GUIDE_URL.."#top", "here")
  local dota2alttab = BB.link( data_links.dota2alttab_main, "here" )
  local feedback = BB.link( data_links.playdota_feedback_thread_1, "in this thread" )

  local other_version_name = If(DOTA_VERSION == 1, "Dota 2", "Dota 1")

  io.write([=[
[ANCHOR=]top[/ANCHOR]
[nqb][indent][size="2"][b]This is part of a larger guide to every hero. You can find the other parts ]=]..main_guide..[=[[/b][/size][/indent]
[indent][size="2"][b]A [color="Lime"]Dota2[/color] version of this guide is available ]=]..dota2alttab..[=[[/b][/size][/indent]
[indent][size="2"][b][color="red"]Update in progress![/color] Please give us your feedback ]=]..feedback..[=[[/b][/size][/indent][/nqb]
[CENTER][B][COLOR="Royalblue"][SIZE="6"]]=]..GUIDE_TITLE..[=[[/SIZE][/COLOR][/B][/CENTER]

]=])

  Output.print_taverns(GUIDE_TAVERNS, function(hero)
    return string.format(
      '[goanchor=%s]%s[/goanchor]',
      hero.id, BB.img(hero.image))
  end)

  io.write[=[
[SIZE="3"][COLOR="RoyalBlue"]How to use[/COLOR][/SIZE][LIST=1]
[*]Find your hero by clicking on the tavern icons or by doing a text search with Ctrl+F.
[*]Brackets [B][ ][/B] indicate optional items.
[*]An arrow [B]->[/B] indicates ordering: get the items in the left before the ones in the right.
[*]The [B]Extension:[/B] list is often more for giving interesting possibilities than an actual build order. This is particularly true for item independent heroes and supports.
[*][B]All builds should be adapted to each different game.[/B]
[*]Good luck and have fun![/LIST]

[SIZE="3"][COLOR="RoyalBlue"]What does this guide contain?[/COLOR][/SIZE]
[INDENT] I try to make is so that each guide includes a short description of the hero and his role, generally accepted, [I]cookie cutter[/I], item and skill builds and some important miscellaneous tips and mechanics clarifications.

The objective is to allow a player to get enough info to play a reasonable game, while keeping the guides short enough so they can be read before the first creepwave spawns and giving them a consistent and familiar style.[/INDENT]

[SIZE="3"][COLOR="Royalblue"]Credits[/COLOR][/SIZE]
[INDENT]This Guide has only been made possible through the helpful contributions of many people. You can find a detailed list [URL="http://www.playdota.com/forums/blogs/drafter/2775/credits-alt-tab-guide-every-hero/"][U]here[/U][/URL][/INDENT]





]=]

  for _, _, tavern in itmatrix(GUIDE_TAVERNS) do
    for _, _, h_id in itmatrix(tavern) do
      if Guides[h_id] then
        nguides = nguides + 1
        print(h_id)
        Output.print_hero_guide( Guides[h_id] )
      else
        table.insert(skipped_guides, h_id)
      end
    end
  end

  -- If we don't add some extra space here the hyperlink to the last guide does not put
  --  the guide on the top of the screen.
  io.write( ('\n'):rep(40) )
  io.write( BB.color('transparent', '[<O>]') )

end

---------------------

nguides = 0
for _, attr in ipairs({
  {'Str', 'Strength'},
  {'Agi', 'Agility'},
  {'Int', 'Intelligence'},
}) do

  local attr_code = attr[1]
  local attr_name = attr[2]
  
  withOutput( ('../results/playdota_dota1/%s.bbcode'):format(attr_code), 'w', function()
    doGuide(
      "The Pretty Alt-Tab Guide to Every "..attr_name.." Hero",
      data_links.playdota_dota1_main,
      setupGuide(1, {
        info = 'i_playdota',
        assets = 'a_playdota',
        taverns = {
          { 'Sentinel'..attr_code, 'Scourge'..attr_code }
        }
      })
    )
  end)
end

print("Wrote "..nguides.." guides.")
if(#skipped_guides) then
  print("")
  print("Skipped Guides:")
  for i, h_id in ipairs(skipped_guides) do
    print(i, h_id)
  end
end