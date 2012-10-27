local Output = {}

local Guide    = require 'guide'
local Versions = require 'data/versions'
local Markup   = require "markup/bbcode"
local BB = Markup

local imgs = {
  tavern_placeholder = "http://www.playdota.com/forums/picture.php?albumid=1714&pictureid=22521",
  opt_begin = "http://www.playdota.com/forums/picture.php?pictureid=7728&albumid=589&dl=1258501163&thumb=1",
  opt_end   = "http://www.playdota.com/forums/picture.php?pictureid=7729&albumid=589&dl=1258501163&thumb=1",
}

---

local P =  io.write

local function map_matrix(rows, f)
  local result = {}
  for i, row in ipairs(rows) do
    result[i] = {}
    for j, x in ipairs(row) do
      result[i][j] = f(x)
    end
  end
  return result
end

function Output.print_taverns(taverns, make_guide_link)

  P(
    BB.center(
      BB.table(map_matrix(taverns, function(tavern)
      
        local tavname
        if DOTA_VERSION == 1 then
          tavname = BB.img(tavern.img)
        else
          tavname = string.format(
            '[TABLE]%s|[b][size="3"]%s[/size][/b][/TABLE]',
            BB.img(tavern.img), BB.color('white', tavern.name) )
        end
    
        local tavtbl = map_matrix(tavern, function(h_id)
          return make_guide_link(Heroes[h_id], tavern)
        end)
        
        while #tavtbl < 5 do
          table.insert(tavtbl, { BB.img(imgs.tavern_placeholder) })
        end
    
        return BB.table({
          { BB.center(tavname) },
          { BB.table(tavtbl) }
        })
          
      end))
    )
  )
  
end

local skill_colors = {
  Q = "YellowGreen",
  W = "SandyBrown", 
  E = "RoyalBlue",
  R = "Red",
  S = "Yellow",
}

local stringify_whole_tip = Guide.mk_tip_stringifier{
  
  text = function(part)
    return part.text
  end,
  
  markup = Markup,
  
  skill = function(part, guide)
    local s = part.value
    return BB.color(skill_colors[s], guide.hero[s])
  end,
  
  hero = function(part)
    return part.hero.nick
  end,
  
  item = function(part)
    return part.item.name
  end,
  
  this_hero = function(part, guide)
    return guide.hero.nick
  end,
  
}

local function print_tip(guide, tip)

  P( stringify_whole_tip(guide, tip), '\n' )
  
end

local function print_tabs(tabs, print_pane)

  P('[tab]\n')
  for i, t in ipairs(tabs) do
      if i > 1 then P('|') end
      P(t.name)
  end
  P('\n')
  for i, t in ipairs(tabs) do
      if i > 1 then P('{|}') end
      print_pane(t)
  end
  P('\n')
  P('[/tab]')
  
end

local function print_skill_build(guide, skills)

  local hero = guide.hero
  
  local nrows = 6
  local ncols = 3
  
  -- Make table wide enough for "Presence of the Dark Lord"
  local header_row = {}
  for j = 1, ncols do
    header_row[2*j-1] = BB.color("Transparent", "__")
    header_row[2*j  ] = BB.color("Transparent", "_____________________")
  end
  
  local tbl_rows = {}
  for i = 1, nrows do tbl_rows[i] = {} end
  
  for n, skill in ipairs(skills) do
    if n > nrows*ncols then break end
    
    local n_repr = If(n < 10, BB.color('Transparent', '_') .. n, tostring(n))

    local skill_repr = BB.color( skill_colors[skill], hero[skill] )

    local j, i = divmod(n-1, nrows)
    j = j + 1
    i = i + 1
    tbl_rows[i][2*j-1] = n_repr
    tbl_rows[i][2*j  ] = skill_repr
  end
  
  P('[table]')
  P( table.concat(header_row, '|'), '\n' )
  for i=1,nrows do
    P( table.concat(tbl_rows[i], '|'), '\n' )
  end
  P('[/table]')

end

----

local function print_item_build(guide, sections)

  local go_parts, go_part

  go_part = function(part)
    if     part.tag == 'ib_item' then
      local item = part.item
      P( BB.note(item.name, BB.img( item.image )) )

    elseif part.tag == 'ib_sequence_point' then
      P( "=>" )

    elseif part.tag == 'ib_optional' then
      P( BB.img(imgs.opt_begin) )
      go_parts(part.parts)
      P( BB.img(imgs.opt_end) )

    elseif part.tag == 'ib_alternate' then
      io.write( "  (" )
      for i, subpart in ipairs(part.parts) do
        if i > 1 then
          io.write( BB.color("White", "or") )
        end
        go_part(subpart)
      end
      io.write( ")  " )
      
    else pattern_failure(part.tag) end
  end

  go_parts = function(parts)
    imap(parts, go_part)
  end

  P('[table]')
  for _, section in ipairs(sections) do
    P( BB.color("White", section.name), '|' )
    go_parts(section.parts); P('\n')
  end
  P('[/table]')

end

function Output.print_hero_guide(guide)
  
  local h = guide.hero
  
  fwrite( [=[
[anchor=]%s[/anchor][indent][URL="%s"]%s%s[/URL] %s   %s   %s   %s[/indent]
[NQB]
]=],
    h.id,
    h.heroPage, BB.img(h.image), BB.size("4", h.fullName),
    "Version "..Versions.fromDate(guide.date),
    BB.link(h.heroPage, "Detailed Info"),
    BB.anchor(h.heroPage, "Permalink") ,
    BB.anchor('top', "Back to Top")
  )

   --Hero description
  for _, tip in ipairs(guide.heroDescription or {}) do
    print_tip(guide, tip)
  end
  
  P('\n')
  
  --Skill build
  print_tabs(guide.skillBuilds, function(tab)
    print_skill_build(guide, tab.skills)
    imap(tab.tips, function(tip)
      print_tip(guide, tip)
    end)
  end)
  
  P('\n')

  --Item build
  print_tabs(guide.itemBuilds, function(tab)
    print_item_build(guide, tab.sections)
    imap(tab.tips, function(tip)
      print_tip(guide, tip)
    end)
  end)
  
  P('\n')
  
  --Tips
  print_tabs(guide.tipGroups, function(tab)
    P( Markup.color('transparent', '.') )
    for _, tip in ipairs(tab.tips) do
      P('\n')
      print_tip(guide, tip)
    end
    P( Markup.color('transparent', '.') )
  end)
  
  P( "[/NQB]" )
  
end


return Output