local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('Blackmarket:server:CreatePed', function(x, y, z, w) --- Ped Sync
    TriggerClientEvent('Blackmarket:client:CreatePed', -1, x, y, z, w)
end)

RegisterNetEvent("qb-blackmarket:server:buyLaptops", function(products)
    local src = source
    local data = Config.Products[products]
    local Player = QBCore.Functions.GetPlayer(source)
    local info = {}
    local moneyPlayer = tonumber(Player.PlayerData.money.crypto)
    if moneyPlayer >= data.sell then
        info.uses = 3
        Player.Functions.RemoveMoney('crypto', tonumber(data.sell), 'BlackMarket: Got Laptop')
        Player.Functions.AddItem(products, 1, false, info)
        TriggerClientEvent('QBCore:Notify', source, " You bought a "..products.." for "..data.sell.. " QBits", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough Crypto!", 'error')
    end
end)

RegisterNetEvent("qb-blackmarket:server:buyPractice", function(products)
    local src = source
    local data = Config.Products[products]
    local Player = QBCore.Functions.GetPlayer(source)
    local moneyPlayer = tonumber(Player.PlayerData.money.crypto)
    if moneyPlayer >= data.sell then
        Player.Functions.RemoveMoney('crypto', tonumber(data.sell), 'BlackMarket: Practice')
        Player.Functions.AddItem(products, 1, false, info)
        TriggerClientEvent('QBCore:Notify', source, " You bought a "..products.." for "..data.sell.. " QBits", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough Crypto!", 'error')
    end
end)

RegisterNetEvent("qb-blackmarket:server:buyElectronics", function(products)
    local src = source
    local data = Config.Products[products]
    local Player = QBCore.Functions.GetPlayer(source)
    local moneyPlayer = tonumber(Player.PlayerData.money.crypto)
    if moneyPlayer > data.sell then
        Player.Functions.RemoveMoney('crypto', tonumber(data.sell), 'BlackMarket: Electronic')
        Player.Functions.AddItem(products, 1, false)
        TriggerClientEvent('QBCore:Notify', source, " You bought a "..products.." for "..data.sell.. " QBits", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough Crypto!", 'error')
    end
end)

RegisterNetEvent("qb-blackmarket:server:buyDrugs", function(products)
    local src = source
    local data = Config.Products[products]
    local Player = QBCore.Functions.GetPlayer(source)
    local moneyPlayer = tonumber(Player.PlayerData.money.crypto)
    if moneyPlayer > data.sell then
        Player.Functions.RemoveMoney('crypto', tonumber(data.sell), 'BlackMarket: Drug Purchase')
        Player.Functions.AddItem(products, 10, false)
        TriggerClientEvent('QBCore:Notify', source, " You bought "..products.." for "..data.sell.. " QBits", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough Crypto!", 'error')
    end
end)
