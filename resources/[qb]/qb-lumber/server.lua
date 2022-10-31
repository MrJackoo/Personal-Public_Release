local QBCore = exports['qb-core']:GetCoreObject()

-- Chopping
RegisterServerEvent("qb-lumber:server:woodchop", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local wood = math.random(2,5)
    Player.Functions.AddItem("wood", wood)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wood'], "add")
end)

-- Wood
RegisterServerEvent('qb-lumber:server:processWood', function(wood)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local logs = Player.Functions.GetItemByName('wood')
    local woodNumber = tonumber(wood)
    if not tonumber(wood) then return end
    if logs ~= nil and woodNumber > 0 then
        if logs.amount >= woodNumber then
            TriggerClientEvent("qb-lumber:client:processWood", src, woodNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')
    end
end)

RegisterServerEvent('qb-lumber:server:Wood', function(woodNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local logs = Player.Functions.GetItemByName("wood")
    local woodNumber = tonumber(woodNumber)
    local Rewardchance = math.random(1,100)
    local BigReward = math.random(1,100)
    
	if Player.PlayerData.items ~= nil then 
        if logs ~= nil then
            if logs.amount >= woodNumber then 
                Player.Functions.RemoveItem("wood", woodNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wood'], "remove")
                
                if Rewardchance <= 50 then
                    Player.Functions.AddItem("lumber", math.random(2,4) * woodNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lumber'], "add")
                else
                    Player.Functions.AddItem("lumber", math.random(1,2) * woodNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lumber'], "add")
                end
            
                if BigReward >= 50 then
                    Player.Functions.AddItem("thatch", math.random(2,4) * woodNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thatch'], "add")
                else
                    Player.Functions.AddItem("thatch", math.random(1,2) * woodNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['thatch'], "add")
                end

            end
        end
	end
end)

-- Charcoal
RegisterServerEvent('qb-lumber:server:processCharcoal', function(charcoal)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local logs = Player.Functions.GetItemByName('wood')
    local charcoalNumber = tonumber(charcoal)
    if not tonumber(charcoal) then return end
    if logs ~= nil and charcoalNumber > 0 then
        if logs.amount >= charcoalNumber then
            TriggerClientEvent("qb-lumber:client:processCharcoal", src, charcoalNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')
    end
end)

RegisterServerEvent('qb-lumber:server:Charcoal', function(charcoalNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local logs = Player.Functions.GetItemByName("wood")
    local charcoalNumber = tonumber(charcoalNumber)
    local Rewardchance = math.random(1,100)
    local BigReward = math.random(1,100)
    
	if Player.PlayerData.items ~= nil then 
        if logs ~= nil then
            if logs.amount >= charcoalNumber then 
                Player.Functions.RemoveItem("wood", charcoalNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wood'], "remove")
                
                if Rewardchance <= 50 then
                    Player.Functions.AddItem("charcoal", math.random(2,4) * charcoalNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['charcoal'], "add")
                else
                    Player.Functions.AddItem("charcoal", math.random(1,2) * charcoalNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['charcoal'], "add")
                end
            
                if BigReward >= 50 then
                    Player.Functions.AddItem("charcoal", math.random(2,3) * charcoalNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['charcoal'], "add")
                end

            end
        end
	end
end)