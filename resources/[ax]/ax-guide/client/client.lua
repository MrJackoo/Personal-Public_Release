local QBCore = exports['qb-core']:GetCoreObject()

-- CreateThread(function()
--     while true do
--         Wait(0)

--         if IsControlJustPressed(1, 288) then
--             if true then
--                 SetNuiFocus(true, true)
--                 SendNUIMessage({type = 'openGuideHud'})
--             end
--         end
--     end
-- end)

RegisterNUICallback('closeGuideHud', function(data, cb)
	SetNuiFocus(false, false)
end)


RegisterCommand('openGuideHud', function()
    openMenu()
end)

RegisterKeyMapping('openGuideHud', 'Open AX Guide', "keyboard", "F1")

function openMenu()
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openGuideHud'})
end

RegisterCommand('axpdm', function()
    SetNewWaypoint(-71.64, -1122.6)
    QBCore.Functions.Notify("A waypoint has been set, check your map", "success")
end)

RegisterCommand('axtuners', function()
    SetNewWaypoint(147.63, -3025.29)
    QBCore.Functions.Notify("A waypoint has been set, check your map", "success")
end)

RegisterCommand('aximpound', function()
    SetNewWaypoint(-192.01, -1157.88)
    QBCore.Functions.Notify("A waypoint has been set, check your map", "success")
end)

RegisterCommand('axpolice', function()
    SetNewWaypoint(414.57, -981.0)
    QBCore.Functions.Notify("A waypoint has been set, check your map", "success")
end)

RegisterCommand('axnhs', function()
    SetNewWaypoint(289.46, -586.71)
    QBCore.Functions.Notify("A waypoint has been set, check your map", "success")
end)