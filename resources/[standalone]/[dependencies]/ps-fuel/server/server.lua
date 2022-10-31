-- Variables

local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function GlobalTax(value)
	local tax = (value / 100 * Config.GlobalTax)
	return tax
end

-- Server Events

QBCore.Commands.Add("setfuel", "Set car fuel", {{name="amount", help="Amount of fuel"}}, true, function(source, args)
    local src = source
	local amount = tonumber(args[1])

	if amount ~= nil then
		TriggerClientEvent('jackofuel:client:forcefuel', src, amount)
	end
	
end, "admininistrator")

RegisterNetEvent("ps-fuel:server:OpenMenu", function (amount, inGasStation, hasWeapon)
	local src = source
	if not src then return end
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local tax = GlobalTax(amount)
	local total = math.ceil(amount + tax)
	if inGasStation == true and not hasWeapon then
		TriggerClientEvent('qb-menu:client:openMenu', src, {
			{
				header = 'Gas Station',
				txt = 'The total cost is going to be: £'..total..' including taxes.' ,
				params = {
					event = "ps-fuel:client:RefuelVehicle",
					args = total,
				}
			},
		})
	else
		TriggerClientEvent('qb-menu:client:openMenu', src, {
			{
				header = 'Gas Station',
				txt = 'Refuel from jerry can' ,
				params = {
					event = "ps-fuel:client:RefuelVehicle",
					args = total,
				}
			},
		})
	end
end)

QBCore.Functions.CreateCallback('ps-fuel:server:fuelCan', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local itemData = Player.Functions.GetItemByName("weapon_petrolcan")
    cb(itemData)
end)

RegisterNetEvent("ps-fuel:server:PayForFuel", function (amount, GivePetrolCan, GivePetrolAmmo)
	local src = source
	if not src then
		return
	end

	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then
		return
	end

	Player.Functions.RemoveMoney('cash', amount, 'Fuel: Paid For Fuel')

	local alreadyhascan = QBCore.Functions.HasItem(src, 'weapon_petrolcan')

	if GivePetrolCan and not alreadyhascan then
		Player.Functions.AddItem('weapon_petrolcan', 1)
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["weapon_petrolcan"], "add", 1)

		Player = QBCore.Functions.GetPlayer(src)

		local JerryCan = Player.Functions.GetItemByName("weapon_petrolcan")

		
		if Player.PlayerData.items[JerryCan.slot] then
			print("Giving fuel")
            Player.PlayerData.items[JerryCan.slot].info.ammo = tonumber(2500)
        end
		Player.Functions.SetInventory(Player.PlayerData.items, true)

	elseif GivePetrolAmmo and alreadyhascan then
		local JerryCan = Player.Functions.GetItemByName("weapon_petrolcan")

		
		if Player.PlayerData.items[JerryCan.slot] then
            Player.PlayerData.items[JerryCan.slot].info.ammo = tonumber(2500)
        end

		Player.Functions.SetInventory(Player.PlayerData.items, true)
	end
end)
