if Config.Framework == 'qb' or Config.Framework == 'qbx' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
end

function GetPlayer(src)
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then
        return QBCore.Functions.GetPlayer(src)
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayerFromId(src)
    end
end

function GetIdentifier(src)
    local player = GetPlayer(src)
    if not player then return end
    
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then
        return player.PlayerData.citizenid
    elseif Config.Framework == 'esx' then
        return player.identifier
    end
end

local function mergeTables(...)
    local mergedTable = {}
    for _, tbl in ipairs({...}) do
        if type(tbl) == "table" then
            for index, value in pairs(tbl) do
                mergedTable[index] = value
            end
        end
    end
    return mergedTable
end

function RemoveItem(player, item, count)
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then
        player.Functions.RemoveItem(item, count)
    elseif Config.Framework == 'esx' then
        player.removeInventoryItem(item, count)
    end
end

function AddItem(player, item, count)
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then
        player.Functions.AddItem(item, count)
    elseif Config.Framework == 'esx' then
        player.addInventoryItem(item, count)
    end
end



function GrabSkin(identifier)
    local skin = nil
    
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then
        if Config.Appearance == 'skinchanger' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})

            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'fivem-appearance' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})

            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'illenium-appearance' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})

            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'qb-clothing' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})
            if result and result[1] and result[1].skin then
                    skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'crm-appearance' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})

            if result and result[1] and result[1].skin then
                    skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'bl_appearance' then
            local result = MySQL.query.await("SELECT * FROM `appearance` WHERE `id` = ?", {identifier})
            if result and result[1] and result[1].skin then
                skin = mergeTables(json.decode(result[1].skin), json.decode(result[1].clothes), json.decode(result[1].tattoos))
            end
        elseif Config.Appearance == 'tgiann-clothing' then
            local result = MySQL.query.await("SELECT * FROM tgiann_skin WHERE citizenid = ?", { identifier })
            if result and result[1] and result[1].skin then
                skin = {
                    skin = json.decode(result[1].skin),
                    model = tonumber(result[1].model)
                }
            end
        elseif Config.Appearance == 'rcore_clothing' then
            local rcoreSkin = exports["rcore_clothing"]:getSkinByIdentifier(identifier)
            skin = {
                skin = rcoreSkin.skin,
                model =  rcoreSkin.ped_model,
            }

        elseif Config.Appearance == 'dx_clothing' then
            skin = {
                skin = false,
                tattoos = false
            }
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})
            if result and result[1] and result[1].skin then
                    skin.skin = json.decode(result[1].skin)
            end

            skin.tattoos = exports['dx_clothing']:getTattoosByIdentifier(identifier) 
        elseif Config.Appearance == 'karma_clothing' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})
            if result and result[1] and result[1].skin then
                skin = {
                    skin = {
                        newSkin = json.decode(result[1].skin),
                        newHead = {
                            headblend = {},
                            features = {},
                            overlays = {},
                            eyeColor = 0,
                            fade = 0,
                            tattoos = {}
                        }
                    }
                }
                local headDataQuery = MySQL.single.await('SELECT citizenid, model, head_blend, head_features, head_overlays, fade, tattoos, eye_color FROM karma_head_clothing WHERE citizenid = ? LIMIT 1', { identifier })
                if headDataQuery then
                    skin.skin.newHead = {
                        headblend = json.decode(headDataQuery.head_blend),
                        features = json.decode(headDataQuery.head_features),
                        overlays = json.decode(headDataQuery.head_overlays),
                        eyeColor = headDataQuery.eye_color,
                        fade = headDataQuery.fade,
                        tattoos = json.decode(headDataQuery.tattoos)
                    }
                end
            end
        end
    elseif Config.Framework == 'esx' then
        if Config.Appearance == 'skinchanger' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {identifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'fivem-appearance' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {identifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'illenium-appearance' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {identifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'qb-clothing' then
            return
        elseif Config.Appearance == 'crm-appearance' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {identifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif Config.Appearance == 'bl_appearance' then
            local result = MySQL.query.await("SELECT * FROM `appearance` WHERE `id` = ?", {identifier})
            if result and result[1] and result[1].skin then
                local decodedSkin = json.decode(result[1].skin)
                skin = mergeTables(json.decode(result[1].skin), json.decode(result[1].clothes), json.decode(result[1].tattoos))
            end
        elseif Config.Appearance == 'tgiann-clothing' then
            local result = MySQL.query.await("SELECT * FROM tgiann_skin WHERE citizenid = ?", { identifier })
            if result and result[1] and result[1].skin then
                skin = {
                    skin = json.decode(result[1].skin),
                    model = tonumber(result[1].model)
                }
            end
        elseif Config.Appearance == 'rcore_clothing' then
            local rcoreSkin = exports["rcore_clothing"]:getSkinByIdentifier(identifier)
            skin = {
                skin = rcoreSkin.skin,
                model =  rcoreSkin.ped_model,
            }

        elseif Config.Appearance == 'dx_clothing' then
            skin = {
                skin = false,
                tattoos = false
            }
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {identifier})
            if result and result[1] and result[1].skin then
                skin.skin = json.decode(result[1].skin)
            end
            skin.tattoos = exports['dx_clothing']:getTattoosByIdentifier(identifier) 
        elseif Config.Appearance == 'karma_clothing' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {identifier})
            if result and result[1] and result[1].skin then
                skin = {
                    skin = {
                        newSkin = json.decode(result[1].skin),
                        newHead = {
                            headblend = {},
                            features = {},
                            overlays = {},
                            eyeColor = 0,
                            fade = 0,
                            tattoos = {}
                        }
                    }
                }
                local headDataQuery = MySQL.single.await('SELECT citizenid, model, head_blend, head_features, head_overlays, fade, tattoos, eye_color FROM karma_head_clothing WHERE citizenid = ? LIMIT 1', { identifier })
                if headDataQuery then
                    skin.skin.newHead = {
                        headblend = json.decode(headDataQuery.head_blend),
                        features = json.decode(headDataQuery.head_features),
                        overlays = json.decode(headDataQuery.head_overlays),
                        eyeColor = headDataQuery.eye_color,
                        fade = headDataQuery.fade,
                        tattoos = json.decode(headDataQuery.tattoos)
                    }
                end
            end
        end
    end

    return skin
end