local QBCore = exports['qb-core']:GetCoreObject()
local onlinePlayers = {}
local displayid = false
abusetime = 5000 -- command cooldowqn time of id in Milliseconds
displaytime = 15000 -- Display time of id in Milliseconds
local cooldowntime = 60 -- 3 Minutes
local timeremaining = 0 -- Default time remaining counter (Dont Change)


Citizen.CreateThread(function()
    TriggerServerEvent('axiomid:add-id')
    while true do
        Wait(1)
        while displayid do
            Wait(1)
            for k, v in pairs(GetNeareastPlayers()) do
                local x, y, z = table.unpack(v.coords)
                Draw3DText(x, y, z + 1.1, v.playerId, 1.6)
                Draw3DText(x, y, z + 1.20, v.topText, 1.0)
                Draw3DText(x, y, z + 1.30, v.topText2, 1.0)
            end
        end
    end
end)


RegisterCommand('axiomid:toggleid', function()
    if timeremaining <= 0 then
        cooldown()
        displayid = true
        Wait(displaytime)
        displayid = false
    else
        local errormessage = "You have recently displayed playerID's"
        TriggerEvent('QBCore:Notify', errormessage, "error")
        Wait(abusetime)
    end
end)


RegisterNetEvent('axiomid:client:add-id')
AddEventHandler('axiomid:client:add-id', function(identifier, playerSource) -- (identifier, identifier2, playerSource)
    if playerSource then
        onlinePlayers[playerSource] = identifier --{identifier,identifier2}
    else
        onlinePlayers = identifier -- {identifier,identifier2}
    end
end)

RegisterKeyMapping('axiomid:toggleid', 'Toggle Show ID', 'Keyboard', 'delete')

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players_clean = {}
    local playerCoords = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed, false) then
        local players, _ = GetPlayersInArea(playerCoords, Config.distance)
        for i = 1, #players, 1 do
            local playerServerId = GetPlayerServerId(players[i])
            local player = GetPlayerFromServerId(playerServerId)
            local ped = GetPlayerPed(player)
            if IsEntityVisible(ped) then
                for x, v in pairs(onlinePlayers) do 
                    if x == tostring(playerServerId) then
                        table.insert(players_clean, {topText = v:upper(), playerId = playerServerId, coords = GetEntityCoords(ped)})
                        -- table.insert(players_clean, {topText = v[1]:upper(), topText2 = v[2]:upper(), playerId = playerServerId, coords = GetEntityCoords(ped)})
                    end
                end
            end
        end
    else
        local players, _ = GetPlayersInArea(playerCoords, Config.distance)
        for i = 1, #players, 1 do
            local playerServerId = GetPlayerServerId(players[i])
            local player = GetPlayerFromServerId(playerServerId)
            local ped = GetPlayerPed(player)
            if IsEntityVisible(ped) then
                for x, v in pairs(onlinePlayers) do 
                    if x == tostring(playerServerId) then
                        table.insert(players_clean, {topText = v:upper(), playerId = playerServerId, coords = GetEntityCoords(ped)})
                        -- table.insert(players_clean, {topText = v[1]:upper(), topText2 = v[2]:upper(), playerId = playerServerId, coords = GetEntityCoords(ped)})
                    end
                end
            end
        end
    end
   
    return players_clean
end

function cooldown()
    timeremaining = cooldowntime
    Citizen.CreateThread(function()
        while timeremaining > 0 do
            Citizen.Wait(1000)
            timeremaining = timeremaining - 1
        end
    end)
end

function Draw3DText(x, y, z, text, newScale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = newScale * (1 / dist) * (1 / GetGameplayCamFov()) * 100
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

function GetPlayersInArea(coords, area)
	local players, playersInArea = GetPlayers(), {}
	local coords = vector3(coords.x, coords.y, coords.z)
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)

		if #(coords - targetCoords) <= area then
			table.insert(playersInArea, players[i])
		end
	end
	return playersInArea
end