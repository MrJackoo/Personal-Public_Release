local QBCore = exports['qb-core']:GetCoreObject()

-- Events
RegisterServerEvent("ax-police:server:TrainingSlides", function(slidenumber)
    local displayimage = slidenumber
    TriggerClientEvent("ax-police:client:Slides", -1, displayimage)
end)