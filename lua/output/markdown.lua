local Output = {}

local Guide  = require 'guide'
local Markup = require 'markup/markdown'
----

local P = io.write

local stringify_whole_tip = Guide.mk_tip_stringifier{
  
  text = function(part)
    return part.text
  end,
  
  markup = Markup,
  
  skill = function(part, guide)
    return Markup.bold(guide.hero[part.value])
  end,
  
  hero = function(part)
    return part.hero.nick
  end,
  
  item = function(part)
    return Markup.bold(part.item.name)
  end,
  
  this_hero = function(part, guide)
    return guide.hero.nick
  end,
}

local function print_tip(guide, tip)
  P( stringify_whole_tip(guide, tip), '\n\n' )
end

local function print_tabs(tabs, print_pane)

  for i, tab in ipairs(tabs) do
    P( Markup.h3(tab.name) )
    print_pane(tab)
  end

end

local function print_skill_build(guide, skills)
  local hero = guide.hero

  local nrows = 6
  local ncols = 3

  local tbl_rows = {}
  for i = 1, nrows do tbl_rows[i] = {} end

  for n, skill in ipairs(skills) do
    if n > nrows*ncols then break end

    local j, i = divmod(n-1, nrows)
    j = j + 1
    i = i + 1
    tbl_rows[i][2*j-1] = Markup.bold(n)
    tbl_rows[i][2*j  ] = '`'..skill..'` '..hero[skill]
  end

  P('\n')
  for j=1,2*ncols do P( '| ')    end; P('|\n')
  for j=1,2*ncols do P( '|:---') end; P('|\n')
  for i=1,nrows do
    P( table.concat(tbl_rows[i], '|'), '|\n' )
  end
  P('\n')
end

local function print_item_build(guide, sections)
  local go_parts, go_part

  go_part = function(part)
    if     part.tag == 'ib_item' then
      local item = part.item
      P(item.name..'; ')

    elseif part.tag == 'ib_sequence_point' then
      P(' => ')

    elseif part.tag == 'ib_optional' then
      P(' [ ')
      go_parts(part.parts)
      P(' ] ')

    elseif part.tag == 'ib_alternate' then
      P(' [ ')
      for i, subpart in ipairs(part.parts) do
        if i > 1 then
          P('or ')
        end
        go_part(subpart)
      end
      P(' ] ')
    
    else pattern_failure(part.tag) end
  end

  go_parts = function(parts)
    imap(parts, go_part)
  end

  P('\n')
  P('| | |\n')
  P('|:---|:---|\n')
  for _, section in ipairs(sections) do
    P( Markup.bold(section.name), '|' )
    go_parts(section.parts)
    P('|\n')
  end
  P('\n')

end


function Output.print_hero_guide(guide)
  local h = guide.hero

  P( Markup.h2(h.fullName) )

  --Hero description
  for _, tip in ipairs(guide.heroDescription or {}) do
    print_tip(guide, tip)
  end

  --Skill build
  print_tabs(guide.skillBuilds, function(tab)
    print_skill_build(guide, tab.skills)
    imap(tab.tips, function(tip)
      print_tip(guide, tip)
    end)
  end) 

  --Item build
  print_tabs(guide.itemBuilds, function(tab)
    print_item_build(guide, tab.sections)
    imap(tab.tips, function(tip)
      print_tip(guide, tip)
    end)
  end)

  --Tips
  print_tabs(guide.tipGroups, function(tab)
    for _, tip in ipairs(tab.tips) do
      print_tip(guide, tip)
    end
  end)
  
  P( Markup.hr() )
end

return Output
