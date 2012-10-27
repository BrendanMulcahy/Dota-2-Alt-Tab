local Output = {}

local Guide  = require 'guide'
local Markup = require 'markup/html'

--- Escaping

local E = Markup.escape
local U = Markup.unescape

--- Pretty Printing


local indent_level = 0

local function with_indent(f)
  indent_level = indent_level + 1
  f()
  indent_level = indent_level - 1
end

local W, P

if true then --change this line to pretty print the html for debugging
  W = io.write
  P = io.write
else
  W = function(...)
    for i=1, indent_level do
      io.write('  ')
    end
    io.write(...)
  end

  P = function(...)
    W(...); io.write('\n')
  end
end

--- Helpers

local function TAG(tag, attrs, f)

  local attrs_str = table.concat(map(attrs, function(kv)
    return ' '..kv[1]..'="'..U(kv[2])..'"'
  end))

  P('<', tag, attrs_str, '>')
  with_indent(function()
    if type(f) == 'function' then
      f()
    else
      P(U(f))
    end
  end)
  P('</', tag, '>')

end

---

function Output.print_taverns(taverns)

  TAG('div', {{'class', 'section taverns'}}, function()
    for _, tav_row in ipairs(taverns) do
      for _, tav in ipairs(tav_row) do
        TAG('div', {{'class', 'tavern'}}, function()
          TAG('h3', {{'class', tav.stat}}, function()
            P( Markup.sprite('tavern', 'stat_'..tav.stat) )
            P( U(tav.name) )
            P( Markup.sprite('tavern', 'team_'..tav.team) )
          end)
          TAG('table', {}, function()
            for _, row in ipairs(tav) do
              TAG('tr', {}, function()
                for _, h_id in ipairs(row) do
                  local hero = Heroes[h_id]
                  TAG('td', {}, function()
                    TAG('a', {{'href', '#'..hero.id}, {'class', 'nav'}}, function()
                      P( Markup.sprite('hero', hero.id, E("Go to the "..hero.fullName.." guide") ) )
                    end)
                  end)
                end
              end)
            end
          end)
        end)
      end
    end
  end)

end

----

local stringify_whole_tip = Guide.mk_tip_stringifier{
  
  text = function(part)
    return U(part.text)
  end,
  
  markup = Markup,
  
  skill = function(part, guide)
    return '<span class="'..part.value..'">'..U(guide.hero[part.value])..'</span>'
  end,
  
  hero = function(part)
    return U(part.hero.nick)
  end,
  
  item = function(part)
    return U(part.item.name)
  end,
  
  this_hero = function(part, guide)
    return U(guide.hero.nick)
  end,
}

local function print_tip(guide, tip)

  P( '<div class="tip">', stringify_whole_tip(guide, tip), '</div>' )
  
end

local function print_tabs(tabs, print_pane)

  TAG('div', {{'class', 'tabs'}}, function()

    for i, tab in ipairs(tabs) do
      local cls = (i==1 and 'active' or 'inactive')
      TAG('div', {{'class', 'tab '..cls}}, function()
        TAG('h3', {}, E(tab.name))
      end)
    end

    for i, tab in ipairs(tabs) do
      local cls = (i==1 and 'visible' or 'hidden')
      TAG('div', {{'class', 'pane '..cls}}, function()
        TAG('div', {{'class', 'paneContents'}}, function()
          print_pane(tab)
        end)
      end)
    end

  end)

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
    tbl_rows[i][2*j-1] = string.format('<td class="tn">%d</td>', n)
    tbl_rows[i][2*j  ] = string.format('<td class="%s">%s</td>', skill, U(hero[skill]))
  end

  TAG('table', {{'class', 'skillBuild'}}, function()
    for i=1,nrows do
      TAG('tr', {}, function()
        P( table.unpack(tbl_rows[i]) )
      end)
    end
  end)

end

local function print_item_build(guide, sections)

  local go_parts, go_part

  go_part = function(part)
    if     part.tag == 'ib_item' then
      local item = part.item
      P(Markup.sprite('item', item.id, E(item.name)))

    elseif part.tag == 'ib_sequence_point' then
      P(Markup.sprite('symbol', 'Arrow'))

    elseif part.tag == 'ib_optional' then
      P(Markup.sprite('symbol', 'LBracket'))
      go_parts(part.parts)
      P(Markup.sprite('symbol', 'RBracket'))

    elseif part.tag == 'ib_alternate' then
      P(Markup.sprite('symbol', 'LBracket'))
      for i, subpart in ipairs(part.parts) do
        if i > 1 then
          P(Markup.sprite('symbol', 'Slash'))
        end
        go_part(subpart)
      end
      P(Markup.sprite('symbol', 'RBracket'))
    
    else pattern_failure(part.tag) end
  end

  go_parts = function(parts)
    imap(parts, go_part)
  end

  TAG('table', {{'class', 'itemBuild'}}, function()
    for _, section in ipairs(sections) do
      TAG('tr', {}, function()
        TAG('th', {}, E(section.name))
        TAG('td', {}, function()
          go_parts(section.parts)
        end)
      end)
    end
  end)

end


function Output.print_hero_guide(guide)
  local h = guide.hero

  TAG('div', {{'class', 'guide'}, {'id', E(h.id)}}, function()

    TAG('div', {{'class', 'guideHeader'}}, function()
      P(Markup.sprite('herobig', h.id, h.fullName))
      TAG('h2', {}, h.fullName)
      TAG('div', {{'class','nav'}}, function()
        TAG('a', {{'href',h.heroPage},{'target','_blank'}}, E("Detailed Info"))
        TAG('a', {{'href','#'..h.id}}, E("Permalink"))
        TAG('a', {{'href','#'}}, E("Back to top"))
      end)
    end)

    TAG('div', {{'class','guideBody'}}, function()

      --Hero description
      for _, tip in ipairs(guide.heroDescription or {}) do
        print_tip(guide, tip)
      end
      
      --[[
      --Hero description
      if guide.heroDescription then
        print_tabs({{name="Hero Description"}}, function()
          for _, tip in ipairs(guide.heroDescription) do
            print_tip(guide, tip)
          end
        end)
      end
      --]]
    
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
    
    end)
  end)
end

return Output
