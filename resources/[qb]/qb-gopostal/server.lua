local QBCore = exports['qb-core']:GetCoreObject()
local Deposit = {}

RegisterNetEvent('qb-gopostal:city:RentVehicle', function(bool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if bool then
        if Player.PlayerData.money.cash >= Config.Deposit then
            Deposit[Player.PlayerData.citizenid] = Config.Deposit
            Player.Functions.RemoveMoney('cash', Config.Deposit, 'GoPostal: Paid Deposit')
            TriggerClientEvent('QBCore:Notify', src, '£250 Deposit Paid With Cash', 'success')
            TriggerClientEvent('qb-gopostal:city:SpawnVehicle', src)
        elseif Player.PlayerData.money.bank >= Config.Deposit then
            Deposit[Player.PlayerData.citizenid] = Config.Deposit
            Player.Functions.RemoveMoney('bank', Config.Deposit, 'GoPostal: Paid Deposit')
            TriggerClientEvent('QBCore:Notify', src, '£250 Deposit Paid From Bank', 'success')
            TriggerClientEvent('qb-gopostal:city:SpawnVehicle', src)
        else
            TriggerClientEvent('QBCore:Notify', src, '£250 Deposit Required', 'error')
        end
    else
        if Deposit[Player.PlayerData.citizenid] ~= nil then
            Player.Functions.AddMoney('cash', Deposit[Player.PlayerData.citizenid], "GoPostal Deposit")
            Deposit[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('QBCore:Notify', src, '£250 Deposit Refunded To Cash', 'success')
        end
    end
end)

RegisterServerEvent('qb-gopostal:city:Success', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randomAmount = math.random(100, 450)
	local price = math.random(250,500)
    
	if Player ~= nil then
		-- Bonus Pay
		if randomAmount >= 1 and randomAmount < 30 then --30
			bonus = math.random(85, 100)
		elseif randomAmount >= 30 and randomAmount < 60 then --30
			bonus = math.random(150, 200)
		elseif randomAmount >= 60 and randomAmount < 85 then --25
			bonus = math.random(350, 400)
		elseif randomAmount > 85 then --15
			bonus = math.random(600, 650)
		end
	end
    
    -- Payment
    local pay = price + bonus
    Player.Functions.AddMoney('cash', pay, 'Go-Postal Paycheck')
    TriggerClientEvent('QBCore:Notify', src, 'Total Pay: £'..pay.. ' ( Delivery Fee: £'..price..' + Tip: £' ..bonus..' )', 'success', 5000)

    local chance = math.random(100, 350)
    if chance < 40 then
		Player.Functions.AddItem('package', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["package"], "add")
		TriggerClientEvent('QBCore:Notify', src, 'They refused the package, you can keep it!', "success")
    end
end)