local PlayerJob = {}
local onDuty = false
local currentGarage = 0
local currentHospital
local inHelicopter = false
local inGarage = false
local inAmoury = false
local GarageZones = {}
local NHSMenuItemId = nil
local PlayerJob = QBCore.Functions.GetPlayerData().job

-- Functions

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
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

-- function TakeOutVehicle(vehicleInfo)
--     local coords = Config.Locations["vehicle"][currentGarage]
--     QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
--         SetVehicleNumberPlateText(veh, Lang:t('info.amb_plate')..tostring(math.random(1000, 9999)))
--         SetEntityHeading(veh, coords.w)
--         exports['ps-fuel']:SetFuel(veh, 100.0)
--         TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
--         if Config.VehicleSettings[vehicleInfo] ~= nil then
--             QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
--         end
--         TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
--         SetVehicleEngineOn(veh, true, true)
--     end, coords, true)
-- end

-- function MenuGarage()
--     local vehicleMenu = {
--         {
--             header = Lang:t('menu.amb_vehicles'),
--             isMenuHeader = true
--         }
--     }

--     local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
--     for veh, label in pairs(authorizedVehicles) do
--         vehicleMenu[#vehicleMenu+1] = {
--             header = label,
--             txt = "",
--             params = {
--                 event = "ambulance:client:TakeOutVehicle",
--                 args = {
--                     vehicle = veh
--                 }
--             }
--         }
--     end
--     vehicleMenu[#vehicleMenu+1] = {
--         header = Lang:t('menu.close'),
--         txt = "",
--         params = {
--             event = "qb-menu:client:closeMenu"
--         }

--     }
--     exports['qb-menu']:openMenu(vehicleMenu)
-- end

-- Events

-- RegisterNetEvent('ambulance:client:TakeOutVehicle', function(data)
--     local vehicle = data.vehicle
--     TakeOutVehicle(vehicle)
-- end)

-- RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
--     PlayerJob = JobInfo
--     if PlayerJob.name == 'ambulance' then
--         onDuty = PlayerJob.onduty
--         if PlayerJob.onduty then
--             TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
--         else
--             TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
--         end
--     end
-- end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    TriggerServerEvent("hospital:server:SetDoctor")
end)



--------------------------------------------------- [[ GARAGE ZONE ]]--------------------------------------------------
local function CreateNHSGarageZone()
    local combo = ComboZone:Create(GarageZones, {name = 'garages', debugPoly=false}) 
    combo:onPlayerInOut(function(isPointInside, _, zone)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            if LocalPlayer.state.isLoggedIn and PlayerJob.name == "ambulance" then
                if isPointInside then
                    CurrentGarage = zone.name
                    exports['qb-core']:DrawText(Config.GarageZones[CurrentGarage]['drawText'], DrawTextPosition)
                else
                    CurrentGarage = nil
                    if NHSMenuItemId ~= nil then
                        exports['qb-radialmenu']:RemoveOption(NHSMenuItemId)
                        NHSMenuItemId = nil
                    end
                    exports['qb-core']:HideText()
                end
            end
        end)
    end)
end

local function CreateNHSGaragePolyZone(garage)
    local zone = PolyZone:Create(Config.GarageZones[garage].Zone.Shape, {
        name = garage,
        minZ = Config.GarageZones[garage].Zone.minZ,
        maxZ = Config.GarageZones[garage].Zone.maxZ,
        debugPoly = Config.GarageZones[garage].debug
    })
    table.insert(GarageZones, zone)
end
----------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports.spawnmanager:setAutoSpawn(false)
    local ped = PlayerPedId()
    TriggerServerEvent("hospital:server:SetDoctor")
    CreateThread(function()
        Wait(5000)
        -- SetEntityMaxHealth(ped, 200)
        -- SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(ped, 0.0)
        SetPlayerHealthRechargeLimit(ped, 0.0)
    end)
    CreateThread(function()
        Wait(1000)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            SetEntityHealth(PlayerPedId(), PlayerData.metadata["health"])
            SetPedArmour(PlayerPedId(), PlayerData.metadata["armor"])
            if (not PlayerData.metadata["inlaststand"] and PlayerData.metadata["isdead"]) then
                deathTime = Laststand.ReviveInterval
                OnDeath()
                DeathTimer()
            elseif (PlayerData.metadata["inlaststand"] and not PlayerData.metadata["isdead"]) then
                SetLaststand(true)
            else
                TriggerServerEvent("hospital:server:SetDeathStatus", false)
                TriggerServerEvent("hospital:server:SetLaststandStatus", false)
            end
            
            if PlayerJob.name == "ambulance" then
                for garageName, garage in pairs(Config.GarageZones) do
                    CreateNHSGaragePolyZone(garageName)
                end
                CreateNHSGarageZone()
            end
        end)
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if PlayerJob.name == 'ambulance' and onDuty then
        TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
    end
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
    -- print("duty is:", duty, "and onDuty is:", onDuty)
    TriggerServerEvent("hospital:server:SetDoctor")
end)


-- RegisterNetEvent('hospital:client:CheckStatus', function()
--     local player, distance = GetClosestPlayer()
--     if player ~= -1 and distance < 5.0 then
--         local playerId = GetPlayerServerId(player)
--         statusCheckPed = GetPlayerPed(player)
--         QBCore.Functions.TriggerCallback('hospital:GetPlayerStatus', function(result)
--             if result then
--                 for k, v in pairs(result) do
--                     if k ~= "BLEED" and k ~= "WEAPONWOUNDS" then
--                         statusChecks[#statusChecks+1] = {bone = Config.BoneIndexes[k], label = v.label .." (".. Config.WoundStates[v.severity] ..")"}
--                     elseif result["WEAPONWOUNDS"] then
--                         for k, v in pairs(result["WEAPONWOUNDS"]) do
--                             -- TriggerEvent('chat:addMessage', {
--                             --     color = { 255, 0, 0},
--                             --     multiline = false,
--                             --     args = {Lang:t('info.status'), WeaponDamageList[v]}
--                             -- })
--                             QBCore.Functions.Notify("test", 'success')
--                         end
--                     elseif result["BLEED"] > 0 then
--                         -- TriggerEvent('chat:addMessage', {
--                         --     color = { 255, 0, 0},
--                         --     multiline = false,
--                         --     args = {Lang:t('info.status'), Lang:t('info.is_status', {status = Config.BleedingStates[v].label})}
--                         -- })
--                         QBCore.Functions.Notify("test2", 'success')
--                     else
--                         QBCore.Functions.Notify(Lang:t('success.healthy_player'), 'success')
--                     end
--                 end
--                 isStatusChecking = true
--                 statusCheckTime = Config.CheckTime
--             end
--         end, playerId)
--     else
--         QBCore.Functions.Notify(Lang:t('error.no_player'), 'error')
--     end
-- end)

RegisterNetEvent('hospital:client:RevivePlayer', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.Progressbar("hospital_revive", Lang:t('progress.revive'), 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 49,
                }, {}, {}, function() -- Done
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify(Lang:t('success.revived'), 'success')
                    TriggerServerEvent("hospital:server:RevivePlayer", playerId)
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
                end)
            else
                QBCore.Functions.Notify("No Player nearby", "error")
            end
        else
            QBCore.Functions.Notify("No AED", "error")
        end
    end, 'aed')
end)

RegisterNetEvent('hospital:client:TreatWounds', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.Progressbar("hospital_healwounds", Lang:t('progress.healing'), 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 49,
                }, {}, {}, function() -- Done
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify(Lang:t('success.helped_player'), 'success')
                    TriggerServerEvent("hospital:server:TreatWounds", playerId)
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
                end)
            else
                QBCore.Functions.Notify("No Player nearby", "error")
            end
        else
            QBCore.Functions.Notify("No Medbag", "error")
        end
    end, "medbag")
end)

--------------------------------------------------------------------[[ NEW FEEATURES ]]--------------------------------------------------------------------
RegisterNetEvent('hospital:client:AdministerMorphine', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 5.0 then
        local playerId = GetPlayerServerId(player)
        QBCore.Functions.Progressbar("AdministerMorphine", "Giving Patient Morphine", 5000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = medicateanimdict,
            anim = medicateanimtype,
            flags = 49,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), medicateanimdict, "exit", 1.0)
            QBCore.Functions.Notify("Given Patient Morphine", 'success')
            TriggerServerEvent("hospital:server:GivingMorphine", playerId, false)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), medicateanimdict, "exit", 1.0)
            QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
        end)
    else
        QBCore.Functions.Notify("No Player nearby", "error")
    end

end)
--------------------------------------------------------------------[[      END      ]]--------------------------------------------------------------------

local check = false
local function EMSControls(variable)
    CreateThread(function()
        check = true
        while check do
            if IsControlJustPressed(0, 38) then
                exports['qb-core']:KeyPressed(38)
                if variable == "sign" then
                   TriggerEvent('EMSToggle:Duty')
                elseif variable == "stash" then
                    TriggerEvent('qb-ambulancejob:stash')
                elseif variable == "armory" then
                    TriggerEvent('qb-ambulancejob:armory')
                elseif variable == "storeheli" then
                    TriggerEvent('qb-ambulancejob:storeheli')
                elseif variable == "takeheli" then
                    TriggerEvent('qb-ambulancejob:pullheli')
                elseif variable == "roof" then
                    TriggerEvent('qb-ambulancejob:elevator_main')
                elseif variable == "main" then
                    TriggerEvent('qb-ambulancejob:elevator_roof')
                elseif variable == "lower" then
                    TriggerEvent('qb-ambulancejob:elevator_lower')
                elseif variable == "reception" then
                    TriggerEvent('qb-ambulancejob:receptionmenu')
                end
            end
            Wait(1)
        end
    end)
end

RegisterNetEvent('qb-ambulancejob:receptionmenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "🔔 NHS Reception",
            isMenuHeader = true
        },
        {
            header = "Sign In/Out",
            txt = "Toggle Police Duty",
            params = {
                event = "EMSToggle:Duty",
            }
        },
        {
            header = "📜 NHS Application",
            txt = "Apply for the Los Santos Police Service",
            params = {
                event = "qb-ambulancejob:AccessApplication",
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

RegisterNetEvent('qb-ambulancejob:AccessApplication', function()
    exports['jobapplications']:ShowApplication(true, "ambulance")
end)

RegisterNetEvent('qb-ambulancejob:stash', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "ambulancestash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "ambulancestash_"..QBCore.Functions.GetPlayerData().citizenid)
    end
end)

-- old Armoury

-- RegisterNetEvent('qb-ambulancejob:armory', function()
--     if onDuty then
--         TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
--     end
-- end)


-- local CheckVehicle = false
-- local function EMSVehicle(k)
--     CheckVehicle = true
--     CreateThread(function()
--         while CheckVehicle do
--             if IsControlJustPressed(0, 38) then
--                 exports['qb-core']:KeyPressed(38)
--                 CheckVehicle = false
--                 local ped = PlayerPedId()
--                     if IsPedInAnyVehicle(ped, false) then
--                         QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
--                     else
--                         local currentVehicle = k
--                         MenuGarage(currentVehicle)
--                         currentGarage = currentVehicle
--                     end
--                 end
--             Wait(1)
--         end
--     end)
-- end

-- local CheckHeli = false
-- local function EMSHelicopter(k)
--     CheckHeli = true
--     CreateThread(function()
--         while CheckHeli do
--             if IsControlJustPressed(0, 38) then
--                 exports['qb-core']:KeyPressed(38)
--                 CheckHeli = false
--                 local ped = PlayerPedId()
--                     if IsPedInAnyVehicle(ped, false) then
--                         QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
--                     else
--                         local currentHelictoper = k
--                         local coords = Config.Locations["helicopter"][currentHelictoper]
--                         QBCore.Functions.SpawnVehicle(Config.Helicopter, function(veh)
--                             SetVehicleNumberPlateText(veh, Lang:t('info.heli_plate')..tostring(math.random(1000, 9999)))
--                             SetEntityHeading(veh, coords.w)
--                             SetVehicleLivery(veh, 1) -- Ambulance Livery
--                             exports['ps-fuel']:SetFuel(veh, 100.0)
--                             TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
--                             TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
--                             SetVehicleEngineOn(veh, true, true)
--                         end, coords, true)
--                     end
--                 end
--             Wait(1)
--         end
--     end)
-- end

----------------------------------------------------------[[ JACKO CONVERSION ]]----------------------------------------------------------

-- new armory
RegisterNetEvent('qb-ambulancejob:armory', function()

    local Player = QBCore.Functions.GetPlayerData()

    local NHSEquipment = {
        label = "NHS Medical Armory",
        slots = 30,
        items = {}
    }
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local nhs_data = PlayerData.metadata['jobflags']

    -- print("the players data is: ", json.encode(nhs_data))


    for k,_ in pairs(Config.Items.items) do
        local v = Config.Items.items[k]
        if v.access.flagName then
            -- print("This has a flag here")
            if nhs_data[v.access.flagName] then
                if tonumber(nhs_data[v.access.flagName]) >= tonumber(v.access.flagLevel) then
                    -- print("I am Inside the flag checking ", json.encode(v))
                    table.insert(NHSEquipment.items, {
                        name = v.name,
                        price = v.price,
                        amount = v.amount,
                        info = v.info,
                        type = v.type,
                        slot = v.slot
                    })
                end
            end
        elseif PlayerData.job.grade.level >= v.access.jobGrade then
            -- print("Non flag adding ", json.encode(v))
            table.insert(NHSEquipment.items, {
                name = v.name,
                price = v.price,
                amount = v.amount,
                info = v.info,
                type = v.type,
                slot = v.slot
            })
            -- print("The table now has the following: ", json.encode(NHSEquipment))
        end
    end
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", NHSEquipment)

end)

RegisterNetEvent('qb-ambulancejob:HelicopterSpawn', function(data)
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

RegisterNetEvent('qb-ambulancejob:storecar', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    local DeltedNHSCar = false
    if PlayerData.job.name == "ambulance" then
        for k,v in pairs(Config.NHSGarage.cars) do
            local deletevehiclemode = GetHashKey(v.model)
            if deletevehiclemode == GetEntityModel(car) then
                DeleteVehicle(car)
                DeleteEntity(car)
                DeltedNHSCar = true
                QBCore.Functions.Notify('Vehicle Parked', "primary", 3000)  
                break    
            end
        end
        
        if not DeltedNHSCar then
            QBCore.Functions.Notify('NHS Vehicles Only', "error", 3000)
        end
    else
        QBCore.Functions.Notify('Police/NHS Only', "error", 3000)
    end
end)

-- Store Helicopter
RegisterNetEvent('qb-ambulancejob:storeair', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local heli = GetVehiclePedIsIn(PlayerPedId(),true)
    local DeltedNHSCar = false
    if PlayerData.job.name == "ambulance" then
        for k,v in pairs(Config.NHSGarage.air) do
            local deletevehiclemode = GetHashKey(v.model)
            if deletevehiclemode == GetEntityModel(heli) then
                DeleteVehicle(heli)
                DeleteEntity(heli)
                DeltedNHSheli = true
                QBCore.Functions.Notify('Vehicle Parked', "primary", 3000)  
                break    
            end
        end
        
        if not DeltedNHSheli then
            QBCore.Functions.Notify('NHS Vehicles Only', "error", 3000)
        end
    else
        QBCore.Functions.Notify('Police/NHS Only', "error", 3000)
    end
end)

-- RegisterNetEvent('qb-ambulancejob:storecar', function()
--     local PlayerData = QBCore.Functions.GetPlayerData()
--     local car = GetVehiclePedIsIn(PlayerPedId(),true)
--     if (PlayerData.job.name == "ambulance" and onDuty) then
--         DeleteVehicle(car)
--         DeleteEntity(car)
--         QBCore.Functions.Notify('Vehicle Parked')
--     else
--         QBCore.Functions.Notify('Police/NHS Only', "error", 3000)
--     end
-- end)

RegisterNetEvent('qb-ambulancejob:Helicopter', function()
    local helicopterMenu = {
        {
            header = "🚁 HELIMED - 99",
            isMenuHeader = true
        }
    }

    local airlist = {}
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local nhs_data = PlayerData.metadata['jobflags']
    for k,_ in pairs(Config.NHSGarage.air) do
        local v = Config.NHSGarage.air[k]
         -- for each item in the NHS garage in config.lua it adds to the cars list
        if v.access.flagName then
            if nhs_data[v.access.flagName] then
                if tonumber(nhs_data[v.access.flagName]) >= tonumber(v.access.flagLevel) then
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
                event = "qb-ambulancejob:HelicopterSpawn",
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
            event = "qb-ambulancejob:storeair",
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
end)

-- New Helicopter Thread

CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inHelicopter and PlayerJob.name == "ambulance" then
            if onDuty then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerEvent("qb-ambulancejob:Helicopter")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('qb-ambulancejob:VehicleGarage', function()
    local NHSCarMenu = {
        {
            header = "🚔 NHS Garage",
            isMenuHeader = true
        }
    }

    local carlist = {}
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local PlayerData = QBCore.Functions.GetPlayerData()
    local nhs_data = PlayerData.metadata['jobflags']
    for k,_ in pairs(Config.NHSGarage.cars) do
        local v = Config.NHSGarage.cars[k]
         -- for each item in the NHS garage in config.lua it adds to the cars list
        if v.access.flagName then
            if nhs_data[v.access.flagName] then
                if tonumber(nhs_data[v.access.flagName]) >= tonumber(v.access.flagLevel) then
                    table.insert(carlist, {label = v.name, veh = v.model})
                end
            end
        elseif PlayerData.job.grade.level >= v.access.jobGrade then
            table.insert(carlist, {label = v.name, veh = v.model})

        end
    end

    for label, vehicle in pairs(carlist) do
        NHSCarMenu[#NHSCarMenu+1] = {
            header = vehicle.label,
            txt = "",
            params = {
                event = "NHS:client:TakeOutVehicleNew",
                args = {
                    vehicle = vehicle.veh
                }
            }
        }        
    end

    NHSCarMenu[#NHSCarMenu+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(NHSCarMenu)
end)

--------------------------------------------------------------------------------------------[[ NEW CAR SPAWNING FEATURES ]]-------------------------------------------------------------------------------

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        print("the resource: " .. resource .. " has been restarted")
        for garageName, garage in pairs(Config.GarageZones) do
            CreateNHSGaragePolyZone(garageName)
        end
        CreateNHSGarageZone()
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    if PlayerJob.name == "ambulance" then
        for garageName, garage in pairs(Config.GarageZones) do
            CreateNHSGaragePolyZone(garageName)
        end
        CreateNHSGarageZone()
    end
  end)

--------------------------------------------------------------------------------------------[[ NEW CAR SPAWNING FEATURES ]]-------------------------------------------------------------------------------
function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

function AddNHSCarOptions()
    local Player = PlayerPedId()
    if IsPedInAnyVehicle(Player) then
        NHSMenuItemId = exports['qb-radialmenu']:AddOption({
            id = 'nhs_police_car',
            title = 'Park Vehicle',
            icon = 'square-parking',
            type = 'client',
            event = 'qb-ambulancejob:storecar',
            shouldClose = true
        }, NHSMenuItemId)
    else
        NHSMenuItemId = exports['qb-radialmenu']:AddOption({
            id = 'nhs_police_car',
            title = 'Service Vehicles',
            icon = 'warehouse',
            type = 'client',
            event = 'qb-ambulancejob:VehicleGarage',
            shouldClose = true
        }, NHSMenuItemId)
    end
end


function UpdateNHSRadial()
    local garage = Config.GarageZones[CurrentGarage]
    if CurrentGarage ~= nil and garage ~= nil then
        -- print("NHS CAR GARAGE BRO")
        AddNHSCarOptions()
    else
        if NHSMenuItemId ~= nil then
            exports['qb-radialmenu']:RemoveOption(NHSMenuItemId)
            NHSMenuItemId = nil
        end
    end
end

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

RegisterNetEvent('NHS:client:TakeOutVehicleNew', function(data, cb)
    local vehicle = data.vehicle
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
        SetVehicleNumberPlateText(veh, "NHS"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, location.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleDoorsLocked(veh, 2)

    end, location, true)
end)

-- radial menu event
RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    UpdateNHSRadial()
end)
--------------------------------------------------------------------------------------------[[ NEW CAR SPAWNING FEATURES END ]]--------------------------------------------------------------------------



----------------------------------------------------------[[ END OF JACKO CONVERSION ]]----------------------------------------------------------
RegisterNetEvent('qb-ambulancejob:elevator_control', function()
    local PillboxElevator = {
        {
            header = "🏥 Pillbox Elevator Control",
            isMenuHeader = true
        }
    }

    PillboxElevator[#PillboxElevator+1] = {
        header = "Roof Access",
        txt = "Press here to take elevator to roof",
        params = {
            event = "qb-ambulancejob:elevator_roof",
        }
    }
    PillboxElevator[#PillboxElevator+1] = {
        header = "Main Floor",
        txt = "Press here to take elevator to Main Floor",
        params = {
            event = "qb-ambulancejob:elevator_main",
        }
    }
    PillboxElevator[#PillboxElevator+1] = {
        header = "Lower Pillbox",
        txt = "Press here to take elevator to Lower",
        params = {
            event = "qb-ambulancejob:elevator_lower",
        }
    }

    exports['qb-menu']:openMenu(PillboxElevator)
end)




RegisterNetEvent('qb-ambulancejob:elevator_roof', function()
    local ped = PlayerPedId()
    for k, _ in pairs(Config.Locations["roof"])do
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end

        local coords = vector3(339.52, -584.06, 74)
        local heading = 249.57
        SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
        SetEntityHeading(ped, heading)

        Wait(100)

        DoScreenFadeIn(1000)
    end
end)

RegisterNetEvent('qb-ambulancejob:elevator_main', function()
    local ped = PlayerPedId()
    for k, _ in pairs(Config.Locations["main"])do
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end

        local coords = vector3(329.64, -598.02, 43.28)
        local heading = 61.26
        SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
        SetEntityHeading(ped, heading)

        Wait(100)

        DoScreenFadeIn(1000)
    end
end)

RegisterNetEvent('qb-ambulancejob:elevator_lower', function()
    local ped = PlayerPedId()
    for k, _ in pairs(Config.Locations["lower"])do
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end

        local coords = vector3(345.75, -585.61, 28)
        local heading = 255.11
        SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
        SetEntityHeading(ped, heading)

        Wait(100)

        DoScreenFadeIn(1000)
    end
end)

RegisterNetEvent('EMSToggle:Duty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
    -- TriggerServerEvent("police:server:UpdateBlips")
end)

CreateThread(function()
    -- for k, v in pairs(Config.Locations["vehicle"]) do
    --     local boxZone = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 5, 5, {
    --         name="vehicle"..k,
    --         debugpoly = false,
    --         heading = 70,
    --         minZ = v.z - 2,
    --         maxZ = v.z + 2,
    --     })
    --     boxZone:onPlayerInOut(function(isPointInside, point)
    --         if isPointInside then
    --             inGarage = true
    --             if onDuty and PlayerJob.name == 'ambulance' then
    --                 if IsPedInAnyVehicle(PlayerPedId(), false) then
    --                     exports['qb-core']:HideText()
    --                     exports['qb-core']:DrawText("[E] - Access NHS Garage", 'left')
    --                 else
    --                     exports['qb-core']:DrawText("[E] - Access NHS Garage", 'left')
    --                 end
    --             end
    --         else
    --             inGarage = false
    --             exports['qb-menu']:closeMenu()
    --             exports['qb-core']:HideText()
    --         end
    --     end)
    -- end

    -- for k, v in pairs(Config.Locations["helicopter"]) do
    --     local boxZone = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 5, 5, {
    --         name="helicopter"..k,
    --         debugpoly = false,
    --         heading = 70,
    --         minZ = v.z - 2,
    --         maxZ = v.z + 2,
    --     })
    --     boxZone:onPlayerInOut(function(isPointInside)
    --         if isPointInside and PlayerJob.name =="ambulance" and onDuty then
    --             exports['qb-core']:DrawText(Lang:t('text.heli_button'), 'left')
    --             EMSHelicopter(k)
    --         else
    --             CheckHeli = false
    --             exports['qb-core']:HideText()
    --         end
    --     end)
    -- end

    ----------------------------------------------------------[[ JACKO CONVERSION ]]----------------------------------------------------------

    -- New Helicopter zones
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
                    exports['qb-core']:DrawText("[E] - Access Helicopters", 'left')
                else
                    exports['qb-core']:DrawText("[E] - Access Helicopters", 'left')
                end
            end
        else
            inHelicopter = false
            exports['qb-core']:HideText()
        end
    end)
    ----------------------------------------------------------[[ END OF JACKO CONVERSION ]]----------------------------------------------------------

end)


-- Convar turns into a boolean
if Config.UseTarget then
    CreateThread(function()
        for k, v in pairs(Config.Locations["stash"]) do
            exports['qb-target']:AddBoxZone("stash"..k, vector3(v.x, v.y, v.z), 1.0, 2, {
                name = "stash"..k,
                debugpoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:stash",
                        icon = "fa fa-hand",
                        label = "Open Stash",
                        job = "ambulance"
                    }
                },
                distance = 1.5
            })
        end
        for k, v in pairs(Config.Locations["armory"]) do
            exports['qb-target']:AddBoxZone("armory"..k, vector3(v.x, v.y, v.z), 2.2, 1.5, {
                name = "armory"..k,
                debugpoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:armory",
                        icon = "fa fa-hand",
                        label = "Open Armory",
                        job = "ambulance"
                    }
                },
                distance = 1.5
            })
        end
        for k, v in pairs(Config.Locations["roof"]) do
            exports['qb-target']:AddBoxZone("roof"..k, vector3(v.x, v.y, v.z), 2, 2, {
                name = "roof"..k,
                debugpoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:elevator_control",
                        icon = "fas fa-hand-point-up",
                        label = "Elevator Panel",
                    },
                },
                distance = 8
            })
        end
        for k, v in pairs(Config.Locations["main"]) do
            exports['qb-target']:AddBoxZone("main"..k, vector3(v.x, v.y, v.z), 1, 3, {
                name = "main"..k,
                debugpoly = false,
                heading = 247,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:elevator_control",
                        icon = "fas fa-hand-point-up",
                        label = "Elevator Panel",
                    },
                },
                distance = 8
            })
        end
        for k, v in pairs(Config.Locations["lower"]) do
            exports['qb-target']:AddBoxZone("lower"..k, vector3(v.x, v.y, v.z), 4.5, 3, {
                name = "main"..k,
                debugpoly = false,
                heading = 250,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:elevator_control",
                        icon = "fas fa-hand-point-up",
                        label = "Elevator Panel",
                    },
                },
                distance = 8
            })
        end
    end)
else
    CreateThread(function()
        
        local stashPoly = {}
        for k, v in pairs(Config.Locations["stash"]) do
            stashPoly[#stashPoly+1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 1.0, 2, {
                name="stash"..k,
                debugpoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local stashCombo = ComboZone:Create(stashPoly, {name = "stashCombo", debugpoly = false})
        stashCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name =="ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.pstash_button'),'left')
                    EMSControls("stash")
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local armoryPoly = {}
        for k, v in pairs(Config.Locations["armory"]) do
            armoryPoly[#armoryPoly+1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 2.2, 1.5, {
                name="armory"..k,
                debugpoly = false,
                heading = 70,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local armoryCombo = ComboZone:Create(armoryPoly, {name = "armoryCombo", debugpoly = false})
        armoryCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name =="ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.armory_button'),'left')
                    EMSControls("armory")
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local roofPoly = {}
        for k, v in pairs(Config.Locations["roof"]) do
            roofPoly[#roofPoly+1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 2, 2, {
                name="roof"..k,
                debugpoly = false,
                heading = 70,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local roofCombo = ComboZone:Create(roofPoly, {name = "roofCombo", debugpoly = false})
        roofCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name =="ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.elevator_main'),'left')
                    EMSControls("main")
                else
                    exports['qb-core']:DrawText(Lang:t('error.not_ems'),'left')
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local mainPoly = {}
        for k, v in pairs(Config.Locations["main"]) do
            mainPoly[#mainPoly+1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 1.5, 1.5, {
                name="main"..k,
                debugpoly = false,
                heading = 70,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local mainCombo = ComboZone:Create(mainPoly, {name = "mainPoly", debugpoly = false})
        mainCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name =="ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.elevator_roof'),'left')
                    EMSControls("roof")
                else
                    exports['qb-core']:DrawText(Lang:t('error.not_ems'),'left')
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local toggledutyzones = {}
        for k, v in pairs(Config.Locations["toggledutyzones"]) do
            toggledutyzones[#toggledutyzones+1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 1.5, 1.5, {
                name="toggleduty"..k,
                debugpoly = false,
                heading = 70,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local toggledutycombo = ComboZone:Create(toggledutyzones, {name = "toggledutyzone", debugpoly = false})
        toggledutycombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name =="ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText("NHS Reception",'left')
                    EMSControls("reception")
                else
                    exports['qb-core']:DrawText("NHS Reception",'left')
                    EMSControls("reception")
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)
    end)
end

RegisterNetEvent("nhs:client:StartImpounding", function ()
    if PlayerJob.name == "ambulance" then 
        TriggerEvent('nhs:client:ImpoundCar', 0)
    end
end)


RegisterNetEvent('nhs:client:ImpoundCar', function(price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    
    -- local lastcar = GetPlayersLastVehicle()
    -- local vehicletoimpound = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicletoimpound))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicletoimpound))
    local totalFuel = exports['ps-fuel']:GetFuel(vehicletoimpound)

    -- lastcar ~= 0 and lastcar ~= nil

    if vehicle ~= 0 then
        -- print("The last car is: ", lastcar)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        local plate = QBCore.Functions.GetPlate(vehicle)

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

                while not NetworkHasControlOfEntity(vehicle) do 
                    Wait(0)
                    NetworkRequestControlOfEntity(vehicle)
                end

                if NetworkHasControlOfEntity(vehicle) then
                    SetEntityAsMissionEntity(vehicle)
                    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
                    TriggerServerEvent("police:server:ImpoundCar", plate, price, bodyDamage, engineDamage, totalFuel)
                    TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
                    QBCore.Functions.DeleteVehicle(vehicle)
                    ClearPedTasks(ped)
                    QBCore.Functions.Notify("Vehicle with plate: "..plate.." Impounded with a retrieval price of: £"..price, 'success', 5000)
                end 

                

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
