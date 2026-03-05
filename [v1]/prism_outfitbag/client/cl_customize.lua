if Config.Framework == 'qb' or Config.Framework == 'qbx' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
end

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    TriggerEvent('prism_outfitbag:client:playerLoaded')
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('prism_outfitbag:client:playerLoaded')
end)

CanPlaceBag = function()
    return true
end

GetPlayerData = function ()
    if Config.Framework == 'qbx' or Config.Framework == 'qb' then
        return QBCore.Functions.GetPlayerData()
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayerData()
    end
end

GetIdentifier = function ()
    local playerData = GetPlayerData()

    if not playerData then
        return nil
    end

    if Config.Framework == 'qbx' or Config.Framework == 'qb' then
        return playerData.citizenid
    elseif Config.Framework == 'esx' then
        return playerData.identifier
    end
end

RegisterTarget = function (entity, owner, bagId, isLocked)
    if Config.Interaction == 'ox_target' then
        local Options = {}

        Options[#Options+1] = {
            onSelect = function()
                local locked = false
                for _, bag in pairs(PlacedBags) do
                    if bag.bagId == bagId then
                        locked = bag.isLocked or false
                        break
                    end
                end
                TriggerEvent('prism_outfitbag:client:openBag', owner, bagId, locked)
            end,
            icon = 'fas fa-user',
            label = 'Open Bag',
        }

        if owner == GetIdentifier() and Config.EnablePickup then
            Options[#Options+1] = {
                onSelect = function()
                    TriggerEvent('prism_outfitbag:client:pickUpBag', bagId)
                end,
                icon = 'fas fa-hand',
                label = 'Pick up Bag'
            }
        end

        exports.ox_target:addLocalEntity(entity, Options)
    elseif Config.Interaction == 'qb-target' then
        local Options = {}

        Options[#Options+1] = {
            action = function()
                local locked = false
                for _, bag in pairs(PlacedBags) do
                    if bag.bagId == bagId then
                        locked = bag.isLocked or false
                        break
                    end
                end
                TriggerEvent('prism_outfitbag:client:openBag', owner, bagId, locked)
            end,
            icon = 'fas fa-user',
            label = 'Open Bag',
        }

        if owner == GetIdentifier() and Config.EnablePickup then
            Options[#Options+1] = {
                action = function()
                    TriggerEvent('prism_outfitbag:client:pickUpBag', bagId)
                end,
                icon = 'fas fa-hand',
                label = 'Pick up Bag'
            }
        end

        exports['qb-target']:AddTargetEntity(entity, {
            options = Options,
            distance = Config.Bag.interactionRange
        })
    end
end

SetSkin = function(skinData, isMale, isPlayer, ped)
    local ped = ped
    local plyModel

    if skinData ~= nil and skinData.model ~= nil then
        plyModel = type(skinData.model) == 'string' and joaat(skinData.model) or skinData.model
    else
        plyModel = isMale and GetHashKey("mp_m_freemode_01") or GetHashKey("mp_f_freemode_01")
    end

    if isPlayer then
        RequestModel(plyModel)
        while not HasModelLoaded(plyModel) do
            RequestModel(plyModel)
            Wait(0)
        end
        SetPlayerModel(PlayerId(), plyModel)
        ped = PlayerPedId()
        SetPedDefaultComponentVariation(PlayerPedId())
        local isFreemodePed = plyModel == GetHashKey("mp_m_freemode_01") or plyModel == GetHashKey("mp_f_freemode_01")
        if isFreemodePed then
            SetPedHeadBlendData(PlayerPedId(), 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        end
    end
    
    if Config.Appearance == 'skinchanger' then
        TriggerEvent('skinchanger:loadSkin', skinData, nil, ped)
    elseif Config.Appearance == 'fivem-appearance' then
        exports['fivem-appearance']:setPedAppearance(ped, skinData)
    elseif Config.Appearance == 'illenium-appearance' then
        exports['illenium-appearance']:setPedAppearance(ped, skinData)
    elseif Config.Appearance == 'qb-clothing' then
        TriggerEvent('qb-clothing:client:loadPlayerClothing', skinData, ped)
    elseif Config.Appearance == 'crm-appearance' then
        exports['crm-appearance']:crm_set_ped_appearance(ped, skinData)
    elseif Config.Appearance == 'bl_appearance' then
        exports.bl_appearance:SetPlayerPedAppearance(skinData)
    elseif Config.Appearance == 'tgiann-clothing' then
        TriggerEvent("tgiann-clothing:client:loadPedClothing", skinData.skin, ped)
    elseif Config.Appearance == 'rcore_clothing' then
        exports['rcore_clothing']:setPedSkin(ped, skinData)
    elseif Config.Appearance == 'dx_clothing' then
        exports['dx_clothing']:setPedAppearance(ped, skinData)
    elseif Config.Appearance == 'karma_clothing' then
        TriggerEvent('qb-clothing:client:loadPlayerClothing', skinData.skin, PlayerPedId())
    end
end