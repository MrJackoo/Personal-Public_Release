local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-pawnshop:server:sellPawnItems", function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (itemAmount * itemPrice)

    if Player.Functions.RemoveItem(itemName, itemAmount) then
        if Config.BankMoney then
            Player.Functions.AddMoney('bank', totalPrice, 'Pawnshop Payout')
        else
            Player.Functions.AddMoney("cash", totalPrice, 'Pawnshop Payout')
        end
        TriggerClientEvent("QBCore:Notify", src, "You have sold "..itemAmount.. " x "..itemName.." for £"..totalPrice, "success")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
     TriggerClientEvent("QBCore:Notify", src, "ERROR! Not enough items maybe?", "error")
    end
    
end)

QBCore.Functions.CreateCallback('qb-pawnshop:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)