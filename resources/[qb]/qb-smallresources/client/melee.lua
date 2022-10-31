-- Disables Left Click Attack
local canFight = false
CreateThread(function()
    while true do
    if canFight == false then
        DisableControlAction(0,24,true)
    end
    if IsControlPressed(0, 25) then
        canFight = true
    end
    if IsControlJustReleased(0, 25) then
        canFight = false
    end
        Wait(1)
    end
end)

-- Prevents Attacking from Motorcycles/Bikes
--[[CreateThread(function()
    while true do
           Wait(1)
           local PlayerPed = PlayerPedId()
           local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
           local vehicleClass = GetVehicleClass(vehicle)

        if IsPedInAnyVehicle(PlayerPed) and vehicleClass == 8 or vehicleClass == 13 then -- class #13 are bicycles
            DisableControlAction(1, 73, true)
            DisableControlAction(1, 105, true)
            DisableControlAction(1, 120, true)
            DisableControlAction(1, 154, true)
            DisableControlAction(1, 186, true)
            DisableControlAction(1, 252, true)
            DisableControlAction(1, 323, true)
            DisableControlAction(1, 337, true)
            DisableControlAction(1, 345, true)
            DisableControlAction(1, 354, true)
            DisableControlAction(1, 357, true)
        end
    end
end)]]--
