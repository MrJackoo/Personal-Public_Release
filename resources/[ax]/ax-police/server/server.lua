local QBCore = exports['qb-core']:GetCoreObject()

-- Custom Images (Training Room)
RegisterServerEvent("ax-police:server:CustomImages", function(image)
    local displayimage = image
    TriggerClientEvent("ax-police:client:Images", -1, displayimage)
end)

-- Custom Images (Meeting Room)
RegisterServerEvent("ax-police:server:CustomImages2", function(image)
    local displayimage = image
    TriggerClientEvent("ax-police:client:Images2", -1, displayimage)
end)

-- Meeting Notes
RegisterServerEvent("ax-police:server:MeetingSlides", function(slidenumber)
    local displayimage = slidenumber
    TriggerClientEvent("ax-police:MeetingSlides", -1, displayimage)
end)