-- Variables
QBCore = exports['qb-core']:GetCoreObject()
isHandcuffed = false
isZiptied = false
cuffType = 1
isEscorted = false
PlayerJob = {}
onDuty = false
local DutyBlips = {}
local pedsReady = false

exports("CanRaid", function()
    local retval = false
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerJob.name == "police" and PlayerData.job.grade.level >= Config.RaidLevel then
        retval = true
    end
    return retval
end)

exports['qb-policejob']:CanRaid()

-- Functions
local function CreateDutyBlips(playerId, playerLabel, playerJob, playerLocation)
    local ped = GetPlayerPed(playerId)
    local blip = GetBlipFromEntity(ped)
    if not DoesBlipExist(blip) then
        if NetworkIsPlayerActive(playerId) then
            blip = AddBlipForEntity(ped)
        else
            blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
        end
        SetBlipSprite(blip, 1)
        ShowHeadingIndicatorOnBlip(blip, true)
        SetBlipRotation(blip, math.ceil(playerLocation.w))
        SetBlipScale(blip, 1.0)
        if playerJob == "police" then
            SetBlipColour(blip, 38)
        else
            SetBlipColour(blip, 5)
        end
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(playerLabel)
        EndTextCommandSetBlipName(blip)
        DutyBlips[#DutyBlips+1] = blip
    end

    if GetBlipFromEntity(PlayerPedId()) == blip then
        -- Ensure we remove our own blip.
        RemoveBlip(blip)
    end
end

-- Events
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
    isHandcuffed = false
    TriggerServerEvent("QBCore:Server:SetMetaData", "ishandcuffed", false)
    TriggerServerEvent("QBCore:Server:SetMetaData", "isziptied", false)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:SetZiptiedStatus", false)
    -- TriggerServerEvent("police:server:UpdateBlips")
    TriggerServerEvent("police:server:UpdateCurrentCops")

    if player.metadata.tracker then
        local trackerClothingData = {
            outfitData = {
                ["accessory"] = {
                    item = 13,
                    texture = 0
                }
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    else
        local trackerClothingData = {
            outfitData = {
                ["accessory"] = {
                    item = -1,
                    texture = 0
                }
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    end

    if PlayerJob and PlayerJob.name ~= "police" then
        if DutyBlips then
            for _, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    -- TriggerServerEvent('police:server:UpdateBlips')
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:SetZiptiedStatus", false)
    TriggerServerEvent("police:server:UpdateCurrentCops")
    isHandcuffed = false
    isZiptied = false
    isEscorted = false
    onDuty = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    if DutyBlips then
        for _, v in pairs(DutyBlips) do
            RemoveBlip(v)
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.name == "police" and PlayerJob.name ~= "police" then
        if JobInfo.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
            onDuty = false
        end
    end

    if JobInfo.name ~= "police" then
        if DutyBlips then
            for _, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
    PlayerJob = JobInfo
    -- TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('police:client:sendBillingMail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('email.sender'),
            subject = Lang:t('email.subject'),
            message = Lang:t('email.message', {value = gender, value2 = charinfo.lastname, value3 = amount}),
            button = {}
        })
    end)
end)

-- RegisterNetEvent('police:client:UpdateBlips', function(players)
--     if PlayerJob and (PlayerJob.name == 'police' or PlayerJob.name == 'ambulance') and
--         onDuty then
--         if DutyBlips then
--             for _, v in pairs(DutyBlips) do
--                 RemoveBlip(v)
--             end
--         end
--         DutyBlips = {}
--         if players then
--             for _, data in pairs(players) do
--                 local id = GetPlayerFromServerId(data.source)
--                 CreateDutyBlips(id, data.label, data.job, data.location)

--             end
--         end
--     end
-- end)

RegisterNetEvent('police:client:policeAlert', function(coords, text)
    local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1name = GetStreetNameFromHashKey(street1)
    local street2name = GetStreetNameFromHashKey(street2)
    QBCore.Functions.Notify({text = text, caption = street1name.. ' ' ..street2name}, 'police')
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blipText = Lang:t('info.blip_text', {value = text})
    SetBlipSprite(blip, 60)
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

RegisterNetEvent('police:client:SendToJail', function(time)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:SetZiptiedStatus", false)
    isHandcuffed = false
    isZiptied = false
    isEscorted = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    TriggerEvent("prison:client:Enter", time)
end)

RegisterNetEvent('qb-policejob:SentencePlayer', function()
    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        local playerId = GetPlayerServerId(player)
        local jaildialog = exports['qb-input']:ShowInput({
            header = "Sentence Player",
            submitText = "Send To Prison",
            inputs = {
                {
                    text = "Player ID",
                    name = "targetid",
                    type = "number",
                    isRequired = true
                },
                {
                    text = "Jail Time",
                    name = "sentencetime",
                    type = "number",
                    isRequired = true
                },
                {
                    text = "Fine Amount",
                    name = "fineamount",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if not jaildialog then return end

        if tonumber(jaildialog.sentencetime) >= 0 and tonumber(jaildialog.sentencetime) <= tonumber(Config.MaxSentence) then
            if tonumber(jaildialog.fineamount) >= 0 and tonumber(jaildialog.fineamount) <= tonumber(Config.MaxFine) then
                -- print("fining Person: ", tonumber(jaildialog.fineamount))
                if #(vector3(GetEntityCoords(PlayerPedId())) - vector3(GetEntityCoords(jaildialog.targetid))) > 10 then
                    if tonumber(jaildialog.sentencetime) ~= 0 then
                        TriggerServerEvent("police:server:JailPlayer", tonumber(jaildialog.targetid), tonumber(jaildialog.sentencetime))
                    end

                    if tonumber(jaildialog.fineamount) ~= 0 then
                        TriggerServerEvent('qb-policejob:FinePlayer', tonumber(jaildialog.targetid), tonumber(jaildialog.fineamount))
                    end

                    QBCore.Functions.Notify('Player ID '..jaildialog.targetid..' has been successfully fined £'..jaildialog.fineamount..' and has received '..jaildialog.sentencetime..' Months in jail!', 'success', 15000)
                else
                    QBCore.Functions.Notify('Player is to far away..', 'error', 5000)  
                end
            else
                QBCore.Functions.Notify('Invalid fine amount..', 'error', 5000)      
            end
        else
            QBCore.Functions.Notify('Invalid jail time..', 'error', 5000)      
        end
    else
        QBCore.Functions.Notify('This command is for police only..', 'error', 5000)
    end
end)

-- RegisterNetEvent('qb-policejob:SentencePlayer', function()
--     if QBCore.Functions.GetPlayerData().job.name == 'police' then
--         local sentence = exports['qb-input']:ShowInput({
--             header = "Sentence",
--             submitText = "Confirm",
--             inputs = {
--                 {
--                     type = 'number',
--                     isRequired = true,
--                     name = 'jail',
--                     text = 'Jail Time'
--                 },
--                 {
--                     type = 'number',
--                     isRequired = true,
--                     name = 'fine',
--                     text = 'Fine Amount'
--                 }
--             }
--         })
--         if sentence then
--             if tonumber(sentence.jail) >= 0 and tonumber(sentence.jail) <= 1000 then
--                 if tonumber(sentence.fine) >= 0 and tonumber(sentence.fine) <= 1000000 then
--                     if #(vector3(GetEntityCoords(PlayerPedId())) - vector3(GetEntityCoords(targetID))) > 10 then
--                         if tonumber(sentence.jail) ~= 0 then
--                             TriggerServerEvent("police:server:JailPlayer", targetID, tonumber(sentence.jail))
--                         end
--                         if tonumber(sentence.fine) ~= 0 then
--                             TriggerServerEvent('qb-policejob:FinePlayer', targetID, sentence.fine)
--                         end
--                         QBCore.Functions.Notify('Player ID '..targetID..' has been successfully fined £'..sentence.fine..' and has received '..sentence.jail..' Months in jail!', 'success', 15000)
--                     else
--                         QBCore.Functions.Notify('Player is to far away..', 'error', 5000)  
--                     end
--                 else
--                     QBCore.Functions.Notify('Invalid fine amount..', 'error', 5000)      
--                 end
--             else
--                 QBCore.Functions.Notify('Invalid jail time..', 'error', 5000)      
--             end
--         end
--     else
--         QBCore.Functions.Notify('This command is for police only..', 'error', 5000)
--     end
-- end)

RegisterNetEvent('police:client:SendPoliceEmergencyAlert', function()
    local player = QBCore.Functions.GetPlayerData()
    local playername = player.charinfo.firstname .. player.charinfo.lastname
    local callsign = player.metadata.callsign
    local fullname = string.format(player.charinfo.firstname, player.charinfo.lastname)
    local playerPos = GetEntityCoords(PlayerPedId())

    -- TriggerServerEvent('police_alerts:SendAlert', {
    --     notiftype = "panic",
    --     name = playername,
    -- })    
    RequestAnimDict('random@arrests')
    while not HasAnimDictLoaded('random@arrests') do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)

    Wait(3000)
    ClearPedTasks(PlayerPedId())

    -- TriggerServerEvent('police:server:policeAlert', Lang:t('info.officer_down', {lastname = player.charinfo.lastname, callsign = player.metadata.callsign}))
    -- TriggerServerEvent('hospital:server:ambulanceAlert', Lang:t('info.officer_down', {lastname = player.charinfo.lastname, callsign = player.metadata.callsign}))
end)

Citizen.CreateThread(function()
    modelHash = GetHashKey("mp_m_freemode_01")
    local model = modelHash
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    createNPC()
end)

function createNPC()
    local armorynpc = {x = 480.20, y = -996.75, z = 29.69, rotation = 97.63}
	armory_ped = CreatePed(0, modelHash, armorynpc.x, armorynpc.y, armorynpc.z, armorynpc.rotation, false, false)
	FreezeEntityPosition(armory_ped, true)
	SetEntityInvincible(armory_ped, true)

    -- (ped, Compid, DrawableID, TextureID)

    SetPedPropIndex(armory_ped, 1, 8, 0, true) -- Glasses
    SetPedComponentVariation(armory_ped, 0, 2, 0, 0) -- Head
    SetPedComponentVariation(armory_ped, 1, 210, 0, 0) -- Mask
    SetPedComponentVariation(armory_ped, 2, 18, 1, 0) -- hair
    SetPedComponentVariation(armory_ped, 3, 198, 0, 0) -- Torso
    SetPedComponentVariation(armory_ped, 4, 148, 0, 0) -- Legs
    SetPedComponentVariation(armory_ped, 5, 0, 0, 0) -- Bags
    SetPedComponentVariation(armory_ped, 6, 51, 0, 0) -- Shoes
    SetPedComponentVariation(armory_ped, 7, 154, 2, 0) -- Ties
    SetPedComponentVariation(armory_ped, 8, 194, 0, 0) -- T-Shirt
    SetPedComponentVariation(armory_ped, 9, 0, 0, 0) -- Vests
    SetPedComponentVariation(armory_ped, 10, 0, 0, 0) -- Decal
    SetPedComponentVariation(armory_ped, 11, 420, 1, 0) -- Tops

	SetBlockingOfNonTemporaryEvents(armory_ped, true)
	TaskStartScenarioInPlace(armory_ped, "WORLD_HUMAN_COP_IDLES", 0, true)
    exports['qb-target']:AddTargetEntity(armory_ped, {
        options = {
            {
                type = "client",
                event = "qb-police:client:openArmoury",
                label = 'Access Armory',
                icon = 'fas fa-gun',
                job = "police",
            }
        },
        distance = 2.0
    })
end

-- Threads
CreateThread(function()
    for _, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 60)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 29)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)
