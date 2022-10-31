local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-vu:bill:player", function(serverid, amount)
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(serverid))
    local amount = tonumber(amount)
    if biller.PlayerData.job.name == 'vu' then
        if billed ~= nil then
            if amount and amount > 0 then
                MySQL.Async.insert('INSERT INTO phone_invoices (citizenid, amount, society, title, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?, ?)',
                {billed.PlayerData.citizenid, amount, biller.PlayerData.job.name, "VU Till", biller.PlayerData.charinfo.firstname .. ' ' .. biller.PlayerData.charinfo.lastname, biller.PlayerData.citizenid})
                TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
            else
                TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
    end
end)

QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientIce', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local icebag = Ply.Functions.GetItemByName("vu_icepacket")
    if icebag ~= nil then
        if icebag.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientSoftdrink', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local softdrinksyrup = Ply.Functions.GetItemByName("vu_sodasyrup")
    if softdrinksyrup ~= nil then
        if softdrinksyrup.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientmShake', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local mshakemix = Ply.Functions.GetItemByName("vu_mshakeformula")
    if mshakemix ~= nil then
        if mshakemix.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientcocktail', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local cocktailmix = Ply.Functions.GetItemByName("vu_cocktailmix")
    local cocktailglass = Ply.Functions.GetItemByName("vu_cocktailglass")
    local umbrella = Ply.Functions.GetItemByName("vu_umbrella")
    local olive = Ply.Functions.GetItemByName("vu_olive")
    if cocktailmix ~= nil and cocktailglass ~= nil and umbrella ~= nil and olive ~= nil then
        if cocktailmix.amount >= 2 and cocktailglass.amount >= 1 and umbrella.amount >= 1 and olive.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientWhiskey', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local whiskey = Ply.Functions.GetItemByName("vu_whiskeyshot")
    local whiskeyglass = Ply.Functions.GetItemByName("vu_whiskeyglass")
    local umbrella = Ply.Functions.GetItemByName("vu_umbrella")
    local ice = Ply.Functions.GetItemByName("vu_ice")
    if whiskey ~= nil and whiskeyglass ~= nil and umbrella ~= nil and ice ~= nil then
        if whiskey.amount >= 2 and whiskeyglass.amount >= 1 and umbrella.amount >= 1 and ice.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientPeanut', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local servingdish = Ply.Functions.GetItemByName("vu_servingdish")
    local peanutpacket = Ply.Functions.GetItemByName("vu_peanutpacket")
    if servingdish ~= nil and peanutpacket ~= nil then
        if peanutpacket.amount >= 2 and servingdish.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientJager', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local redgull = Ply.Functions.GetItemByName("vu_redgull")
    local shotglass = Ply.Functions.GetItemByName("vu_shotglass")
    local jager = Ply.Functions.GetItemByName("vu_jager")
    if redgull ~= nil and shotglass ~= nil and jager ~= nil then
        if redgull.amount >= 1 and shotglass.amount >= 1 and jager.amount >= 1 then 
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientSourz', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local shotglass = Ply.Functions.GetItemByName("vu_shotglass")
    local sourzmix = Ply.Functions.GetItemByName("vu_sourzmix")
    if shotglass ~= nil and sourzmix ~= nil then
        if shotglass.amount >= 1 and sourzmix.amount >= 1 then
            cb(true)
        else 
            cb(false)
        end
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('qb-vu:server:get:ingredientdontstopdrinking', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local peanuts = Ply.Functions.GetItemByName("vu_peanuts")
    local whiskey = Ply.Functions.GetItemByName("vu_whiskey")
    local cocktail = Ply.Functions.GetItemByName("vu_cocktail")
    if peanuts ~= nil and whiskey ~= nil and cocktail ~= nil then
        if cocktail.amount >= 3 and whiskey.amount >= 3 and peanuts.amount >= 2 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)


QBCore.Functions.CreateUseableItem("vu-dontstopdrinking", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-vu:MurderMeal", source, item.name)
end)

QBCore.Functions.CreateUseableItem("vu-icepacket", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-vu:icePacket", source, item.name)
end)

