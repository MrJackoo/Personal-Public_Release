local QBCore = exports['qb-core']:GetCoreObject()
local xsound = exports.xsound

QBCore.Functions.CreateUseableItem("boombox", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-boombox:client:placeBoombox', src)
end)

RegisterNetEvent('qb-boombox:server:playMusic', function(song, entity, coords)
    local src = source
    xsound:PlayUrlPos(-1, tostring(entity), song, Config.DefaultVolume, coords)
    xsound:Distance(-1, tostring(entity), Config.radius)
    isPlaying = true
end)

RegisterNetEvent('qb-boombox:server:pickedup', function(entity)
    local src = source
    xsound:Destroy(-1, tostring(entity))
end)

RegisterNetEvent('qb-boombox:server:stopMusic', function(data)
    local src = source
    xsound:Destroy(-1, tostring(data.entity))
    TriggerClientEvent('qb-boombox:client:playMusic', src)
end)

RegisterNetEvent('qb-boombox:server:stopMusicVU', function(data)
    local src = source
    xsound:Destroy(-1, tostring(data.entity))
    TriggerClientEvent('qb-boombox:client:playMusicVU', src)
end)

RegisterNetEvent('qb-boombox:server:pauseMusic', function(data)
    local src = source
    xsound:Pause(-1, tostring(data.entity))
end)

RegisterNetEvent('qb-boombox:server:resumeMusic', function(data)
    local src = source
    xsound:Resume(-1, tostring(data.entity))
end)

RegisterNetEvent('qb-boombox:server:changeVolume', function(volume, entity)
    local src = source
    if not tonumber(volume) then return end
    xsound:setVolume(-1, tostring(entity), volume)
end)


local function CheckBoomboxAce(callback)
    
end

QBCore.Functions.CreateCallback("qb-boom:checkaces", function(source, cb)

    if IsPlayerAceAllowed(source, 'pickupboombox') then
        cb(true)
    else
        cb(false)
    end
	
end)