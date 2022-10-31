local QBCore = exports['qb-core']:GetCoreObject()
local canTake = false
local inRange = false
local headerOpen = false
local pedspawned = false

CreateThread(function()
	local blip = AddBlipForCoord(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z)
	SetBlipSprite(blip, 431)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Pawn Shop")
	EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    modelHash = GetHashKey("mp_m_freemode_01")
    local model = modelHash
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    createNPC()
end)

function createNPC()
	Test_Ped = CreatePed(0, modelHash, Config.NPCLoc.x, Config.NPCLoc.y, Config.NPCLoc.z, Config.NPCLoc.w, false, false)
	FreezeEntityPosition(Test_Ped, true)
	SetEntityInvincible(Test_Ped, true)

	-- (ped, Compid, DrawableID, TextureID)

    SetPedPropIndex(Test_Ped, 1, 8, 0, true) -- Glasses
    SetPedComponentVariation(Test_Ped, 0, 1, 0, 0) -- Head
    SetPedComponentVariation(Test_Ped, 1, 210, 0, 0) -- Mask
    SetPedComponentVariation(Test_Ped, 2, 18, 1, 0) -- hair
    SetPedComponentVariation(Test_Ped, 3, 0, 0, 0) -- Torso
    SetPedComponentVariation(Test_Ped, 4, 141, 0, 0) -- Legs
    SetPedComponentVariation(Test_Ped, 5, 0, 0, 0) -- Bags
    SetPedComponentVariation(Test_Ped, 6, 10, 0, 0) -- Shoes
    SetPedComponentVariation(Test_Ped, 7, 124, 2, 0) -- Ties
    SetPedComponentVariation(Test_Ped, 8, 60, 0, 0) -- T-Shirt
    SetPedComponentVariation(Test_Ped, 9, 0, 0, 0) -- Vests
    SetPedComponentVariation(Test_Ped, 10, 0, 0, 0) -- Decal
    SetPedComponentVariation(Test_Ped, 11, 266, 0, 0) -- Tops

	SetBlockingOfNonTemporaryEvents(Test_Ped, true)
	TaskStartScenarioInPlace(Test_Ped, "WORLD_HUMAN_BUM_STANDING", 0, true)
    exports['qb-target']:AddTargetEntity(Test_Ped, {
        options = {
            {
                type = "client",
                event = "qb-pawnshop:client:openMenu",
                label = 'Access Pawn Shop',
                icon = 'fas fa-sack-dollar',
            }
        },
        distance = 2.0
    })
end

RegisterNetEvent('qb-pawnshop:client:openMenu', function()
	if Config.UseTimes then
		if GetClockHours() >= Config.TimeOpen and GetClockHours() <= Config.TimeClosed then
			local pawnShop = {
				{
					header = "Pawn Shop",
					isMenuHeader = true,
				},
				{
					header = "Sell",
					txt = "Sell Items To The Pawn Shop",
					params = {
						event = "qb-pawnshop:client:openPawn",
						args = {
							items = Config.PawnItems
						}
					}
				}
			}
			exports['qb-menu']:openMenu(pawnShop)
		else
			QBCore.Functions.Notify("Pawnshop is closed. Come back between "..Config.TimeOpen..":00 AM - "..Config.TimeClosed..':00 PM')
		end
	else
		local pawnShop = {
			{
				header = "Pawn Shop Menu",
				isMenuHeader = true,
			},
			{
				header = "Sell",
				txt = "Sell Items To The Pawn Shop",
				params = {
					event = "qb-pawnshop:client:openPawn",
					args = {
						items = Config.PawnItems
					}
				}
			}
		}
		exports['qb-menu']:openMenu(pawnShop)
	end
end)

RegisterNetEvent('qb-pawnshop:client:openPawn', function(data)
	QBCore.Functions.TriggerCallback('qb-pawnshop:server:getInv', function(inventory)
		local PlyInv = inventory
		local pawnMenu = {
			{
				header = "Pawn Menu",
				isMenuHeader = true,
			}
		}
		for k,v in pairs(PlyInv) do
			for i = 1, #data.items do
				if v.name == data.items[i].item then
					pawnMenu[#pawnMenu +1] = {
						header = QBCore.Shared.Items[v.name].label,
						txt = "Selling Price: £"..data.items[i].price,
						params = {
							event = "qb-pawnshop:client:pawnitems",
							args = {
								label = QBCore.Shared.Items[v.name].label,
								price = data.items[i].price,
								name = v.name,
								amount = v.amount
							}
						}
					}
				end
			end
		end
		pawnMenu[#pawnMenu+1] = {
			header = "⬅ Go Back",
			params = {
				event = "qb-pawnshop:client:openMenu"
			}
		}
		exports['qb-menu']:openMenu(pawnMenu)
	end)
end)

RegisterNetEvent("qb-pawnshop:client:pawnitems", function(item)
	local sellingItem = exports['qb-input']:ShowInput({
		header = "Pawn Item",
		submitText = "Sell Item",
		inputs = {
			{
				type = 'number',
				isRequired = false,
				name = 'amount',
				text = 'max amount '..item.amount
			}
		}
	})
	if sellingItem then
		if not sellingItem.amount then
			return
		end
		if tonumber(sellingItem.amount) > 0 then
			TriggerServerEvent('qb-pawnshop:server:sellPawnItems', item.name, sellingItem.amount, item.price)
		else
			QBCore.Functions.Notify("Trying to sell a negative amount?", "error")
		end
	end
end)

RegisterNetEvent('qb-pawnshop:client:resetPickup', function()
	canTake = false
end)