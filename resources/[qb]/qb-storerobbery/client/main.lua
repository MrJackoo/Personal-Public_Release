local QBCore = exports['qb-core']:GetCoreObject()
local currentRegister = 0
local currentSafe = 0
local copsCalled = false
local CurrentCops = 0
local PlayerJob = {}
local onDuty = false
local usingAdvanced = false

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

CreateThread(function()
    while true do
        Wait(100 * 60)
        if copsCalled then
            copsCalled = false
        end
    end
end)

CreateThread(function()
    Wait(1000)
    setupRegister()
    setupSafes()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        for k in pairs(Config.Registers) do
            local dist = #(pos - Config.Registers[k].coords)
            if dist <= 1 and Config.Registers[k].robbed then
                inRange = true
                DrawText3Ds(Config.Registers[k].coords, 'The Cash Register Is Empty')
            elseif dist <= 1 and Config.Registers[k].failed then
                inRange = true
                DrawText3Ds(Config.Registers[k].coords, 'The Cash Register Is on ~r~ LOCKDOWN')
            end
        end
        if not inRange then
            Wait(2000)
        end
        Wait(3)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        local inRange = false
        if QBCore ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            for safe,_ in pairs(Config.Safes) do
                local dist = #(pos - Config.Safes[safe].coords)
                if dist < 3 then
                    inRange = true
                    if dist < 1.0 then
                        if not Config.Safes[safe].robbed then
                            DrawText3Ds(Config.Safes[safe].coords, '~g~E~w~ - Try Combination')
                            if IsControlJustPressed(0, 38) then
                                if CurrentCops >= Config.MinimumStoreRobberyPolice then
                                    currentSafe = safe
                                    local tempsafeID = Config.Safes[currentSafe].camId
                                    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                    end
                                    if math.random(100) <= 50 then
                                        TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                                    end
                                    if Config.Safes[safe].type == "keypad" then
                                        SendNUIMessage({
                                            action = "openKeypad",
                                        })
                                        SetNuiFocus(true, true)
                                    else
                                        QBCore.Functions.TriggerCallback('qb-storerobbery:server:getPadlockCombination', function(combination)
                                            TriggerEvent("SafeCracker:StartMinigame", combination)
                                        end, safe)
                                    end

                                    if not copsCalled then
                                        pos = GetEntityCoords(PlayerPedId())
                                        local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                                        local street1 = GetStreetNameFromHashKey(s1)
                                        local street2 = GetStreetNameFromHashKey(s2)
                                        local streetLabel = street1
                                        if street2 ~= nil then
                                            streetLabel = streetLabel .. " " .. street2
                                        end
                                        local data = exports['cd_dispatch']:GetPlayerInfo()
                                        TriggerServerEvent('cd_dispatch:AddNotification', {
                                            job_table = {'police'}, 
                                            coords = data.coords,
                                            title = 'Store Robbery',
                                            message = 'A store\'s silent alarm has been activated on '..data.street..' Camera ID: '..tempsafeID,
                                            flash = 0,
                                            unique_id = tostring(math.random(0000000,9999999)),
                                            blip = {
                                                sprite = 362,
                                                scale = 0.8,
                                                colour = 49,
                                                flashes = false,
                                                text = 'Grade 1 - Store Robbery',
                                                time = (5*30*1000),
                                                sound = 1,
                                            }
                                        })
                                        copsCalled = true
                                    end
                                else
                                    QBCore.Functions.Notify("Not Enough Police (".. Config.MinimumStoreRobberyPolice .." Required)", "error")
                                end
                            end
                        else
                            DrawText3Ds(Config.Safes[safe].coords, 'Safe Opened')
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(2000)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
    usingAdvanced = isAdvanced
    for k in pairs(Config.Registers) do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - Config.Registers[k].coords)
        if dist <= 1 and not Config.Registers[k].robbed and not Config.Registers[k].failed then
            if CurrentCops >= Config.MinimumStoreRobberyPolice then
                if usingAdvanced then
                    -- Advanced lockpick(true)
                    currentRegister = k
                    local tempcamId = Config.Registers[currentRegister].camId
                    lockpickreg()                    
                    if not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                    end
                    if not copsCalled then
                        local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                        local street1 = GetStreetNameFromHashKey(s1)
                        local street2 = GetStreetNameFromHashKey(s2)
                        local streetLabel = street1
                        if street2 ~= nil then
                            streetLabel = streetLabel .. " " .. street2
                        end
                        local data = exports['cd_dispatch']:GetPlayerInfo()
                        TriggerServerEvent('cd_dispatch:AddNotification', {
                            job_table = {'police'}, 
                            coords = data.coords,
                            title = 'Store Robbery',
                            message = 'A store\'s silent alarm has been activated on '..data.street..' Camera ID: '..tempcamId,
                            flash = 0,
                            unique_id = tostring(math.random(0000000,9999999)),
                            blip = {
                                sprite = 362,
                                scale = 0.8,
                                colour = 49,
                                flashes = false,
                                text = 'Grade 1 - Store Robbery',
                                time = (5*30*1000),
                                sound = 1,
                            }
                        })
                        copsCalled = true
                    end
                else
                    QBCore.Functions.Notify("Nice try this cash register is not that weak fam, Now get out of my shop", "error")
                    local pedcoords = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('qb-storerobbery:server:notrobnow')
                end
            else
                QBCore.Functions.Notify("Not Enough Police ("..Config.MinimumStoreRobberyPolice.." required)", "error")
            end
        end
    end
end)

RegisterNetEvent('qb-storerobbery:client:pedattack', function(waslockpicked)
    if waslockpicked then
        local chance = math.random(1,100)
        if chance >= 60 then
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped)

            local model = "a_f_m_bodybuild_01"

            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            
            GetEntityForwardX(ped)

            local agroped = CreatePed(0, model, pedcoords.x + (GetEntityForwardX(ped)*6), pedcoords.y + (GetEntityForwardY(ped)*6), pedcoords.z, 0, false, true)

            GiveWeaponToPed(agroped, GetHashKey("WEAPON_BAT"), 0, true, true)

            TaskSetBlockingOfNonTemporaryEvents(agroped, true)
            SetPedFleeAttributes(agroped, 0, 0)
            SetPedCombatAttributes(agroped, 46, true)

            TaskGotoEntityAiming(agroped, ped, 0, 5)
            

            TaskCombatPed(agroped, ped, 0, 16)

            Wait(30000)

            SetEntityAsNoLongerNeeded(ped)
        end
    else
        local chance = math.random(1,100)
        if chance >= 50 then
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped)

            local model = "a_f_m_bodybuild_01"

            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            
            GetEntityForwardX(ped)
            
            local agroped = CreatePed(0, model, pedcoords.x + (GetEntityForwardX(ped)*6), pedcoords.y + (GetEntityForwardY(ped)*6), pedcoords.z, 0, true, true)

            GiveWeaponToPed(agroped, GetHashKey("WEAPON_BAT"), 0, true, true)

            TaskSetBlockingOfNonTemporaryEvents(agroped, true)
            SetPedFleeAttributes(agroped, 0, 0)
            SetPedCombatAttributes(agroped, 46, true)

            TaskGotoEntityAiming(agroped, ped, 0, 5)
            

            TaskCombatPed(agroped, ped, 0, 16)

            Wait(30000)

            SetEntityAsNoLongerNeeded(ped)
        end
    end
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true

    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function setupRegister()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getRegisterStatus', function(Registers)
        for k in pairs(Registers) do
            Config.Registers[k].robbed = Registers[k].robbed
            Config.Registers[k].failed = Registers[k].failed
        end
    end)
end

function setupSafes()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getSafeStatus', function(Safes)
        for k in pairs(Safes) do
            Config.Safes[k].robbed = Safes[k].robbed
            Config.Safes[k].failed = Safes[k].failed
        end
    end)
end

DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function lockpickreg()
    local chance = math.random(1,100)
    if chance >= 5 then
        local success = exports['qb-lock']:StartLockPickCircle(math.random(3,4),math.random(5,6))
        
        if success then
            QBCore.Functions.Progressbar("search_register", "Emptying The Register..", 60000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flags = 16,
            }, {}, {}, function() -- Done
                TriggerServerEvent('qb-storerobbery:server:setRegisterStatus', currentRegister)
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('qb-storerobbery:server:takeMoney', currentRegister, true)
                currentRegister = 0
            end, function() -- Cancel
                openingDoor = false
                ClearPedTasks(PlayerPedId())
                QBCore.Functions.Notify("Process canceled..", "error")
                TriggerServerEvent('qb-storerobbery:server:setRegisterStatus', currentRegister, true)
                currentRegister = 0
            end)
        else
            QBCore.Functions.Notify("Better Luck next time", "error")
            -- print(currentRegister)
            TriggerServerEvent('qb-storerobbery:server:setRegisterStatus', currentRegister, true)
            currentRegister = 0
        end
    else 
        QBCore.Functions.Notify("It seems like your lockpick snapped in the register!", "error")
        TriggerServerEvent('qb-storerobbery:server:unlucky')
        TriggerServerEvent('qb-storerobbery:server:notrobnow')
        TriggerServerEvent('qb-storerobbery:server:setRegisterStatus', currentRegister, true)
        currentRegister = 0        
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(100)
    end
end

function takeAnim()
    local ped = PlayerPedId()
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Wait(100)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end

local openingDoor = false


RegisterNUICallback('callcops', function(_, cb)

    -- TriggerEvent("police:SetCopAlert")
    -- print("camera is: ", Config.Safes[currentSafe].camId)
    local data = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'}, 
        coords = data.coords,
        title = 'Store Robbery',
        message = 'A store\'s safe alarm has been activated on '..data.street..' Camera ID: '..Config.Safes[currentSafe].camId,
        flash = 0,
        unique_id = tostring(math.random(0000000,9999999)),
        blip = {
            sprite = 362,
            scale = 0.8,
            colour = 49,
            flashes = false,
            text = 'Grade 1 - Store Robbery',
            time = (5*30*1000),
            sound = 1,
        }
    })

    cb('ok')
end)

RegisterNetEvent('SafeCracker:EndMinigame', function(won)
    if currentSafe ~= 0 then
        if won then
            if currentSafe ~= 0 then
                if not Config.Safes[currentSafe].robbed then
                    SetNuiFocus(false, false)
                    TriggerServerEvent("qb-storerobbery:server:SafeReward", currentSafe)
                    TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
                    currentSafe = 0
                    takeAnim()
                end
            else
                SendNUIMessage({
                    action = "kekw",
                })
            end
        end
    end
    copsCalled = false
end)

RegisterNUICallback('PadLockSuccess', function(_, cb)
    if currentSafe ~= 0 then
        if not Config.Safes[currentSafe].robbed then
            SendNUIMessage({
                action = "kekw",
            })
        end
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
    cb('ok')
end)

RegisterNUICallback('PadLockClose', function(_, cb)
    SetNuiFocus(false, false)
    copsCalled = false
    cb('ok')
end)

RegisterNUICallback("CombinationFail", function(_, cb)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    cb("ok")
end)

RegisterNUICallback('TryCombination', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:isCombinationRight', function(combination)
        if tonumber(data.combination) ~= nil then
            if tonumber(data.combination) == combination then
                TriggerServerEvent("qb-storerobbery:server:SafeReward", currentSafe)
                TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = false,
                })
                currentSafe = 0
                takeAnim()
            else
                -- print("safe is: ", Config.Safes[currentSafe].camId)
                -- TriggerEvent("police:SetCopAlert")
                local data = exports['cd_dispatch']:GetPlayerInfo()
                TriggerServerEvent('cd_dispatch:AddNotification', {
                    job_table = {'police'}, 
                    coords = data.coords,
                    title = 'Store Robbery',
                    message = 'A store\'s safe alarm has been activated on '..data.street..' Camera ID: '..Config.Safes[currentSafe].camId,
                    flash = 0,
                    unique_id = tostring(math.random(0000000,9999999)),
                    blip = {
                        sprite = 362,
                        scale = 0.8,
                        colour = 49,
                        flashes = false,
                        text = 'Grade 1 - Store Robbery',
                        time = (5*30*1000),
                        sound = 1,
                    }
                })
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = true,
                })
                currentSafe = 0
            end
        end
        cb("ok")
    end, currentSafe)
end)

RegisterNetEvent('qb-storerobbery:client:setRegisterStatus', function(batch, val)
    -- Has to be a better way maybe like adding a unique id to identify the register
    if(type(batch) ~= "table") then
        Config.Registers[batch] = val
    else
        for k in pairs(batch) do
            Config.Registers[k] = batch[k]
        end
    end
end)

RegisterNetEvent('qb-storerobbery:client:setSafeStatus', function(safe, bool)
    Config.Safes[safe].robbed = bool
end)
