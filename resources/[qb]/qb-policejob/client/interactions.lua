-- Variables
local isEscorting = false
local cuffAttemptCount = 0
local dict = 'mp_arresting'
local animname = 'idle'
local dict2 = 'mp_arrest_paired'
local PlayerData = QBCore.Functions.GetPlayerData()

-- Functions
exports('IsHandcuffed', function()
    return isHandcuffed
end)

exports('IsZiptied', function()
    return isZiptied
end)

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function IsTargetDead(playerId)
    local retval = false
    local hasReturned = false
    QBCore.Functions.TriggerCallback('police:server:isPlayerDead', function(result)
        retval = result
        hasReturned = true
    end, playerId)
    while not hasReturned do
      Wait(10)
    end
    return retval
end

local function IsTargetPlayingAnim(playerPed)
    local retval = false
    local hasReturned = false

    if IsEntityPlayingAnim(playerPed,"missminuteman_1ig_2","handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) then
        retval = true
        hasReturned = true
    else
        retval = false
        hasReturned = true
    end

    while not hasReturned do
      Wait(10)
    end

    return retval
end

local function HandCuffAnimation()
    local ped = PlayerPedId()
    if isHandcuffed == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
    end

    loadAnimDict("mp_arrest_paired")
	Wait(100)
    TaskPlayAnim(ped, "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
	Wait(3500)
    TaskPlayAnim(ped, "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

local function ZiptieAnimation()
    local ped = PlayerPedId()
    loadAnimDict("mp_arrest_paired")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 2.5, "ziptie", 0.2)
	Wait(100)
    TaskPlayAnim(ped, "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
	Wait(3500)
    TaskPlayAnim(ped, "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

local function GetCuffedAnimation(playerId)
    local ped = PlayerPedId()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
    local heading = GetEntityHeading(cuffer)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
    loadAnimDict("mp_arrest_paired")
    SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))

	Wait(100)
	SetEntityHeading(ped, heading)
	TaskPlayAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3.0, 3.0, -1, 32, 0, 0, 0, 0 ,true, true, true)
	Wait(2500)
end

-- Events
RegisterNetEvent('police:client:SetOutVehicle', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, vehicle, 16)
    end
end)

RegisterNetEvent('police:client:PutInVehicle', function()
    local ped = PlayerPedId()
    if isHandcuffed or isEscorted then
        local vehicle = QBCore.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) then
			for i = GetVehicleMaxNumberOfPassengers(vehicle), 1, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    isEscorted = false
                    TriggerEvent('hospital:client:isEscorted', isEscorted)
                    ClearPedTasks(ped)
                    DetachEntity(ped, true, false)
                    Wait(100)
                    SetPedIntoVehicle(ped, vehicle, i)
                    return
                end
            end
		end
    end
end)

RegisterNetEvent('police:client:SearchPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
        TriggerServerEvent("police:server:SearchPlayer", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:SeizeCash', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeCash", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:SeizeDriverLicense', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeDriverLicense", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)


RegisterNetEvent('police:client:RobPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)

        local playerdeadstatus = IsTargetDead(playerId)
        local playinganumationcheck = IsTargetPlayingAnim(playerPed)
        print(playerdeadstatus, playinganumationcheck)

        if playinganumationcheck and not playerdeadstatus then

            if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HUNTINGRIFLE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
                return QBCore.Functions.Notify("Nice Try, use an actual weapon", "error")
            end

            QBCore.Functions.Progressbar("robbing_player", Lang:t("progressbar.robbing"), math.random(5000, 7000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "random@shop_robbery",
                anim = "robbery_action_b",
                flags = 16,
            }, {}, {}, function() -- Done
                local plyCoords = GetEntityCoords(playerPed)
                local pos = GetEntityCoords(ped)
                if #(pos - plyCoords) < 2.5 then
                    StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
                    TriggerEvent("inventory:server:RobPlayer", playerId)
                else
                    QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
                end
            end, function() -- Cancel
                StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
            end)
        else
            return QBCore.Functions.Notify("The person needs to be alive/compliant or cuffed", "primary", 6000)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:JailPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t('info.jail_time_input'),
            submitText = Lang:t('info.submit'),
            inputs = {
                {
                    text = Lang:t('info.time_months'),
                    name = "jailtime",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if tonumber(dialog['jailtime']) > 0 then
            TriggerServerEvent("police:server:JailPlayer", playerId, tonumber(dialog['jailtime']))
        else
            QBCore.Functions.Notify(Lang:t("error.time_higher"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

-- RegisterNetEvent('police:client:BillPlayer', function()
--     local player, distance = QBCore.Functions.GetClosestPlayer()
--     if player ~= -1 and distance < 2.5 then
--         local playerId = GetPlayerServerId(player)
--         local dialog = exports['qb-input']:ShowInput({
--             header = Lang:t('info.bill'),
--             submitText = Lang:t('info.submit'),
--             inputs = {
--                 {
--                     text = Lang:t('info.amount'),
--                     name = "invoice",
--                     type = "number",
--                     isRequired = true
--                 }
--             }
--         })
--         if tonumber(dialog['bill']) > 0 then
--             TriggerServerEvent("police:server:BillPlayer", playerId, tonumber(dialog['bill']))
--         else
--             QBCore.Functions.Notify(Lang:t("error.amount_higher"), "error")
--         end
--     else
--         QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
--     end
-- end)

RegisterNetEvent('police:client:FinePlayer', function()
    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        local playerId = GetPlayerServerId(player)
        local dialog = exports['qb-input']:ShowInput({
            header = "Fine Player",
            submitText = "Submit Fine",
            inputs = {
                {
                    text = "Player ID",
                    name = "targetid",
                    type = "number",
                    isRequired = true
                },
                {
                    text = "Amount",
                    name = "fineamount",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if not dialog then return end
        
        if tonumber(dialog.fineamount) >= 0 and tonumber(dialog.fineamount) <= tonumber(Config.MaxFine) then
            if playerId == tonumber(dialog.targetid) then
                TriggerServerEvent("police:server:FinePlayer", tonumber(dialog.targetid), tonumber(dialog.fineamount))
            else
                QBCore.Functions.Notify('Could not find anyone with the ID: '..dialog.targetid, "error")
            end
        else
            QBCore.Functions.Notify("You cannot fine this person: £"..dialog.fineamount.." as it is over the limit!", "error")
        end
    else
        QBCore.Functions.Notify("Police Only", "error")
    end
end)

RegisterNetEvent('police:client:PutPlayerInVehicle', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isZiptied and not isEscorted then
            TriggerServerEvent("police:server:PutPlayerInVehicle", playerId)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isZiptied and not isEscorted then
            QBCore.Functions.Progressbar("player_out", 'Taking out of Vehicle', 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
            end, function() -- Cancel
                ClearPedTasks(PlayerPedId())
            end, "fa-solid fa-chevrons-right")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:EscortPlayer', function()
    local escortingplayer = PlayerPedId()
    if IsPedInAnyVehicle(escortingplayer, false) then
        QBCore.Functions.Notify("Nice try, Get out the vehicle first", "error")
    else
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 2.5 then
            local playerId = GetPlayerServerId(player)
            if not isHandcuffed and not isZiptied and not isEscorted then
                TriggerServerEvent("police:server:EscortPlayer", playerId)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    end
end)

RegisterNetEvent('police:client:KidnapPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(GetPlayerPed(player)) then
            if not isHandcuffed and not isEscorted then
                TriggerServerEvent("police:server:KidnapPlayer", playerId)
            end
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:GetEscorted', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or isHandcuffed or isZiptied or PlayerData.metadata["inlaststand"] then
            if not isEscorted then
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                isEscorted = true
                SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
                AttachEntityToEntity(ped, dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:DeEscort', function()
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('police:client:GetKidnappedTarget', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or isHandcuffed or isZiptied then
            if not isEscorted then
                isEscorted = true
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                RequestAnimDict("nm")

                while not HasAnimDictLoaded("nm") do
                    Wait(10)
                end
                AttachEntityToEntity(ped, dragger, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(ped, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
                ClearPedTasksImmediately(ped)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:GetKidnappedDragger', function()
    QBCore.Functions.GetPlayerData(function(_)
        if not isEscorting then
            local dragger = PlayerPedId()
            RequestAnimDict("missfinale_c2mcs_1")

            while not HasAnimDictLoaded("missfinale_c2mcs_1") do
                Wait(10)
            end
            TaskPlayAnim(dragger, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
            isEscorting = true
        else
            local dragger = PlayerPedId()
            ClearPedSecondaryTask(dragger)
            ClearPedTasksImmediately(dragger)
            isEscorting = false
        end
        TriggerEvent('hospital:client:SetEscortingState', isEscorting)
        TriggerEvent('qb-kidnapping:client:SetKidnapping', isEscorting)
    end)
end)

-- Zipties
RegisterNetEvent('police:client:ZiptiePlayer', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    local playerId = GetPlayerServerId(player)
                    if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                        TriggerServerEvent("police:server:ZiptiePlayer", playerId, true)
                        ZiptieAnimation()
                    else
                        QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
                    end
                else
                    QBCore.Functions.Notify(Lang:t("error.no_cuff"), "error")
                end
            end, Config.PlasticCuffs)
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:GetZiptied', function(playerId, isSoftcuff)
    ClearPedTasksImmediately(PlayerPedId())
    GetCuffedAnimation(playerId)

    if not isZiptied then
        isZiptied = true
        cuffType = 16
        TriggerServerEvent("police:server:SetZiptiedStatus", true)
        QBCore.Functions.Notify("You are ziptied!")
    end
end)

-- Cuff
RegisterNetEvent('police:client:CuffPlayer', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    local playerId = GetPlayerServerId(player)
                    if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                        TriggerServerEvent("police:server:CuffPlayer", playerId, false)
                        HandCuffAnimation()
                    else
                        QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
                    end
                else
                    QBCore.Functions.Notify(Lang:t("error.no_cuff"), "error")
                end
            end, Config.HandCuffItem)
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:GetCuffed', function(playerId, isSoftcuff)
    if not isHandcuffed then
        isHandcuffed = true
        TriggerServerEvent("police:server:SetHandcuffStatus", true)
        ClearPedTasksImmediately(PlayerPedId())
        if GetSelectedPedWeapon(ped) ~= WEAPON_UNARMED then
            SetCurrentPedWeapon(ped, WEAPON_UNARMED, true)
        end
        if cuffAttemptCount >= 3 then
            TriggerServerEvent("police:server:SetHandcuffStatus", true)
            cuffAttemptCount = 0
        else
             QBCore.Functions.GetPlayerData(function(PlayerData)
                if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] then
                    TriggerServerEvent("police:server:SetHandcuffStatus", true)
                    cuffAttemptCount = 0
                else
                    breakout()
                    cuffAttemptCount = cuffAttemptCount + 1
                end
            end)
        end
        if not isSoftcuff then
            cuffType = 49
            GetCuffedAnimation(playerId)
            QBCore.Functions.Notify("You are cuffed, but you can walk")
        end
    else
        cuffAttemptCount = 0
        isHandcuffed = false
        isEscorted = false
        TriggerEvent('hospital:client:isEscorted', isEscorted)
        DetachEntity(ped, true, false)
        TriggerServerEvent("police:server:SetHandcuffStatus", false)
        ClearPedTasksImmediately(PlayerPedId())
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
        QBCore.Functions.Notify(Lang:t("success.uncuffed"),"success")
    end
end)

function breakout()
    local success = exports['qb-lock']:StartLockPickCircle(3, 6, success)
    if success then
        QBCore.Functions.Notify("You resisted being handcuffed")
        cuffAttemptCount = cuffAttemptCount + 1
        isHandcuffed = false
        isEscorted = false
        TriggerEvent('hospital:client:isEscorted', isEscorted)
        DetachEntity(PlayerPedId(), true, false)
        TriggerServerEvent("police:server:SetHandcuffStatus", false)
        ClearPedTasksImmediately(PlayerPedId())
    else
        cuffAttemptCount = 0
        IsHandcuffed = true
        QBCore.Functions.Notify("Breakout failed!", "error")
    end
end

-- Uncuff
RegisterNetEvent('police:client:UnCuffPlayer', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 2.0 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                TriggerServerEvent("police:server:UnCuffPlayer", playerId, true)
                UnCuffAnimation()
            else
                QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:GetUnCuffed', function(playerId)
    local ped = PlayerPedId()
    Wait(4000)
    isHandcuffed = false
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(ped, true, false)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    ClearPedTasksImmediately(ped)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 2.5, "Cuff", 0.2)
    QBCore.Functions.Notify(Lang:t("success.uncuffed"),"success")
    cuffAttemptCount = 0
end)


-- Cut Zipties
RegisterNetEvent('police:client:CutZipties', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 2.0 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                TriggerServerEvent("police:server:CutZipties", playerId, true)
                UnCuffAnimation()
            else
                QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    else
        Wait(2000)
    end
end)


RegisterNetEvent('police:client:Releasezipties', function(playerId)
    local ped = PlayerPedId()
    Wait(4000)
    isZiptied = false
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(ped, true, false)
    TriggerServerEvent("police:server:SetZiptiedStatus", false)
    ClearPedTasksImmediately(ped)
end)

-- Softcuff
RegisterNetEvent('police:client:CuffPlayerSoft', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                TriggerServerEvent("police:server:CuffPlayer", playerId, true)
                HandCuffAnimation()
            else
                QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    else
        Wait(2000)
    end
end)


-- Clothing options

RegisterNetEvent('police:client:removemask', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 1.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:takeclothing", playerId, "mask")
    else
        QBCore.Functions.Notify("Nobody Nearby", "error")
    end
end)

RegisterNetEvent('police:client:removehat', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            TriggerServerEvent("police:server:takeclothing", playerId, "hat")
    else
        QBCore.Functions.Notify("Nobody Nearby", "error")
    end
end)

RegisterNetEvent('police:client:takeoffclothing', function(type)
    local target = src
    local TargetData = QBCore.Functions.GetPlayerData(target)
    clothingtype = type
    if clothingtype == "mask" then
        -- local ad = "missheist_agency2ahelmet"
        -- loadAnimDict(ad)
        -- RequestAnimDict(dict)
        -- TaskPlayAnim(PlayerPedId(), ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        -- Wait(1000)
        -- SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 0)
        if TargetData.metadata['isdead'] or TargetData.metadata['inlaststand'] or TargetData.metadata['ishandcuffed'] or TargetData.metadata['isziptied'] then
            exports['qb-radialmenu']:ToggleClothing("Mask")
            QBCore.Functions.Notify("Taken your mask off", "error")
        end
    elseif clothingtype == "hat" then
        local target = src
        local TargetData = QBCore.Functions.GetPlayerData(target)
        -- local ad = "missheist_agency2ahelmet"
        -- loadAnimDict(ad)
        -- RequestAnimDict(dict)
        -- TaskPlayAnim(PlayerPedId(), ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        -- Wait(600)
        -- ClearPedSecondaryTask(PlayerPedId())
        -- SetPedPropIndex(PlayerPedId(), 0, -1, 0, true)
        if TargetData.metadata['isdead'] or TargetData.metadata['inlaststand'] or TargetData.metadata['ishandcuffed'] or TargetData.metadata['isziptied'] then
            exports['qb-radialmenu']:ToggleProps("Hat")
            QBCore.Functions.Notify("Taken your hat off", "error")
        end
    end
end)

-- MDW

RegisterNetEvent('axiomPD:client:mdwAccess', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Police MDW Access",
        submitText = "Send",
        inputs = {
            {
                text = "Citizen ID", -- text you want to be displayed as a place holder
                name = "cid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "First Name", -- text you want to be displayed as a place holder
                name = "fname", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Last Name", -- text you want to be displayed as a place holder
                name = "lname", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Call Sign", -- text you want to be displayed as a place holder
                name = "callsign", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Phone Number", -- text you want to be displayed as a place holder
                name = "phone", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Rank", -- text you want to be displayed as a place holder
                name = "rank", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
        },
    })
    
    if dialog then
        if not dialog.cid and not dialog.fname and dialog.lname and dialog.callsign and dialog.phone and dialog.rank then return end
        TriggerServerEvent('axiomPD:server:mdwAccess', dialog.cid, dialog.fname, dialog.lname, dialog.callsign, dialog.phone, dialog.rank)
    end
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1)
        if isEscorted then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 249, true)
            EnableControlAction(0, 46, true)
        end

        if isHandcuffed then
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
            EnableControlAction(0, 249, true) -- Added for talking while cuffed
            EnableControlAction(0, 46, true)  -- Added for talking while cuffed

            if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3)) and not QBCore.Functions.GetPlayerData().metadata["isdead"] then
                loadAnimDict("mp_arresting")
                TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            end
        end

        if isZiptied then
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
            EnableControlAction(0, 249, true) -- Added for talking while cuffed
            EnableControlAction(0, 46, true)  -- Added for talking while cuffed

            if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3)) and not QBCore.Functions.GetPlayerData().metadata["isdead"] then
                loadAnimDict("mp_arresting")
                TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            end
        end

        if not isHandcuffed and not isEscorted and not isZiptied then
            Wait(2000)
        end
    end
end)