local QBCore = exports['qb-core']:GetCoreObject()
local timer = Config.WaitTime * 60 * 1000

RegisterServerEvent('qb-dumpster:server:startDumpsterTimer')
AddEventHandler('qb-dumpster:server:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('qb-dumpster:server:giveDumpsterReward')
AddEventHandler('qb-dumpster:server:giveDumpsterReward', function()
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local itemType = math.random(#Config.RewardTypes)
    local WeaponChance = math.random(1, 500)
    local odd1 = math.random(1, 50)
    local tierChance = math.random(1, 100)
    local tier = 1

    if tierChance < 25 then 
            tier = 1 
        elseif tierChance >= 15 and tierChance < 40 then 
            tier = 2 
        elseif tierChance >= 40 and tierChance < 50 then 
            tier = 3 
        elseif tierChance >= 50 and tierChance < 60 then 
            tier = 4
        elseif tierChance >= 60 and tierChance < 70 then 
            tier = 5
        elseif tierChance >= 70 and tierChance < 80 then 
            tier = 6
        elseif tierChance >= 80 and tierChance < 90 then 
            tier = 7
        elseif tierChance >= 90 and tierChance < 96 then 
            tier = 8
        elseif tierChance >= 96 and tierChance < 98 then 
            tier = 9
        else
            tier = 10
        end
        
    if WeaponChance ~= odd1 then
        if tier ~= 10 then
             if Config.RewardTypes[itemType].type == "item" then
                
                 local item = Config.DumpsterRewards["tier"..tier][math.random(#Config.DumpsterRewards["tier"..tier])]
                 
                 local itemAmount = math.random(item.minAmount, item.maxAmount)
                 
                 ply.Functions.AddItem(item.item, itemAmount)
                 
                 TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                 
             elseif Config.RewardTypes[itemType].type == "money" then
                local info = {
                    worth = math.random(50, 100)
                }
                
                ply.Functions.AddItem('empty_weed_bag', math.random(1,3), false, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['empty_weed_bag'], "add")
            end
        end
    end
end)

function startTimer(id, object)
    Citizen.CreateThread(function()
        Citizen.Wait(timer)
        TriggerClientEvent('qb-dumpster:server:startDumpsterTimer', id, object)
    end)
end