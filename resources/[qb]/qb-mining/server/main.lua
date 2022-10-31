local QBCore = exports['qb-core']:GetCoreObject()

-- Mine
RegisterServerEvent('qb-mining:server:mine', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local qty = math.random(1,3)
    Player.Functions.AddItem('rock', qty)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rock'], 'add')
end)

-- Rocks
RegisterServerEvent('qb-mining:server:processRocks', function(rocks)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local rock = Player.Functions.GetItemByName('rock')
    local rocksNumber = tonumber(rocks)
    if not tonumber(rocks) then return end
    if rock ~= nil and rocksNumber > 0 then
        if rock.amount >= rocksNumber then
            TriggerClientEvent('qb-mining:client:processRocks', src, rocksNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:washRocks', function(rocksNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local rock = Player.Functions.GetItemByName('rock')
    local rocksNumber = tonumber(rocksNumber)
    local Rewardchance = math.random(1,100)
    local BigReward = math.random(1,100)
    
	if Player.PlayerData.items ~= nil then 
        if rock ~= nil then
            if rock.amount >= rocksNumber then 
                Player.Functions.RemoveItem('rock', rocksNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rock'], 'remove')
                
                if Rewardchance <= 50 then
                    Player.Functions.AddItem('oxide', math.random(1,2) * rocksNumber)
                    Player.Functions.AddItem('sulfur', math.random(1,2) * rocksNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['oxide'], 'add')
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['sulfur'], 'add')
                else
                    Player.Functions.AddItem('carbonate_ore', math.random(1,2) * rocksNumber)
                    Player.Functions.AddItem('oxide', 1 * rocksNumber)
                    Player.Functions.AddItem('sulfur', 1 * rocksNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['oxide'], 'add')
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['sulfur'], 'add')
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['carbonate_ore'], 'add')
                end
            
                if BigReward >= 50 then
                    Player.Functions.AddItem('sulphide', math.random(1,2) * rocksNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['sulphide'], 'add')
                end
                
            end
        end
	end
end)

-- Carbonate Ore
RegisterServerEvent('qb-mining:server:processCarbonate', function(carbonate)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local ore = Player.Functions.GetItemByName('carbonate_ore')
    local carbonateNumber = tonumber(carbonate)
    if not tonumber(carbonate) then return end
    if ore ~= nil and carbonateNumber > 0 then
        if ore.amount >= carbonateNumber then
            TriggerClientEvent('qb-mining:client:processCarbonate', src, carbonateNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:CarbonateOre', function(carbonateNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local ore = Player.Functions.GetItemByName('carbonate_ore')
    local carbonateNumber = tonumber(carbonateNumber)
    local Rewardchance = math.random(1,100)
    local BigReward = math.random(1,100)
    
	if Player.PlayerData.items ~= nil then
        if ore ~= nil then
            if ore.amount >= carbonateNumber then 
                Player.Functions.RemoveItem('carbonate_ore', carbonateNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['carbonate_ore'], 'remove')
                
                if Rewardchance <= 50 then
                    Player.Functions.AddItem('iron', math.random(1,2) * carbonateNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['iron'], 'add')
                else
                    Player.Functions.AddItem('metalscrap', math.random(1,2) * carbonateNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['metalscrap'], 'add')
                end
            
                if BigReward >= 50 then
                    Player.Functions.AddItem('steel', math.random(1,2) * carbonateNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['steel'], 'add')
                else
                    Player.Functions.AddItem('aluminum', math.random(1,2) * carbonateNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['aluminum'], 'add')
                end
            end
        end
	end
end)

--Oxide
RegisterServerEvent('qb-mining:server:processOxide', function(oxide)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local oxides = Player.Functions.GetItemByName('oxide')
    local oxideNumber = tonumber(oxide)
    if not tonumber(oxide) then return end
    if oxides ~= nil and oxideNumber > 0 then
        if oxides.amount >= oxideNumber then
            TriggerClientEvent('qb-mining:client:processOxide', src, oxideNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Oxide', function(oxideNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local oxides = Player.Functions.GetItemByName('oxide')
    local oxideNumber = tonumber(oxideNumber)
    local Rewardchance = math.random(1,100)
    local BigReward = math.random(1,100)
    
	if Player.PlayerData.items ~= nil then 
        if oxides ~= nil then
            if oxides.amount >= oxideNumber then 
                Player.Functions.RemoveItem('oxide', oxideNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['oxide'], 'remove')
                
                if Rewardchance <= 50 then
                    Player.Functions.AddItem('ironoxide', math.random(1,2) * oxideNumber)
                    Player.Functions.AddItem('copperoxide', 1 * oxideNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'add')
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copperoxide'], 'add')
                else
                    Player.Functions.AddItem('copperoxide', math.random(2,4)* oxideNumber)
                    Player.Functions.AddItem('ironoxide', 1 * oxideNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'add')
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copperoxide'], 'add')
                end
            
                if BigReward >= 50 then
                    Player.Functions.AddItem('aluminumoxide', math.random(1,2) * oxideNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['aluminumoxide'], 'add')
                end
                
            end
        end
	end
end)

-- Sulphide
RegisterServerEvent('qb-mining:server:processSulphide', function(sulphide)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local sulphides = Player.Functions.GetItemByName('sulphide')
    local sulphideNumber = tonumber(sulphide)
    if not tonumber(sulphide) then return end
    if sulphides ~= nil and sulphideNumber > 0 then
        if sulphides.amount >= sulphideNumber then
            TriggerClientEvent('qb-mining:client:processSulphide', src, sulphideNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Sulphide', function(sulphideNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local sulphides = Player.Functions.GetItemByName('sulphide')
    local sulphideNumber = tonumber(sulphideNumber)
    local Rewardchance = math.random(1,100)
    local BigReward = math.random(1,100)
    
	if Player.PlayerData.items ~= nil then 
        if sulphides ~= nil then
            if sulphides.amount >= sulphideNumber then 
                Player.Functions.RemoveItem('sulphide', sulphideNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['sulphide'], 'remove')
                
                if Rewardchance <= 50 then
                    Player.Functions.AddItem('copper', math.random(1,2) * sulphideNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copper'], 'add')
                else
                    Player.Functions.AddItem('lead', math.random(1,2) * sulphideNumber)
                    Player.Functions.AddItem('copper', 1 * sulphideNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copper'], 'add')
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lead'], 'add')
                end
            
                if BigReward >= 50 then
                    Player.Functions.AddItem('zinc', 2 * sulphideNumber)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['zinc'], 'add')
                end
                   
            end
        end
	end
end)

-- Harden Steel
RegisterServerEvent('qb-mining:server:processSteel', function(steel)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local steels = Player.Functions.GetItemByName('steel')
    local irons = Player.Functions.GetItemByName('iron')
    local steelNumber = tonumber(steel)
    if not tonumber(steel) then return end
    if (steels ~= nil and irons ~= nil and steelNumber > 0) then
        if steels.amount >= steelNumber * 2 and irons.amount >= steelNumber * 2 then 
            TriggerClientEvent('qb-mining:client:processSteel', src, steelNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Steel', function(steelNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local steels = Player.Functions.GetItemByName('steel')
    local irons = Player.Functions.GetItemByName('iron')
    local bonus = 1
    local Rewardchance = math.random(1,100)

    if Rewardchance > 70 then 
        bonus = 2
    end

	if Player.PlayerData.items ~= nil then 
        if (steels ~= nil and irons ~= nil and steelNumber > 0) then
            if steels.amount >= steelNumber * 2 and irons.amount >= steelNumber * 2 then 
                
                Player.Functions.RemoveItem('steel', 2 * steelNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['steel'], 'remove')
                Player.Functions.RemoveItem('iron', 2 * steelNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['iron'], 'remove')
            
                Player.Functions.AddItem('hardened_steel', 1 * steelNumber * bonus)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['hardened_steel'], 'add')
                   
            end
        end
	end
end)

-- Reinforced Aluminium
RegisterServerEvent('qb-mining:server:processAluminium', function(aluminium)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local aluminiums = Player.Functions.GetItemByName('aluminum')
    local aluminiumoxides = Player.Functions.GetItemByName('aluminumoxide')
    local aluminiumNumber = tonumber(aluminium)
    if not tonumber(aluminium) then return end
    if (aluminiums ~= nil and aluminiumoxides ~= nil and aluminiumNumber > 0) then
        if aluminiums.amount >= aluminiumNumber * 2 and aluminiumoxides.amount >= aluminiumNumber * 2 then 
            TriggerClientEvent('qb-mining:client:processAluminium', src, aluminiumNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Aluminium', function(aluminiumNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local aluminiums = Player.Functions.GetItemByName('aluminum')
    local aluminiumoxides = Player.Functions.GetItemByName('aluminumoxide')
    local bonus = 1
    local Rewardchance = math.random(1,100)

    if Rewardchance > 70 then 
        bonus = 2
    end

	if Player.PlayerData.items ~= nil then 
        if (aluminiums ~= nil and aluminiumoxides ~= nil and aluminiumNumber > 0) then
            if aluminiums.amount >= aluminiumNumber * 2 and aluminiumoxides.amount >= aluminiumNumber * 2 then 
                
                Player.Functions.RemoveItem('aluminum', 2 * aluminiumNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['aluminum'], 'remove')
                Player.Functions.RemoveItem('aluminumoxide', 2 * aluminiumNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['aluminumoxide'], 'remove')
            
                Player.Functions.AddItem('reinforced_aluminum', 1 * aluminiumNumber * bonus)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['reinforced_aluminum'], 'add')
                   
            end
        end
	end
end)

-- Reinforced Metal
RegisterServerEvent('qb-mining:server:processMetal', function(metal)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local irons = Player.Functions.GetItemByName('iron')
    local metalscraps = Player.Functions.GetItemByName('metalscrap')
    local metalNumber = tonumber(metal)
    if not tonumber(metal) then return end
    if (irons ~= nil and metalscraps ~= nil and metalNumber > 0) then
        if irons.amount >= metalNumber * 2 and metalscraps.amount >= metalNumber * 2 then 
            TriggerClientEvent('qb-mining:client:processMetal', src, metalNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Metal', function(metalNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local irons = Player.Functions.GetItemByName('iron')
    local metalscraps = Player.Functions.GetItemByName('metalscrap')
    local bonus = 1
    local Rewardchance = math.random(1,100)

    if Rewardchance > 70 then 
        bonus = 2
    end

	if Player.PlayerData.items ~= nil then 
        if (irons ~= nil and metalscraps ~= nil and metalNumber > 0) then
            if irons.amount >= metalNumber * 2 and metalscraps.amount >= metalNumber * 2 then 
                
                Player.Functions.RemoveItem('iron', 2 * metalNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['iron'], 'remove')
                Player.Functions.RemoveItem('metalscrap', 2 * metalNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['metalscrap'], 'remove')
            
                Player.Functions.AddItem('reinforced_metal', 1 * metalNumber * 2)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['reinforced_metal'], 'add')
                   
            end
        end
	end
end)

-- Refined Copper
RegisterServerEvent('qb-mining:server:processCopper', function(copper)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local coppers = Player.Functions.GetItemByName('copper')
    local copperoxides = Player.Functions.GetItemByName('copperoxide')
    local copperNumber = tonumber(copper)
    if not tonumber(copper) then return end
    if (coppers ~= nil and copperoxides ~= nil and copperNumber > 0) then
        if coppers.amount >= copperNumber * 2 and copperoxides.amount >= copperNumber * 2 then 
            TriggerClientEvent('qb-mining:client:processCopper', src, copperNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Copper', function(copperNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local coppers = Player.Functions.GetItemByName('copper')
    local copperoxides = Player.Functions.GetItemByName('copperoxide')
    local bonus = 1
    local Rewardchance = math.random(1,100)

    if Rewardchance > 70 then 
        bonus = 2
    end

	if Player.PlayerData.items ~= nil then 
        if (coppers ~= nil and copperoxides ~= nil and copperNumber > 0) then
            if coppers.amount >= copperNumber * 2 and copperoxides.amount >= copperNumber * 2 then 
                
                Player.Functions.RemoveItem('copper', 2 * copperNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copper'], 'remove')
                Player.Functions.RemoveItem('copperoxide', 2 * copperNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copperoxide'], 'remove')
            
                Player.Functions.AddItem('refined_copper', 1 * copperNumber * bonus)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['refined_copper'], 'add')
                   
            end
        end
	end
end)

-- Refined lead
RegisterServerEvent('qb-mining:server:processLead', function(lead)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local leads = Player.Functions.GetItemByName('lead')
    local ironoxides = Player.Functions.GetItemByName('ironoxide')
    local leadNumber = tonumber(lead)
    if not tonumber(lead) then return end
    if (leads ~= nil and ironoxides ~= nil and leadNumber > 0) then
        if leads.amount >= leadNumber * 2 and ironoxides.amount >= leadNumber * 2 then 
            TriggerClientEvent('qb-mining:client:processLead', src, leadNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Lead', function(leadNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local leads = Player.Functions.GetItemByName('lead')
    local ironoxides = Player.Functions.GetItemByName('ironoxide')
    local bonus = 1
    local Rewardchance = math.random(1,100)

    if Rewardchance > 70 then 
        bonus = 2
    end

	if Player.PlayerData.items ~= nil then 
        if (leads ~= nil and ironoxides ~= nil and leadNumber > 0) then
            if leads.amount >= leadNumber * 2 and ironoxides.amount >= leadNumber * 2 then 
                
                Player.Functions.RemoveItem('lead', 2 * leadNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lead'], 'remove')
                Player.Functions.RemoveItem('ironoxide', 2 * leadNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'remove')
            
                Player.Functions.AddItem('refined_lead', 1 * leadNumber * bonus)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['refined_lead'], 'add')
                   
            end
        end
	end
end)

-- Refined Zinc
RegisterServerEvent('qb-mining:server:processZinc', function(zinc)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local zincs = Player.Functions.GetItemByName('zinc')
    local ironoxides = Player.Functions.GetItemByName('ironoxide')
    local zincNumber = tonumber(zinc)
    if not tonumber(zinc) then return end
    if (zincs ~= nil and ironoxides ~= nil and zincNumber > 0) then
        if zincs.amount >= zincNumber * 2 and ironoxides.amount >= zincNumber * 2 then 
            TriggerClientEvent('qb-mining:client:processZinc', src, zincNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:Zinc', function(zincNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local zincs = Player.Functions.GetItemByName('zinc')
    local ironoxides = Player.Functions.GetItemByName('ironoxide')
    local bonus = 1
    local Rewardchance = math.random(1,100)

    if Rewardchance > 70 then 
        bonus = 2
    end

	if Player.PlayerData.items ~= nil then 
        if (zincs ~= nil and ironoxides ~= nil and zincNumber > 0) then
            if zincs.amount >= zincNumber * 2 and ironoxides.amount >= zincNumber * 2 then 
                
                Player.Functions.RemoveItem('zinc', 2 * zincNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['zinc'], 'remove')
                Player.Functions.RemoveItem('ironoxide', 2 * zincNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'remove')
            
                Player.Functions.AddItem('refined_zinc', 1 * zincNumber * bonus)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['refined_zinc'], 'add')
                   
            end
        end
	end
end)

-- Weapons Grade

-- WG Aluminium
RegisterServerEvent('qb-mining:server:processWGAluminium', function(wgaluminium)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local raluminium = Player.Functions.GetItemByName('reinforced_aluminum')
    local aluminumoxide = Player.Functions.GetItemByName('aluminumoxide')
    local wgaluminiumNumber = tonumber(wgaluminium)
    
    if not tonumber(wgaluminium) then return end
    
    if (raluminium ~= nil and aluminumoxide ~= nil and wgaluminiumNumber > 0) then
        if raluminium.amount >= wgaluminiumNumber * 10 and aluminumoxide.amount >= wgaluminiumNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGAluminium', src, wgaluminiumNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGAluminium', function(wgaluminiumNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local raluminium = Player.Functions.GetItemByName('reinforced_aluminum')
    local aluminumoxide = Player.Functions.GetItemByName('aluminumoxide')
    
	if Player.PlayerData.items ~= nil then 
        if (raluminium ~= nil and aluminumoxide ~= nil and wgaluminiumNumber > 0) then
            if raluminium.amount >= wgaluminiumNumber * 10 and aluminumoxide.amount >= wgaluminiumNumber * 10 then 
                
                Player.Functions.RemoveItem('reinforced_aluminum', 10 * wgaluminiumNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['reinforced_aluminum'], 'remove')
                Player.Functions.RemoveItem('aluminumoxide', 10 * wgaluminiumNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['aluminumoxide'], 'remove')
            
                Player.Functions.AddItem('wg_aluminium', 1 * wgaluminiumNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_aluminium'], 'add')
                   
            end
        end
	end
end)

-- WG Brass
RegisterServerEvent('qb-mining:server:processWGBrass', function(wgbrass)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local rcopper = Player.Functions.GetItemByName('refined_copper')
    local rzinc = Player.Functions.GetItemByName('refined_zinc')
    local wgbrassNumber = tonumber(wgbrass)
    
    if not tonumber(wgbrass) then return end
    
    if (rcopper ~= nil and rzinc ~= nil and wgbrassNumber > 0) then
        if rcopper.amount >= wgbrassNumber * 1 and rzinc.amount >= wgbrassNumber * 1 then 
            TriggerClientEvent('qb-mining:client:processWGBrass', src, wgbrassNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGBrass', function(wgbrassNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local rcopper = Player.Functions.GetItemByName('refined_copper')
    local rzinc = Player.Functions.GetItemByName('refined_zinc')
    
	if Player.PlayerData.items ~= nil then 
        if (rcopper ~= nil and rzinc ~= nil and wgbrassNumber > 0) then
            if rcopper.amount >= wgbrassNumber * 1 and rzinc.amount >= wgbrassNumber * 1 then 
                
                Player.Functions.RemoveItem('refined_copper', 1 * wgbrassNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['refined_copper'], 'remove')
                Player.Functions.RemoveItem('refined_zinc', 1 * wgbrassNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['refined_zinc'], 'remove')
            
                Player.Functions.AddItem('wg_brass', 1 * wgbrassNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_brass'], 'add')
                   
            end
        end
	end
end)

-- WG Lead
RegisterServerEvent('qb-mining:server:processWGLead', function(wglead)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local rlead = Player.Functions.GetItemByName('refined_lead')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
    local wgleadNumber = tonumber(wglead)
    
    if not tonumber(wglead) then return end
    
    if (rlead ~= nil and ironoxide ~= nil and wgleadNumber > 0) then
        if rlead.amount >= wgleadNumber * 10 and ironoxide.amount >= wgleadNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGLead', src, wgleadNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGLead', function(wgleadNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local rlead = Player.Functions.GetItemByName('refined_lead')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
    
	if Player.PlayerData.items ~= nil then 
        if (rlead ~= nil and ironoxide ~= nil and wgleadNumber > 0) then
            if rlead.amount >= wgleadNumber * 10 and ironoxide.amount >= wgleadNumber * 10 then 
                
                Player.Functions.RemoveItem('refined_lead', 10 * wgleadNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['refined_lead'], 'remove')
                Player.Functions.RemoveItem('ironoxide', 10 * wgleadNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'remove')
            
                Player.Functions.AddItem('wg_lead', 1 * wgleadNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_lead'], 'add')
                   
            end
        end
	end
end)

-- WG Metal
RegisterServerEvent('qb-mining:server:processWGMetal', function(wgmetal)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local rmetal = Player.Functions.GetItemByName('reinforced_metal')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
    local wgmetalNumber = tonumber(wgmetal)
    
    if not tonumber(wgmetal) then return end
    
    if (rmetal ~= nil and ironoxide ~= nil and wgmetalNumber > 0) then
        if rmetal.amount >= wgmetalNumber * 10 and ironoxide.amount >= wgmetalNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGMetal', src, wgmetalNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGMetal', function(wgmetalNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local rmetal = Player.Functions.GetItemByName('reinforced_metal')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
	if Player.PlayerData.items ~= nil then 
        if (rmetal ~= nil and ironoxide ~= nil and wgmetalNumber > 0) then
            if rmetal.amount >= wgmetalNumber * 10 and ironoxide.amount >= wgmetalNumber * 10 then 
                
                Player.Functions.RemoveItem('reinforced_metal', 10 * wgmetalNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['reinforced_metal'], 'remove')
                Player.Functions.RemoveItem('ironoxide', 10 * wgmetalNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'remove')
            
                Player.Functions.AddItem('wg_metal', 1 * wgmetalNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_metal'], 'add')
                   
            end
        end
	end
end)

-- WG Plastic
RegisterServerEvent('qb-mining:server:processWGPlastic', function(wgplastic)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local plastic = Player.Functions.GetItemByName('plastic')
    local copperoxide = Player.Functions.GetItemByName('copperoxide')
    local wgplasticNumber = tonumber(wgplastic)
    
    if not tonumber(wgplastic) then return end
    
    if (plastic ~= nil and copperoxide ~= nil and wgplasticNumber > 0) then
        if plastic.amount >= wgplasticNumber * 10 and copperoxide.amount >= wgplasticNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGPlastic', src, wgplasticNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGPlastic', function(wgplasticNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local plastic = Player.Functions.GetItemByName('plastic')
    local copperoxide = Player.Functions.GetItemByName('copperoxide')
	if Player.PlayerData.items ~= nil then 
        if (plastic ~= nil and copperoxide ~= nil and wgplasticNumber > 0) then
            if plastic.amount >= wgplasticNumber * 10 and copperoxide.amount >= wgplasticNumber * 10 then 
                
                Player.Functions.RemoveItem('plastic', 10 * wgplasticNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['plastic'], 'remove')
                Player.Functions.RemoveItem('copperoxide', 10 * wgplasticNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copperoxide'], 'remove')
            
                Player.Functions.AddItem('wg_plastic', 1 * wgplasticNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_plastic'], 'add')
                   
            end
        end
	end
end)

-- WG Rubber
RegisterServerEvent('qb-mining:server:processWGRubber', function(wgrubber)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local rubber = Player.Functions.GetItemByName('rubber')
    local copperoxide = Player.Functions.GetItemByName('copperoxide')
    local wgrubberNumber = tonumber(wgrubber)
    
    if not tonumber(wgrubber) then return end
    
    if (rubber ~= nil and copperoxide ~= nil and wgrubberNumber > 0) then
        if rubber.amount >= wgrubberNumber * 10 and copperoxide.amount >= wgrubberNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGRubber', src, wgrubberNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGRubber', function(wgrubberNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local rubber = Player.Functions.GetItemByName('rubber')
    local copperoxide = Player.Functions.GetItemByName('copperoxide')
	if Player.PlayerData.items ~= nil then 
        if (rubber ~= nil and copperoxide ~= nil and wgrubberNumber > 0) then
            if rubber.amount >= wgrubberNumber * 10 and copperoxide.amount >= wgrubberNumber * 10 then 
                
                Player.Functions.RemoveItem('rubber', 10 * wgrubberNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rubber'], 'remove')
                Player.Functions.RemoveItem('copperoxide', 10 * wgrubberNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copperoxide'], 'remove')
            
                Player.Functions.AddItem('wg_rubber', 1 * wgrubberNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_rubber'], 'add')
                   
            end
        end
	end
end)

-- WG Steel
RegisterServerEvent('qb-mining:server:processWGSteel', function(wgsteel)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local hsteel = Player.Functions.GetItemByName('hardened_steel')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
    local wgsteelNumber = tonumber(wgsteel)

    if not tonumber(wgsteel) then return end
    
    if (hsteel ~= nil and ironoxide ~= nil and wgsteelNumber > 0) then
        if hsteel.amount >= wgsteelNumber * 10 and ironoxide.amount >= wgsteelNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGSteel', src, wgsteelNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGSteel', function(wgsteelNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local hsteel = Player.Functions.GetItemByName('hardened_steel')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
	if Player.PlayerData.items ~= nil then 
        if (hsteel ~= nil and ironoxide ~= nil and wgsteelNumber > 0) then
            if hsteel.amount >= wgsteelNumber * 10 and ironoxide.amount >= wgsteelNumber * 10 then 
                
                Player.Functions.RemoveItem('hardened_steel', 10 * wgsteelNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['hardened_steel'], 'remove')
                Player.Functions.RemoveItem('ironoxide', 10 * wgsteelNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'remove')
            
                Player.Functions.AddItem('wg_steel', 1 * wgsteelNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_steel'], 'add')
                   
            end
        end
	end
end)

-- WG Wood
RegisterServerEvent('qb-mining:server:processWGWood', function(wgwood)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local lumber = Player.Functions.GetItemByName('lumber')
    local wood = Player.Functions.GetItemByName('wood')
    local wgwoodNumber = tonumber(wgwood)
    
    if not tonumber(wgwood) then return end
    
    if (lumber ~= nil and wood ~= nil and wgwoodNumber > 0) then
        if lumber.amount >= wgwoodNumber * 10 and wood.amount >= wgwoodNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGWood', src, wgwoodNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGWood', function(wgwoodNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local lumber = Player.Functions.GetItemByName('lumber')
    local wood = Player.Functions.GetItemByName('wood')
    
	if Player.PlayerData.items ~= nil then 
        if (lumber ~= nil and wood ~= nil and wgwoodNumber > 0) then
            if lumber.amount >= wgwoodNumber * 10 and wood.amount >= wgwoodNumber * 10 then 
                
                Player.Functions.RemoveItem('lumber', 10 * wgwoodNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lumber'], 'remove')
                Player.Functions.RemoveItem('wood', 10 * wgwoodNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wood'], 'remove')
            
                Player.Functions.AddItem('wg_wood', 1 * wgwoodNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_wood'], 'add')
                   
            end
        end
	end
end)

-- WG Zinc
RegisterServerEvent('qb-mining:server:processWGZinc', function(wgzinc)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local rzinc = Player.Functions.GetItemByName('refined_zinc')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
    local wgzincNumber = tonumber(wgzinc)
    
    if not tonumber(wgzinc) then return end
    
    if (rzinc ~= nil and ironoxide ~= nil and wgzincNumber > 0) then
        if rzinc.amount >= wgzincNumber * 10 and ironoxide.amount >= wgzincNumber * 10 then 
            TriggerClientEvent('qb-mining:client:processWGZinc', src, wgzincNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-mining:server:WGZinc', function(wgzincNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local rzinc = Player.Functions.GetItemByName('refined_zinc')
    local ironoxide = Player.Functions.GetItemByName('ironoxide')
    
	if Player.PlayerData.items ~= nil then 
        if (rzinc ~= nil and ironoxide ~= nil and wgzincNumber > 0) then
            if rzinc.amount >= wgzincNumber * 10 and ironoxide.amount >= wgzincNumber * 10 then 
                
                Player.Functions.RemoveItem('refined_zinc', 10 * wgzincNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['refined_zinc'], 'remove')
                Player.Functions.RemoveItem('ironoxide', 10 * wgzincNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ironoxide'], 'remove')
            
                Player.Functions.AddItem('wg_zinc', 1 * wgzincNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wg_zinc'], 'add')
                   
            end
        end
	end
end)












