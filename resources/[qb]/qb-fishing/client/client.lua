local QBCore = exports['qb-core']:GetCoreObject()
local fishing = false
local pause = false
local pausetimer = 0
local correct = 0
local genderNum = 0
local peds = {} 

--============================================================== For testing

if Config.TestFish then 
	RegisterCommand("startfish", function(source)
		TriggerEvent("fishing:fishstart")
	end)

	RegisterCommand('spawnfish', function()
	 	TriggerServerEvent('fishing:server:catch') 
	end)
end

--============================================================== Threads

-- Spawning Thread

local function spawnPeds()
    if not Config.Peds or not next(Config.Peds) or pedsSpawned then return end
    for i = 1, #Config.Peds do
        local current = Config.Peds[i]
        RequestModel(current.model)
        while not HasModelLoaded(current.model) do
            Wait(1)
        end
        local ped = CreatePed(0, current.model, current.coords.x, current.coords.y, current.coords.z, current.coords.w, false, false)
        SetBlockingOfNonTemporaryEvents(ped, true)	
		FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
		TaskStartScenarioInPlace(ped, current.scenario)
		local opts = nil
		if current.fishingstore then
			opts = {
				{
					event = "doj:client:SellLegalFish",
					icon = "fa fa-fish",
					label = "Sell Fish",
				},
				-- {
				-- 	event = "jacko_fishing:openshop",
				-- 	icon = "fas fa-fish",
				-- 	label = "Fishing Gear",
				-- },
				{
					event = "doj:client:SellillegalFish",
					icon = "fa fa-fish",
					label = "Sell Exotic Fish",
				}
			}
		end
		if opts then
			exports[Config.targetExport]:AddTargetEntity(ped, {
				options = opts,
			})
		end
    end
	pedsSpawned = true
end

CreateThread(function()
	while true do
		Wait(1200)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1)
		if fishing then
				if IsControlJustReleased(0, 23) then
					input = 1
			   	end

			if IsControlJustReleased(0, Config.StopFishing) then
				endFishing()
				QBCore.Functions.Notify('You Stopped Fishing', 'error', 3000)
			end

			if fishing then
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(playerPed)
				if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z -3.0)  then
				else
					endFishing()
					QBCore.Functions.Notify('Water isnt deep enough to fish', 'error', 3000)
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					endFishing()
					QBCore.Functions.Notify('Fishing ended', 'error', 3000)
				end
			end 

			if pausetimer > 3 then
				input = 99
			end

			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerEvent('fishing:SkillBar')
				else
					QBCore.Functions.Notify('The Fish Escaped!', 'error', 3000)
					exports['qb-core']:HideText()
					loseBait()
					endFishing()
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		local wait = math.random(Config.FishingWaitTime.minTime , Config.FishingWaitTime.maxTime)
		Wait(wait)
		if fishing then
			pause = true
			correct = 1
			QBCore.Functions.Notify('A fish approaches', 'primary', 3000)
			exports['qb-core']:DrawText('Press [F] to Catch Fish!', 'left')
			input = 0
			pausetimer = 0
		end
	end
end)

CreateThread(function()
	-- while true do
	-- 	Wait(500)
	-- 	for k = 1, #Config.PedList, 1 do
	-- 		v = Config.PedList[k]
	-- 		local playerCoords = GetEntityCoords(PlayerPedId())
	-- 		local dist = #(playerCoords - v.coords)

	-- 		if dist < 50.0 and not peds[k] then
	-- 			local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
	-- 			peds[k] = {ped = ped}
	-- 		end

	-- 		if dist >= 50.0 and peds[k] then
	-- 			for i = 255, 0, -51 do
	-- 				Wait(50)
	-- 				SetEntityAlpha(peds[k].ped, i, false)
	-- 			end
	-- 			DeletePed(peds[k].ped)
	-- 			peds[k] = nil
	-- 		end
	-- 	end
	-- end
	spawnPeds()
end)

--============================================================== Events

RegisterNetEvent('fishing:client:progressBar', function()
	exports['progressBars']:drawBar(1000, 'Opening Tackel Box')
end)

RegisterNetEvent('fishing:client:attemptTreasureChest', function()
	local ped = PlayerPedId()
	attemptTreasureChest()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
			QBCore.Functions.Progressbar("accepted_key", "Inserting Key..", (math.random(2000, 5000)), false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "mini@repair",
				anim = "fixing_a_player",
				flags = 16,
			}, {}, {}, function() -- Done
				ClearPedTasks(ped)
				openedTreasureChest()
			end, function() -- Cancel
				ClearPedTasks(ped)
				QBCore.Functions.Notify("Canceled!", "error")
			end)
		else
		  QBCore.Functions.Notify("You dont have a key to this lock!", "error")
		end
	  end, 'fishingkey')
end)


RegisterNetEvent('fishing:SkillBar', function(message)
	local time = math.random(6,10)
    local circles = math.random(1,2)
	local success = exports['qb-lock']:StartLockPickCircle(circles, time, success)
	if success then
		catchAnimation()
	else
		QBCore.Functions.Notify('The Fish Got Away!', 'error')
		endFishing()
		loseBait()
	end	
end)

RegisterNetEvent('fishing:client:spawnFish', function(args)
	local time = 10000
	local args = tonumber(args)
	if args == 1 then 
		RequestTheModel("A_C_KillerWhale")
		local pos = GetEntityCoords(PlayerPedId())
		local ped = CreatePed(29, `A_C_KillerWhale`, pos.x, pos.y, pos.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_KillerWhale`)
		Wait(time)
		DeletePed(ped)	
	elseif args == 2 then 
		RequestTheModel("A_C_dolphin")
		local pos = GetEntityCoords(PlayerPedId())
		local ped = CreatePed(29, `A_C_dolphin`, pos.x, pos.y, pos.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_dolphin`)
		Wait(time)
		DeletePed(ped)
	elseif args == 3 then
		RequestTheModel("A_C_sharkhammer")
		local pos = GetEntityCoords(PlayerPedId())
		local ped = CreatePed(29, `A_C_sharkhammer`, pos.x, pos.y, pos.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_sharkhammer`)
		Wait(time)
		DeletePed(ped)
	elseif args == 4 then
		RequestTheModel("A_C_SharkTiger")
		local pos = GetEntityCoords(PlayerPedId())
		local ped = CreatePed(29, `A_C_SharkTiger`, pos.x, pos.y, pos.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_SharkTiger`)
		Wait(time)
		DeletePed(ped)
	elseif args == 5 then
		RequestTheModel("A_C_stingray")
		local pos = GetEntityCoords(PlayerPedId())
		local ped = CreatePed(29, `A_C_stingray`, pos.x, pos.y, pos.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_stingray`)
		Wait(time)
		DeletePed(ped)
	else
		RequestTheModel("a_c_fish")
		local pos = GetEntityCoords(PlayerPedId())
		local ped = CreatePed(29, `a_c_fish`, pos.x, pos.y, pos.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`a_c_fish`)
		Wait(time)
		DeletePed(ped)
	end
end)

-- RegisterNetEvent('fishing:client:useFishingBox', function(BoxId)
-- 	TriggerServerEvent("inventory:server:OpenInventory", "stash", 'FishingBox_'..BoxId, {maxweight = 50000, slots = 20})
-- 	TriggerEvent("inventory:client:SetCurrentStash", 'FishingBox_'..BoxId) 
-- end) 

RegisterNetEvent('fishing:fishstart', function()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed) 
	if IsPedSwimming(playerPed) then return QBCore.Functions.Notify("You can't be swimming and fishing at the same time.", "error") end 
	if IsPedInAnyVehicle(playerPed) then return QBCore.Functions.Notify("You need to exit your vehicle to start fishing.", "error") end 
	if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z - 3.0)  then
		local time = 1000
		QBCore.Functions.Notify('Using Fishing Rod', 'primary', time)
		Wait(time)
		-- exports['qb-core']:DrawText('Press [X] to stop fishing at any time', 'left')
		fishAnimation()
	else
		QBCore.Functions.Notify('You need to go further away from the shore', 'error')
	end
end, false)


--============================================================== Functions

loseBait = function()
	local chance = math.random(1, 100)
	if chance <= 75 then
		TriggerServerEvent("fishing:server:removeFishingBait")
		loseBaitAnimation()
	else
		endFishing()
		QBCore.Functions.Notify('You lost your bait', 'primary')
	end
end

loseBaitAnimation = function()
	local ped = PlayerPedId()
	local animDict = "gestures@f@standing@casual"
	local animName = "gesture_damn"
	DeleteEntity(rodHandle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 0, 0, 0, 48, 0)
	RemoveAnimDict(animDict)
	exports['qb-core']:DrawText('Fish took your bait!', 'left')
	Wait(2000)
	exports['qb-core']:HideText()
	endFishing()
end

RequestTheModel = function(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

catchAnimation = function()
	local ped = PlayerPedId()
	local animDict = "mini@tennis"
	local animName = "forehand_ts_md_far"
	DeleteEntity(rodHandle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 0, 0, 0, 48, 0)
	local time = 1750
	QBCore.Functions.Notify('Fish Caught!', 'success', time)
	Wait(time)
	TriggerServerEvent('fishing:server:catch')
	if math.random(1, 100) < 50 then
		TriggerServerEvent('hud:server:RelieveStress', 50)
	-- elseif math.random(1,100) <= 99 then
	-- 	TriggerServerEvent("fishing:server:addTackleBox")
	end
	PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	RemoveAnimDict(animDict)
	Wait(1000)
	endFishing()
end

fishAnimation = function()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
			local ped = PlayerPedId()
			local animDict = "amb@world_human_stand_fishing@idle_a"
			local animName = "idle_c"
			RequestAnimDict(animDict)
			while not HasAnimDictLoaded(animDict) do
				Wait(100)
			end
			TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 11, 0, 0, 0, 0)
			fishingRodEntity()
			fishing = true
			Wait(3700)
			exports['qb-core']:HideText() 
		else
		  endFishing()
		  QBCore.Functions.Notify("You dont have any fishing bait", "error")
		end
	end, 'fishbait')
end

fishingRodEntity = function()
	local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
	local fishingRodHash = `prop_fishing_rod_01`
	local bone = GetPedBoneIndex(ped, 18905)
    rodHandle = CreateObject(fishingRodHash, pedPos, true)
    AttachEntityToEntity(rodHandle, ped, bone, 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
end

endFishing = function() 
	local ped = PlayerPedId()
	DeleteObject(rodHandle)
	ClearPedTasks(ped)
	fishing = false
	rodHandle = 0
	exports['qb-core']:HideText()
end

attemptTreasureChest = function()
	local ped = PlayerPedId()
	local animDict = "veh@break_in@0h@p_m_one@"
	local animName = "low_force_entry_ds"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
	RemoveAnimDict(animDict)
	QBCore.Functions.Notify('Attempting to open Treasure Chest', 'primary', 1500)
	Wait(1500)
	ClearPedTasks(PlayerPedId())
end

openedTreasureChest = function()
	TriggerServerEvent("QBCore:Server:RemoveItem", "fishingkey", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["fishingkey"], "remove", 1)
	QBCore.Functions.Notify("The corroded key has snapped", "error", 7500)

	TriggerServerEvent("QBCore:Server:RemoveItem", "fishinglootbig", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["fishinglootbig"], "remove", 1)
	QBCore.Functions.Notify("Treasure chest opened!", "success", 7500)
	TriggerServerEvent("Brad:GiveItem")
	-- local ShopItems = {} 
	-- ShopItems.label = "Treasure Chest"
	-- ShopItems.items = Config.largeLootboxRewards
	-- ShopItems.slots = Config.largeLootboxRewards
	-- TriggerServerEvent("inventory:server:OpenInventory", "stash", "TreasureChest", ShopItems)
end

-- nearPed = function(model, coords, heading, gender, animDict, animName, scenario)
-- 	RequestModel(GetHashKey(model))
-- 	while not HasModelLoaded(GetHashKey(model)) do
-- 		Wait(1)
-- 	end

-- 	if gender == 'male' then
-- 		genderNum = 4
-- 	elseif gender == 'female' then 
-- 		genderNum = 5
-- 	else
-- 		print("No gender provided! Check your configuration!")
-- 	end	

-- 	ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
-- 	SetEntityAlpha(ped, 0, false)

-- 	FreezeEntityPosition(ped, true)
-- 	SetEntityInvincible(ped, true)
-- 	SetBlockingOfNonTemporaryEvents(ped, true)
-- 	if animDict and animName then
-- 		RequestAnimDict(animDict)
-- 		while not HasAnimDictLoaded(animDict) do
-- 			Wait(1)
-- 		end
-- 		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
-- 	end
-- 	if scenario then
-- 		TaskStartScenarioInPlace(ped, scenario, 0, true) 
-- 	end
-- 	for i = 0, 255, 51 do
-- 		Wait(50)
-- 		SetEntityAlpha(ped, i, false)
-- 	end

-- 	return ped
-- end