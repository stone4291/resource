local DEFAULT_FRAMEWORK = 'ox'

Framework = setmetatable({}, {
    __newindex = function(self, name, fn)
        exports(name, function() return fn end)
        rawset(self, name, fn)
    end
})

local context = IsDuplicityVersion() and 'server' or 'client'
local requireLua = require
local Utils = requireLua 'utils'

local function format(str)
    if not string.find(str, "'") then return str end
    return str:gsub("'", "")
end

Config = {
    convars = {
        core = format(GetConvar('bl:framework', DEFAULT_FRAMEWORK)),
        inventory = format(GetConvar('bl:inventory', DEFAULT_FRAMEWORK)),
        context = format(GetConvar('bl:context', DEFAULT_FRAMEWORK)),
        target = format(GetConvar('bl:target', DEFAULT_FRAMEWORK)),
        progressbar = format(GetConvar('bl:progressbar', DEFAULT_FRAMEWORK)),
        radial = format(GetConvar('bl:radial', DEFAULT_FRAMEWORK)),
        notify = format(GetConvar('bl:notify', DEFAULT_FRAMEWORK)),
        textui = format(GetConvar('bl:textui', DEFAULT_FRAMEWORK)),
    },
    resources = {
        core = {
            qb = 'qb-core',
            ox = 'ox_core',
            esx = 'es_extended'
        }
    }
}

---@param module string
---@return string?
function GetFramework(module)
    local moduleConfig = Config.resources[module]
    if not moduleConfig then return end
    return moduleConfig[Config.convars[module]]
end

exports('getFramework', GetFramework)

-- ================================
-- BACKWARD COMPATIBILITY EXPORT
-- This fixes: No such export core
-- ================================
function core()
    local framework = GetFramework('core')

    if framework == 'qb-core' then
        return exports['qb-core']:GetCoreObject()

    elseif framework == 'es_extended' then
        return exports['es_extended']:getSharedObject()

    elseif framework == 'ox_core' then
        return exports['ox_core']
    end

    return nil
end

exports('core', core)