--
-- Array functions
------------------

--Lua 5.1 compat
table.unpack = table.unpack or unpack 
table.pack   = table.pack or (function(...) return {n=select('#', ...), ...} end)

local function mk_map(it)
  return function(seq, f)
    local res = {}
    for k, v in it(seq) do
      res[k] = f(v, k)
    end
    return res  
  end
end

map  = mk_map(pairs)
imap = mk_map(ipairs)

function join(tbls)
  local n = 0
  local res = {}
  for _, tbl in ipairs(tbls) do
    for _, x in ipairs(tbl) do
      n = n + 1
      res[n] = x
    end
  end
  return res
end

function any(tbl, f)
  for _, v in pairs(tbl) do
    if f(v) then return true end
  end
  return false
end

function slice(tbl, i, j)
  if i == nil then i = 1 end
  if j == nil then j = #tbl end
  local res = {}
  for k = i,j do
    res[k-i+1] = tbl[k]
  end
  return res
end

--
-- String functions
-------------------

function capitalize(str)
  return str:gsub( "(%w)([%w]*)", function (first, rest)
    return string.upper(first) .. rest
  end )
end

--
-- Table
--------

local function mixin(dst, src)
  for k, v in pairs(src) do
    if type(v) ~= 'table' then
      dst[k] = v
    elseif type(dst[k]) == 'table' and type(v) == 'table' then
      mixin(dst[k], v)
    else
      dst[k] = mixin({}, v)
    end
  end
  return dst
end

function joinDota(relations) --"joinData" wasn't as funny of a name.
  local res = {}
  for _, t in ipairs(relations) do
    mixin(res, t)
  end
  return res
end
    
function printTable(tbl, nesting)
  local printed_tables = {}
  
  local function go(tbl, nesting)
    printed_tables[tbl] = true
    for k, v in pairs(tbl) do
      local tabs = string.rep('\t', nesting)
      if type(v) ~= 'table' or printed_tables[v] then
        print(string.format( "%s%s\t%s", tabs, k, tostring(v) ))
      else
        print(string.format( "%s%s (%s):", tabs, k, tostring(v)))
        go(v, nesting + 1)
      end
    end
  end
  
  go(tbl, nesting or 0)
end

function itmatrix(mat)
  local i, j = 1, 0
  local N = #mat
  
  return function()
    while i <= N do
      local M = #mat[i]
      if j < M then
        j = j + 1
        return i, j, mat[i][j]
      else
        i = i + 1
        j = 0
      end
    end
    return nil
  end
end

--
-- Misc
-------

function concatSpaces(strings)
  local addSpace = false
  return table.concat(imap(strings, function(s)
    local needsSpace = addSpace and s:match([=[^[^%s'",.:;!?&)]]=])
    addSpace = s:match('[^%s(]$')
    return If(needsSpace, ' '..s, s)
  end))
end

function divmod(n, m)
  return math.floor(n/m), n%m
end

function withOutput(filename, mode, func)
  local file = io.open(filename, mode)
  local oldfile = io.output()
  io.output(file)
  func(file)
  io.close(file)
  io.output(oldfile)
end

function fwrite(...)
  return io.write(string.format(...))
end

function If(cond, a, b)
  if cond then return a else return b end
end

function pattern_failure(tag)
  error("Pattern match failure: "..tostring(tag), 2)
end