local function mk_bb_tag(tagname)
  return function(text)
    return string.format( '[%s]%s[/%s]', tagname, text, tagname )
  end
end

local function mk_bb_tag_attr(tagname)
  return function(attr, text)
    return string.format( '[%s=%q]%s[/%s]', tagname, attr, text, tagname )
  end
end

local bb_center = mk_bb_tag "center"
local bb_img    = mk_bb_tag "img"
local bb_bold   = mk_bb_tag "b"

local bb_color = mk_bb_tag_attr "color"
local bb_note  = mk_bb_tag_attr "note"
local bb_size  = mk_bb_tag_attr "size"

local bb_small = function(text)
  return bb_size("1", text)
end

local function bb_link(link, text)
  return string.format('[u][url="%s"]%s[/url][/u]', link, text)
end

local function bb_anchor(link, text)
  return string.format('[u][goanchor="%s"]%s[/goanchor][/u]', link, text)
end

local function bb_table(rows, f)
  local lines = {}
  for i, row in ipairs(rows)do
    lines[i] = table.concat(row, '|')
  end
  return '[TABLE]'..table.concat(lines, '\n')..'[/TABLE]\n'
end

local function bb_ulist(...)
  local items = table.pack(...)
  local res = {}
  table.insert(res, '[LIST]')
  for _, item in ipairs(items) do
    table.insert(res, '[*]'..item )
  end
  table.insert(res, '[/LIST]')
  return table.concat(res)
end

return {
  link = bb_link,
  img = bb_img,
  ulist = bb_ulist,
  small = bb_small,
  bold = bb_bold,

  center = bb_center,
  color = bb_color,
  note = bb_note,
  size = bb_size,
  table = bb_table,
  
  anchor = bb_anchor,
}
