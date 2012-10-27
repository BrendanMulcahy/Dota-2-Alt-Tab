local strict = {}

function strict.forbid_global_variables_except(allowed_globals)

    local function is_allowed(desiredvar)
        if desiredvar:match('^_[A-Z]') then
            return true -- Builtin Lua variables: _G, _PROMPT, etc.
        end
        for _, allowed_var in ipairs(allowed_globals) do
            if desiredvar == allowed_var then
                return true
            end
        end
        return false
    end
    
    setmetatable(_G, {
        __index = function(t, varname)
            if is_allowed(varname) then
                return rawget(t, varname)
            else
                error('Accessing an undefined global variable "'..varname..'"', 2)
            end
        end,

        __newindex = function(t, varname, value)
            if is_allowed(varname) then
                return rawset(t, varname, value)
            else
                error('Setting a new global variable "'..varname..'"', 2)
            end
        end
    })
end

return strict