RegisterNetEvent("moonlight_trucks:ztas1234tjiaeuz1478134", function(amount)
    local src = source
    if not amount or type(amount) ~= "number" or amount <= 0 then return end

    -- Detect ESX or QBCore
    local xPlayer = nil
    local qbcore = nil

    if ESX then
        xPlayer = ESX.GetPlayerFromId(src)
    elseif QBCore then
        qbcore = QBCore.Functions.GetPlayer(src)
    end

    -- OX Inventory (give item "money", not actual cash)
    local success = exports.ox_inventory:AddItem(src, "cash", amount)

    if not success then
        -- Fallback to cash if OX item not working
        if xPlayer then
            xPlayer.addAccountMoney("money", amount)
        elseif qbcore then
            qbcore.Functions.AddMoney("cash", amount)
        else
            print(("^1[moonlight_trucks]^0 Failed to give money to player %s: no framework detected"):format(src))
        end
    end
end)
