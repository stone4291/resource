local YourWebhook = 'YOUR-WEBHOOK'  -- help: https://docs.brutalscripts.com/site/others/discord-webhook

function GetWebhook()
    return YourWebhook
end

-- STAFF CHECK CALLBACK (auto-detect god/admin)
RESCB("brutal_gangs:server:StaffCheck", function(source, cb)
    local src = source
    cb(StaffCheck(src))
end)

-- GET PLAYER DRESSING (Wardrobe / Outfits)
RESCB("brutal_gangs:server:GetDressing", function(source, cb)
    local src = source
    local dressingTable = {}
    local dataArrived = false

    if Config['Core']:upper() == 'ESX' then
        TriggerEvent('esx_datastore:getDataStore', 'property', GetIdentifier(src), function(store)
            local dressings = store.get('dressing') or {}
            for k,v in pairs(dressings) do
                table.insert(dressingTable, {label = v.label, skin = v.skin})
            end
            dataArrived = true
        end)
    elseif Config['Core']:upper() == 'QBCORE' then
        local results = MySQL.query.await('SELECT * FROM player_outfits WHERE citizenid = ?', { GetIdentifier(src) })
        for k, v in pairs(results) do
            table.insert(dressingTable, {label = v.outfitname ~= "" and v.outfitname or "None", skin = results[k].skin, model = v.model})
        end
        dataArrived = true
    end

    -- Wait until data is ready
    while not dataArrived do
        Citizen.Wait(10)
    end

    cb(dressingTable)
end)

-- STAFF CHECK FUNCTION
function StaffCheck(source)
    local staff = false

    if Config.Core:upper() == 'ESX' then
        local player = Core.GetPlayerFromId(source)
        local playerGroup = player.getGroup()

        -- Automatically staff if group is 'admin' or 'god'
        if playerGroup == 'admin' or playerGroup == 'god' then
            staff = true
        end
    elseif Config.Core:upper() == 'QBCORE' then
        -- Automatically staff if player has god/admin permissions
        if Core.Functions.HasPermission(source, 'god') or Core.Functions.HasPermission(source, 'admin') or IsPlayerAceAllowed(source, 'god') or IsPlayerAceAllowed(source, 'admin') then
            staff = true
        end
    end

    return staff
end

-- SAVE PLAYER SKIN (QBCore)
RegisterNetEvent("brutal_gangs:server:qbcore-loadPlayerSkin")
AddEventHandler("brutal_gangs:server:qbcore-loadPlayerSkin", function(model, skin)
    local src = source

    if model ~= nil and skin ~= nil then
        MySQL.query('DELETE FROM playerskins WHERE citizenid = ?', { GetIdentifier(src) }, function()
            MySQL.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
                GetIdentifier(src),
                model,
                skin,
                1
            })
        end)
    end
end)