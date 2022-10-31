
local QBCore = exports['qb-core']:GetCoreObject()
local washers = {
    { x=1123.72, y=-3194.37, z=-40.0, h=0,  length=1.4, width=1.3 },
    { x=1125.62, y=-3194.32, z=-40.4, h=0,  length=1.4, width=1.3 },
    { x=1127.01, y=-3194.33, z=-40.4, h=0,  length=1.4, width=1.3 },
}


CreateThread(function()
    for washer, data in pairs(washers) do 
        exports['qb-target']:AddBoxZone("wash"..washer, vector3(data.x, data.y, data.z), data.length, data.width, {
            name="wash"..washer,
            heading=data.h,
            debugPoly=false,
            minZ=data.z - 1,
            maxZ=data.z + 1,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-moneywash:openwasher",
                        icon = "fas fa-step-backward",
                        label = "Open Washer",
                        id = washer,
                        canInteract = function()
                            local c = false 
                            QBCore.Functions.TriggerCallback("qb-moneywash:isWashing", function(result)
                                c = result
                            end, washer)
                            Wait(200)
                            if not c then return true else return false end 
                        end
                    },
                    {
                        type = "server",
                        event = "qb-moneywash:startwasher",
                        icon = "fas fa-hourglass-start",
                        label = "Start Washer",
                        id = washer,
                        canInteract = function()
                            local c = false 
                            QBCore.Functions.TriggerCallback("qb-moneywash:isWashing", function(result)
                                c = result
                            end, washer)
                            Wait(200)
                            if not c then return true else return false end
                        end
                    },
                    {
                        type = "server",
                        event = "qb-moneywash:collect",
                        icon = "fas fa-money-bill-alt",
                        label = "Collect Money",
                        id = washer,
                        canInteract = function()
                            local c = false
                            QBCore.Functions.TriggerCallback("qb-moneywash:isReady", function(result)
                                c = result
                            end, washer)
                            Wait(200)
                            return c
                        end
                    },
                },
            distance = 3.0
        })
    end
end)


-- Open the passed washerId's stash.
RegisterNetEvent("qb-moneywash:openwasher")
AddEventHandler("qb-moneywash:openwasher", function(data)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "washer"..data.id, {maxweight = 1000000, slots = 1})
    TriggerEvent("inventory:client:SetCurrentStash", "washer"..data.id)
end)

RegisterNetEvent('qb-moneywash:Notification')
AddEventHandler('qb-moneywash:Notification', function()
    Notification()
end)

function Notification()
	Citizen.Wait(10000)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Laundry Services",
        subject = "30 Minute Washing",
        message = "Your washing has been cleaned, come and pick it up"
    })
end