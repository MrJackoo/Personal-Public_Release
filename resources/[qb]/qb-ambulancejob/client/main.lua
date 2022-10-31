QBCore = exports['qb-core']:GetCoreObject()

local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
local PlayerJob = QBCore.Functions.GetPlayerData().job
local canLeaveBed = true
local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil
local closestBed = nil
local doctorCount = 0
local CurrentDamageList = {}
local cam = nil
local playerArmor = nil
local recentlysent = false
local insafetyzone = false
inBedDict = "anim@gangops@morgue@table@"
inBedAnim = "body_search"
isInHospitalBed = false
isBleeding = 0
bleedTickTimer, advanceBleedTimer = 0, 0
fadeOutTimer, blackoutTimer = 0, 0
legCount = 0
armcount = 0
headCount = 0
playerHealth = nil
isDead = false
isStatusChecking = false
statusChecks = {}
statusCheckTime = 0
medicateanimdict = "amb@medic@standing@tendtodead@idle_a"
medicateanimtype = "idle_a"
healAnimDict = "mini@cpr@char_a@cpr_str"
healAnim = "cpr_pumpchest"
injured = {}

BodyParts = {
    ['HEAD'] =          { label = Lang:t('body.head'),          causeLimp = false, isDamaged = false, severity = 0 },
    ['NECK'] =          { label = Lang:t('body.neck'),          causeLimp = false, isDamaged = false, severity = 0 },
    ['SPINE'] =         { label = Lang:t('body.spine'),         causeLimp = true, isDamaged = false, severity = 0 },
    ['UPPER_BODY'] =    { label = Lang:t('body.upper_body'),    causeLimp = false, isDamaged = false, severity = 0 },
    ['LOWER_BODY'] =    { label = Lang:t('body.lower_body'),    causeLimp = true, isDamaged = false, severity = 0 },
    ['LARM'] =          { label = Lang:t('body.left_arm'),      causeLimp = false, isDamaged = false, severity = 0 },
    ['LHAND'] =         { label = Lang:t('body.left_hand'),     causeLimp = false, isDamaged = false, severity = 0 },
    ['LFINGER'] =       { label = Lang:t('body.left_fingers'),  causeLimp = false, isDamaged = false, severity = 0 },
    ['LLEG'] =          { label = Lang:t('body.left_leg'),      causeLimp = true, isDamaged = false, severity = 0 },
    ['LFOOT'] =         { label = Lang:t('body.left_foot'),     causeLimp = true, isDamaged = false, severity = 0 },
    ['RARM'] =          { label = Lang:t('body.right_arm'),     causeLimp = false, isDamaged = false, severity = 0 },
    ['RHAND'] =         { label = Lang:t('body.right_hand'),    causeLimp = false, isDamaged = false, severity = 0 },
    ['RFINGER'] =       { label = Lang:t('body.right_fingers'), causeLimp = false, isDamaged = false, severity = 0 },
    ['RLEG'] =          { label = Lang:t('body.right_leg'),     causeLimp = true, isDamaged = false, severity = 0 },
    ['RFOOT'] =         { label = Lang:t('body.right_foot'),    causeLimp = true, isDamaged = false, severity = 0 },
}

-- Functions

local function GetAvailableBed(bedId)
    local pos = GetEntityCoords(PlayerPedId())
    local retval = nil
    if bedId == nil then
        for k, _ in pairs(Config.Locations["beds"]) do
            if not Config.Locations["beds"][k].taken then
                if #(pos - vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z)) < 500 then
                        retval = k
                end
            end
        end
    else
        if not Config.Locations["beds"][bedId].taken then
            if #(pos - vector3(Config.Locations["beds"][bedId].coords.x, Config.Locations["beds"][bedId].coords.y, Config.Locations["beds"][bedId].coords.z))  < 500 then
                retval = bedId
            end
        end
    end
    return retval
end

local function GetDamagingWeapon(ped)
    for k, v in pairs(Config.Weapons) do
        if HasPedBeenDamagedByWeapon(ped, k, 0) then
            return v
        end
    end

    return nil
end

local function IsDamagingEvent(damageDone, weapon)
    local luck = math.random(100)
    local multi = damageDone / Config.HealthDamage

    return luck < (Config.HealthDamage * multi) or (damageDone >= Config.ForceInjury or multi > Config.MaxInjuryChanceMulti or Config.ForceInjuryWeapons[weapon])
end

local function DoLimbAlert()
    if not isDead and not InLaststand then
        if #injured > 0 then
            local limbDamageMsg = ''
            if #injured <= Config.AlertShowInfo then
                for k, v in pairs(injured) do
                    limbDamageMsg = limbDamageMsg..Lang:t('info.pain_message', {limb = v.label, severity = Config.WoundStates[v.severity]})
                    if k < #injured then
                        limbDamageMsg = limbDamageMsg .. " | "
                    end
                end
            else
                limbDamageMsg = Lang:t('info.many_places')
            end
            QBCore.Functions.Notify(limbDamageMsg, "primary")
        end
    end
end

local function DoBleedAlert()
    if not isDead and tonumber(isBleeding) > 0 then
        QBCore.Functions.Notify(Lang:t('info.bleed_alert', {bleedstate = Config.BleedingStates[tonumber(isBleeding)].label}), "error")
    end
end

local function ApplyBleed(level)
    if isBleeding ~= 4 then
        if isBleeding + level > 4 then
            isBleeding = 4
        else
            isBleeding = isBleeding + level
        end
        DoBleedAlert()
    end
end

local function SetClosestBed()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k, _ in pairs(Config.Locations["beds"]) do
        local dist2 = #(pos - vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z))
        if current then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    if current ~= closestBed and not isInHospitalBed then
        closestBed = current
    end
end

local function IsInjuryCausingLimp()
    for _, v in pairs(BodyParts) do
        if v.causeLimp and v.isDamaged then
            return true
        end
    end
    return false
end

local function ProcessRunStuff(ped)
    if IsInjuryCausingLimp() then
        RequestAnimSet("move_m@injured")
        while not HasAnimSetLoaded("move_m@injured") do
            Wait(0)
        end
        SetPedMovementClipset(ped, "move_m@injured", 1 )
        SetPlayerSprint(PlayerId(), false)
    end
end

function ResetPartial()
    for _, v in pairs(BodyParts) do
        if v.isDamaged and v.severity <= 2 then
            v.isDamaged = false
            v.severity = 0
        end
    end

    for k, v in pairs(injured) do
        if v.severity <= 2 then
            v.severity = 0
            table.remove(injured, k)
        end
    end

    if isBleeding <= 2 then
        isBleeding = 0
        bleedTickTimer = 0
        advanceBleedTimer = 0
        fadeOutTimer = 0
        blackoutTimer = 0
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
    DoBleedAlert()

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
end

local function ResetAll()
    isBleeding = 0
    bleedTickTimer = 0
    advanceBleedTimer = 0
    fadeOutTimer = 0
    blackoutTimer = 0
    onDrugs = 0
    wasOnDrugs = false
    onPainKiller = 0
    wasOnPainKillers = false
    injured = {}

    for _, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 0
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    CurrentDamageList = {}
    TriggerServerEvent('hospital:server:SetWeaponDamage', CurrentDamageList)

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
    DoBleedAlert()

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
    TriggerServerEvent("hospital:server:resetHungerThirst")
end

local function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(1)
	end
end

local function SetBedCam()
    isInHospitalBed = true
    canLeaveBed = false
    local player = PlayerPedId()

    DoScreenFadeOut(1000)

    while not IsScreenFadedOut() do
        Wait(100)
    end

	if IsPedDeadOrDying(player) then
		local pos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    end

    bedObject = GetClosestObjectOfType(bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z, 1.0, bedOccupyingData.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(player, bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z + 0.02)
    --SetEntityInvincible(PlayerPedId(), true)
    Wait(500)
    FreezeEntityPosition(player, true)

    loadAnimDict(inBedDict)

    TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    SetEntityHeading(player, bedOccupyingData.coords.w)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, player, 31085, 0, 1.0, 1.0 , true)
    SetCamFov(cam, 90.0)
    local heading = GetEntityHeading(player)
    heading = (heading > 180) and heading - 180 or heading + 180
    SetCamRot(cam, -45.0, 0.0, heading, 2)

    DoScreenFadeIn(1000)

    Wait(1000)
    FreezeEntityPosition(player, true)
end

local function LeaveBed()
    local player = PlayerPedId()

    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Wait(0)
    end

    FreezeEntityPosition(player, false)
    SetEntityInvincible(player, false)
    SetEntityHeading(player, bedOccupyingData.coords.w + 90)
    TaskPlayAnim(player, getOutDict , getOutAnim, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    Wait(4000)
    ClearPedTasks(player)
    TriggerServerEvent('hospital:server:LeaveBed', bedOccupying)
    FreezeEntityPosition(bedObject, true)
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
    isInHospitalBed = false
	
    QBCore.Functions.GetPlayerData(function(PlayerData)
	if PlayerData.metadata["injail"] > 0 then
		    TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
	    end
    end)
end

local function IsInDamageList(damage)
    local retval = false
    if CurrentDamageList then
        for k, _ in pairs(CurrentDamageList) do
            if CurrentDamageList[k] == damage then
                retval = true
            end
        end
    end
    return retval
end

local function CheckWeaponDamage(ped)
    local detected = false
    for k, v in pairs(QBCore.Shared.Weapons) do
        if HasPedBeenDamagedByWeapon(ped, k, 0) then
            detected = true
            if not IsInDamageList(k) then
                --[[TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = false,
                    args = {Lang:t('info.status'), v.damagereason}
                })]]--
                CurrentDamageList[#CurrentDamageList+1] = k
            end
        end
    end
    if detected then
        TriggerServerEvent("hospital:server:SetWeaponDamage", CurrentDamageList)
    end
    ClearEntityLastDamageEntity(ped)
end

local function ApplyImmediateEffects(ped, bone, weapon, damageDone)
    local armor = GetPedArmour(ped)
    if Config.MinorInjurWeapons[weapon] and damageDone < Config.DamageMinorToMajor then
        if Config.CriticalAreas[Config.Bones[bone]] then
            if armor <= 0 then
                ApplyBleed(1)
            end
        end

        if Config.StaggerAreas[Config.Bones[bone]] and (Config.StaggerAreas[Config.Bones[bone]].armored or armor <= 0) then
            if math.random(100) <= math.ceil(Config.StaggerAreas[Config.Bones[bone]].minor) then
                SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            end
        end
    elseif Config.MajorInjurWeapons[weapon] or (Config.MinorInjurWeapons[weapon] and damageDone >= Config.DamageMinorToMajor) then
        if Config.CriticalAreas[Config.Bones[bone]] then
            if armor > 0 and Config.CriticalAreas[Config.Bones[bone]].armored then
                if math.random(100) <= math.ceil(Config.MajorArmoredBleedChance) then
                    ApplyBleed(1)
                end
            else
                ApplyBleed(1)
            end
        else
            if armor > 0 then
                if math.random(100) < (Config.MajorArmoredBleedChance) then
                    ApplyBleed(1)
                end
            else
                if math.random(100) < (Config.MajorArmoredBleedChance * 2) then
                    ApplyBleed(1)
                end
            end
        end

        if Config.StaggerAreas[Config.Bones[bone]] and (Config.StaggerAreas[Config.Bones[bone]].armored or armor <= 0) then
            if math.random(100) <= math.ceil(Config.StaggerAreas[Config.Bones[bone]].major) then
                SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            end
        end
    end
end

local function CheckDamage(ped, bone, weapon, damageDone)
    if weapon == nil then return end

    if Config.Bones[bone] and not isDead and not InLaststand then
        ApplyImmediateEffects(ped, bone, weapon, damageDone)

        if not BodyParts[Config.Bones[bone]].isDamaged then
            BodyParts[Config.Bones[bone]].isDamaged = true
            BodyParts[Config.Bones[bone]].severity = math.random(1, 3)
            injured[#injured+1] = {
                part = Config.Bones[bone],
                label = BodyParts[Config.Bones[bone]].label,
                severity = BodyParts[Config.Bones[bone]].severity
            }
        else
            if BodyParts[Config.Bones[bone]].severity < 4 then
                BodyParts[Config.Bones[bone]].severity = BodyParts[Config.Bones[bone]].severity + 1

                for _, v in pairs(injured) do
                    if v.part == Config.Bones[bone] then
                        v.severity = BodyParts[Config.Bones[bone]].severity
                    end
                end
            end
        end

        TriggerServerEvent('hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(ped)
    end
end

local function ProcessDamage(ped)
    if not isDead and not InLaststand and not onPainKillers then
        for _, v in pairs(injured) do
            if (v.part == 'LLEG' and v.severity > 1) or (v.part == 'RLEG' and v.severity > 1) or (v.part == 'LFOOT' and v.severity > 2) or (v.part == 'RFOOT' and v.severity > 2) then
                if legCount >= Config.LegInjuryTimer then
                    if not IsPedRagdoll(ped) and IsPedOnFoot(ped) then
                        local chance = math.random(100)
                        if (IsPedRunning(ped) or IsPedSprinting(ped)) then
                            if chance <= Config.LegInjuryChance.Running then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        else
                            if chance <= Config.LegInjuryChance.Walking then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        end
                    end
                    legCount = 0
                else
                    legCount = legCount + 1
                end
            elseif (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) or (v.part == 'RARM' and v.severity > 1) or (v.part == 'RHAND' and v.severity > 1) or (v.part == 'RFINGER' and v.severity > 2) then
                if armcount >= Config.ArmInjuryTimer then
                    if (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) then
                        local isDisabled = 15
                        CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Wait(1)
                            end
                        end)
                    else
                        local isDisabled = 15
                        CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisableControlAction(0, 25, true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Wait(1)
                            end
                        end)
                    end

                    armcount = 0
                else
                    armcount = armcount + 1
                end
            elseif (v.part == 'HEAD' and v.severity > 2) then
                if headCount >= Config.HeadInjuryTimer then
                    local chance = math.random(100)

                    if chance <= Config.HeadInjuryChance then
                        SetFlash(0, 0, 100, 10000, 100)

                        DoScreenFadeOut(100)
                        while not IsScreenFadedOut() do
                            Wait(0)
                        end

                        if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                            SetPedToRagdoll(ped, 5000, 1, 2)
                        end

                        Wait(5000)
                        DoScreenFadeIn(250)
                    end
                    headCount = 0
                else
                    headCount = headCount + 1
                end
            end
        end
    end
end

-- Events

RegisterNetEvent('hospital:client:ambulanceAlert', function(coords, text)
    local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1name = GetStreetNameFromHashKey(street1)
    local street2name = GetStreetNameFromHashKey(street2)
    QBCore.Functions.Notify({text = text, caption = street1name.. ' ' ..street2name}, 'ambulance')
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blipText = Lang:t('info.ems_alert', {text = text})
    SetBlipSprite(blip, 153)
    SetBlipSprite(blip2, 161)
    SetBlipColour(blip, 1)
    SetBlipColour(blip2, 1)
    SetBlipDisplay(blip, 4)
    SetBlipDisplay(blip2, 8)
    SetBlipAlpha(blip, transG)
    SetBlipAlpha(blip2, transG)
    SetBlipScale(blip, 0.8)
    SetBlipScale(blip2, 2.0)
    SetBlipAsShortRange(blip, false)
    SetBlipAsShortRange(blip2, false)
    PulseBlip(blip2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipText)
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        SetBlipAlpha(blip2, transG)
        if transG == 0 then
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('hospital:client:Revive', function()
    local player = PlayerPedId()

    if isDead or InLaststand then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
        isDead = false
        SetEntityInvincible(player, false)
        SetLaststand(false)
    end

    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        SetEntityInvincible(player, true)
        canLeaveBed = true
    end

    TriggerServerEvent("hospital:server:RestoreWeaponDamage")
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, 200)
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    ResetAll()
    ResetPedMovementClipset(player, 0.0)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
    emsNotified = false
    QBCore.Functions.Notify(Lang:t('info.healthy'))
end)

-- Events
RegisterNetEvent("Hospital:CheckIn", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if recentlysent == false then
        if doctorCount >= Config.MinimalDoctors then
            TriggerServerEvent("hospital:server:SendDoctorAlert")
            recentlysent = true
            Wait(60000)
            recentlysent = false
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
            QBCore.Functions.Progressbar("hospital_checkin", Lang:t('progress.checking_in'), 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                local bedId = GetAvailableBed()
                if bedId then
                    TriggerServerEvent("hospital:server:SendToBed", bedId, true)
                else
                    QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
                end
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
            end)
        end
    else
        QBCore.Functions.Notify("You have recently contacted a doctor, be patient!", "error", 3000)
    end
end)

RegisterNetEvent('hospital:client:SetPain', function()
    ApplyBleed(math.random(1,4))
    if not BodyParts[Config.Bones[24816]].isDamaged then
        BodyParts[Config.Bones[24816]].isDamaged = true
        BodyParts[Config.Bones[24816]].severity = math.random(1, 4)
        injured[#injured+1] = {
            part = Config.Bones[24816],
            label = BodyParts[Config.Bones[24816]].label,
            severity = BodyParts[Config.Bones[24816]].severity
        }
    end

    if not BodyParts[Config.Bones[40269]].isDamaged then
        BodyParts[Config.Bones[40269]].isDamaged = true
        BodyParts[Config.Bones[40269]].severity = math.random(1, 4)
        injured[#injured+1] = {
            part = Config.Bones[40269],
            label = BodyParts[Config.Bones[40269]].label,
            severity = BodyParts[Config.Bones[40269]].severity
        }
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
end)

RegisterNetEvent('hospital:client:KillPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('hospital:client:HealInjuries', function(type)
    if type == "full" then
        local player = PlayerPedId()
        ResetAll()
        TriggerServerEvent("hospital:server:RestoreWeaponDamage")
        SetEntityMaxHealth(player, 200)
        SetEntityHealth(player, 200)
        ClearPedBloodDamage(player)
        SetPlayerSprint(PlayerId(), true)
        QBCore.Functions.Notify("Wounds Successfully Patched Up", 'success')
    else
        local player = PlayerPedId()
        ResetPartial()
        TriggerServerEvent("hospital:server:RestoreWeaponDamage")
        ClearPedBloodDamage(player)
        QBCore.Functions.Notify("A Bandage has been applied, seek further assistance", 'success')
    end
end)

RegisterNetEvent('hospital:client:OnMorphine', function(type)
    DoScreenFadeOut(3000)
    Wait(2000)
    DoScreenFadeIn(3000)
    SetTimecycleModifier("hud_def_blur")
    Wait(5000)
    ClearTimecycleModifier()        
    ResetAll()
    Wait(2000)
    TriggerServerEvent("hospital:server:RestoreWeaponDamage")
    QBCore.Functions.Notify(Lang:t('success.wounds_healed'), 'success')
end)

RegisterNetEvent('hospital:client:SendToBed', function(id, data, isRevive)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    CreateThread(function ()
        Wait(5)
        if isRevive then
            QBCore.Functions.Notify(Lang:t('success.being_helped'), 'success')
            Wait(Config.AIHealTimer * 1000)
            TriggerEvent("hospital:client:Revive")
        else
            canLeaveBed = true
        end
    end)
end)

RegisterNetEvent('hospital:client:SetBed', function(id, isTaken)
    Config.Locations["beds"][id].taken = isTaken
end)

RegisterNetEvent('hospital:client:SetBed2', function(id, isTaken)
    Config.Locations["jailbeds"][id].taken = isTaken
end)

RegisterNetEvent('hospital:client:RespawnAtHospital', function()
    TriggerServerEvent("hospital:server:RespawnAtHospital")
    if exports["qb-policejob"]:IsHandcuffed() or exports["qb-policejob"]:IsZiptied() then
        TriggerEvent("police:client:GetCuffed", -1)
    end
    TriggerEvent("police:client:DeEscort")
end)

RegisterNetEvent('hospital:client:SendBillEmail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('mail.sender'),
            subject = Lang:t('mail.subject'),
            message = Lang:t('mail.message', {gender = gender, lastname = charinfo.lastname, costs = amount}),
            button = {}
        })
    end)
end)

RegisterNetEvent('qb-ambulancejob:ShadyMedicalBed', function(id, data, isRevive)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    CreateThread(function ()
        Wait(5)
        if isRevive then
            QBCore.Functions.Notify("You are being treated")
            Wait(Config.AIHealTimer * 1000)
            TriggerEvent("hospital:client:Revive")
            TriggerServerEvent("qb-ambulancejob:server:ShadyMedicalBill")
        else
            canLeaveBed = true
        end
    end)
end)


RegisterNetEvent('hospital:client:SetDoctorCount', function(amount)
    doctorCount = amount
end)

RegisterNetEvent('hospital:client:adminHeal', function()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
    TriggerServerEvent("hospital:server:resetHungerThirst")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local ped = PlayerPedId()
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent('hospital:server:SetLaststandStatus', false)
    TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
    if bedOccupying then
        TriggerServerEvent("hospital:server:LeaveBed", bedOccupying)
    end
    isDead = false
    deathTime = 0
    SetEntityInvincible(ped, false)
    SetPedArmour(ped, 0)
    ResetAll()
end)

-- Threads

CreateThread(function()
    for _, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 61)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 25)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if isInHospitalBed and canLeaveBed then
            sleep = 0
            exports['qb-core']:DrawText(Lang:t('text.bed_out'))
            if IsControlJustReleased(0, 38) then
                exports['qb-core']:KeyPressed(38)
                LeaveBed()
                exports['qb-core']:HideText()
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait((1000 * Config.MessageTimer))
        DoLimbAlert()
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        SetClosestBed()
        if isStatusChecking then
            statusCheckTime = statusCheckTime - 1
            if statusCheckTime <= 0 then
                statusChecks = {}
                isStatusChecking = false
            end
        end
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        local armor = GetPedArmour(ped)

        if not playerHealth then
            playerHealth = health
        end

        if not playerArmor then
            playerArmor = armor
        end

        local armorDamaged = (playerArmor ~= armor and armor < (playerArmor - Config.ArmorDamage) and armor > 0) -- Players armor was damaged
        local healthDamaged = (playerHealth ~= health) -- Players health was damaged

        local damageDone = (playerHealth - health)

        if armorDamaged or healthDamaged then
            local hit, bone = GetPedLastDamageBone(ped)
            local bodypart = Config.Bones[bone]
            local weapon = GetDamagingWeapon(ped)

            if hit and bodypart ~= 'NONE' then
                local checkDamage = true
                if damageDone >= Config.HealthDamage then
                    if weapon then
                        if armorDamaged and (bodypart == 'SPINE' or bodypart == 'UPPER_BODY') or weapon == Config.WeaponClasses['NOTHING'] then
                            checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                            if armorDamaged then
                                TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
                            end
                        end

                        if checkDamage then
                            if IsDamagingEvent(damageDone, weapon) then
                                CheckDamage(ped, bone, weapon, damageDone)
                            end
                        end
                    end
                elseif Config.AlwaysBleedChanceWeapons[weapon] then
                    if armorDamaged and (bodypart == 'SPINE' or bodypart == 'UPPER_BODY') or weapon == Config.WeaponClasses['NOTHING'] then
                        checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                    end
                    if math.random(100) < Config.AlwaysBleedChance and checkDamage then
                        ApplyBleed(1)
                    end
                end
            end

            CheckWeaponDamage(ped)
        end

        playerHealth = health
        playerArmor = armor

        if not isInHospitalBed then
            ProcessDamage(ped)
        end
        Wait(100)
    end
end)

local listen = false
 local function CheckInControls(variable)
    CreateThread(function()
        listen = true
        while listen do
            if IsControlJustPressed(0, 38) then
                exports['qb-core']:KeyPressed(38)
                if variable == "checkin" then
                   TriggerEvent('qb-ambulancejob:checkin')
                    listen = false
                elseif variable == "beds" then
                    TriggerEvent('qb-ambulancejob:beds')
                    listen = false
                end
            end
            Wait(1)
        end
    end)
end

RegisterNetEvent('qb-ambulancejob:beds', function()
    if GetAvailableBed(closestBed) then
        TriggerServerEvent("hospital:server:LayinBed", closestBed, false)
    else
        QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
    end
end)


-- new checkin thread
CreateThread(function()
    while true do
        Wait(1000)
        if isDead or InLaststand then
            exports['qb-target']:RemoveZone('nhsassistance')
            exports['qb-target']:AddBoxZone("nhsrevive", vector3(312.04, -593.78, 43.28), 2.0, 1.7, {
                name = "nhsrevive",
                heading = 250,
                debugPoly = false,
                minZ = 42.50,
                maxZ = 44.00,
                }, {
                    options = { 
                    {
                        event = 'Hospital:CheckIn',
                        icon = 'fas fa-notes-medical',
                        label = "Check in to bed",
                    }
                },
                distance = 2.0,
            })
        else
            exports['qb-target']:RemoveZone('nhsrevive')
            exports['qb-target']:AddBoxZone("nhsassistance", vector3(312.04, -593.78, 43.28), 2.0, 1.7, {
                name = "nhsassistance",
                heading = 250,
                debugPoly = false,
                minZ = 42.50,
                maxZ = 44.00,
                }, {
                    options = { 
                    {
                        event = 'hospital:server:SendDoctorAlert',
                        icon = 'fas fa-notes-medical',
                        type = "server",
                        label = "Call Doctor",
                    }
                },
                distance = 2.0,
            })
        end
    end
end)

-- CreateThread(function()
--     while true do
--         sleep = 1000
--         if LocalPlayer.state.isLoggedIn then
--             local pos = GetEntityCoords(PlayerPedId())
--             if isDead or InLaststand then
--                 for k, checkins in pairs(Config.Locations["checking"]) do
--                     if #(pos - checkins) < 6.5 then
--                         sleep = 5
--                         if doctorCount >= Config.MinimalDoctors then
--                             exports['qb-core']:DrawText(Lang:t('text.call_doc'),'left')
--                         else
--                             exports['qb-core']:DrawText(Lang:t('text.call_doc'),'left')
--                         end
--                         if IsControlJustReleased(0, 38) then
--                             if doctorCount >= Config.MinimalDoctors then
--                                 TriggerServerEvent("hospital:server:SendDoctorAlert")
--                             else
--                                 TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
--                                 QBCore.Functions.Progressbar("hospital_checkin", Lang:t('progress.checking_in'), 10000, false, true, {
--                                     disableMovement = true,
--                                     disableCarMovement = true,
--                                     disableMouse = false,
--                                     disableCombat = true,
--                                 }, {}, {}, {}, function() -- Done
--                                     TriggerEvent('animations:client:EmoteCommandStart', {"c"})
--                                     local bedId = GetAvailableBed()
--                                     if bedId then
--                                         TriggerServerEvent("hospital:server:SendToBed", bedId, true)
--                                         Wait(3000)
--                                         exports['qb-core']:HideText()
--                                     else
--                                         QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
--                                     end
--                                     exports['qb-core']:HideText()
--                                 end, function() -- Cancel
--                                     TriggerEvent('animations:client:EmoteCommandStart', {"c"})
--                                     QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
--                                     exports['qb-core']:HideText()
--                                 end)
--                             end
--                         end
--                     elseif #(pos - checkins) < 6.5 then
--                         sleep = 5
--                         if doctorCount >= Config.MinimalDoctors then
--                             exports['qb-core']:DrawText(Lang:t('text.call_doc'),'left')
--                         else
--                             exports['qb-core']:DrawText(Lang:t('text.call_doc'),'left')
--                         end
--                     end
--                 end
--             end
--         end
--         Wait(sleep)
--     end
-- end)

-- Convar turns into a boolean
if Config.UseTarget then
    CreateThread(function()
        for k, v in pairs(Config.Locations["beds"]) do
            exports['qb-target']:AddBoxZone("beds"..k,  v.coords, 2.5, 2.3, {
                name = "beds"..k,
                heading = -20,
                debugPoly = false,
                minZ = v.coords.z - 1,
                maxZ = v.coords.z + 1,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:beds",
                        icon = "fas fa-bed",
                        label = "Lay in Bed",
                    }
                },
                distance = 1.5
            })
        end
    end)
else
    CreateThread(function()
        local bedPoly = {}
        for k, v in pairs(Config.Locations["beds"]) do
            bedPoly[#bedPoly+1] = BoxZone:Create(v.coords, 2.5, 2.3, {
                name="beds"..k,
                heading = -20,
                debugPoly = false,
                minZ = v.coords.z - 1,
                maxZ = v.coords.z + 1,
            })
            local bedCombo = ComboZone:Create(bedPoly, {name = "bedCombo", debugPoly = false})
            bedCombo:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    exports['qb-core']:DrawText(Lang:t('text.lie_bed'), 'left')
                    CheckInControls("beds")
                else
                    listen = false
                    exports['qb-core']:HideText()
                end
            end)
        end
    end)
end

CreateThread(function()
    local safezonepoly = {}
    safezonepoly = PolyZone:Create({
        vector2(266.96887207031, -611.74877929688),
        vector2(290.505859375, -554.76208496094),
        vector2(308.16333007812, -558.93865966797),
        vector2(304.97015380859, -566.26983642578),
        vector2(297.28713989258, -565.9462890625),
        vector2(301.89709472656, -575.97802734375),
        vector2(299.6891784668, -583.47119140625),
        vector2(299.98648071289, -584.09240722656),
        vector2(301.26138305664, -581.36444091797),
        vector2(302.56744384766, -581.89593505859),
        vector2(301.35751342773, -580.56164550781),
        vector2(305.60833740234, -569.68597412109),
        vector2(311.82205200195, -571.71594238281),
        vector2(312.18072509766, -570.93389892578),
        vector2(311.13854980469, -570.64685058594),
        vector2(314.16262817383, -562.013671875),
        vector2(319.04672241211, -563.61499023438),
        vector2(315.140625, -572.10308837891),
        vector2(314.32849121094, -571.72399902344),
        vector2(314.17834472656, -572.92028808594),
        vector2(317.69155883789, -573.82934570312),
        vector2(318.35549926758, -573.46905517578),
        vector2(317.18185424805, -572.84741210938),
        vector2(321.09310913086, -564.71484375),
        vector2(324.3740234375, -566.91595458984),
        vector2(321.75473022461, -574.32067871094),
        vector2(320.58673095703, -574.04089355469),
        vector2(319.92501831055, -575.21020507812),
        vector2(323.10632324219, -575.8056640625),
        vector2(323.77731323242, -575.77557373047),
        vector2(323.32913208008, -574.53247070312),
        vector2(325.47619628906, -566.83129882812),
        vector2(329.66354370117, -568.17541503906),
        vector2(326.85357666016, -576.04260253906),
        vector2(325.90023803711, -575.99591064453),
        vector2(325.53167724609, -576.68072509766),
        vector2(326.2858581543, -577.11975097656),
        vector2(326.07144165039, -578.05242919922),
        vector2(326.93008422852, -578.11059570312),
        vector2(331.04238891602, -568.43170166016),
        vector2(334.19564819336, -570.63177490234),
        vector2(333.71871948242, -578.68603515625),
        vector2(349.65237426758, -585.25646972656),
        vector2(347.96466064453, -589.85809326172),
        vector2(329.50790405273, -583.08227539062),
        vector2(327.46118164062, -590.09722900391),
        vector2(326.74481201172, -589.96551513672),
        vector2(326.33520507812, -590.84326171875),
        vector2(328.05850219727, -591.04498291016),
        vector2(327.82373046875, -592.69683837891),
        vector2(328.67794799805, -593.08074951172),
        vector2(328.99923706055, -591.37176513672),
        vector2(333.24197387695, -592.81286621094),
        vector2(329.14672851562, -604.41955566406),
        vector2(324.91458129883, -602.89904785156),
        vector2(327.37438964844, -595.75140380859),
        vector2(327.7890625, -594.78009033203),
        vector2(326.51019287109, -594.93939208984),
        vector2(324.17919921875, -602.84545898438),
        vector2(312.81127929688, -598.77093505859),
        vector2(314.7978515625, -592.71765136719),
        vector2(314.25015258789, -592.60119628906),
        vector2(311.93304443359, -598.50134277344),
        vector2(296.82992553711, -592.9052734375),
        vector2(298.95547485352, -586.90728759766),
        vector2(299.43215942383, -585.66180419922),
        vector2(298.68420410156, -585.59448242188),
        vector2(293.81109619141, -599.26812744141),
        vector2(309.09072875977, -604.76611328125),
        vector2(303.40545654297, -620.70501708984),
        vector2(290.87258911133, -616.18542480469),
        vector2(289.90469360352, -618.55938720703),
        vector2(281.66497802734, -615.77502441406),
        vector2(272.43295288086, -612.52435302734)
        }, {
        name="pillboxsafety",
        minZ = 41.5,
        maxZ = 50.0,
        debugPoly = false
    })
    safezonepoly:onPlayerInOut(function(isPointInside)
        if isPointInside then
            QBCore.Functions.Notify("You have entered safezone", "primary", 10000)
            Wait(2000)
            QBCore.Functions.Notify("You can only stay here for 10 Minutes maximum", "success", 10000)
            Wait(2000)
            QBCore.Functions.Notify("If you are caught loitering then staff will intervene", "error", 10000)
            Wait(2000)
            exports['qb-core']:DrawText("PILLBOX SAFEZONE [INSIDE] | NO CRIME ALLOWED", 'left')
        else
            exports['qb-core']:DrawText("PILLBOX SAFEZONE [OUTSIDE] | CRIME ALLOWED", 'left')
            Wait(2000)
            exports['qb-core']:HideText()
        end
    end)
end)

CreateThread(function()
    local alreadyEnteredZone = false
    local text = '[E] Pay for Treatment'
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        local dist = #(GetEntityCoords(ped)-vector3(296.35, -1352.11, 24.54))
        if isDead or InLaststand then
        if dist <= 2.5 and not isHealingPerson then
            wait = 5
            inZone  = true
            if IsControlJustReleased(0, 38) then
                exports['qb-core']:KeyPressed()
                TriggerServerEvent("qb-ambulancejob:server:ShadyMedical")
            end
        else
            wait = 1000
            end
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            TriggerEvent('qb-drawtext:client:DrawText', text, left)
            exports['qb-core']:DrawText('[E] Pay for Treatment','left')
        end
        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['qb-core']:HideText()
        end
        Wait(wait)
    end
end)
