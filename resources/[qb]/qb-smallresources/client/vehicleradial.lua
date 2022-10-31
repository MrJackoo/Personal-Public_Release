local CarRadial = nil
local menuactive = false

function carradialmenu()
    CarRadial = exports['qb-radialmenu']:AddOption({
        id = 'caroptions',
        title = 'Veh Control',
        icon = 'car-alt',
        type = 'client',
        event = 'vehcontrol:openExternal',
        shouldClose = true
    }, CarRadial)

    menuactive = true
end

function UpdateCarRadial()
    local Player = PlayerPedId()
    if IsPedInAnyVehicle(Player) then
        carradialmenu()
    else
        if CarRadial ~= nil then
            exports['qb-radialmenu']:RemoveOption(CarRadial)
            CarRadial = nil
        end
    end
end

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    UpdateCarRadial()
end)