local Guide = {}

local Versions = require "data/versions"

--- Helpers

local function getter_from_table(tablename, tbl) return function(id)
	local i_res = assert(id, tablename.."id is required")
	local v_res = assert(tbl and tbl(id), "Unrecognized "..tablename.." id "..id)
	return v_res, i_res
end end

local get_hero = getter_from_table("hero", function(x) return Heroes[x] end)
local get_item = getter_from_table("item", function(x) return Items[x]  end)

local DEFAULT_SKILLBUILD_NAME = "Skills"
local DEFAULT_ITEMBUILD_NAME  = "Items"
local DEFAULT_TIPGROUP_NAME   = "Tips"

--- Constants (used when writing guides)

Guide.Q = {tag='tip_skill', value='Q'}
Guide.W = {tag='tip_skill', value='W'}
Guide.E = {tag='tip_skill', value='E'}
Guide.R = {tag='tip_skill', value='R'}
Guide.S = {tag='tip_skill', value='S'}

Guide.MAX = 25 

Guide.SEQ = {'ib_sequence_point'}
Guide.OPT = 'ib_optional'
Guide.ALT = 'ib_alternate'

Guide.H = function(id) return { tag='tip_hero', hero=get_hero(id) } end
Guide.I = function(id) return { tag='tip_item', item=get_item(id) } end
Guide.THIS = { tag='tip_this_hero' }
Guide.MARKUP =  function(func, args) return { tag='tip_markup', func=func, args=args } end
Guide.NOPERIOD = { tag='tip_no_period' }

--- Text Content

function Guide.Tip(tip_parts)
	
	local versions = tip_parts.versions
	
	local accepted_versions = {}
	for v=1,2 do
		accepted_versions[v] = not not (
			(versions==nil) or any(versions, function(x) return x == v end)
		)
	end
	
	local tip_parts = imap(tip_parts, function(part)
		if type(part) == 'string' then
			return { tag='tip_text', text=part }
		else
			return part
		end
	end)
	
	return {
		tag = 'tip',
		versions = accepted_versions,
		parts = tip_parts
	}
	
end

function Guide.HERODESC(tips)
	return { tag='section_hero_description', tips=imap(tips, Guide.Tip) }
end

function Guide.SKILLBUILDNOTE(tip_parts)
	return { tag='section_skill_build_note', tip=Guide.Tip(tip_parts) }
end

function Guide.ITEMBUILDNOTE(tip_parts)
	return { tag='section_item_build_note', tip=Guide.Tip(tip_parts) }
end

function Guide.TIPS(tips)
	return {
		tag  = 'section_tip_group',
		name = tips.name or DEFAULT_TIPGROUP_NAME,
		tips = imap(tips, Guide.Tip)
	}
end

--- Guide entry point

function Guide.GUIDE(guidedesc)
	local guide = {}

	guide.hero, guide.heroid = get_hero(guidedesc.heroid)

	guide.date        = assert(guidedesc.date, "Date is required")
	guide.dotaVersion = Versions.fromDate(guide.date)

  guide.heroDescription = nil
	guide.skillBuilds = {}
	guide.itemBuilds  = {}
	guide.tipGroups   = {}
	
	for _, section in ipairs(guidedesc) do

		local function add_note(noteType, tipProp)
			assert(not guide[noteType], "Duplicate "..noteType)
			guide[noteType] = section[tipProp]
		end

		local function add_tab(tabType)
			table.insert(guide[tabType], section)
		end

		if     section.tag == 'section_skill_build'      then add_tab ('skillBuilds')
		elseif section.tag == 'section_item_build'       then add_tab ('itemBuilds')
		elseif section.tag == 'section_tip_group'        then add_tab ('tipGroups')
		elseif section.tag == 'section_hero_description' then add_note('heroDescription', 'tips')
		else   pattern_failure(section.tag) end
		
	end

	return guide
end

--- Skill Builds

local function skillbuild_to_list(descs, reqs)

	-- Copy build so we can mutate and normalize input
	do 
		local _descs = {}
		for i, d in ipairs(descs) do
			if d.tag == 'tip_skill' then
				_descs[i] = {1, d.value, 1}
			elseif type(d) == 'table' then
				_descs[i] = {d[1], d[2].value, (d[3] or 1)}
			else pattern_error(d) end
		end
		descs = _descs
	end

	-- Default skill points, so we don't need to type full builds all the time
	if not any( descs, (function(desc) return desc[2] == 'R' end) ) then
		table.insert(descs, 1, {Guide.MAX, 'R', 1})
	end

	for _, skill in ipairs{'S', 'R', 'Q', 'W', 'E'} do
		if(reqs[skill]) then
			table.insert(descs, {Guide.MAX, skill, 1})
		end
	end

	-- Error checking
	for _, desc in ipairs(descs) do
		local ammt, skill, minlevel = desc[1], desc[2], desc[3]
		assert(ammt > 0,    'Ammount of times to level up a skill is not positive')
		assert(reqs[skill], 'Skill "'..skill..'" is not recognized.')
		assert(minlevel,    'Failed to set default value for minlevel')
	end

	-- Process build
	local curr_levels = map(reqs, function() return 0 end)
	local build = {}

	for hero_level = 1, Guide.MAX do

		for _, desc in ipairs(descs) do
			local ammount, skill, minlevel = desc[1], desc[2], desc[3]

			local dsl = curr_levels[skill] + 1 -- Desired skill level
			local rhls = reqs[skill]           -- Required hero levels

			if  (ammount > 0)                 -- I want to level up this skill
			    and (rhls[dsl] ~= nil)        -- Skill is not maxed out
			    and (hero_level >= rhls[dsl]) -- Game-imposed level requirements
			    and (hero_level >= minlevel)  -- Self-imposed level requirements
			then
				build[hero_level] = skill
				curr_levels[skill] = dsl
				desc[1] = ammount - 1
				break
			end
		end

		-- Sanity check: Each level must level-up some skill.
		-- (We might want to loosen this requirement for Dragon Knight though).
		assert(build[hero_level]) 
	end

	return build
end

local heroSkillRequirements =  {
	Q = {1,3,5,7},
	W = {1,3,5,7},
	E = {1,3,5,7},
	R = {6,11,16},
	S = {1,3,5,7,9,11,13,15,17,21}
}

local invokerSkillRequirements = {
	Q = {1,3,5,7,9,11,13},
	W = {1,3,5,7,9,11,13},
	E = {1,3,5,7,9,11,13},
	R = {2,7,12,17},
	S = false
}

function Guide.SKILLBUILD(descs)
	return {
		tag = 'section_skill_build',
		name = descs.name or DEFAULT_SKILLBUILD_NAME,
    tips = imap(descs.tips or {}, Guide.Tip),
		skills = skillbuild_to_list(
			descs,
			If(descs.isInvoker, invokerSkillRequirements, heroSkillRequirements )
		),
	}
end

--- Item Builds

local function normalize_item_build(desc)
    
	local do_sections, do_section, do_parts, do_part

	do_sections = function()
		return imap(desc, do_section)
	end

	do_section = function(section)
		return {
			name = section[1],
			parts = do_parts(slice(section, 2))
		}
	end

	do_parts = function(parts)
		return join(map(parts, do_part))
	end

	do_part = function(part)
		if type(part) == 'string' then
			return { { tag='ib_item', item=get_item(part) } }
			
		elseif type(part)  == 'table' then
			local tag = part[1]
			local subparts = slice(part, 2)
			
			if type(tag) == 'number' then
				local subpart_results = do_parts(subparts)
				
				local xs = {}; for i = 1, tag do xs[i] = subpart_results end
				return join(xs)
			
      elseif tag == 'ib_sequence_point' then
				return { { tag=tag } }
      
			elseif tag == 'ib_optional' then
				return { {tag=tag, parts=do_parts(subparts) } }
		
			elseif tag == 'ib_alternate' then
				return { {tag=tag, parts=do_parts(subparts) } }
			
			else pattern_failure(tag) end
			
		else pattern_failure(part) end
	end

	return do_sections()
	
end

function Guide.ITEMBUILD(builddesc)
	return {
		tag = 'section_item_build',
		name = (builddesc.name or DEFAULT_ITEMBUILD_NAME),
    tips = imap(builddesc.tips or {}, Guide.Tip),
		sections = normalize_item_build(builddesc)
	}
end

---

function Guide.mk_tip_stringifier(kw)

  local function stringify_tip(guide, tip)

    local versions  = tip.versions
    local tip_parts = tip.parts

    if not versions[DOTA_VERSION] then return "" end

    return concatSpaces(imap(tip_parts, function(part)

      if     part.tag == 'tip_text'      then
        return kw.text(part, guide)

      elseif part.tag == 'tip_markup'    then
        
        local real_args = imap(part.args, function(arg)
          if type(arg) == 'table' and arg.tag == 'tip' then
            return stringify_tip(guide, arg)
          else
            return arg
          end
        end)
        
        return kw.markup[part.func](table.unpack(real_args))

      elseif part.tag == 'tip_skill'     then
        return kw.skill(part, guide)

      elseif part.tag == 'tip_hero'      then
        return kw.hero(part, guide)

      elseif part.tag == 'tip_item'      then
        return kw.item(part, guide)

      elseif part.tag == 'tip_this_hero' then
        return kw.this_hero(part, guide)
      
      elseif part.tag == 'tip_no_period' then
        -- do nothing

      else pattern_failure(part.tag) end

    end))

  end

  return function(guide, tip)
    local sentence = stringify_tip(guide, tip)
  
    if
      #tip.parts > 0
      and tip.parts[#tip.parts].tag ~= 'tip_no_period'
      and sentence:match("[^.:!?]$")
    then
      sentence = sentence.."."
    end
    
    return sentence
  end
  
end

---

return Guide