local QBCore = exports['qb-core']:GetCoreObject()
local chicken

local iscatching = false
local isprocessing = false
local ispackaging = false
local isselling = false


--[[
	ALive Chicken = alivechicken
	Cut up chicken = slaughteredchicken
	Packaged Chicken = packagedchicken
]]


local caughtchicken1 = 0
local caughtchicken2 = 0
local caughtchicken3 = 0
local caughtamount = 0
local share = false
local prop
local packagedup = false
local cardboard
local meat
local packages = 0

------------------------------------------------

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D2(x, y, z, text)
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

----
-------------------- start Catching Chicken ---------------------------------------
CreateThread(function()
    while true do
	Wait(0)
		local ped = PlayerPedId()
		local plyCoords = GetEntityCoords(ped)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.chickenstart.x, Config.chickenstart.y, Config.chickenstart.z)
		if dist <= 20.0 then
			DrawMarker(27, Config.chickenstart.x, Config.chickenstart.y, Config.chickenstart.z - 0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
			Wait(1500)
		end
		
		if dist <= 2.5 then
			DrawText3D2(Config.chickenstart.x, Config.chickenstart.y, Config.chickenstart.z, "~g~[E]~w~ To start catching chickens")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0,38) then -- "E"
				if not iscatching then
					iscatching = true
					QBCore.Functions.Progressbar("chicken_", "Gathering Alive Chicken", math.random(15000, 20000), false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "mini@repair",
						anim = "fixing_a_player",
						flags = 16,
					}, {}, {}, function()
						TriggerServerEvent("slaughtering:server:addalivechicken")
						ClearPedTasks(ped)
						iscatching = false
					end, function()
						ClearPedTasks(ped)
						QBCore.Functions.Notify("Canceled", "error")
						iscatching = false
					end)
				else
					QBCore.Functions.Notify("Looks Like you are already doing something", "error")
				end
			end			
		end
	end
end)

-------------Killing/Slaughtering the chicken ------------------
CreateThread(function()
    while true do
	Wait(0)
		local ped = PlayerPedId()
		local plyCoords = GetEntityCoords(ped)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Slaughterloc.x, Config.Slaughterloc.y, Config.Slaughterloc.z)
		if dist <= 20.0 then
			DrawMarker(27, Config.Slaughterloc.x, Config.Slaughterloc.y, Config.Slaughterloc.z - 0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
			Wait(1500)
		end
		
		if dist <= 2.5 then
			DrawText3D2(Config.Slaughterloc.x, Config.Slaughterloc.y, Config.Slaughterloc.z , "~g~[E]~w~ To Cut up the chicken")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0,38) then -- "E"
				if not isprocessing then
					isprocessing = true
					QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem) -- check to see if player has item (check bottom of this function to add item name)
						if hasItem then
							QBCore.Functions.Progressbar("chicken_", "Cutting up chicken..", math.random(5000, 10000), false, true, {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}, -- control actions
							{
								animDict = "anim@amb@business@coc@coc_unpack_cut_left@",
								anim = "coke_cut_v1_coccutter",
								flags = 63,
							}, -- Animation
							{
								model = "prop_knife",
								bone = 0,
								coords = { x = 0.13, y = 0.14, z = 0.09 },
								rotation = { x = 40.0, y = 0.0, z = 0.0 },
							}, -- Prop 1
							{
								model = "prop_int_cf_chick_01",
								bone = 57005,
								coords = { x = 0.0, y = 0.0, z = 0.00 },
								rotation = { x = 0.0, y = 0.0, z = 0.0 },
							}, -- Prop 2
							function() -- Task completed
								ClearPedTasks(ped)							
								TriggerServerEvent("slaughtering:server:processing", "slaughter")
								QBCore.Functions.Notify('You Make Slaughtered Chicken')
								isprocessing = false
							end,
							function() -- Task Cancelled
								ClearPedTasks(ped)
								QBCore.Functions.Notify("Canceled", "error")
								isprocessing = false
							end)
						else
							QBCore.Functions.Notify("You have no chickens", "error")
							isprocessing = false
						end
					end, 'alivechicken') -- Item name goes here example: end, "aed")
				else 
					QBCore.Functions.Notify("Looks Like you are already doing something", "error")
				end
			end			
		end
	end
end)

--------------- Selling the Chicken ---------------------------
CreateThread(function()
    while true do
		Wait(5)
		local ped = PlayerPedId()
		local plyCoords = GetEntityCoords(ped)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.selling.x, Config.selling.y, Config.selling.z)
		if dist <= 2.0 then
			DrawText3D2(Config.selling.x, Config.selling.y, Config.selling.z + 0.1, "[E] Sell Packed Chickens")
			if IsControlJustPressed(0,38) then 
				if not isselling then
					isselling = true
					SellChicken()
				else
					QBCore.Functions.Notify("Looks Like you are already doing something", "error")	
				end
			end
		end
	end
end)




------chicken packed----------------
CreateThread(function()
    while true do
	Wait(0)
		local ped = PlayerPedId()
		local plyCoords = GetEntityCoords(ped)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Packing2.x, Config.Packing2.y, Config.Packing2.z)
		if dist <= 20.0 then
			DrawMarker(27, Config.Packing2.x, Config.Packing2.y, Config.Packing2.z - 0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
			Wait(1500)
		end
		
		if dist <= 2.5 then
			DrawText3D2(Config.Packing2.x , Config.Packing2.y, Config.Packing2.z, "~g~[E]~w~ To pack chicken")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0,38) then -- "E"
				if not ispackaging then
					ispackaging = true
					QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem) -- check to see if player has item (check bottom of this function to add item name)
						if hasItem then
							QBCore.Functions.Progressbar("chicken_", "Packing the Chicken..", math.random(5000, 10000), false, true, {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							{
								animDict = "anim@heists@ornate_bank@grab_cash_heels",
								anim = "grab",
								flags = 63,
							},
							{},
							{},
							function()								
								packages = 0
								ClearPedTasks(ped)
								TriggerServerEvent("slaughtering:server:processing", "package")
								QBCore.Functions.Notify('You packed a chicken')
								ispackaging = false
							end,
							function()
								ClearPedTasks(ped)
								ispackaging = false
								QBCore.Functions.Notify("Canceled", "error")
							end)
						else
							QBCore.Functions.Notify("You have no chicken", "error")
							ispackaging = false
						end
					end, 'slaughteredchicken')
				else
					QBCore.Functions.Notify("Looks Like you are already doing something", "error")	
				end
			end
		end
	end
end)


-----

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end



--------------Selling-------------------------
function SellChicken()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem) -- check to see if player has item (check bottom of this function to add item name)
		if hasItem then
			QBCore.Functions.Progressbar("chicken_", "Selling Chicken..", math.random(3000, 7000), false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			{
				animDict = "switch@trevor@jerking_off",
				anim = "trev_jerking_off_loop",
				flags = 63,
			},
			{},{},
			function()
				ClearPedTasks(ped)
				TriggerServerEvent('chicken:sell', Config.Chickenprice)
				isselling = false
			end,
			function()
				ClearPedTasks(ped)
				isselling = false
				QBCore.Functions.Notify("Canceled", "error")
			end)
		else
			QBCore.Functions.Notify("You dont have any Chicken Fillets!", "error")
			isselling = false
		end
	end, 'packagedchicken')
end




