-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local copsCalled = false
local currentSpot = 0
local CurrentCops = 0
local securityActive = true

-- Functions
function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
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

function GrabItem(spot)
    local pos = GetEntityCoords(PlayerPedId())
    local seconds = math.random(7,9)
    local circles = math.random(4,6)
    local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
    
    if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    
    if success then
        exports['qb-target']:AllowTargeting(false)
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'}, 
            coords = data.coords,
            title = 'Ammunation Robbery',
            message = 'Individuals are robbing an ammunation at '..data.street,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 110,
                scale = 0.8,
                colour = 3,
                flashes = false,
                text = 'Grade 1 - Ammunation Robbery',
                time = (5*30*1000),
                sound = 1,
            }
        })

        QBCore.Functions.Progressbar("grab_ammo", "Removing Items..", 35000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            },
            {
                animDict = "missheist_jewel",
                anim = "smash_case",
                flags = 16,
            },
            {},
            {},           
            function() -- Done
                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                TriggerServerEvent('qb-ammunationrobbery:server:setSpotState', "isDone", true, spot)
                TriggerServerEvent('qb-ammunationrobbery:server:setSpotState', "isBusy", false, spot)
                TriggerServerEvent('qb-ammunationrobbery:server:itemReward', spot)
                exports['qb-target']:AllowTargeting(true)
                --TriggerServerEvent('qb-cooldowns:setCooldown', 'robbery_shop', os.time() + 3600)
            end,
            function() -- Cancel
                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                TriggerServerEvent('qb-ammunationrobbery:server:setSpotState', "isBusy", false, spot)
                print("status set")
                QBCore.Functions.Notify("Cancelled..", "error")
                exports['qb-target']:AllowTargeting(true)
            end
        )
    else
        if math.random(1, 100) <= 40 and IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
            QBCore.Functions.Notify("You ripped your glove..")
            TriggerServerEvent('qb-ammunationrobbery:server:setSpotState', "isBusy", false, spot)
            print("status set") 
        end
        TriggerServerEvent('qb-ammunationrobbery:server:setSpotState', "isBusy", false, spot)
        print("status set")  
    end
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("qb-ammunationrobbery:server:LoadLocationList")
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-ammunationrobbery:client:LoadList', function(list)
    Config.Locations = list
end)

RegisterNetEvent('qb-ammunationrobbery:client:setSpotState', function(stateType, state, spot)
    if stateType == "isBusy" then
        Config.Locations["takeables"][spot].isBusy = state
    elseif stateType == "isDone" then
        Config.Locations["takeables"][spot].isDone = state
    end
end)

-- Threads
CreateThread(function()
     
    for spot, location in pairs(Config.Locations["takeables"]) do
        if not location.isBusy and not location.isDone then
            -- print("locations state is: ", location.isBusy)
            -- print("locations Done is: ", location.isDone)
            exports['qb-target']:AddBoxZone(Config.Locations["takeables"][spot].name, Config.Locations["takeables"][spot].coords, Config.Locations["takeables"][spot].width, Config.Locations["takeables"][spot].length, {
                name= c,
                heading= Config.Locations["takeables"][spot].heading,
                debugPoly= Config.Locations["takeables"][spot].debug,
                minZ = Config.Locations["takeables"][spot].coords.z - 1,
                maxZ = Config.Locations["takeables"][spot].coords.z + 1,
                }, {
                options = {
                {
                    type = "client",
                    action = function() -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                        if not Config.Locations["takeables"][spot].isBusy and not Config.Locations["takeables"][spot].isDone then
                            TriggerEvent('qb-ammunationrobbery:client:robcase', spot,location)
                            TriggerServerEvent('qb-ammunationrobbery:server:setSpotState', "isBusy", true, spot)                              
                        end
                    end,
                    canInteract = function()
                        if not Config.Locations["takeables"][spot].isBusy and not Config.Locations["takeables"][spot].isDone then
                            return true
                        end
                        return false
                    end,
                    icon = "fas fa-hammer",
                    label = Config.Locations["takeables"][spot].name,
                },
                },
                distance = 3.5
            })
        else
            Wait(1000)
            exports['qb-target']:RemoveZone(Config.Locations["takeables"][spot].name)
        end
    end

end)

RegisterNetEvent('qb-ammunationrobbery:client:robcase', function(spot,location)
    if location.isBusy or location.isDone then
        return print("ree kid")
    end

    if CurrentCops >= Config.RequiredCops then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
            if hasItem then
                currentSpot = spot
                GrabItem(currentSpot)
            else
                QBCore.Functions.Notify("You are missing an advanced lockpick", "error")
            end
        end, "advancedlockpick")
    else
        QBCore.Functions.Notify("Not enough Police", "error", 5000)
    end
end)

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