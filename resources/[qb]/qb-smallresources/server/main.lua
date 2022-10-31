local VehicleNitrous = {}

RegisterNetEvent('tackle:server:TacklePlayer', function(playerId)
    TriggerClientEvent("tackle:client:GetTackled", playerId)
end)

QBCore.Functions.CreateCallback('nos:GetNosLoadedVehs', function(_, cb)
    cb(VehicleNitrous)
end)

QBCore.Commands.Add("id", "Check Your ID #", {}, false, function(source)
    local src = source
    TriggerClientEvent('QBCore:Notify', src,  "ID: "..src)
end)

QBCore.Commands.Add("citizenid", "Check your Citizen ID", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    TriggerClientEvent('QBCore:Notify', source, 'Your Citizen ID is : ' .. citizenid .. '', 'success', 15000)
end)

QBCore.Commands.Add("checkdensityzone", "Check what zone you are in", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("density:checkme", src)

end, "stafflead")

QBCore.Commands.Add("p#", "Check your phone number", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local result = MySQL.scalar.await('SELECT phone_number FROM players where citizenid = ?', { citizenid })
    TriggerClientEvent('QBCore:Notify', src, 'Phone Number: ' .. result .. '', 'success', 30000)
end)

QBCore.Functions.CreateUseableItem("harness", function(source, item)
    TriggerClientEvent('seatbelt:client:UseHarness', source, item)
end)

QBCore.Commands.Add("givecash", "Give a player cash", {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Amount'}}, false, function(source, args)
    local src = source
	local id = tonumber(args[1])
	local amount = math.ceil(tonumber(args[2]))

	if id and amount then
		local SendingPlayer = QBCore.Functions.GetPlayer(src)
		local ReceivingPlayer = QBCore.Functions.GetPlayer(id)

		if ReceivingPlayer and SendingPlayer then
			if not SendingPlayer.PlayerData.metadata["isdead"] then
				local distance = SendingPlayer.PlayerData.metadata["inlaststand"] and 3.0 or 10.0
				if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(id))) < distance then
                    if amount > 0 then
                        if SendingPlayer.Functions.RemoveMoney('cash', amount, 'Small resource: Givecash Command (Player)') then
                            if ReceivingPlayer.Functions.AddMoney('cash', amount, 'Small resource: Givecash Command (Player)') then
                                TriggerClientEvent('QBCore:Notify', src, "You gave £" .. tostring(amount) .. ' to ' .. tostring(id) .. '', "success")
                                TriggerClientEvent('QBCore:Notify', id, "Recieved " .. tostring(amount) .. '£ from ID ' .. tostring(src), "success")
                            else
                                -- Return player cash
                                SendingPlayer.Functions.AddMoney('cash', amount, 'Small resource: Givecash Command (Player)')
                                TriggerClientEvent('QBCore:Notify', src, 'Could not give item to the given id', "error")
                            end
                            
                            if amount >= 100000 then
                                TriggerEvent('qb-log:server:CreateLog', 'money', "Cash Transfer (Sending)", "turqois", ''..SendingPlayer.PlayerData.charinfo.firstname .. ' ' .. SendingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: '..SendingPlayer.PlayerData.citizenid..'** - ID: '..src..') **Gave £'.. format_int(amount) ..' in cash to **'..ReceivingPlayer.PlayerData.charinfo.firstname .. ' ' .. ReceivingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: ' ..ReceivingPlayer.PlayerData.citizenid.. '** - ID: '..id..')', true)
                                TriggerEvent('qb-log:server:CreateLog', 'money', "Cash Transfer (Received)", "turqois", ''..ReceivingPlayer.PlayerData.charinfo.firstname .. ' ' .. ReceivingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: '..ReceivingPlayer.PlayerData.citizenid..'** - ID: '..src..') **Received £'.. format_int(amount) ..' in cash from **'..SendingPlayer.PlayerData.charinfo.firstname .. ' ' .. SendingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: '..SendingPlayer.PlayerData.citizenid..'** - ID: '..id..')', true)
                            else
                                TriggerEvent('qb-log:server:CreateLog', 'money', "Cash Transfer (Sending)", "turqois", ''..SendingPlayer.PlayerData.charinfo.firstname .. ' ' .. SendingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: '..SendingPlayer.PlayerData.citizenid..'** - ID: '..src..') **Gave £'.. format_int(amount) ..' in cash to **'..ReceivingPlayer.PlayerData.charinfo.firstname .. ' ' .. ReceivingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: ' ..ReceivingPlayer.PlayerData.citizenid.. '** - ID: '..id..')', false)
                                TriggerEvent('qb-log:server:CreateLog', 'money', "Cash Transfer (Received)", "turqois", ''..ReceivingPlayer.PlayerData.charinfo.firstname .. ' ' .. ReceivingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: '..ReceivingPlayer.PlayerData.citizenid..'** - ID: '..src..') **Received £'.. format_int(amount) ..' in cash from **'..SendingPlayer.PlayerData.charinfo.firstname .. ' ' .. SendingPlayer.PlayerData.charinfo.lastname.. ' **(CitizenID: ' ..SendingPlayer.PlayerData.citizenid.. '** - ID: '..id..')', false)
                            end

                        else
                            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have this amount.', "error")
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', src, 'Invalid Amount Given', "error")
                    end
				else
					TriggerClientEvent('QBCore:Notify', src, 'You are too far away', "error")
				end
			else
				TriggerClientEvent('QBCore:Notify', src, 'You are dead LOL', "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', src, 'Wrong ID', "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 'Usage /givecash [ID] [AMOUNT]', "error")
	end
end)


-- Format Currency
function format_int(n)
    if not n then return 0 end
    n = tonumber(n)
    if n >= 1e14 then return tostring(n) end
    if n <= -1e14 then return "-" .. tostring(math.abs(n)) end
    local negative = n < 0
    n = tostring(math.abs(n))
    local dp = string.find(n, "%.") or #n + 1

    for i = dp - 4, 1, -3 do
        n = n:sub(1, i) .. "," .. n:sub(i + 1)
    end

    -- Make sure the amount is padded with zeroes
    if n[#n - 1] == "." then
        n = n .. "0"
    end

    return (negative and "-" or "") .. n
end



RegisterNetEvent('qb-smallresources:getPhoneNumber', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local result = MySQL.scalar.await('SELECT phone_number FROM players where citizenid = ?', { citizenid })
    TriggerClientEvent('QBCore:Notify', src, 'Phone Number: ' .. result .. '', 'success', 30000)
end)

RegisterNetEvent('equip:harness', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.items[item.slot].info.uses == nil then
        Player.PlayerData.items[item.slot].info.uses = 49
        Player.Functions.SetInventory(Player.PlayerData.items)
    elseif Player.PlayerData.items[item.slot].info.uses == 1 then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1, item.slot)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('qb-carwash:server:washCar', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    elseif Player.Functions.RemoveMoney('bank', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have enough money..', 'error')
    end
end)

QBCore.Functions.CreateCallback('smallresources:server:GetCurrentPlayers', function(_, cb)
    local TotalPlayers = 0
    for _ in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)


QBCore.Functions.CreateUseableItem("starting_package", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.RemoveItem("starting_package", 1)

    Player.Functions.AddItem("lockpick", 5)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["lockpick"], "add")
    TriggerClientEvent('QBCore:Notify', source, 'You have been given a 5 Lockpicks', 'success')

    Player.Functions.AddItem("bandage", 3)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["bandage"], "add")
    TriggerClientEvent('QBCore:Notify', source, 'You have been given 3 Bandages ', 'success')

    Player.Functions.AddItem("water_bottle", 2)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["water_bottle"], "add")
    TriggerClientEvent('QBCore:Notify', source, 'You have been given 2 Water Bottles', 'success')

    Player.Functions.AddItem("sandwich", 2)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["sandwich"], "add")
    TriggerClientEvent('QBCore:Notify', source, 'You have been given 2 Sandwitches', 'success')

    Player.Functions.AddItem("taxitoken", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["taxitoken"], "add")
    TriggerClientEvent('QBCore:Notify', source, 'You have been given a taxitoken', 'success')
end)

QBCore.Functions.CreateUseableItem("taxitoken", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    local payamount = 2000

    Player.Functions.RemoveItem("taxitoken", 1)
    
    Player.Functions.AddMoney('cash', payamount, 'Reedemed Taxi Token')
    TriggerClientEvent('QBCore:Notify', source, "Sucessfully redeemed taxi token! You have been given £"..payamount, 'success')
    
end)

QBCore.Commands.Add("refreshinterior", "Use this if your cannot see the inside of the building", {}, false, function(source)
	TriggerClientEvent('JackoBikes:refreshInt', source)
end)