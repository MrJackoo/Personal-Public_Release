-- Variables
QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
local onDuty = false

-- Functions
function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function LoadDict(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end
end

-- Handlers
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "vu" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent("qb-vu:MurderMeal")
AddEventHandler("qb-vu:MurderMeal", function()
	useTray()
end)

RegisterNetEvent("qb-vu:icePacket")
AddEventHandler("qb-vu:icePacket", function()
	MakeFries()
end)

RegisterNetEvent("qb-vu:DrinkTray")
AddEventHandler("qb-vu:DrinkTray", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientdontstopdrinking', function(HasItems)
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Making A Special..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-cocktail", 3)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "vu-whiskey", 3)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-peanuts", 2)


					TriggerServerEvent('QBCore:Server:AddItem', "vu-dontstopdrinking", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-dontstopdrinking"], "add")

                    QBCore.Functions.Notify("You made a A Daily Special", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("You dont have the items to make this", "error")
			end
		end)
	else
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-vu:CocktailMix")
AddEventHandler("qb-vu:CocktailMix", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientcocktail', function(HasItems)
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Pouring a Cocktail..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-cocktailmix", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-cocktailglass", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-umbrella", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-olive", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "vu-cocktail", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-cocktail"], "add")
                    QBCore.Functions.Notify("You made a cocktail", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-vu:MoneyShot")
AddEventHandler("qb-vu:MoneyShot", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientWhiskey', function(HasItems)
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Pouring a glass of Whiskey..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-whiskeyshot", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-whiskeyglass", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-umbrella", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-ice", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "vu-whiskey", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-whiskey"], "add")
                    QBCore.Functions.Notify("You made a VU Special Whiskey", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-vu:Peanuts")
AddEventHandler("qb-vu:Peanuts", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientPeanut', function(HasItems)
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Prepairing Peanuts..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-peanutpacket", 2)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-servingdish", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "vu-peanuts", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-peanuts"], "add")
                    QBCore.Functions.Notify("You have prepared a dish of peanuts", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)


RegisterNetEvent("qb-vu:Jaegerbomb")
AddEventHandler("qb-vu:Jaegerbomb", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientJager', function(HasItems)
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Making A Jager Bomb..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-jager", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "vu-shotglass", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-redgull", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "vu-jagerbomb", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-jagerbomb"], "add")
                    QBCore.Functions.Notify("You poured a shot", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-vu:Sourzshot")
AddEventHandler("qb-vu:Sourzshot", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientSourz', function(HasItems)
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "Pouring some Sourz..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "vu-sourzmix", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "vu-shotglass", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "vu-sourz", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-sourz"], "add")
                    QBCore.Functions.Notify("You poured a shot.", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)



RegisterNetEvent("qb-vu:SoftDrink")
AddEventHandler("qb-vu:SoftDrink", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientSoftdrink', function(HasItem)
        if HasItem then
           MakeSoftDrink()
        else
            QBCore.Functions.Notify("You don't have any soda syrup..", "error")
        end
      end, 'burger-sodasyrup')
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)

RegisterNetEvent("qb-vu:mShake")
AddEventHandler("qb-vu:mShake", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('qb-vu:server:get:ingredientmShake', function(HasItem)
        if HasItem then
           MakeMShake()
        else
            QBCore.Functions.Notify("You don't have any Milkshake Formula..", "error")
        end
      end, 'burger-mshakeformula')
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)

-- RegisterNetEvent("qb-vu:PattyFry")
-- AddEventHandler("qb-vu:PattyFry", function()
--     if onDuty then
--     QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
--         if HasItem then
--            MakePatty()
--         else
--             QBCore.Functions.Notify("You don't have any raw patties..", "error")
--         end
--       end, 'burger-raw')
--     else
--         QBCore.Functions.Notify("You must be Clocked into work", "error")
--     end
-- end)



RegisterNetEvent("qb-vu:DutyB")
AddEventHandler("qb-vu:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-vu:Tray1")
AddEventHandler("qb-vu:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray2")
AddEventHandler("qb-vu:Tray2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray2", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray3")
AddEventHandler("qb-vu:Tray3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray3", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray4")
AddEventHandler("qb-vu:Tray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray4")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray4", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray5")
AddEventHandler("qb-vu:Tray5", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray5")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray5", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray6")
AddEventHandler("qb-vu:Tray6", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray6")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray6", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray7")
AddEventHandler("qb-vu:Tray7", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray7")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray7", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray8")
AddEventHandler("qb-vu:Tray8", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray8")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray8", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray9")
AddEventHandler("qb-vu:Tray9", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray9")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray9", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray10")
AddEventHandler("qb-vu:Tray10", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray10")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray10", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray11")
AddEventHandler("qb-vu:Tray11", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray11")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray11", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray12")
AddEventHandler("qb-vu:Tray12", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray12")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray12", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-vu:Tray13")
AddEventHandler("qb-vu:Tray13", function()
    TriggerEvent("inventory:client:SetCurrentStash", "vutray13")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vutray13", {
        maxweight = 10000,
        slots = 6,
    })
end)
 -- Storage at bar (door)
-- RegisterNetEvent("qb-vu:Storage")
-- AddEventHandler("qb-vu:Storage", function()
--     TriggerEvent("inventory:client:SetCurrentStash", "vustorage")
--     TriggerServerEvent("inventory:server:OpenInventory", "stash", "vustorage", {
--         maxweight = 2500000,
--         slots = 90,
--     })
-- end)
 -- Fridge
 RegisterNetEvent("qb-vu:Storage2")
 AddEventHandler("qb-vu:Storage2", function()
     TriggerEvent("inventory:client:SetCurrentStash", "vustorage2")
     TriggerServerEvent("inventory:server:OpenInventory", "stash", "vustorage2", {
         maxweight = 3000000,
         slots = 90,
     })
 end)

-- Private Room Fridge
-- RegisterNetEvent("qb-vu:Storage3")
-- AddEventHandler("qb-vu:Storage3", function()
--     TriggerEvent("inventory:client:SetCurrentStash", "vustorage3")
--     TriggerServerEvent("inventory:server:OpenInventory", "stash", "vustorage3", {
--         maxweight = 2500000,
--         slots = 90,
--     })
-- end)

-- RegisterNetEvent("qb-vu:Storage4")
-- AddEventHandler("qb-vu:Storage4", function()
--     TriggerEvent("inventory:client:SetCurrentStash", "vustorage4")
--     TriggerServerEvent("inventory:server:OpenInventory", "stash", "vustorage4", {
--         maxweight = 250000000,
--         slots = 90,
--     })
-- end)

-- RegisterNetEvent("qb-vu:Storage5")
-- AddEventHandler("qb-vu:Storage5", function()
--     TriggerEvent("inventory:client:SetCurrentStash", "vustorage5")
--     TriggerServerEvent("inventory:server:OpenInventory", "stash", "vustorage5", {
--         maxweight = 250000000,
--         slots = 90,
--     })
-- end)

-- Functions --
-- function MakeFries()
-- TriggerServerEvent('QBCore:Server:RemoveItem', "vu_icepacket", 1)
-- TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu_icepacket"], "remove")
-- QBCore.Functions.Progressbar("pickup", "cracking Ice..", 4000, false, true, {
--     disableMovement = true,
--     disableCarMovement = false,
--     disableMouse = false,
--     disableCombat = false,
-- },{
--     animDict = "amb@prop_human_bbq@male@base",
--     anim = "base",
--     flags = 8,
--     }, {
--         model = "prop_cs_fork",
--         bone = 28422,
--         coords = { x = -0.005, y = 0.00, z = 0.00 },
--         rotation = { x = 175.0, y = 160.0, z = 0.0 },
--     }
-- )
-- Citizen.Wait(4000)
-- TriggerServerEvent('QBCore:Server:AddItem', "vu_ice", 4)
-- TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu_ice"], "add")
-- StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
-- end

function useTray()
    TriggerServerEvent('QBCore:Server:RemoveItem', "vu-dontstopdrinking", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-dontstopdrinking"], "remove")
    QBCore.Functions.Progressbar("pickup", "emptying tray..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
        }, {
            model = "prop_cs_fork",
            bone = 28422,
            coords = { x = -0.005, y = 0.00, z = 0.00 },
            rotation = { x = 175.0, y = 160.0, z = 0.0 },
        }
    )
    Wait(4000)
    --add items from box
    TriggerServerEvent('QBCore:Server:AddItem', "vu-cocktail", 3)
    TriggerServerEvent('QBCore:Server:AddItem', "vu-whiskey", 3)
    TriggerServerEvent('QBCore:Server:AddItem', "vu-peanuts", 2)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-cocktail"], "add")
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-whiskey"], "add")
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-peanuts"], "add")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakeSoftDrink()
    TriggerServerEvent('QBCore:Server:RemoveItem', "vu-sodasyrup", 1)
    QBCore.Functions.Progressbar("pickup", "Filling a cup..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "vu-softdrink", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-softdrink"], "add")
    QBCore.Functions.Notify("You made a Soda", "success")
end


function MakeMShake()
    TriggerServerEvent('QBCore:Server:RemoveItem', "vu-mshakeformula", 1)
    QBCore.Functions.Progressbar("pickup", "Filling up a cup..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "vu-mshake", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vu-mshake"], "add")
    QBCore.Functions.Notify("You made a Milkshake", "success")
end

CreateThread(function()
    exports['qb-target']:AddBoxZone("Duty", vector3(102.47, -1299.38, 28.77), 2, 1.2, {
        name = "Duty",
        heading = 127.21,
        debugPoly = false,
        minZ=28.4,
        maxZ=30.0,
    }, {
        options = {
            {
                event = "qb-vu:DutyB",
                icon = "far fa-clipboard",
                label = "Clock On/Off",
                job = "vu",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_1", vector3(113.42, -1303.07, 29.89), 0.5, 0.7, {
        name = "vu_tray_1",
        heading = 300.13,
        debugPoly = false,
        minZ=29.5,
        maxZ=29.7,
    }, {
        options = {
            {
                event = "qb-vu:Tray1",
                icon = "far fa-clipboard",
                label = "Bar 1",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_2", vector3(127.32, -1282.46, 30.3), 0.5, 0.7, {
        name="vu_tray_2",
        heading=300.13,
        debugPoly=false,
        minZ=26.5,
        maxZ=29.7,
    }, {
        options = {
            {
                event = "qb-vu:Tray2",
                icon = "far fa-clipboard",
                label = "Bar 2",
				-- job = "all",
            },
        },
        distance = 1.5
    })
    exports['qb-target']:AddBoxZone("vu_tray_3", vector3(124.1, -1284.08, 28.8), 0.5, 0.7, {
        name="vu_tray_3",
        heading=300.13,
        debugPoly=false,
        minZ=28.5,
        maxZ=29.7,
    }, {
        options = {
            {
                event = "qb-vu:Tray3",
                icon = "far fa-clipboard",
                label = "Table 1",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_4", vector3(125.72, -1286.54, 29.33), 0.5, 0.7, {
        name="vu_tray_4",
        heading=300.13,
        debugPoly=false,
        minZ=28.5,
        maxZ=29.7,
    }, {
        options = {
            {
                event = "qb-vu:Tray4",
                icon = "far fa-clipboard",
                label = "Table 2",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_5",vector3(121.94, -1287.1, 28.76), 0.5, 0.7, {
        name="vu_tray_5",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=28.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray5",
                icon = "far fa-clipboard",
                label = "Table 3",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_6", vector3(120.95, -1285.13, 28.68), 0.5, 0.7, {
        name="vu_tray_6",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=28.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray6",
                icon = "far fa-clipboard",
                label = "Table 4",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_7", vector3(117.43, -1282.89, 28.99), 0.5, 0.7, {
        name="vu_tray_7",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=28.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray7",
                icon = "far fa-clipboard",
                label = "Table 5",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_8", vector3(115.78, -1287.02, 28.88), 0.5, 0.7, {
        name="vu_tray_8",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=28.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray8",
                icon = "far fa-clipboard",
                label = "Table 6",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_9", vector3(112.83, -1283.05, 28.88), 0.5, 0.7, {
        name="vu_tray_9",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=28.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray9",
                icon = "far fa-clipboard",
                label = "Table 7",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_10", vector3(116.52, -1291.45, 28.68), 0.5, 0.7, {
        name="vu_tray_10",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=28.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray10",
                icon = "far fa-clipboard",
                label = "Table 8",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_11", vector3(123.4, -1294.79, 29.69), 0.5, 0.7, {
        name="vu_tray_11",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=29.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray11",
                icon = "far fa-clipboard",
                label = "Table 9",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_12", vector3(119.96, -1296.62, 29.99), 0.5, 0.7, {
        name="vu_tray_12",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=29.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray12",
                icon = "far fa-clipboard",
                label = "Table 10",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("vu_tray_13", vector3(113.42, -1303.07, 29.89), 0.5, 0.7, {
        name="vu_tray_13",
        heading=300.13,
        debugPoly=false,
        minZ=26.9,
        maxZ=29.2,
    }, {
        options = {
            {
                event = "qb-vu:Tray13",
                icon = "far fa-clipboard",
                label = "Table 11",
				-- job = "all",
            },
        },
        distance = 3.5
    })

    -- exports['qb-target']:AddBoxZone("vufryer", vector3(127.99, -1281.81, 29.46), 1.3, 0.5, {
    --     name="vufryer",
    --     heading=300.29,
    --     debugPoly=false,
    --     minZ=25.0,
    --     maxZ=26.4,
    --     }, {
    --         options = {
    --             {
    --                 event = "consumeables:server:useicepacket",
    --                 icon = "fas fa-box",
    --                 label = "Open the Bag of Ice",
    --                 job = "vu",
    --             },
    --         },
    --     distance = 2
    -- })


    -- exports['qb-target']:AddBoxZone("vudrinks",vector3(133.52, -1286.5, 29.49) , 1.3, 0.3, {
    --     name="vudrinks",
    --     heading=300.29,
    --     debugPoly=false,
    --     minZ=26.5,
    --     maxZ=29.7,
    --     }, {
    --         options = {
    --             {
    --                 event = "qb-vu:SoftDrinks",
    --                 icon = "fas fa-filter",
    --                 label = "Make Some Drinks",
    --                 job = "vu",
    --             },
    --         },
    --     distance = 1.5
    -- })

    exports['qb-target']:AddBoxZone("vufridge", vector3(129.77, -1280.7, 29.25), 1.6, 1, {
        name="vufridge",
        heading=210.29,
        debugPoly=false,
        minZ=26.5,
        maxZ=29.7,
        }, {
            options = {
                {
                    event = "qb-vu:Fridge",
                    icon = "fas fa-laptop",
                    label = "Order Ingredients",
                    job = "vu",
                },
            },
        distance = 3
    })

    exports['qb-target']:AddBoxZone("vuprivfridge", vector3(119.02, -1302.64, 29.21), 1.6, 1, {
        name="vuprivfridge",
        heading=210.29,
        debugPoly=false,
        minZ=26.5,
        maxZ=29.7,
        }, {
            options = {
                {
                    event = "qb-vu:PrivFridge",
                    icon = "fas fa-laptop",
                    label = "Order Ingredients",
                    job = "vu",
                },
            },
        distance = 3
    })

     exports['qb-target']:AddBoxZone("vudisplay", vector3(132.3, -1287.94, 29.27), 1.8, 0.7, {
         name="vudisplay",
         debugPoly=false,
         heading=300.29,
         minZ=25.2,
         maxZ=30.9,
         }, {
             options = {
                 {
                     event = "qb-VU:Storage",
                     icon = "fas fa-box",
                     label = "VU Storage",
                     job = "vu",
                 },
             },
         distance = 3.0
     })

    exports['qb-target']:AddBoxZone("vudisplay2", vector3(93.81, -1291.04, 29.26), 1.8, 0.7, {
        name="vudisplay2",
        debugPoly=false,
        heading=300.29,
        minZ=25.2,
        maxZ=38.9,
        }, {
            options = {
                {
                    event = "qb-vu:Storage2",
                    icon = "fas fa-box",
                    label = "vu Storage",
                    job = "vu",
                },
            },
        distance = 3.0
    })

    exports['qb-target']:AddBoxZone("vudisplay3", vector3(119.24, -1302.84, 29.26), 1.8, 0.7, {
        name="vudisplay3",
        debugPoly=false,
        heading=356.29,
        minZ=25.2,
        maxZ=32.9,
        }, {
            options = {
                {
                    event = "qb-vu:Storage3",
                    icon = "fas fa-box",
                    label = "vu Storage",
                    job = "vu",
                },
            },
        distance = 3.0
    })

    -- exports['qb-target']:AddBoxZone("vudisplay4", vector3(934.78, -1460.78, 33.61), 1.8, 0.7, {
    --     name="vudisplay4",
    --     debugPoly=false,
    --     heading=309.29,
    --     minZ=32.2,
    --     maxZ=35.9,
    --     }, {
    --         options = {
    --             {
    --                 event = "qb-vu:Storage4",
    --                 icon = "fas fa-box",
    --                 label = "vu Storage",
    --                 job = "vu",
    --             },
    --         },
    --     distance = 3.0
    -- })


    -- exports['qb-target']:AddBoxZone("vucraftburger", vector3(130.59, -1286.59, 29.23), 1.4, 0.7, {
    --     name="vucraftburger",
    --     debugPoly=false,
    --     heading=210.29,
    --     minZ=26.5,
    --     maxZ=29.7,
    --     }, {
    --         options = {
    --             {
    --                 event = "qb-vu:Workstation",
    --                 icon = "fas fa-cocktail",
    --                 label = "Work Station",
    --                 job = "vu",
    --             },
    --         },
    --     distance = 3.0
    -- })


    exports['qb-target']:AddBoxZone("vu_register_1", vector3(132.93, -1285.9, 29.43), 0.5, 0.4, {
        name="vu_register_1",
        debugPoly=false,
        heading=300.17,
        minZ=26.5,
        maxZ=29.7,
        }, {
            options = {
                {
                    event = "qb-vu:bill",
                    parms = "1",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                    job = "vu",
                },
            },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("vu_register_2", vector3(129.09, -1284.76, 28.67), 0.5, 0.4, {
        name="vu_register_2",
        debugPoly=false,
        heading=300.17,
        minZ=26.5,
        maxZ=29.7,
        }, {
            options = {
                {
                    event = "qb-vu:bill",
                    parms = "1",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                    job = "vu",
                },
            },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("vu_register_3", vector3(118.87, -1303.01, 29.0), 0.5, 0.4, {
        name="vu_register_3",
        debugPoly=false,
        heading=300.17,
        minZ=29.3,
        maxZ=29.7,
        }, {
            options = {
                {
                    event = "qb-vu:bill",
                    parms = "1",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                    job = "vu",
                },
            },
        distance = 1.5
    })

end)

-- RegisterNetEvent('qb-vu:Workstation', function(data)
--     exports['qb-menu']:openMenu({
--         {
--             id = 0,
--             header = "Available Drinks",
--             isMenuHeader = true
--         },
--         {
--             id = 1,
--             header = "Whiskey",
--             txt = "2 x Whiskey Shot , Whiskey Glass , Umbrella , Ice",
--             params = {
--                 event = "qb-vu:MoneyShot"
--             }
--         },
--         {
--             id = 2,
--             header = "Cocktail",
--             txt = "2 x Cocktail Mix , Cocktail Glass , Umbrella , Olive",
--             params = {
--                 event = "qb-vu:CocktailMix"
--             }
--         },
--         {
--             id = 3,
--             header = "Peanuts",
--             txt = "2 x Peanut Packet , Serving Dish",
--             params = {
--                 event = "qb-vu:Peanuts"
--             }
--         },
--         {
--             id = 4,
--             header = "Sourz Shot",
--             txt = "Sourzmix , ShotGlass",
--             params = {
--                 event = "qb-vu:Sourzshot"
--             }
--         },
--         {
--             id = 5,
--             header = "Jagerbomb",
--             txt = "Jager , Shotglass , Redgull ",
--             params = {
--                 event = "qb-vu:Jaegerbomb"
--             }
--         },
--         {
--             id = 6,
--             header = "Drink Tray",
--             txt = "3 x Cocktails, 3 x Whiskeys and 2 x Peanuts",
--             params = {
--                 event = "qb-vu:DrinkTray"
--             }
--         },
--     })
-- end)

RegisterNetEvent('qb-vu:Fridge', function(data)
    exports['qb-menu']:openMenu({
        {
            id = 0,
            header = "Fridge",
            isMenuHeader = true
        },
        {
            id = 1,
            header = "Order Items",
            txt = "Order New Drinks!",
            params = {
                event = "qb-vu:shop"
            }
        },
        -- {
        --     id = 2,
        --     header = "Open Fridge",
        --     txt = "See what you have in storage",
        --     params = {
        --         event = "qb-vu:Storage2"
        --     }
        -- },
    })
end)

RegisterNetEvent('qb-vu:PrivFridge', function(data)
    exports['qb-menu']:openMenu({
        {
            id = 0,
            header = "Fridge",
            isMenuHeader = true
        },
        {
            id = 1,
            header = "Order Items",
            txt = "Order New Drinks!",
            params = {
                event = "qb-vu:shop"
            }
        },
        -- {
        --     id = 2,
        --     header = "Open Fridge",
        --     txt = "See what you have in storage",
        --     params = {
        --         event = "qb-vu:Storage3"
        --     }
        -- },
    })
end)

-- RegisterNetEvent('qb-vu:SoftDrinks', function(data)
--     exports['qb-menu']:openMenu({
--         {
--             id = 0,
--             header = "Drink Menu",
--             isMenuHeader = true
--         },
--         {
--             id = 1,
--             header = "Soft Drink",
--             txt = "Soda Syrup",
--             params = {
--                 event = "qb-vu:SoftDrink"
--             }
--         },
--         {
--             id = 2,
--             header = "Milkshake",
--             txt = "Milkshake Formula",
--             params = {
--                 event = "qb-vu:mShake"
--             }
--         },
--     })
-- end)

RegisterNetEvent('qb-vu:bill', function()
    local bill = exports['qb-input']:ShowInput({
        header = 'Create Receipt',
        submitText = "Submit",
        inputs = {
            
            {
                text = "Paypal ID", -- text you want to be displayed as a place holder
                name = "serverid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                type = 'number', -- number doesn't accept decimals??
                name = 'amount',
                text = 'Enter Bill Amount',
                isRequired = true
            }
        }
    })
    if bill then
        if not bill.serverid then return end
        if tonumber(bill.amount) > 0 then 
        	TriggerServerEvent('qb-vu:bill:player', bill.serverid, bill.amount)
    	end
    else
        QBCore.Functions.Notify("You are already doing something!", "error")
    end
end)

RegisterNetEvent("qb-vu:shop")
AddEventHandler("qb-vu:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "vu", Config.Items)
end)

-- Threads
CreateThread(function() 
    while true do
        Wait(0)
        local Player = PlayerPedId()
		local vuCoords = vector3(120.48, -1281.51, 29.48)
		local pos = GetEntityCoords(Player)
		local distance = #(pos - vuCoords)
        if distance < 1.5 then
			PlayerJob = QBCore.Functions.GetPlayerData().job
		    if PlayerJob.name == "vu" then
		        DrawText3Ds(120.48, -1281.51, 29.48, "[E] To use decks")
		        if IsControlJustReleased(0, 38) then
		            TriggerEvent("qb-boombox:client:playMusicVU")
		            TriggerEvent("qb-boombox:client:placeBoomboxVu")
		        end
		    end
        end
    end
end)
CreateThread(function()
    while true do
		Wait(0)
        if #(GetEntityCoords(PlayerPedId()) - vector3(108.7954, -1289.298, 29.6591)) <= 1.0 then
            DrawText3Ds(108.78, -1289.34, 29.25, "[E] Pole Dance / [H] Stop")
            if IsControlJustReleased(0, 38) then
                LoadDict('mini@strip_club@pole_dance@pole_dance1')
                local scene = NetworkCreateSynchronisedScene(108.7954, -1289.298, 29.6591, vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "mini@strip_club@pole_dance@pole_dance1", "pd_dance_01", 1.5, -4.0, 1, 1, 1148846080, 0)
                NetworkStartSynchronisedScene(scene)
            elseif IsControlJustReleased(0, 74) then
                ClearPedTasksImmediately(PlayerPedId())
            end
        end
    end
end)

CreateThread(function()
    mainblip = AddBlipForCoord(130.73, -1302.31, 29.23)

    SetBlipSprite (mainblip, 279)
    SetBlipDisplay(mainblip, 4)
    SetBlipScale  (mainblip, 0.8)
    SetBlipColour (mainblip, 48)
	SetBlipAlpha (mainblip, 0.9)
    SetBlipAsShortRange(mainblip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Vanilla Unicorn")
    EndTextCommandSetBlipName(mainblip)
end)