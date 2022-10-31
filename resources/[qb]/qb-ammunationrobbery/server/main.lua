local QBCore = exports['qb-core']:GetCoreObject()
local alarmTriggered = false

-- Callbacks
QBCore.Functions.CreateCallback('qb-ammunationrobbery:server:getCops', function(source, cb)
	local cops = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                cops = cops + 1
            end
        end
	end
	cb(cops)
end)

-- Events
RegisterServerEvent('qb-ammunationrobbery:server:LoadLocationList', function()
    local src = source 
    TriggerClientEvent("qb-ammunationrobbery:server:LoadLocationList", src, Config.Locations)
end)

RegisterServerEvent('qb-ammunationrobbery:server:itemReward', function(spot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}

    local giveallchance = math.random(1,100)
    local giveall = false

    if giveallchance >= 95 then
        giveall = true
    end

    if giveall then
        print("player got rng lucky and won all items")
        for k,v in ipairs(Config.Locations["takeables"][spot].reward) do
            if Player.Functions.AddItem(v.item, v.amount, info) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, 'You have to much in your pocket ..', 'error')
            end
        end
    else
        local numofrewards = #(Config.Locations["takeables"][spot].reward)
        
        if numofrewards <= 1 then
            print("only 1 reward, Giving reward number 1")
            rewarditem = Config.Locations["takeables"][spot].reward[1]
            if Player.Functions.AddItem(rewarditem.item, rewarditem.amount, info) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[rewarditem.item], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, 'You have to much in your pocket ..', 'error')
            end
        else
            print("giving random item")
            local numbertogive = math.random(1,numofrewards)
            rewarditem = Config.Locations["takeables"][spot].reward[numbertogive]

            if rewarditem.rare then
                print("random item is rare, doing chance check")
                local chance = math.random(1,100)
                if chance >= 70 then
                    print("giving rare item", rewarditem.item)
                    rewarditem = rewarditem
                else
                    local badrewards = {}
                    print("failed rare item check rerolling")
                    for k,v in pairs(Config.Locations["takeables"][spot].reward) do
                        if v.rare == false then
                            table.insert(badrewards, v)
                            print("inserting into table: ", json.encode(v))
                        end
                    end
                    print("selecting item")
                    local numbertogive = math.random(1,#badrewards)
                    rewarditem = badrewards[numbertogive]
                    print("item selected and giving player: ", rewarditem.item)
                end
            end

            if Player.Functions.AddItem(rewarditem.item, rewarditem.amount, info) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[rewarditem.item], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, 'You have to much in your pocket ..', 'error')
            end
        end
    end
end)

RegisterServerEvent('qb-ammunationrobbery:server:setSpotState', function(stateType, state, spot)
    if stateType == "isBusy" then
        Config.Locations["takeables"][spot].isBusy = state
    elseif stateType == "isDone" then
        Config.Locations["takeables"][spot].isDone = state
    end
    --TriggerEvent('qb-scoreboard:server:SetActivityBusy', "ammunation", true)
    TriggerClientEvent('qb-ammunationrobbery:client:setSpotState', -1, stateType, state, spot)
end)

RegisterServerEvent("particleserver", function(method)
    TriggerClientEvent("ptfxparticle", -1, method)
end)

QBCore.Functions.CreateUseableItem("laptop4", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-ammunationrobbery:client:UseBlueLaptop", source, item)
end)