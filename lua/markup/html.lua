
local function escape(text)
	--Text to escaped HTML (indempotent)
	if type(text) == 'table' and text.tag == 'html_escaped' then
		return text
	else
		return {
			tag = 'html_escaped',
			html = string.gsub(tostring(text), '.', {
				[ [[&]] ] = [[&amp;]],
				[ [[<]] ] = [[&lt;]],
				[ [[>]] ] = [[&gt;]],
				[ [["]] ] = [[&quot;]],
				[ [[']] ] = [[&apos;]],
			})
		}
	end
end

local function unescape(text)
	--Text to escaped HTML (string)
	return escape(text).html
end


local function t_link(href, text)
  return string.format('<a href="%s">%s</a>', href, text)
end

local function t_img(href, alt, title)
  if title then
    return string.format( '<img src="%s" alt="%s" title="%s">', href, unescape(alt), unescape(title) )
  else
    return string.format( '<img src="%s" alt="%s">', href, alt )
  end
end

local function t_small(text)
  return string.format('<small>%s</small>', text)
end

local function t_bold(text)
  return string.format('<strong>%s</strong>', text)
end

local function t_ulist(...)
  local items = table.pack(...)
  local res = {}
  table.insert(res, '<ul>')
  for _, item in ipairs(items) do
    table.insert(res, '<li>')
    table.insert(res, item)
    table.insert(res, '</li>')
  end
  table.insert(res, '</ul>')
  return table.concat(res)
end

local function t_sprite(spriteType, spriteId, title)
  return string.format( '<span class="s_%s si_%s"%s></span>', 
    spriteType, spriteId,
    If(title, ' title="'..unescape(title)..'"', '')
  )
end

return {
  escape = escape,
  unescape = unescape,

  link = t_link,
  img = t_img,
  ulist = t_ulist,
  small = t_small,
  bold = t_bold,
  sprite = t_sprite,
}