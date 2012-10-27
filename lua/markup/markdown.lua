
local function escape(text)
	return text
end

local function unescape(text)
	return text
end


local function t_link(href, text)
  return '['..text..']('..href..')'
end

local function t_small(text)
  return text
end

local function t_italic(text)
  return '*'..text..'*'
end

local function t_bold(text)
  return '**'..text..'**'
end

local function t_ulist(...)
  local items = table.pack(...)
  local res = {}
  table.insert(res, '\n')
  for _, item in ipairs(items) do
    table.insert(res, '  * ')
    table.insert(res, item)
    table.insert(res, '\n')
  end
  table.insert(res, '\n')
  return table.concat(res)
end


local function t_h1(text) return ('#'..text..'#\n') end
local function t_h2(text) return ('##'..text..'##\n') end
local function t_h3(text) return ('###'..text..'###\n') end
local function t_h4(text) return ('####'..text..'####\n') end
local function t_h5(text) return ('#####'..text..'#####\n') end
local function t_h6(text) return ('######'..text..'######\n') end

local function t_hr() return '\n------\n\n' end

return {
  escape = escape,
  unescape = unescape,

  link = t_link,
  ulist = t_ulist,
  small = t_small,
  bold = t_bold,
  
  italic = t_italic,

  h1 = t_h1,
  h2 = t_h2,
  h3 = t_h3,
  h4 = t_h4,
  h5 = t_h5,
  h6 = t_h6,

  hr = t_hr,
}
