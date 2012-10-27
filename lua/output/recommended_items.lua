local Output = {}

local W = io.write

local function print_section(guide, parts)

  local go_parts, go_part

  go_part = function(part)
    if     part.tag == 'ib_item' then
      local item = part.item
      
  W('			"item"		"item_'..item.id..'"\r\n')
    
    elseif part.tag == 'ib_sequence_point' then
      --Do Nothing
        
    elseif part.tag == 'ib_optional' then
      --TODO: be more informative?
      go_parts(part.parts)
    
    elseif part.tag == 'ib_alternate' then
      --TODO: be more informative?
      go_parts(part.parts)
      
    else
      pattern_failure(part.tag)
    end
  end

  go_parts = function(parts)
    imap(parts, go_part)
  end

  go_parts(parts)

end

function Output.print_hero_guide(guide)

  local hero = guide.hero

  W('itembuilds/'..hero.valveGuide..'\r\n')
  W('{\r\n')
  W('	"author"		"Generated for dota2alttab.com by Ninguem"\r\n')
  W('	"hero"			"'..hero.valveId..'"\r\n')
  W('	"Title"			"Recommended items for '..hero.nick..'"\r\n')
  W('	\r\n')
  W('	"Items"\r\n')
  W('	{\r\n')

  if guide.itemBuilds[1] then
    local sections = guide.itemBuilds[1].sections

    for _, section in ipairs(sections) do
      
  W('		"'..section.name..'"\r\n')
  W('		{\r\n')
  
      print_section(guide, section.parts)
      
  W('		}\r\n')
  W('		\r\n')
      
    end

  end

  W('	}\r\n')
  W('}\r\n')

end

return Output
