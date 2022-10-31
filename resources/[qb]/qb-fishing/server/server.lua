local QBCore = exports['qb-core']:GetCoreObject()
--============================================================================ Items

-- QBCore.Functions.CreateUseableItem("anchor", function(source, item)
--     local Player = QBCore.Functions.GetPlayer(source)
-- 	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
-- 		TriggerClientEvent('fishing:client:anchor', source)
--     end
-- end)

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
 		TriggerClientEvent('fishing:fishstart', source)
    end
end)

-- QBCore.Functions.CreateUseableItem("fishicebox", function(source, item)
--     local Player = QBCore.Functions.GetPlayer(source)
-- 	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
-- 		TriggerClientEvent('fishing:client:useFishingBox', source, item.info.boxid)  
--     end
-- end)

QBCore.Functions.CreateUseableItem("fishinglootbig", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		TriggerClientEvent("fishing:client:attemptTreasureChest", src)
    end
end)

QBCore.Functions.CreateUseableItem("fishingloot", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		Player.Functions.RemoveItem("fishingloot", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "remove", 1)
		TriggerClientEvent('QBCore:Notify', src, "Opening Box", "primary")
		SetTimeout(1000, function()
			Player.Functions.AddItem('fishingkey', 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingkey'], "add", 1)

			Player.Functions.AddItem(Config.smallLootboxReward, 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.smallLootboxReward], "add", 1)

			Player.Functions.AddMoney('cash', Config.smallLootboxCash, 'FISHING: Fishing Loot Box')
			TriggerClientEvent('QBCore:Notify', src, "You found a couple items and £"..Config.smallLootboxCash, "success")
		end)
    end
end)

QBCore.Functions.CreateUseableItem("fishtacklebox", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		TriggerClientEvent('QBCore:Notify', src, "Opening Tackel Box", "success")
		Player.Functions.RemoveItem("fishtacklebox", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishtacklebox'], "remove", 1)
		SetTimeout(1250, function()
			Player.Functions.AddItem('pearlscard', 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['pearlscard'], "add", 1)
		end)
    end
end)

--============================================================================ Events

RegisterNetEvent('fishing:server:removeFishingBait', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('fishbait', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishbait'], "remove", 1)
end)

-- RegisterNetEvent("fishing:server:addTackleBox", function()
-- 	local src = source
-- 	local Player = QBCore.Functions.GetPlayer(src)
-- 	TriggerClientEvent('QBCore:Notify', src, "There seems to tackle box left over from another fisherman", "primary")
-- 	SetTimeout(1000, function()
-- 		Player.Functions.AddItem('fishtacklebox', 1, nil, {["quality"] = 100}) 
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishtacklebox'], "add", 1)
-- 	end)
-- end) 


RegisterNetEvent('fishing:server:catch', function() 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

    if itemFound then
        for i = 1, itemCount, 1 do
            if luck == 100 then --1
				-- local weight = math.random(850,1000)
				local info = {species = "Orca", type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 1)
				Player.Functions.AddItem('killerwhale', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['killerwhale'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a killer whale!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 97 and luck <= 100 then --1
				Player.Functions.AddItem('fishinglootbig', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishinglootbig'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a Treasure Chest!", "success")
			elseif luck >= 96 and luck <= 99 then --4
				local info = {species = "Bottlenose", type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 2)
				Player.Functions.AddItem('dolphin', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dolphin'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a dolphin!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 92 and luck <= 96 then --4
				local info = {species = "Hammerhead Shark", type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 3)
				Player.Functions.AddItem('sharkhammer', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharkhammer'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a hammerhead shark!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 88 and luck <= 92 then  --4
				local info = {species = "Tiger Shark", type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 4)
				Player.Functions.AddItem('sharktiger', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharktiger'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a tiger shark!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 82 and luck <= 88 then --6
				local info = {species = "Manta ray", type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 5)
				Player.Functions.AddItem('stingray', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stingray'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a Stingray!", "success")
			elseif luck >= 74 and luck <= 82 then --8
				local info = {species = "Flounder", type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('flounder', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['flounder'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a Flounder", "success")
			elseif luck >= 66 and luck <= 74 then --8
				Player.Functions.AddItem('fishingboot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingboot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a fishing boot!", "primary")
			elseif luck >= 58 and luck <= 66 then --8
				local info = {species = "Bass", type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('bass', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bass'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "you caught a Bass", "success")
			elseif luck >= 55 and luck <= 60 then --5
				Player.Functions.AddItem('fishingloot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a small box!", "success")
			elseif luck >= 47 and luck <= 55 then --8
				local info = {species = "Cod", type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('cod', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cod'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a Cod", "success")
			elseif luck >= 40 and luck <= 47 then --7
				Player.Functions.AddItem('fishingtin', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingtin'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a fishing tin!", "primary")
			elseif luck >= 5 and luck <= 40 then --35
				local info = {species = "Mackerel", type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('mackerel', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['mackerel'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a Mackerel", "success")
			elseif luck >= 43 and luck <= 46 then -- More Luck on tackle Boxes
				Player.Functions.AddItem('fishtacklebox', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishtacklebox'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "There seems to tackle box left over from another fisherman", "primary")
            end
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('fishing:server:SellillegalFish', function(args, amount)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	if args == 1 then 
		local dolphininv = Player.Functions.GetItemByName("dolphin")
		local inputdolphin = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (dolphininv ~= nil and inputdolphin > 0) then
			if dolphininv.amount >= inputdolphin then
				print(dolphininv)
				local payment = Config.dolphinPrice * inputdolphin
				Player.Functions.RemoveItem("dolphin", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Dolphin')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dolphin'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." Dolphin(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellillegalFish", src)
			else
				TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any illegal Fish to sell", "error")
			TriggerClientEvent("doj:client:SellillegalFish", src)
		end
	elseif args == 2 then 
		local sharktigerinv = Player.Functions.GetItemByName("sharktiger")
		local inputsharktiger = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (sharktigerinv ~= nil and inputsharktiger > 0) then
			if sharktigerinv.amount >= inputsharktiger then
				local payment = Config.sharktigerPrice * inputsharktiger
				Player.Functions.RemoveItem("sharktiger", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Tigershark')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharktiger'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." Tiger Shark(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellillegalFish", src)
			-- else
			-- 	TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any Tiger Sharks to sell", "error")
			TriggerClientEvent("doj:client:SellillegalFish", src)
		end
	elseif args == 3 then

		local sharkhammerinv = Player.Functions.GetItemByName("sharkhammer")
		local inputsharkhammer = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (sharkhammerinv ~= nil and inputsharkhammer > 0) then
			if sharkhammerinv.amount >= inputsharkhammer then
				local payment = Config.sharkhammerPrice * inputsharkhammer
				Player.Functions.RemoveItem("sharkhammer", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Hammerhead shark')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharkhammer'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." Hammerhead Shark(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellillegalFish", src)
			-- else
			-- 	TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any Hammerhead Sharks to sell", "error")
			TriggerClientEvent("doj:client:SellillegalFish", src)
		end
	elseif args == 4 then

		local killerwhaleinv = Player.Functions.GetItemByName("killerwhale")
		local inputkillerwhale = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (killerwhaleinv ~= nil and inputkillerwhale > 0) then
			if killerwhaleinv.amount >= inputkillerwhale then
				local payment = Config.killerwhalePrice * inputkillerwhale
				Player.Functions.RemoveItem("killerwhale", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Killer Whale')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['killerwhale'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." Killer Whale(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellillegalFish", src)
			-- else
			-- 	TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any Killer Whales to sell", "error")
			TriggerClientEvent("doj:client:SellillegalFish", src)
		end
	end
end)

RegisterNetEvent('fishing:server:SellLegalFish', function(args, amount) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	if args == 1 then 
		local mackerelinv = Player.Functions.GetItemByName("mackerel")
		local inputmackerel = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (mackerelinv ~= nil and inputmackerel > 0) then
			if mackerelinv.amount >= inputmackerel then
				local payment = Config.mackerelPrice * inputmackerel
				Player.Functions.RemoveItem("mackerel", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Mackerel')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["mackerel"], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." Mackerel(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellLegalFish", src)
			-- else
			-- 	TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any fish to sell", "error")
			TriggerClientEvent("doj:client:SellLegalFish", src)
		end
	elseif args == 2 then
		local codfishinv = Player.Functions.GetItemByName("cod")
		local inputcod = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (codfishinv ~= nil and inputcod > 0) then
			if codfishinv.amount >= inputcod then
				local payment = Config.codfishPrice * inputcod
				Player.Functions.RemoveItem("cod", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Cod')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cod'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." Cod(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellLegalFish", src)
			else
				TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any fish to sell", "error")
			TriggerClientEvent("doj:client:SellLegalFish", src)
		end
	elseif args == 3 then
		local bassinv = Player.Functions.GetItemByName("bass")
		local inputbass = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (bassinv ~= nil and inputbass > 0) then
			if bassinv.amount >= inputbass then
				local payment = Config.bassPrice * inputbass
				Player.Functions.RemoveItem("bass", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Bass')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bass'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." bass Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellLegalFish", src)
			else
				TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any fish to sell", "error")
			TriggerClientEvent("doj:client:SellLegalFish", src)
		end
	elseif args == 4 then
		local flounderinv = Player.Functions.GetItemByName("flounder")
		local inputflounder = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (flounderinv ~= nil and inputflounder > 0) then
			if flounderinv.amount >= inputflounder then
				local payment = Config.flounderPrice * inputflounder
				Player.Functions.RemoveItem("flounder", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Flounder')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['flounder'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." flounder(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellLegalFish", src)
			else
				TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any fish to sell", "error")
			TriggerClientEvent("doj:client:SellLegalFish", src)
		end
	else
		local stingrayinv = Player.Functions.GetItemByName("stingray")
		local inputstingray = tonumber(amount)

		if not tonumber(amount) then return end
		
		if (stingrayinv ~= nil and inputstingray > 0) then
			if stingrayinv.amount >= inputstingray then
				local payment = Config.stingrayPrice * inputstingray
				Player.Functions.RemoveItem("stingray", amount, k)
				Player.Functions.AddMoney('bank', tonumber(payment), 'FISHING: Sold Stingray')
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stingray'], "remove", amount)
				TriggerClientEvent('QBCore:Notify', src, amount .." stingray(s) Sold for £"..payment, "success")
				TriggerClientEvent("doj:client:SellLegalFish", src)
			else
				TriggerClientEvent('QBCore:Notify', src, "Attempted Selling Exploit (This has been logged)", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You dont have any fish to sell", "error")
			TriggerClientEvent("doj:client:SellLegalFish", src)
		end
	end
end)

RegisterNetEvent("Brad:GiveItem")
AddEventHandler("Brad:GiveItem", function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	for k, v in pairs(Config.largeLootboxRewards) do
		Player.Functions.AddItem(v.name, v.amount)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.name], "add", v.amount)
		Wait(1000)
	end
end)



--============================================================================ Callbacks
-- QBCore.Functions.CreateCallback('fishing:server:checkMoney', function(source, cb)
--     local src = source
--     local pData = QBCore.Functions.GetPlayer(src)
--     local bankBalance = pData.PlayerData.money["bank"]
-- 	local price = Config.BoatPrice
--     if bankBalance >= price then
--         pData.Functions.RemoveMoney('bank', Config.BoatPrice, "boat-rental")
-- 		TriggerClientEvent('QBCore:Notify', src, "Boat has been rented for $"..price, "success")
--         cb(true)
--     else
--         TriggerClientEvent('QBCore:Notify', src, "You dont have enough money..", "error")
--         cb(false)
--     end
-- end)