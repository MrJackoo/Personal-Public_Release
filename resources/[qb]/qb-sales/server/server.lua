local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-sales:server:sales' , function(name, sellmin, sellmax, quantity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = math.random(sellmin, sellmax)
    local finalPrice = price * quantity
    
    Player.Functions.RemoveItem(name, quantity)  
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "remove")
    Player.Functions.AddMoney('cash', finalPrice, 'Sold Goods')
    TriggerClientEvent('QBCore:Notify', src, 'You sold your items for £' ..finalPrice, 'success', 3000)
    TriggerEvent('qb-log:server:CreateLog', 'money', "Sales Shop", "green", "**"..Player.PlayerData.charinfo.firstname .. " ".. Player.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(src) .. "(** Citizen ID: "..Player.PlayerData.citizenid.." | ID: "..Player.PlayerData.source..")** has sold " ..quantity.. " x " ..name.. " for **£" .. finalPrice .. "**")
end)
