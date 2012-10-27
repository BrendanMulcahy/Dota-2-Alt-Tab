local setupGuide = require "setup"

local GUIDE_TAVERNS = setupGuide(2, {
  taverns = {
    { 'SentinelStr', 'SentinelAgi', 'SentinelInt' },
    { 'ScourgeStr' , 'ScourgeAgi' , 'ScourgeInt'  },
  },
})

local Output = require 'output/markdown'
local Markup = require 'markup/markdown'

local FILE_MARKDOWN = '../results/dota2markdown.txt'

withOutput(FILE_MARKDOWN, 'w', function()

for _, _, tavern in itmatrix(GUIDE_TAVERNS) do
  for _, _, h in itmatrix(tavern) do
    if(Guides[h]) then
      Output.print_hero_guide( Guides[h] )
    end
  end
end

end)