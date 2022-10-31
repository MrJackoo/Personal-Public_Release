local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('slaughtering:server:addalivechicken')
AddEventHandler('slaughtering:server:addalivechicken', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local chickenstogive = math.random(1,6)

	Player.Functions.AddItem('alivechicken', chickenstogive)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["alivechicken"], 'add')
end)

RegisterServerEvent('slaughtering:server:processing')
AddEventHandler('slaughtering:server:processing', function(triggertype)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	local alivechickens = Player.Functions.GetItemByName('alivechicken')
	local deadchickens = Player.Functions.GetItemByName('slaughteredchicken')
	local packagedchickens = Player.Functions.GetItemByName('packagedchicken')

	if triggertype == "slaughter" then
		if alivechickens ~= nil and alivechickens.amount > 0 then
			Player.Functions.RemoveItem('alivechicken', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["alivechicken"], 'remove')
			Player.Functions.AddItem('slaughteredchicken', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["slaughteredchicken"], 'add')
		else
			TriggerClientEvent(NotifyTrigger, src, "You dont have enough Alive Chickens", "error")
		end
	end

	if triggertype == "package" then
		if deadchickens ~= nil and deadchickens.amount > 0 then
			Player.Functions.RemoveItem('slaughteredchicken', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["slaughteredchicken"], 'remove')
			Player.Functions.AddItem('packagedchicken', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["packagedchicken"], 'add')
		else
			TriggerClientEvent(NotifyTrigger, src, "You dont have enough Slaughtered Chickens", "error")
		end
	end
end)



RegisterServerEvent("chicken:sell")
AddEventHandler("chicken:sell", function(sellprice)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local price = 0
	local price2 = sellprice
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "packagedchicken" then 
                    price = price + (price2 * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("packagedchicken", Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.AddMoney("cash", price, 'Slaughter Pay')
		TriggerClientEvent('QBCore:Notify', src, "You sold some chicken fillets for " .. price, "primary", 8000)
	end
end)

