-- Variables
local currentGarage = 0
local inFingerprint = false
local FingerPrintSessionId = nil
local inDuty = false
local inStash = false
local inTrash = false
local inAmoury = false
local inHelicopter = false
local inImpound = false
local inGarage = false
local GarageZones = {}
local policeradialID = nil
local PlayerJob = QBCore.Functions.GetPlayerData().job
local Handsbefore, togglegloves = 0, false
local currentEvidence = nil

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

local function SetCarItemsInfo()
	local items = {}
	for _, item in pairs(Config.CarItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.CarItems = items
end

local function doCarDamage(currentVehicle, veh)
	local smash = false
	local damageOutside = false
	local damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0

	if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
	if body < 150.0 then body = 150.0 end
	if body < 950.0 then smash = true end
	if body < 920.0 then damageOutside = true end
	if body < 920.0 then damageOutside2 = true end

    Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end

	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end

	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end

	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

-- function TakeOutImpound(vehicle)
--     local coords = Config.Locations["impound"][currentGarage]
--     if coords then
--         QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
--             QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
--                 QBCore.Functions.SetVehicleProperties(veh, properties)
--                 SetVehicleNumberPlateText(veh, vehicle.plate)
--                 SetEntityHeading(veh, coords.w)
--                 exports['ps-fuel']:SetFuel(veh, vehicle.fuel)
--                 doCarDamage(veh, vehicle)
--                 TriggerServerEvent('police:server:TakeOutImpound', vehicle.plate, currentGarage)
--                 closeMenuFull()
--                 TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
--                 TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
--                 SetVehicleEngineOn(veh, true, true)
--             end, vehicle.plate)
--         end, coords, true)
--     end
-- end

local function IsArmoryWhitelist() -- being removed
    local retval = false

    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        retval = true
    end
    return retval
end

local function SetWeaponSeries()
    for k, _ in pairs(Config.Items.items) do
        if Config.Items.items[k].type == "weapon" then
            Config.Items.items[k].info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
    end
end

-- Sort values Function @jackbatchiee (https://www.lua.org/pil/19.3.html)
function sortedKeys (t, f)
	local data = {}
	local sortvalue = {}
	for k,v in pairs(t) do
		table.insert(data, tonumber(v.order))
		sortvalue[v.order] = k
	end
	table.sort(data, f)
	local i = 0
	local iter = function ()
		i = i + 1
		if data[i] ~= nil then
		return sortvalue[tostring(data[i])], t[data[i]] end
	end
	return iter
end

-- function MenuImpound(currentSelection)
--     local impoundMenu = {
--         {
--             header = Lang:t('menu.impound'),
--             isMenuHeader = true
--         }
--     }
--     QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
--         local shouldContinue = false
--         if result == nil then
--             QBCore.Functions.Notify(Lang:t("error.no_impound"), "error", 5000)
--         else
--             shouldContinue = true
--             for _ , v in pairs(result) do
--                 local enginePercent = QBCore.Shared.Round(v.engine / 10, 0)
--                 local currentFuel = v.fuel
--                 local vname = QBCore.Shared.Vehicles[v.vehicle].name

--                 impoundMenu[#impoundMenu+1] = {
--                     header = vname.." ["..v.plate.."]",
--                     txt =  Lang:t('info.vehicle_info', {value = enginePercent, value2 = currentFuel}),
--                     params = {
--                         event = "police:client:TakeOutImpound",
--                         args = {
--                             vehicle = v,
--                             currentSelection = currentSelection
--                         }
--                     }
--                 }
--             end
--         end


--         if shouldContinue then
--             impoundMenu[#impoundMenu+1] = {
--                 header = Lang:t('menu.close'),
--                 txt = "",
--                 params = {
--                     event = "qb-menu:client:closeMenu"
--                 }
--             }
--             exports['qb-menu']:openMenu(impoundMenu)
--         end
--     end)

-- end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

--NUI Callbacks
RegisterNUICallback('closeFingerprint', function(_, cb)
    SetNuiFocus(false, false)
    inFingerprint = false
    cb('ok')
end)

--Events
RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(_, cb)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
    cb("ok")
end)

RegisterNetEvent('police:client:SendEmergencyMessage', function(coords, message)
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Wait(1000)
    CreateThread(function()
        while isCalling do
            Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('qb-policejob:client:ActivatePanicButton', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then 

                    RequestAnimDict('random@arrests')
                    while not HasAnimDictLoaded('random@arrests') do
                        Wait(10)
                    end
                    TaskPlayAnim(PlayerPedId(), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                    
                    local data = exports['cd_dispatch']:GetPlayerInfo()
                    TriggerServerEvent('cd_dispatch:AddNotification', {
                        job_table = {'police', 'ambulance'},
                        coords = data.coords,
                        title = 'Code Zero',
                        message = 'An emergency worker needs urgent assistance on '..data.street,
                        flash = 1,
                        unique_id = tostring(math.random(0000000,9999999)),
                        blip = {
                            sprite = 162,
                            scale = 1.2,
                            colour = 3,
                            flashes = true,
                            text = 'Panic Button',
                            time = (5*60*1000),
                            sound = 4,
                        }
                    })
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 15, "emergency", 0.5)
                    Wait(2500)
                    StopAnimTask(PlayerPedId(), "random@arrests", "generic_radio_enter", -4.0)
            else
                QBCore.Functions.Notify('You don\'t have a radio', 'error', 3000)
            end
        end, "radio")
    else
        QBCore.Functions.Notify('You cannot perform that action', 'error', 3000)
    end
end)

--------------------------------------------------------------------------------------------[[ NEW CAR SEIZURE FEATURES ]]-------------------------------------------------------------------------------

RegisterNetEvent('police:client:SeizeCar', function()
    -- local vehicle = QBCore.Functions.GetClosestVehicle()
       
    

    local lastcar = GetPlayersLastVehicle()
    local vehicletoimpound = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(lastcar))
    local engineDamage = math.ceil(GetVehicleEngineHealth(lastcar))
    local totalFuel = exports['ps-fuel']:GetFuel(lastcar)

    -- lastcar ~= 0 and lastcar ~= nil

    if vehicletoimpound == lastcar then
        -- print("The last car is: ", lastcar)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(lastcar)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            local plate = QBCore.Functions.GetPlate(lastcar)
            QBCore.Functions.Progressbar('police_seizecar', 'Seizing Vehicle', Config.SeizeTime * 1000, false, true, {
                disableMovement = false,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, -- Disable Controls
            {
                animDict = "missheistdockssetup1clipboard@base",
                anim = "base",
                flags = 1,
            }, -- Animation
            {
                model = "prop_notepad_01",
                bone = 18905,
                coords = { x = 0.1, y = 0.00, z = 0.05 },
                rotation = { x = 10.0, y = 0.0, z = 0.0 },
            }, -- Prop 1
            {
                model = "prop_pencil_01",
                bone = 57005,
                coords = { x = 0.0, y = 0.0, z = 0.00 },
                rotation = { x = 0.0, y = 0.0, z = 0.0 },
            }, -- Prop 2
            function() -- done
                StopAnimTask(ped, "missheistdockssetup1clipboard@base", "base", 1.0)

                TriggerServerEvent("police:server:SeizeVehicle", plate, bodyDamage, engineDamage, totalFuel)

                TriggerEvent('persistent-vehicles/forget-vehicle', lastcar)

                QBCore.Functions.DeleteVehicle(lastcar)
                ClearPedTasks(ped)
                QBCore.Functions.Notify("Vehicle with plate: "..plate.." Seized", 'success', 5000)

                local Player = QBCore.Functions.GetPlayerData()    
                local id = PlayerId()
                local serverid = GetPlayerServerId(id)
                local officername = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
                local citizenId = Player.citizenid
                
                TriggerServerEvent("qb-log:server:CreateLog", "police", "POLICE IMPOUND", "red", "**".. officername .. "** (**CitizenID**: *"..citizenId.."* | ID: **"..serverid.." **) Has Seized a: Vehicle with PLATE: **"..plate.."**")
                

            end, function() -- Cancel
                StopAnimTask(ped, "amb@prop_human_bbq@male@base", "base", 1.0)
                ClearPedTasks(ped)
                QBCore.Functions.Notify('Process Canceled', 'error')            
            end, "fa-solid fa-truck-pickup")
        end
    else
        QBCore.Functions.Notify("No Vehicle Found, Get in it first", 'error', 5000)
    end

end)

--------------------------------------------------------------------------------------------[[ NEW CAR IMPOUND FEATURES ]]-------------------------------------------------------------------------------
RegisterNetEvent("police:client:StartImpounding", function ()
    local dialog = exports['qb-input']:ShowInput({
        header = "Police Vehicle Impound",
        submitText = "Impound Vehicle",
        inputs = {
          {
            text = "Price to release", -- text you want to be displayed as a place holder
            name = "price", -- name of the input should be unique otherwise it might override
            type = "number", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          }
        },
      })
    
      if dialog then
        if not dialog.price then return end
        TriggerEvent('police:client:ImpoundCar', dialog.price)
      end
end)

RegisterNetEvent('police:client:ImpoundCar', function(price)
    -- local vehicle = QBCore.Functions.GetClosestVehicle()
       
   

    local lastcar = GetPlayersLastVehicle()
    local vehicletoimpound = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(lastcar))
    local engineDamage = math.ceil(GetVehicleEngineHealth(lastcar))
    local totalFuel = exports['ps-fuel']:GetFuel(lastcar)

    -- lastcar ~= 0 and lastcar ~= nil

    if vehicletoimpound == lastcar then
        -- print("The last car is: ", lastcar)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(lastcar)
        local plate = QBCore.Functions.GetPlate(lastcar)

        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then

            QBCore.Functions.Progressbar('police_impound', 'Impounding Vehicle', Config.ImpoundTime * 1000, false, true, {
                disableMovement = false,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, -- Disable Controls
            {
                animDict = "missheistdockssetup1clipboard@base",
                anim = "base",
                flags = 1,
            }, -- Animation
            {
                model = "prop_notepad_01",
                bone = 18905,
                coords = { x = 0.1, y = 0.00, z = 0.05 },
                rotation = { x = 10.0, y = 0.0, z = 0.0 },
            }, -- Prop 1
            {
                model = "prop_pencil_01",
                bone = 57005,
                coords = { x = 0.0, y = 0.0, z = 0.00 },
                rotation = { x = 0.0, y = 0.0, z = 0.0 },
            }, -- Prop 2
            function() -- done
                StopAnimTask(ped, "missheistdockssetup1clipboard@base", "base", 1.0)

                TriggerServerEvent("police:server:ImpoundCar", plate, price, bodyDamage, engineDamage, totalFuel)
                TriggerEvent('persistent-vehicles/forget-vehicle', lastcar)
                QBCore.Functions.DeleteVehicle(lastcar)
                ClearPedTasks(ped)
                QBCore.Functions.Notify("Vehicle with plate: "..plate.." Impounded with a retrieval price of: £"..price, 'success', 5000)

                local Player = QBCore.Functions.GetPlayerData()    
                local id = PlayerId()
                local serverid = GetPlayerServerId(id)
                local officername = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
                local citizenId = Player.citizenid
                
                TriggerServerEvent("qb-log:server:CreateLog", "police", "POLICE IMPOUND", "red", "**".. officername .. "** (**CitizenID**: *"..citizenId.."* | ID: **"..serverid.." **) Has Impounded a: Vehicle with PLATE: **"..plate.."** (Price: **£"..price..")**")

            end,
            function() -- Cancel
                StopAnimTask(ped, "amb@prop_human_bbq@male@base", "base", 1.0)
                ClearPedTasks(ped)
                QBCore.Functions.Notify('Process Canceled', 'error', 5000)         
            end, "fa-solid fa-triangle-exclamation")
        else
            QBCore.Functions.Notify("You are trying to impound: "..plate.." while being sat inside it or too far away", 'error', 5000)
        end
    else
        -- print("The last car is: "..lastcar.." and the car nearest is: "..vehicletoimpound)
        QBCore.Functions.Notify("No Vehicle Found, Get in it first", 'error', 5000)
    end

end)

--------------------------------------------------------------------------------------------[[ END OF NEW FEATURES ]]-------------------------------------------------------------------------------
-- RegisterNetEvent('police:client:ImpoundVehicle', function(fullImpound, price)
--     local vehicle = QBCore.Functions.GetClosestVehicle()
--     local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
--     local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
--     local totalFuel = exports['ps-fuel']:GetFuel(vehicle)
--     if vehicle ~= 0 and vehicle then
--         local ped = PlayerPedId()
--         local pos = GetEntityCoords(ped)
--         local vehpos = GetEntityCoords(vehicle)
--         if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
--             local plate = QBCore.Functions.GetPlate(vehicle)
--             TriggerServerEvent("police:server:Impound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel)
--             QBCore.Functions.DeleteVehicle(vehicle)
--         end
--     end
-- end)

RegisterNetEvent('police:client:CheckStatus', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result then
                        for _, v in pairs(result) do
                            QBCore.Functions.Notify(''..v..'')
                        end
                    end
                end, playerId)
            else
                QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
            end
        end
    end)
end)


RegisterNetEvent("police:client:ImpoundMenuHeader", function (data)
    MenuImpound(data.currentSelection)
    currentGarage = data.currentSelection
end)

-- RegisterNetEvent('police:client:TakeOutImpound', function(data)
--     if inImpound then
--         local vehicle = data.vehicle
--         TakeOutImpound(vehicle)
--     end
-- end)


local function GetClosestLocation(locations, loc)
    local closestDistance = -1
    local closestIndex = -1
    local closestLocation = nil
    local plyCoords = loc or GetEntityCoords(PlayerPedId(), 0)
    for i,v in ipairs(locations) do
        local location = vector3(v.x, v.y, v.z)
        local distance = #(plyCoords - location)
        if(closestDistance == -1 or closestDistance > distance) then
            closestDistance = distance
            closestIndex = i
            closestLocation = v
        end
    end
    return closestIndex, closestDistance, closestLocation
end

RegisterNetEvent('police:client:EvidenceStashDrawer', function(data)
    local evidenceloc = data.evidencelocation
    local pos = GetEntityCoords(PlayerPedId())
    local takeLoc = Config.Locations["evidence"][evidenceloc]


    local drawer = exports['qb-input']:ShowInput({
        header = Lang:t('info.evidence_stash', {value = evidenceloc}),
        submitText = "open",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'slot',
                text = Lang:t('info.slot')
            }
        }
    })
    if drawer then
        if not drawer.slot then return end
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = evidenceloc, value2 = drawer.slot}), {
            maxweight = 4000000,
            slots = 500,
        })
        TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = evidenceloc, value2 = drawer.slot}))

        local Player = QBCore.Functions.GetPlayerData()    
        local id = PlayerId()
        local serverid = GetPlayerServerId(id)
        local officername = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
        local citizenId = Player.citizenid
        local lockerid = drawer.slot
        local drawerlocations = {
            [1] = {
                name = "Mission Row Main Evidence",
                type = "Master"
            }
        }


        local station = drawerlocations[evidenceloc].name
        
        TriggerServerEvent("qb-log:server:CreateLog", "police", "POLICE EVIDENCE", "blue", "**".. officername .. "** (**CitizenID**: *"..citizenId.."* | ID: **"..serverid.." **) Has Accessed Evidence Locker: **"..lockerid.."** [STATION NAME: **"..station.."**]")
    end
    exports['qb-menu']:closeMenu()

end)

-- Toggle Duty in an event.
RegisterNetEvent('qb-policejob:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateCurrentCops")
    -- TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('qb-police:client:scanFingerPrint', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:showFingerprint", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('qb-police:client:openArmoury', function()
    local Player = QBCore.Functions.GetPlayerData()
    local authorizedItems = {
        label = Lang:t('menu.pol_armory'),
        slots = 30,
        items = {}
    }
    local index = 1
    -- Custom armory whitelist @jackbatchiee
    for _, armoryItem in pairs(Config.Items.items) do
        for i=1, #armoryItem.authorizedFirearms do
            if (armoryItem.authorizedFirearms[i] == Player.metadata.jobflags.firearms and PlayerJob.grade.level >= 0) then
                authorizedItems.items[index] = armoryItem
                authorizedItems.items[index].slot = index
                index = index + 1
            end
        end
    end
    -- for _, armoryItem in pairs(Config.Items.items) do
    --     for i=1, #armoryItem.authorizedJobGrades do
    --         if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
    --             authorizedItems.items[index] = armoryItem
    --             authorizedItems.items[index].slot = index
    --             index = index + 1
    --         end
    --     end
    -- end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", authorizedItems)
end)

-- RegisterCommand('togglepoliceduty', function()
--     TriggerEvent('qb-policejob:ToggleDuty')
-- end)

RegisterNetEvent('qb-policejob:storecar', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    local DeletedPoliceCar = false
    if PlayerData.job.name == "police" then
        for k,v in pairs(Config.PoliceGarage.cars) do
            local deletevehiclemode = GetHashKey(v.model)
            if deletevehiclemode == GetEntityModel(car) then
                DeleteVehicle(car)
                DeleteEntity(car)
                DeletedPoliceCar = true
                QBCore.Functions.Notify('Vehicle Parked', "primary", 3000)  
                break    
            end
        end
        
        if not DeletedPoliceCar then
            QBCore.Functions.Notify('Police Vehicles Only', "error", 3000)
        end
    else
        QBCore.Functions.Notify('Police/NHS Only', "error", 3000)
    end
end)

RegisterNetEvent('qb-policejob:storeheli', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local heli = GetVehiclePedIsIn(PlayerPedId(),true)
    local DeletedPoliceHeli = false
    if PlayerData.job.name == "police" then
        for k,v in pairs(Config.PoliceGarage.air) do
            local deletevehiclemode = GetHashKey(v.model)
            if deletevehiclemode == GetEntityModel(heli) then
                DeleteVehicle(heli)
                DeleteEntity(heli)
                DeletedPoliceHeli = true
                QBCore.Functions.Notify('Vehicle Parked', "primary", 3000)  
                break    
            end
        end
        
        if not DeletedPoliceHeli then
            QBCore.Functions.Notify('Police Vehicles Only', "error", 3000)
        end
    else
        QBCore.Functions.Notify('Police/NHS Only', "error", 3000)
    end
end)

RegisterNetEvent('qb-policejob:HelicopterSpawn', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local helicopter = data.vehicle
    for k, v in pairs(Config.Locations['helicopter']) do
        if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            else
            local coords = Config.Locations["helicopter"][k]
            QBCore.Functions.SpawnVehicle(helicopter, function(veh)
                    SetVehicleNumberPlateText(veh, "INDIA-99"..tostring(math.random(1000, 9999)))
                    SetVehicleDirtLevel(veh, 0)
                    exports['ps-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.w)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            end
        end
    end
end)

RegisterNetEvent('qb-policejob:Helicopter', function()
    local helicopterMenu = {
        {
            header = "🚁 National Police Air Service",
            isMenuHeader = true
        }
    }

    local airlist = {}
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local police_data = PlayerData.metadata['jobflags']
    for k,_ in sortedKeys(Config.PoliceGarage.air) do
        local v = Config.PoliceGarage.air[k]
         -- for each item in the police garage in config.lua it adds to the cars list
        if v.access.flagName then
            if police_data[v.access.flagName] then
                if tonumber(police_data[v.access.flagName]) >= tonumber(v.access.flagLevel) then
                    table.insert(airlist, {label = v.name, veh = v.model})
                end
            end
        elseif PlayerData.job.grade.level >= v.access.jobGrade then
            table.insert(airlist, {label = v.name, veh = v.model})

        end
    end

    for label, vehicle in pairs(airlist) do
        helicopterMenu[#helicopterMenu+1] = {
            header = vehicle.label,
            txt = "",
            params = {
                event = "qb-policejob:HelicopterSpawn",
                args = {
                    vehicle = vehicle.veh
                }
            }
        }        
    end

    helicopterMenu[#helicopterMenu+1] = {
        header = "Store Helicopter",
        txt = "",
        params = {
            event = "qb-policejob:storeheli",
        }
    }
    helicopterMenu[#helicopterMenu+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(helicopterMenu)

    -- exports['qb-menu']:openMenu({
    --     {
    --         header = "🚁 National Police Air Service",
    --         isMenuHeader = true
    --     },
    --     {
    --         header = "Take Helicopter",
    --         txt = "",
    --         params = {
    --             event = "qb-policejob:HelicopterSpawn",
    --         }
    --     },
    --     {
    --         header = "Store Helicopter",
    --         txt = "",
    --         params = {
    --             event = "qb-policejob:storecar",
    --         }
    --     },
    --     {
    --         header = 'Close',
    --         txt = '',
    --         params = {
    --             event = 'qb-menu:closeMenu'
    --         }
    --     },
    -- }) 
end)

RegisterNetEvent('qb-policejob:VehicleGarage', function()
    local GarageMenu = {
        {
            header = "🚔 Vehicle Garage",
            isMenuHeader = true
        }
    }

    local PlayerData = QBCore.Functions.GetPlayerData()
    local police_data = PlayerData.metadata['jobflags']

    -- local carlist = {}
    -- local PlayerJob = QBCore.Functions.GetPlayerData().job
    -- local PlayerData = QBCore.Functions.GetPlayerData()
    -- local police_data = PlayerData.metadata['jobflags']
    -- for k,_ in sortedKeys(Config.PoliceGarage.cars) do
    --     local v = Config.PoliceGarage.cars[k]
    --      -- for each item in the police garage in config.lua it adds to the cars list
    --     if v.access.flagName then
    --         if police_data[v.access.flagName] then
    --             if tonumber(police_data[v.access.flagName]) >= tonumber(v.access.flagLevel) then
    --                 -- table.insert(carlist, {label = v.name, veh = v.model})
    --                 table.insert(carlist, {label = v.name, veh = v})
    --             end
    --         end
    --     elseif PlayerData.job.grade.level >= v.access.jobGrade then
    --         -- table.insert(carlist, {label = v.name, veh = v.model})
    --         table.insert(carlist, {label = v.name, veh = v})
    --     end
    -- end

    -- for label, vehicle in pairs(carlist) do
    --     GarageMenu[#GarageMenu+1] = {
    --         header = vehicle.label,
    --         txt = "",
    --         params = {
    --             event = "police:client:TakeOutVehicleNew",
    --             args = {
    --                 vehicle = vehicle.veh.model,
    --                 mods = vehicle.veh.mods,
    --                 name = vehicle.label,

    --             }
    --         }
    --     }        
    -- end

    GarageMenu[#GarageMenu+1] = {
        header = "👮‍♂️ Frontline Fleet",
        txt = "List of all frontline vehicles",
        params = {
            event = "qb-policejob:VehicleGarage_frontline",
        }
    }  

    if police_data.traffic >= 1 then
        GarageMenu[#GarageMenu+1] = {
            header = "🚥 Traffic Fleet",
            txt = "List of all Traffic Vehicles",
            params = {
                event = "qb-policejob:VehicleGarage_traffic",
            }
        }
    end

    if police_data.cid >= 1 then
        GarageMenu[#GarageMenu+1] = {
            header = "🕵️‍♀️ CID Fleet",
            txt = "List of all CID Vehicles",
            params = {
                event = "qb-policejob:VehicleGarage_cid",
            }
        }
    end

    if police_data.firearms >= 1 then
        GarageMenu[#GarageMenu+1] = {
            header = "🔫 Firearms Fleet",
            txt = "List of all Firearms Vehicles",
            params = {
                event = "qb-policejob:VehicleGarage_firearms",
            }
        }
    end

    GarageMenu[#GarageMenu+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(GarageMenu)
end)

RegisterNetEvent('qb-policejob:VehicleGarage_frontline', function()
    local GarageMenu_frontline = {
        {
            header = "👮‍♂️ Frontline Fleet",
            isMenuHeader = true
        }
    }

    local carlist = {}
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local police_data = PlayerData.metadata['jobflags']
    for k,_ in sortedKeys(Config.PoliceGarage.cars) do
        local v = Config.PoliceGarage.cars[k]
         -- for each item in the police garage in config.lua it adds to the cars list
        if not v.access.flagName and PlayerData.job.grade.level >= v.access.jobGrade then
            -- table.insert(carlist, {label = v.name, veh = v.model})
            table.insert(carlist, {label = v.name, veh = v})
        end
    end

    for label, vehicle in pairs(carlist) do
        GarageMenu_frontline[#GarageMenu_frontline+1] = {
            header = vehicle.label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicleNew",
                args = {
                    vehicle = vehicle.veh.model,
                    mods = vehicle.veh.mods,
                    name = vehicle.label,

                }
            }
        }        
    end

    GarageMenu_frontline[#GarageMenu_frontline+1] = {
        header = "< Go Back",
        txt = "",
        params = {
            event = "qb-policejob:VehicleGarage",
        }
    }

    GarageMenu_frontline[#GarageMenu_frontline+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(GarageMenu_frontline)
end)

RegisterNetEvent('qb-policejob:VehicleGarage_traffic', function()
    local GarageMenu_traffic = {
        {
            header = "🚥 Traffic Fleet",
            isMenuHeader = true
        }
    }

    local carlist = {}
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local police_data = PlayerData.metadata['jobflags']
    
    for k,_ in sortedKeys(Config.PoliceGarage.cars) do
        local v = Config.PoliceGarage.cars[k]
        if v.access.flagName and v.access.flagName == "traffic" then
            if police_data['traffic'] then
                if tonumber(police_data['traffic']) >= tonumber(v.access.flagLevel) then
                    table.insert(carlist, {label = v.name, veh = v})
                end
            end
        end
    end

    for label, vehicle in pairs(carlist) do
        GarageMenu_traffic[#GarageMenu_traffic+1] = {
            header = vehicle.label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicleNew",
                args = {
                    vehicle = vehicle.veh.model,
                    mods = vehicle.veh.mods,
                    name = vehicle.label,

                }
            }
        }        
    end

    GarageMenu_traffic[#GarageMenu_traffic+1] = {
        header = "< Go Back",
        txt = "",
        params = {
            event = "qb-policejob:VehicleGarage",
        }
    }

    GarageMenu_traffic[#GarageMenu_traffic+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(GarageMenu_traffic)
end)

RegisterNetEvent('qb-policejob:VehicleGarage_cid', function()
    local GarageMenu_cid = {
        {
            header = "🕵️‍♀️ CID Fleet",
            isMenuHeader = true
        }
    }

    local carlist = {}
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local police_data = PlayerData.metadata['jobflags']
    
    for k,_ in sortedKeys(Config.PoliceGarage.cars) do
        local v = Config.PoliceGarage.cars[k]
        if v.access.flagName and v.access.flagName == "cid" then
            if police_data['cid'] then
                if tonumber(police_data['cid']) >= tonumber(v.access.flagLevel) then
                    table.insert(carlist, {label = v.name, veh = v})
                end
            end
        end
    end

    for label, vehicle in pairs(carlist) do
        GarageMenu_cid[#GarageMenu_cid+1] = {
            header = vehicle.label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicleNew",
                args = {
                    vehicle = vehicle.veh.model,
                    mods = vehicle.veh.mods,
                    name = vehicle.label,

                }
            }
        }        
    end

    GarageMenu_cid[#GarageMenu_cid+1] = {
        header = "< Go Back",
        txt = "",
        params = {
            event = "qb-policejob:VehicleGarage",
        }
    }

    GarageMenu_cid[#GarageMenu_cid+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(GarageMenu_cid)
end)

RegisterNetEvent('qb-policejob:VehicleGarage_firearms', function()
    local GarageMenu_firearms = {
        {
            header = "🔫 Firearms Fleet",
            isMenuHeader = true
        }
    }

    local carlist = {}
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local police_data = PlayerData.metadata['jobflags']
    
    for k,_ in sortedKeys(Config.PoliceGarage.cars) do
        local v = Config.PoliceGarage.cars[k]
        if v.access.flagName and v.access.flagName == "firearms" then
            if police_data['firearms'] then
                if tonumber(police_data['firearms']) >= tonumber(v.access.flagLevel) then
                    table.insert(carlist, {label = v.name, veh = v})
                end
            end
        end
    end

    for label, vehicle in pairs(carlist) do
        GarageMenu_firearms[#GarageMenu_firearms+1] = {
            header = vehicle.label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicleNew",
                args = {
                    vehicle = vehicle.veh.model,
                    mods = vehicle.veh.mods,
                    name = vehicle.label,

                }
            }
        }        
    end

    GarageMenu_firearms[#GarageMenu_firearms+1] = {
        header = "< Go Back",
        txt = "",
        params = {
            event = "qb-policejob:VehicleGarage",
        }
    }

    GarageMenu_firearms[#GarageMenu_firearms+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(GarageMenu_firearms)
end)

RegisterNetEvent('qb-policejob:receptionmenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "🔔 Police Reception",
            isMenuHeader = true
        },
        {
            header = "Sign In/Out",
            txt = "Toggle Police Duty",
            params = {
                event = "qb-policejob:ToggleDuty",
            }
        },
        {
            header = "📜 Police Application",
            txt = "Apply for the Los Santos Police Service",
            params = {
                event = "qb-policejob:AccessApplication",
            }
        },
        {
            header = 'Close',
            txt = '',
            params = {
                event = 'qb-menu:closeMenu'
            }
        },
    })
end)

RegisterNetEvent('qb-policejob:AccessApplication', function()
    exports['jobapplications']:ShowApplication(true, "police")
end)



-- Threads

if Config.UseTarget then
    CreateThread(function()
        -- Toggle Duty
        for k, v in pairs(Config.Locations["duty"]) do
            exports['qb-target']:AddBoxZone("PoliceDuty_"..k, vector3(v.x, v.y, v.z), 1.0, 1, {
                name = "PoliceDuty_"..k,
                heading = 0,
                debugpoly = false,
                minZ = 27.19,
                maxZ = 31.19,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-policejob:ToggleDuty",
                        icon = "fas fa-sign-in-alt",
                        label = "Sign In",
                        job = "police",
                    },
                    {
                        type = "client",
                        event = "qb-policejob:AccessApplication",
                        icon = "fas fa-pen-to-square",
                        label = "Apply for Police",
                    },
                },
                distance = 1.5
            })
        end

    end)

else
    -- Toggle Duty
    local dutyZones = {}
    for _, v in pairs(Config.Locations["duty"]) do
        dutyZones[#dutyZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 1.75, 1, {
            name="box_zone",
            debugpoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local dutyCombo = ComboZone:Create(dutyZones, {name = "dutyCombo", debugpoly = false})
    dutyCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inDuty = true
            if not onDuty then
                exports['qb-core']:DrawText("Police Reception",'left')
            else
                exports['qb-core']:DrawText("Police Reception",'left')
            end
        else
            inDuty = false
            exports['qb-core']:HideText()
        end
    end)

    -- Toggle Duty Thread
    CreateThread(function ()
        Wait(1000)
        while true do
            local sleep = 1000
            if inDuty and PlayerJob.name == "police" then
                sleep = 5
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('qb-policejob:receptionmenu')
                end
            end
            Wait(sleep)
        end
    end)
end

CreateThread(function()
    -- New evidence locker location @jackbatchiee
   

    local EvidenceZones = {}
    for k, v in pairs(Config.Locations["evidence"]) do
        EvidenceZones[#EvidenceZones+1] = PolyZone:Create(v.zones, {
            name= "EvidencePoly "..v.name,
            debugpoly = v.debug,
            minZ = v.Minz,
            maxZ = v.Maxz,
        })
    end

    local EvidenceCombo = ComboZone:Create(EvidenceZones, {name = "EvidenceCombo", debugpoly = false})
    EvidenceCombo:onPlayerInOut(function(isPointInside)
        if isPointInside and PlayerJob.name =="police" then
            for k, v in pairs(Config.Locations["evidence"]) do
                currentEvidence = k
                exports['qb-target']:AddPolyZone(v.name, v.zones, {
                    name = "Evidence Locker: "..v.name, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
                    debugPoly = v.debug, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
                    minZ = v.Minz,
                    maxZ = v.Maxz,
                },
                {
                    options = {
                        {
                            type = "client",
                            event = "police:client:EvidenceStashDrawer",
                            evidencelocation = currentEvidence,
                            icon = "fas fa-boxes-stacked",
                            label = "Access Evidence",
                            job = "police",
                        },
                        {
                            type = "client",
                            event = "police:client:evidencetrash",
                            icon = "fas fa-dumpster",
                            label = "Access Evidence Trash",
                            job = "police",
                        },
                    },
                    distance = 1.5
                })
            end
        else
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Locations["evidence"]) do
                exports['qb-target']:RemoveZone(v.name)
            end
            currentEvidence = 0
        end
    end)

    -- for k, v in pairs(Config.Locations["evidence"]) do
        -- exports['qb-target']:AddBoxZone("evidence", vector3(vector3(v.x, v.y, v.z)), 5.2, 3, {
        --     name = "box_zone",
        --     heading = 1,
        --     debugPoly = true,
        --     minZ= v.z - 2,
        --     maxZ= v.z + 2,
        -- }, {
        --     options = {
        --         {
        --             type = "client",
        --             event = "police:client:EvidenceStashDrawer", currentEvidence = currentEvidence,
        --             icon = "fas fa-boxes-stacked",
        --             label = "Access Evidence",
        --             job = "police",
        --         },
        --         {
        --             type = "client",
        --             event = "police:client:evidencetrash",
        --             icon = "fas fa-dumpster",
        --             label = "Access Evidence Trash",
        --             job = "police",
        --         },
        --     },
        --     distance = 1.5
        -- })

        -- exports['qb-target']:AddPolyZone("name", v.zones, {
        --     name = v.name, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
        --     debugPoly = v.debug, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
        --     minZ = v.Minz,
        --     maxZ = v.Maxz,
        -- },
        -- {
        --     options = {
        --         {
        --             type = "client",
        --             event = "police:client:EvidenceStashDrawer", currentEvidence = currentEvidence,
        --             icon = "fas fa-boxes-stacked",
        --             label = "Access Evidence",
        --             job = "police",
        --         },
        --         {
        --             type = "client",
        --             event = "police:client:evidencetrash",
        --             icon = "fas fa-dumpster",
        --             label = "Access Evidence Trash",
        --             job = "police",
        --         },
        --     },
        --     distance = 1.5
        -- })

    -- end

    -- Custom Stash @jackbatchiee
    for _, v in pairs(Config.Locations["stash"]) do
        exports['qb-target']:AddBoxZone("stash", vector3(vector3(v.x, v.y, v.z)), 1, 0.5, {
            name = "box_zone",
            heading = 90,
            debugpoly = false,
            minZ=v.z - 2,
            maxZ=v.z + 2,
        }, {
            options = {
                {
                    type = "client",
                    event = "police:client:newstash",
                    icon = "fas fa-people-carry-box",
                    label = "Access Stash",
                    job = "police",
                }
            },
            distance = 1.5
        })
    end

    -- Custom stash event

    RegisterNetEvent('police:client:newstash', function()
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
    end)


    -- custom Evidence Trash
    RegisterNetEvent('police:client:evidencetrash', function()
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
            maxweight = 4000000,
            slots = 300,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
    end)

    for _, v in pairs(Config.Locations["fingerprint"]) do
        exports['qb-target']:AddBoxZone("fingerprints", vector3(vector3(v.x, v.y, v.z)), 3.0, 1.5, {
            name = "box_zone",
            heading = 90,
            debugpoly = false,
            minZ=v.z - 2,
            maxZ=v.z + 2,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-police:client:scanFingerPrint",
                    icon = "fas fa-fingerprint",
                    label = "Scan Fingerprint",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end

    -- for _, v in pairs(Config.Locations["armory"]) do
    --     exports['qb-target']:AddBoxZone("armory", vector3(vector3(v.x, v.y, v.z)), 3.8, 0.7, {
    --         name = "box_zone",
    --         heading = 0,
    --         debugpoly = false,
    --         minZ = 29.14,
    --         maxZ = 32.34,
    --     }, {
    --         --options = {
    --         --    {
    --         --        type = "client",
    --         --        event = "qb-police:client:openArmoury",
    --         --        icon = "fas fa-gun",
    --         --        label = "Access Armoury",
    --         --        job = "police",
    --         --    },
    --         --},
    --         distance = 1.5
    --     })
    -- end

    -- Helicopter
    local helicopterZones = {}
    for _, v in pairs(Config.Locations["helicopter"]) do
        helicopterZones[#helicopterZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 10, 10, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local helicopterCombo = ComboZone:Create(helicopterZones, {name = "helicopterCombo", debugpoly = false})
    helicopterCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inHelicopter = true
            if onDuty then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:HideText()
                    exports['qb-core']:DrawText(Lang:t('info.store_heli'), 'left')
                else
                    exports['qb-core']:DrawText(Lang:t('info.take_heli'), 'left')
                end
            end
        else
            inHelicopter = false
            exports['qb-core']:HideText()
        end
    end)

    -- Police Impound
    -- local impoundZones = {}
    -- for _, v in pairs(Config.Locations["impound"]) do
    --     impoundZones[#impoundZones+1] = BoxZone:Create(
    --         vector3(v.x, v.y, v.z), 1, 1, {
    --         name="box_zone",
    --         debugpoly = false,
    --         minZ = v.z - 1,
    --         maxZ = v.z + 1,
    --     })
    -- end

    -- local impoundCombo = ComboZone:Create(impoundZones, {name = "impoundCombo", debugpoly = false})
    -- impoundCombo:onPlayerInOut(function(isPointInside, point)
    --     if isPointInside then
    --         inImpound = true
    --         if onDuty then
    --             if IsPedInAnyVehicle(PlayerPedId(), false) then
    --                 exports['qb-core']:DrawText(Lang:t('info.impound_veh'), 'left')
    --             else
    --                 local currentSelection = 0

    --                 for k, v in pairs(Config.Locations["impound"]) do
    --                     if #(point - vector3(v.x, v.y, v.z)) < 4 then
    --                         currentSelection = k
    --                     end
    --                 end
    --                 exports['qb-menu']:showHeader({
    --                     {
    --                         header = Lang:t('menu.pol_impound'),
    --                         params = {
    --                             event = 'police:client:ImpoundMenuHeader',
    --                             args = {
    --                                 currentSelection = currentSelection,
    --                             }
    --                         }
    --                     }
    --                 })
    --             end
    --         end
    --     else
    --         inImpound = false
    --         exports['qb-menu']:closeMenu()
    --         exports['qb-core']:HideText()
    --     end
    -- end)
end)
--------------------------------------------------------------------------------------------[[ NEW CAR SPAWNING FEATURES ]]-------------------------------------------------------------------------------

local function CreatePoliceGarageZone()
    local combo = ComboZone:Create(GarageZones, {name = 'garages', debugPoly=false}) 
    combo:onPlayerInOut(function(isPointInside, _, zone)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            if LocalPlayer.state.isLoggedIn and PlayerJob.name == "police" then
                if isPointInside then
                    CurrentGarage = zone.name
                    exports['qb-core']:DrawText(Config.GarageZones[CurrentGarage]['drawText'], DrawTextPosition)
                else
                    CurrentGarage = nil
                    if policeradialID ~= nil then
                        exports['qb-radialmenu']:RemoveOption(policeradialID)
                        policeradialID = nil
                    end
                    exports['qb-core']:HideText()
                end
            end
        end)
    end)
end

local function CreatePoliceGaragePolyZone(garage)
    local zone = PolyZone:Create(Config.GarageZones[garage].Zone.Shape, {
        name = garage,
        minZ = Config.GarageZones[garage].Zone.minZ,
        maxZ = Config.GarageZones[garage].Zone.maxZ,
        debugPoly = Config.GarageZones[garage].debug
    })
    table.insert(GarageZones, zone)
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        print("the resource: " .. resource .. " has been restarted")
        for garageName, garage in pairs(Config.GarageZones) do
            CreatePoliceGaragePolyZone(garageName)
        end
        CreatePoliceGarageZone()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerJob.name == "police" then
            for garageName, garage in pairs(Config.GarageZones) do
                CreatePoliceGaragePolyZone(garageName)
            end
            CreatePoliceGarageZone()
        end
    end)
end)

RegisterNetEvent('police:client:ToggleGloves')
AddEventHandler('police:client:ToggleGloves', function()
	local drawableid = GetPedDrawableVariation(PlayerPedId(), 3)
	if not togglegloves then
		Handsbefore = drawableid
		if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
			if drawableid == 0 then
				drawableid = 85
			elseif drawableid == 1 then
				drawableid = 85
			elseif drawableid == 11 then
				drawableid = 85
			end
		elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
			if drawableid == 0 then
				drawableid = 85
			elseif drawableid == 1 then
				drawableid = 85
			elseif drawableid == 2 then
				drawableid = 85
			end
		end
	else
		drawableid = Handsbefore
	end

	togglegloves = not togglegloves

    RequestAnimDict("nmt_3_rcm-10")
    while not RequestAnimDict do
        Wait(1)
    end
    TaskPlayAnim(PlayerPedId(), 'nmt_3_rcm-10', 'cs_nigel_dual-10', 1.0, 3.0, -1, 48, 0.0, false, false, false)

    SetPedComponentVariation(PlayerPedId(), 3, drawableid, 0, 1)
    Wait(5000)
    ClearPedTasks(PlayerPedId())

end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    if PlayerJob.name == "police" then
        for garageName, garage in pairs(Config.GarageZones) do
            CreatePoliceGaragePolyZone(garageName)
        end
        CreatePoliceGarageZone()
    end
end)

function isvehicleapolicecar(vehicle, cb)
    for k,v in pairs(Config.PoliceGarage.cars) do
        if GetEntityModel(vehicle) == GetHashKey(v.model) then
            return true
        end
    end
end

exports("isitapolicecar", isvehicleapolicecar)


--------------------------------------------------------------------------------------------[[ NEW CAR SPAWNING FEATURES ]]-------------------------------------------------------------------------------
local function AddPoliceCarOptions()
    local Player = PlayerPedId()
    if IsPedInAnyVehicle(Player) then
        policeradialID = exports['qb-radialmenu']:AddOption({
            id = 'park_police_car',
            title = 'Park Vehicle',
            icon = 'square-parking',
            type = 'client',
            event = 'qb-policejob:storecar',
            shouldClose = true
        }, policeradialID)
    else
        policeradialID = exports['qb-radialmenu']:AddOption({
            id = 'access_police_car',
            title = 'Retrieve Vehicle',
            icon = 'warehouse',
            type = 'client',
            event = 'qb-policejob:VehicleGarage',
            shouldClose = true
        }, policeradialID)
    end
end

local function AddPoliceImpoundOptions()
    policeradialID = exports['qb-radialmenu']:AddOption({
        id = 'police_impound_list',
        title = 'Police Impound',
        icon = 'square-parking',
        type = 'client',
        event = 'police:client:AccessPoliceImpound',
        shouldClose = true
    }, policeradialID)

end

local function UpdatePoliceRadial()
    local garage = Config.GarageZones[CurrentGarage]
    if CurrentGarage ~= nil and garage ~= nil then
        if garage.type == 'vehicle' then
            -- print("police garage adding")
            AddPoliceCarOptions()
        elseif garage.type == 'policeimpound' then
            -- print("jack this is an impound for police")
            AddPoliceImpoundOptions()
        end
    else
        if policeradialID ~= nil then
            exports['qb-radialmenu']:RemoveOption(policeradialID)
            policeradialID = nil
        end
    end
end

RegisterNetEvent('police:client:TakeOutVehicleNew', function(data, cb)
    local vehicle = data.vehicle
    local mods = data.mods
    local garage = Config.GarageZones[CurrentGarage]
    local spawnDistance = Config.CarSpawnDistance
    local location
    local heading
    local closestDistance = -1
    local parkingSpots = garage.ParkingSpots or {}

    if next(parkingSpots) ~= nil then
        if Config.AllowSpawningFromAnywhere then
            local freeParkingSpots = {}
            for _, parkingSpot in ipairs(parkingSpots) do
                local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(parkingSpot.x,parkingSpot.y, parkingSpot.z))
                if veh == -1 or distance >= 1.5 then
                    freeParkingSpots[#freeParkingSpots+1] = parkingSpot
                end
            end
            _, _, location = GetClosestLocation(freeParkingSpots, SpawnAtLastParkinglot and (vehicle and (vehicle.parkingspot and vector3(vehicle.parkingspot.x, vehicle.parkingspot.y, vehicle.parkingspot.z) or nil) or nil) or nil)
            if location == nil then
                QBCore.Functions.Notify("No Spaces Available", "error", 4500)
            return end
            heading = location.w
        else
            _, closestDistance, location = GetClosestLocation(parkingSpots)
            local plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local spot = vector3(location.x, location.y, location.z)
            if SpawnAtLastParkinglot and vehicle and vehicle.parkingspot then
                spot = vehicle.parkingspot
            end
            local dist = #(plyCoords - vector3(spot.x, spot.y, spot.z))
            if SpawnAtLastParkinglot and dist >= spawnDistance then
                QBCore.Functions.Notify("You are too far from the parking bays", "error", 4500)
                return
            elseif closestDistance >= spawnDistance then
                QBCore.Functions.Notify("You are too far from the parking bays", "error", 4500)
                return
            else
                local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(location.x,location.y, location.z))
                if veh ~= -1 and distance <= 1.5 then
                    QBCore.Functions.Notify("Space Occupied", "error", 4500)
                return end
                heading = location.w
            end
        end
    else
        local ped = GetEntityCoords(PlayerPedId())
        local pedheadin = GetEntityHeading(PlayerPedId())
        local forward = GetEntityForwardVector(PlayerPedId())
        local x, y, z = table.unpack(ped + forward * 3)
        location = vector3(x, y, z)
        if VehicleHeading == 'forward' then
            heading = pedheadin
        elseif VehicleHeading == 'driverside' then
            heading = pedheadin + 90
        elseif VehicleHeading == 'hood' then
            heading = pedheadin + 180
        elseif VehicleHeading == 'passengerside' then
            heading = pedheadin + 270
        end
    end

    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetCarItemsInfo()
        SetVehicleNumberPlateText(veh, Lang:t('info.police_plate')..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, location.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        if Config.VehicleSettings[vehicleInfo] ~= nil then
            if Config.VehicleSettings[vehicleInfo].extras ~= nil then
                QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
            end
            if Config.VehicleSettings[vehicleInfo].livery ~= nil then
                SetVehicleLivery(veh, Config.VehicleSettings[vehicleInfo].livery)
            end
        end

        if mods ~= nil then
            if mods.turbo >= 1 then
                ToggleVehicleMod(veh, 18, true)
                SetVehicleFixed(veh)
            end
        end
        
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
        SetVehicleDoorsLocked(veh, 2)

        local Player = QBCore.Functions.GetPlayerData()    
        local id = PlayerId()
        local serverid = GetPlayerServerId(id)
        local officername = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
        local citizenId = Player.citizenid
        local plate = GetVehicleNumberPlateText(veh)
        local model = data.name
        
        TriggerServerEvent("qb-log:server:CreateLog", "police", "POLICE GARAGE", "blue", "**".. officername .. "** (**CitizenID**: *"..citizenId.."* | ID: **"..serverid.." **) Has Pulled a: **"..model.."** [PLATE: **"..plate.."**] from the Police Garage")

    end, location, true)
end)

-- radial menu event
RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    UpdatePoliceRadial()
end)
--------------------------------------------------------------------------------------------[[ NEW CAR SPAWNING FEATURES END ]]--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------[[ NEW CAR IMPOUND FEATURES ]]-------------------------------------------------------------------------------

RegisterNetEvent('police:client:AccessPoliceImpound', function()
    local impoundMenu = {
        {
            header = "🚨 - Police Impound",
            isMenuHeader = true
        }
    }
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify("No Vehicles in impound", "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = QBCore.Shared.Round(v.engine / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name
    
                impoundMenu[#impoundMenu+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt =  Lang:t('info.vehicle_info', {value = enginePercent, value2 = currentFuel}),
                    params = {
                        event = "police:client:TakeOutImpoundNew",
                        args = {
                            vehicle = v,
                            vehname = vname,
                        }
                    }
                }
            end
        end
    
    
        if shouldContinue then
            impoundMenu[#impoundMenu+1] = {
                header = Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            exports['qb-menu']:openMenu(impoundMenu)
        end
    end)
end)

RegisterNetEvent('police:client:TakeOutImpoundNew', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Police Impound Release Form",
        submitText = "Send",
        inputs = {
          {
            text = "Vehicle Owner", -- text you want to be displayed as a place holder
            name = "vehowner", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Reason For Release", -- text you want to be displayed as a place holder
            name = "reason", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
        },
      })
    
    if dialog then
        if not dialog.vehowner and not dialog.reason then return end
        local impounddata = data.vehicle
        local vehicle = impounddata.vehicle
        local garage = Config.GarageZones[CurrentGarage]
        local spawnDistance = Config.CarSpawnDistance
        local location
        local heading
        local closestDistance = -1
        local parkingSpots = garage.ParkingSpots or vector4(449.34, -1024.98, 27.89, 7.63)

        if next(parkingSpots) ~= nil then
            if Config.AllowSpawningFromAnywhere then
                local freeParkingSpots = {}
                for _, parkingSpot in ipairs(parkingSpots) do
                    local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(parkingSpot.x,parkingSpot.y, parkingSpot.z))
                    if veh == -1 or distance >= 1.5 then
                        freeParkingSpots[#freeParkingSpots+1] = parkingSpot
                    end
                end
                _, _, location = GetClosestLocation(freeParkingSpots, SpawnAtLastParkinglot and (vehicle and (vehicle.parkingspot and vector3(vehicle.parkingspot.x, vehicle.parkingspot.y, vehicle.parkingspot.z) or nil) or nil) or nil)
                if location == nil then
                    QBCore.Functions.Notify("No Spaces Available", "error", 4500)
                return end
                heading = location.w
            else
                _, closestDistance, location = GetClosestLocation(parkingSpots)
                local plyCoords = GetEntityCoords(PlayerPedId(), 0)
                local spot = vector3(location.x, location.y, location.z)
                if SpawnAtLastParkinglot and vehicle and vehicle.parkingspot then
                    spot = vehicle.parkingspot
                end
                local dist = #(plyCoords - vector3(spot.x, spot.y, spot.z))
                if SpawnAtLastParkinglot and dist >= spawnDistance then
                    QBCore.Functions.Notify("You are too far from the parking bays", "error", 4500)
                    return
                elseif closestDistance >= spawnDistance then
                    QBCore.Functions.Notify("You are too far from the parking bays", "error", 4500)
                    return
                else
                    local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(location.x,location.y, location.z))
                    if veh ~= -1 and distance <= 1.5 then
                        QBCore.Functions.Notify("Space Occupied", "error", 4500)
                    return end
                    heading = location.w
                end
            end
        else
            local ped = GetEntityCoords(PlayerPedId())
            local pedheadin = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(ped + forward * 3)
            location = vector3(x, y, z)
            if VehicleHeading == 'forward' then
                heading = pedheadin
            elseif VehicleHeading == 'driverside' then
                heading = pedheadin + 90
            elseif VehicleHeading == 'hood' then
                heading = pedheadin + 180
            elseif VehicleHeading == 'passengerside' then
                heading = pedheadin + 270
            end
        end
        QBCore.Functions.SpawnVehicle(vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, impounddata.plate)
                SetEntityHeading(veh, location.w)
                exports['ps-fuel']:SetFuel(veh, impounddata.fuel)
                doCarDamage(veh, impounddata)
                TriggerServerEvent('police:server:TakeOutImpound', impounddata.plate, currentGarage)
                closeMenuFull()
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, impounddata.plate)
        end, location, true)
        
        local Player = QBCore.Functions.GetPlayerData()    
        local id = PlayerId()
        local serverid = GetPlayerServerId(id)
        local officername = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
        local citizenId = Player.citizenid
        local plate = impounddata.plate
        local model = data.vehname
        
        TriggerServerEvent("qb-log:server:CreateLog", "police", "POLICE IMPOUND", "blue", "**".. officername .. "** (**CitizenID**: *"..citizenId.."* | ID: **"..serverid.." **) Has released a: **"..model.."** [PLATE: **"..plate.."**] from the police impound for: "..dialog.reason)
            
        end
end)
--------------------------------------------------------------------------------------------[[ NEW CAR IMPOUND FEATURES END ]]---------------------------------------------------------------------------

-- Personal Stash Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if LocalPlayer.state.isLoggedIn and inStash and PlayerJob.name == "police" then
            if onDuty then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
                TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Police Trash Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if LocalPlayer.state.isLoggedIn and inTrash and PlayerJob.name == "police" then
            if onDuty then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
                    maxweight = 4000000,
                    slots = 300,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Fingerprint Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if LocalPlayer.state.isLoggedIn and inFingerprint and PlayerJob.name == "police" then
            if onDuty then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerEvent("qb-police:client:scanFingerPrint")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Armoury Thread
-- CreateThread(function ()
--     Wait(1000)
--     while true do
--         local sleep = 1000
--         -- if LocalPlayer.state.isLoggedIn and inAmoury and PlayerJob.name == "police" then
--         if LocalPlayer.state.isLoggedIn and PlayerJob.name == "police" then
--             if onDuty then sleep = 5 end
--             if IsControlJustReleased(0, 38) then
--                 TriggerEvent("qb-police:client:openArmoury")
--             end
--         else
--             sleep = 1000
--         end
--         Wait(sleep)
--     end
-- end)

-- Helicopter Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if LocalPlayer.state.isLoggedIn and PlayerJob.name == "police" and inHelicopter then
            if onDuty then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerEvent("qb-policejob:Helicopter")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Police Impound Thread
-- CreateThread(function ()
--     Wait(1000)
--     while true do
--         local sleep = 1000
--         if LocalPlayer.state.isLoggedIn and inImpound and PlayerJob.name == "police" then
--             if onDuty then sleep = 5 end
--             if IsPedInAnyVehicle(PlayerPedId(), false) then
--                 if IsControlJustReleased(0, 38) then
--                     QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
--                 end
--             end
--         else
--             sleep = 1000
--         end
--         Wait(sleep)
--     end
-- end)

-- New Police Garage Thread
-- CreateThread(function ()
--     Wait(1000)
--     while true do
--         local sleep = 1000
--         if inGarage and PlayerJob.name == "police" then
--             if onDuty then sleep = 5 end
--             if IsControlJustReleased(0, 38) then
--                 TriggerEvent("qb-policejob:VehicleGarage")
--             end
--         else
--             sleep = 1000
--         end
--         Wait(sleep)
--     end
-- end)

RegisterNetEvent('police:client:RepairVehicle', function()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local getFuel = GetVehicleFuelLevel(plyVeh)

        if IsPedInAnyVehicle(PlayerPedId(), false) then

            DisableControlAction(1, 23, true)
            DisableControlAction(1, 75, true)
            DisableControlAction(1, 145, true)
            DisableControlAction(1, 185, true)
            DisableControlAction(1, 251, true)

            QBCore.Functions.Progressbar("rep_body", "Repairing Body", 3000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            }, {}, {}, {}, function() -- Done

            QBCore.Functions.Progressbar("rep_engine", "Repairing Engine", 3000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            }, {}, {}, {}, function() -- Done

            SetVehicleFixed(plyVeh)
            SetVehicleDirtLevel(plyVeh, 0.0)
            SetVehiclePetrolTankHealth(plyVeh, 4000.0)
            SetVehicleFuelLevel(plyVeh, getFuel)

            DisableControlAction(1, 23, false)
            DisableControlAction(1, 75, false)
            DisableControlAction(1, 145, false)
            DisableControlAction(1, 185, false)
            DisableControlAction(1, 251, false)

            for i = 0,5 do SetVehicleTyreFixed(plyVeh, i) end

            end)
        end)
    end
end)

CreateThread(function()
    repairZone = BoxZone:Create(vector3(Config.RepairLocations["mrpd"].coords.x, Config.RepairLocations["mrpd"].coords.y, Config.RepairLocations["mrpd"].coords.z), 9.0, 4.0, {
        name="repairZone",
        debugPoly = false,
        heading = 90.0,
        minZ = 24.5, 
        maxZ = 28.5,
    })

    repairZone:onPlayerInOut(function(isPointInside)
        insideRepair = isPointInside
        if isPointInside then
            exports['qb-core']:DrawText('[E] MRPD Motorworks', 'left')
        else
            exports['qb-core']:HideText()
        end
    end)

    while true do
        local sleep = 1000
        if insideRepair then
            sleep = 0
            if IsControlJustReleased(0, 38) then
                exports['qb-core']:KeyPressed()
                Wait(500)
                exports['qb-core']:HideText()
                TriggerEvent("police:client:RepairVehicle")
            end
        end
        Wait(sleep)
    end
end)