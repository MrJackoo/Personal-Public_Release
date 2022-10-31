local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() -- Just for resource restart (same as event handler)
local radioMenu = false
local onRadio = false
local RadioChannel = 0
local RadioVolume = 50
local hasRadio = false
local radioProp = nil
local dead = false
local laststand = false

--Function
local function LoadAnimDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

local function SplitStr(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[#t+1] = str
    end
    return t
end

local function connecttoradio(channel)
    RadioChannel = channel
    if onRadio then
        exports["pma-voice"]:setRadioChannel(0)
    else
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    end
    exports["pma-voice"]:setRadioChannel(channel)
    if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
    else
        QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
    end
end

local function closeEvent()
	TriggerEvent("InteractSound_CL:PlayOnOne","click",0.6)
end

local function leaveradio()
    closeEvent()
    RadioChannel = 0
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    QBCore.Functions.Notify(Config.messages['you_leave'] , 'error')
end

local function toggleRadioAnimation(pState)
	LoadAnimDic("cellphone@")
	if pState then
		TriggerEvent("attachItemRadio","radio01")
		TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
		radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
	else
		StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
		ClearPedTasks(PlayerPedId())
		if radioProp ~= 0 then
			DeleteObject(radioProp)
			radioProp = 0
		end
	end
end

local function toggleRadio(toggle)
    radioMenu = toggle
    SetNuiFocus(radioMenu, radioMenu)
    if radioMenu then
        toggleRadioAnimation(true)
        SendNUIMessage({type = "open"})
    else
        toggleRadioAnimation(false)
        SendNUIMessage({type = "close"})
    end
end

local function IsRadioOn()
    return onRadio
end

local function DoRadioCheck(PlayerItems)
    local _hasRadio = false

    for _, item in pairs(PlayerItems) do
        if item.name == "radio" then
            _hasRadio = true
            break;
        end
    end

    hasRadio = _hasRadio
end

local function DoDeadCheck(isdead, inlaststand)
    dead = isdead
    laststand = inlaststand
end

--Exports
exports("IsRadioOn", IsRadioOn)

--Events

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    DoRadioCheck(PlayerData.items)
    DoDeadCheck(PlayerData.metadata["isdead"], PlayerData.metadata["inlaststand"])
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DoRadioCheck({})
    PlayerData = {}
    leaveradio()
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    DoRadioCheck(PlayerData.items)
    DoDeadCheck(PlayerData.metadata["isdead"], PlayerData.metadata["inlaststand"])
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        PlayerData = QBCore.Functions.GetPlayerData()
        DoRadioCheck(PlayerData.items)
        DoDeadCheck(PlayerData.metadata["isdead"], PlayerData.metadata["inlaststand"])
    end
end)

RegisterNetEvent('qb-radio:use', function()
    toggleRadio(not radioMenu)
end)

RegisterNetEvent('qb-radio:onRadioDrop', function()
    if RadioChannel ~= 0 then
        leaveradio()
    end
end)


-- Channel Switch 1
RegisterCommand('radiochannel1', function()

    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end

    local rchannel = tonumber(1)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel1', 'Channel 1 Switch', 'keyboard', 'NUMPAD0')

-- Channel Switch 2
RegisterCommand('radiochannel2', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(2)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel2', 'Channel 2 Switch', 'keyboard', 'NUMPAD1')

-- Channel Switch 3
RegisterCommand('radiochannel3', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(3)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel3', 'Channel 3 Switch', 'keyboard', 'NUMPAD2')

-- Channel Switch 4
RegisterCommand('radiochannel4', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(4)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel4', 'Channel 4 Switch', 'keyboard', 'NUMPAD3')


--------------- NHS CHANNELS ---------------------------

RegisterCommand('radiochannel5', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(5)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterCommand('radiochannel6', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(6)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterCommand('radiochannel7', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(7)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

---------------------- POLICE OPERATIONS -----------------------------------------

RegisterCommand('radiochannel8', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(8)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterCommand('radiochannel9', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(9)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterCommand('radiochannel10', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(10)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

-------------- EVENTS -----------------------
-- Channel Switch 1
RegisterNetEvent('rp-radio:radiochannel1', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(1)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel1', 'Channel 1 Switch', 'keyboard', 'NUMPAD0')

-- Channel Switch 2
RegisterNetEvent('rp-radio:radiochannel2', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(2)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel2', 'Channel 2 Switch', 'keyboard', 'NUMPAD1')

-- Channel Switch 3
RegisterNetEvent('rp-radio:radiochannel3', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(3)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel3', 'Channel 3 Switch', 'keyboard', 'NUMPAD2')

-- Channel Switch 4
RegisterNetEvent('rp-radio:radiochannel4', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(4)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterKeyMapping('radiochannel4', 'Channel 4 Switch', 'keyboard', 'NUMPAD3')


--------------- NHS CHANNELS ---------------------------

RegisterNetEvent('rp-radio:radiochannel5', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(5)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterNetEvent('rp-radio:radiochannel6', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(6)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterNetEvent('rp-radio:radiochannel7', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(7)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

---------------------- POLICE OPERATIONS -----------------------------------------

RegisterNetEvent('rp-radio:radiochannel8', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(8)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterNetEvent('rp-radio:radiochannel9', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(9)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterNetEvent('rp-radio:radiochannel10', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(10)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

-- Scroll Volume Up
RegisterCommand('radiovolumeup', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    if RadioVolume < 100 then
        Wait(250)
        RadioVolume = RadioVolume + 10
        QBCore.Functions.Notify('Radio volume increased to ' .. RadioVolume..' %', "success")
        exports["pma-voice"]:setRadioVolume(RadioVolume)
    else
        exports["pma-voice"]:setRadioVolume(100)
        QBCore.Functions.Notify('Radio volume is at 100%', "error")
    end
end)

RegisterKeyMapping('radiovolumeup', 'Radio Volume Up', 'keyboard', 'EQUALS')

-- Scroll Volume Up
RegisterCommand('radiovolumedown', function()
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    if RadioVolume > 0 then
        Wait(250)
        RadioVolume = RadioVolume - 10
        QBCore.Functions.Notify('Radio volume decreased to '.. RadioVolume..' %', "success")
        exports["pma-voice"]:setRadioVolume(RadioVolume)
    else
        exports["pma-voice"]:setRadioVolume(0)
        QBCore.Functions.Notify('Radio volume is at 0%', "error")
    end
end)

RegisterKeyMapping('radiovolumedown', 'Radio Volume Down', 'keyboard', 'MINUS')

-- NUI
RegisterNUICallback('joinRadio', function(data, cb)
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local rchannel = tonumber(data.channel)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                        TriggerServerEvent('cd_dispatch:GetRadioChannel', rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
    cb("ok")
end)

RegisterNUICallback('leaveRadio', function(_, cb)
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end

    if RadioChannel == 0 then
        QBCore.Functions.Notify(Config.messages['not_on_radio'], 'error')
    else
        leaveradio()
    end
    cb("ok")
end)

RegisterNUICallback("volumeUp", function(_, cb)
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end

	if RadioVolume <= 95 then
		RadioVolume = RadioVolume + 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["decrease_radio_volume"], "error")
	end
    cb('ok')
end)

RegisterNUICallback("volumeDown", function(_, cb)
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end

	if RadioVolume >= 10 then
		RadioVolume = RadioVolume - 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["increase_radio_volume"], "error")
	end
    cb('ok')
end)

RegisterNUICallback("increaseradiochannel", function(_, cb)
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    local newChannel = RadioChannel + 1
    exports["pma-voice"]:setRadioChannel(newChannel)
    QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
    cb("ok")
end)

RegisterNUICallback("decreaseradiochannel", function(_, cb)
    if dead or laststand then
        return QBCore.Functions.Notify("Nice Try, You are injured and cannot access your radio" , 'error')
    end
    if not onRadio then return end
    local newChannel = RadioChannel - 1
    if newChannel >= 1 then
        exports["pma-voice"]:setRadioChannel(newChannel)
        QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
        cb("ok")
    end
end)

RegisterNUICallback('poweredOff', function(_, cb)
    leaveradio()
    cb("ok")
end)

RegisterNUICallback('escape', function(_, cb)
    toggleRadio(false)
    cb("ok")
end)

--Main Thread
CreateThread(function()
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn and onRadio then
            if not hasRadio or PlayerData.metadata.isdead or PlayerData.metadata.inlaststand then
                if RadioChannel ~= 0 then
                    leaveradio()
                end
            end
        end
    end
end)
