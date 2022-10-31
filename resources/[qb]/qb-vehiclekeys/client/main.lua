-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local hasKey = false
local IsRobbing = false
local IsHotwiring = false
local AlertSend = false
local lockpickedPlate = nil
local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local usingAdvanced
local openingDoor = false
local hotWiring = false

-- Functions

function LockVehicle()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local veh = QBCore.Functions.GetClosestVehicle(pos)
    local plate = QBCore.Functions.GetPlate(veh)
    local vehpos = GetEntityCoords(veh)
    if IsPedInAnyVehicle(ped) then
        veh = GetVehiclePedIsIn(ped)
    end
    if veh ~= nil and #(pos - vehpos) < 7.5 then
        QBCore.Functions.TriggerCallback('vehiclekeys:server:CheckHasKey', function(result)
            if result then
                local vehLockStatus = GetVehicleDoorLockStatus(veh)
                
                NetworkRequestControlOfEntity(veh)

                -- while not NetworkHasControlOfEntity(veh) do
                --     QBCore.Functions.Notify("Please Stand By, Attempting to lock vehicle", "primary", 5000)
                --     Wait(5000)
                -- end

                loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false,false)

                if vehLockStatus == 2 then
                    ClearPedTasks(ped)
                    -- SetVehicleDoorsLocked(veh, 1)
                    -- SetVehicleDoorsLockedForAllPlayers(veh, false)
                    TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
                    SetVehicleLights(veh, 0)
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                    QBCore.Functions.Notify("Vehicle unlocked!", "success")
                else
                    ClearPedTasks(ped)
                    -- SetVehicleDoorsLocked(veh, 2)
                    -- SetVehicleDoorsLockedForAllPlayers(veh, true)
                    TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 2)
                    SetVehicleLights(veh, 0)
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                    QBCore.Functions.Notify("Vehicle locked!", "error")
                end
            else
                QBCore.Functions.Notify('You don\'t have the keys of the vehicle..', 'error')
            end
        end, plate)
    end
end

function LockpickDoor(isAdvanced)
local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
    local ped = PlayerPedId()
    local vehpos = GetEntityCoords(vehicle)
    local pos = GetEntityCoords(ped)
    local seconds = math.random(10,15)
    local circles = math.random(4,6)
    if #(pos - vehpos) < 2.5 then
        local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
        if (vehLockStatus > 1) then
            IsHotwiring = true
            
                if isAdvanced then
                    seconds = math.random(30,45)
                    circles = math.random(3,5)
                end
                LockpickDoorAnim(30000)
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, 30000)
                
                local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)  
                    
                if success then
                    openingDoor = false
                    StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    IsHotwiring = false
                    QBCore.Functions.Notify("You lockpicked the door!")
                    ClearPedTasks(ped)
                    lockpickedPlate = QBCore.Functions.GetPlate(vehicle)
                    hasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    SetVehicleAlarm(vehicle, false)
                    SetVehicleAlarmTimeLeft(vehicle, 0)
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                    NetworkRequestControlOfEntity(vehicle)
                    TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 1)
                    --TriggerServerEvent('cd_dispatch:pdalerts:StolenCar', exports['cd_dispatch']:GetPlayerInfo())
                else
                    openingDoor = false
                    StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    SetVehicleAlarm(vehicle, false)
                    SetVehicleAlarmTimeLeft(vehicle, 0)
                    IsHotwiring = false
                    QBCore.Functions.Notify("Lockpicking Failed", "error", 2000)
                    --TriggerServerEvent('cd_dispatch:pdalerts:StolenCar', exports['cd_dispatch']:GetPlayerInfo())
                end
            end
        end
    end
end

    
function LockpickIgnition(isAdvanced)
if not hasKey then
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, true)
    local seconds = math.random(10,15)
    local circles = math.random(4,6)
    if vehicle ~= nil and vehicle ~= 0 then
        if GetPedInVehicleSeat(vehicle, -1) == ped then
                IsHotwiring = true
        
                if isAdvanced then
                    seconds = math.random(25,30)
                    circles = math.random(3,5)
                end
                
                HotwireAnim(30000)
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, 30000)
        
                local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
        
                if IsHotwiring then
                    if success then
                        HotwireAnim(0)
                        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                        SetVehicleAlarm(vehicle, false)
                        SetVehicleAlarmTimeLeft(vehicle, 0)
                        QBCore.Functions.Notify("Lockpicking succeeded!")
                        hasKey = true
                        IsHotwiring = false
                        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
                        TriggerServerEvent('hud:server:GainStress', math.random(2, 4))
                    else
                        HotwireAnim(0)
                        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                        SetVehicleAlarm(vehicle, false)
                        SetVehicleAlarmTimeLeft(vehicle, 0)
                        IsHotwiring = false
                        SetVehicleEngineOn(veh, false, false, true)
                        QBCore.Functions.Notify("Hotwire failed", "error")
                        TriggerServerEvent('hud:server:GainStress', math.random(4, 8))
                        TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
                    end
                end
            end
        end 
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    if weapon ~= nil then
        for _, v in pairs(Config.NoRobWeapons) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function GetNearbyPed()
    local retval = nil
    local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
    if not IsEntityDead(closestPed) and closestDistance < 30.0 then
        retval = closestPed
    end
    return retval
end

function openDoorAnim(time)
    local ped = PlayerPedId()
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    IsHotwiring = true
    CreateThread(function()
        while IsHotwiring do
            TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                IsHotwiring = false
                StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickDoorAnim(time)
    local ped = PlayerPedId()
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function HotwireAnim(time)
    local ped = PlayerPedId()
    time = time / 1000
    loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" ,3.0, 3.0, -1, 16, 0, false, false, false)
    hotWiring = true
    CreateThread(function()
        while hotWiring do
            TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(1000)
            time = time - 1
            if time <= 0 then
                hotWiring = false
                StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            end
        end
    end)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function GetOtherPlayersInVehicle(vehicle)
    local otherPeds = {}
    for seat=-1,GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))-2 do
        local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
        if IsPedAPlayer(pedInSeat) and pedInSeat ~= PlayerPedId() then
            otherPeds[#otherPeds+1] = pedInSeat
        end
    end
    return otherPeds
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
    if (IsPedInAnyVehicle(PlayerPedId())) then
        if not hasKey then
            LockpickIgnition(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate)
    local VehPlate = plate
    local CurrentVehPlate = QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), true))
    if VehPlate == nil then
        VehPlate = CurrentVehPlate
    end
    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate)
    if IsPedInAnyVehicle(PlayerPedId()) and plate == CurrentVehPlate then
        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), true), true, false, true)
    end
    QBCore.Functions.Notify({text = "You got vehicle keys for:", caption = VehPlate}, "primary", 5000)
    hasKey = true
end)

RegisterNetEvent('vehiclekeys:client:GiveKeys', function(target)
    -- local plate = QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), true))
    -- TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, target)

    local targetVehicle = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(targetVehicle)
    if target ~= nil then -- Give keys to specific ID
        TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, target)
    else
        if IsPedSittingInVehicle(PlayerPedId(), targetVehicle) then -- Give keys to everyone in vehicle
            local otherOccupants = GetOtherPlayersInVehicle(targetVehicle)
            for p=1,#otherOccupants do
                TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, GetPlayerServerId(NetworkGetPlayerIndexFromPed(otherOccupants[p])))
            end
        else -- Give keys to closest player
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, GetPlayerServerId(QBCore.Functions.GetClosestPlayer()))
        end
    end

end)

RegisterNetEvent('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()))
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    if hasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

-- command

RegisterKeyMapping('togglelocks', 'Toggle Vehicle Locks', 'keyboard', 'L')
RegisterCommand('togglelocks', function()
    LockVehicle()
end)

-- Threads
CreateThread(function()
    while true do
        local sleep = 100
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsTryingToEnter(ped)
        if vehicle ~= 0 then
            local plate = QBCore.Functions.GetPlate(vehicle)
            QBCore.Functions.TriggerCallback('vehiclekeys:CheckOwnership', function(result)
                if not result then
                    QBCore.Functions.TriggerCallback('vehiclekeys:server:CheckHasKey', function(result)
                        if result then
                            hasKey = true
                            SetVehicleEngineOn(vehicle, true, false, true)
                        else
                            hasKey = false
                            local driver = GetPedInVehicleSeat(vehicle, -1)
                            if driver ~= 0 and not IsPedAPlayer(driver) then
                                SetVehicleDoorsLocked(vehicle, 1)
                                SetVehicleEngineOn(vehicle, false, false, true)
                                hasKey = false
                            else
                                if lockpickedPlate == plate then -- lockpicked door not owned
                                    SetVehicleDoorsLocked(vehicle, 1)
                                    SetVehicleEngineOn(vehicle, false, false, true)
                                    hasKey = false
                                else
                                    if driver ~= 0 and IsPedAPlayer(driver) then   
                                    SetVehicleDoorsLocked(vehicle, 1)
                                    hasKey = false
                                    else -- civ vehicle locked
                                    SetVehicleDoorsLocked(vehicle, 2)
                                    SetVehicleEngineOn(vehicle, false, false, true)
                                    hasKey = false  
                                    end                            
                                end
                            end
                        end
                    end, plate)
                else
                    QBCore.Functions.TriggerCallback('vehiclekeys:server:CheckHasKey', function(result)
                        if result then
                            hasKey = true
                            SetVehicleEngineOn(vehicle, true, false, true)
                        else
                            hasKey = false
                            local driver = GetPedInVehicleSeat(vehicle, -1)
                            if driver ~= 0 and not IsPedAPlayer(driver) then
                                SetVehicleEngineOn(vehicle, false, false, true)
                                hasKey = false
                            else
                                if lockpickedPlate == plate then 
                                    SetVehicleEngineOn(vehicle, false, false, true)
                                    hasKey = false
                                else
                                    SetVehicleEngineOn(vehicle, false, false, true)
                                    hasKey = false                               
                                end
                            end
                        end
                    end, plate)
                end
            end, plate)
        end
        Wait(sleep)
        if not hasKey and IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped and QBCore ~= nil and not IsHotwiring then
            local veh = GetVehiclePedIsIn(ped, false)
            SetVehicleEngineOn(veh, false, false, true)
        end
    end
end)

RegisterNetEvent('keys:client:policeunlock', function(source)
    local onFoot = IsPedOnFoot(ped)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    
    if vehicle == nil or vehicle == 0 then return end
    if hasKey then
        QBCore.Functions.Notify("You already have the keys to this vehicle", "error", 5000)
        return
    end
    if #(pos - GetEntityCoords(vehicle)) > 2.5 then return end
    if IsAnyVehicleNearPoint(pos.x, pos.y, pos.z, 3.0) then
        local animationdictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
        local animationtype = "machinic_loop_mechandplayer"
        QBCore.Functions.Progressbar("forcing_entry", "Accessing Vehicle", math.random(5000, 7000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = true,
            disableCombat = true,
        }, {
            animDict = animationdictionary,
            anim = animationtype,
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, animationdictionary, animationtype, 1.0)
            SetVehicleDoorsLocked(vehicle, 0)
            SetVehicleAlarm(vehicle, false)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
        end, function() -- Cancel
            StopAnimTask(ped, animationdictionary, animationtype, 1.0)
            QBCore.Functions.Notify("Cancelled", "error")
        end)
    end
end)