JustTeleported = false
MenuItemId = nil
CurrentLocation = nil
CurrentZone = nil
CurrentTeleport = nil

local function CreateTeleportBoxZone(name, coords, boxWidth, boxLength)
    local pos = vector3(coords.x, coords.y, coords.z)
    return BoxZone:Create(pos, boxWidth and boxWidth or 3, boxLength and boxLength or 3, {
        name = name,
        offset = {0.0, 0.0, 0.0},
        debugPoly = debugPoly,
        heading = coords.h,
        minZ = pos.z - 1.0,
        maxZ = pos.z + 3.0,
        coords = pos,
    })
end

CreateThread(function()
    for k, location in pairs(Config.Teleports) do
        for _,teleport in pairs(location.teleports) do
            local zones = {}
            if type(teleport.coords) == "table" then
                for _, coord in pairs(teleport.coords) do
                    zones[#zones+1] = CreateTeleportBoxZone(coord.id, coord.coords, teleport.boxZoneWidth and teleport.boxZoneWidth or location.boxZoneWidth, teleport.boxZoneLength and teleport.boxZoneLength or location.boxZoneLength)
                end
            else
               zones[1] = CreateTeleportBoxZone(teleport.id, teleport.coords, teleport.boxZoneWidth and teleport.boxZoneWidth or location.boxZoneWidth, teleport.boxZoneLength and teleport.boxZoneLength or location.boxZoneLength)
            end
            local comboZone = ComboZone:Create(zones, {name = "teleportCombo", debugPoly = location.debug ~= nil and location.debug or false})
            comboZone:onPlayerInOut(function(isPointInside, _, z)
                if isPointInside then
                    CurrentLocation = k
                    CurrentZone = z.name
                    CurrentTeleport = teleport.id

                    exports['qb-core']:DrawText(teleport.drawText or location.drawText , teleport.drawTextLocation or location.drawTextLocation)
                    MenuItemId = exports['qb-radialmenu']:AddOption({
                        id = 'teleport',
                        title = teleport.radialTitle or location.radialTitle,
                        icon = 'door-open',
                        type = 'client',
                        event = 'qb-teleport:client:openMenu',
                        shouldClose = true,
                        data = {
                            teleports = location.teleports
                        }
                    }, MenuItemId)
                else
                    exports['qb-core']:HideText()
                    if MenuItemId ~= nil then
                        exports['qb-radialmenu']:RemoveOption(MenuItemId)
                        MenuItemId = nil
                        CurrentLocation = nil
                        CurrentTeleport = nil
                        CurrentZone = nil
                    end
                end
            end)
        end
    end
end)

AddEventHandler('qb-teleport:client:openMenu', function(data)
    local teleports = data
    if data.data and data.data.teleports then
        teleports = data.data.teleports
    end
    TeleportMenu(teleports)
end)

local function teleportToCoords(location, zoneName)
    local ped = PlayerPedId()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do Wait(0) end
    if location.vehicleTeleport == false then
        DoScreenFadeOut(800)
        if IsPedSittingInAnyVehicle(ped) then
            TriggerEvent('QBCore:Notify', "Get of the vehicle you tool", 'error', 5000)
            return DoScreenFadeIn()
        end
        if location.coords.x == nil then
            for _,coord in pairs(location.coords) do
                if coord.id == zoneName then
                    SetEntityCoords(ped, coord.coords.x, coord.coords.y, coord.coords.z)
                    SetEntityHeading(ped, coord.coords.w)
                end
            end
        else
            SetEntityCoords(ped, location.coords.x, location.coords.y, location.coords.z)
            SetEntityHeading(ped, location.coords.w)
        end
        DoScreenFadeIn(800)
        JustTeleported = true
    else
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do Wait(0) end
        if location.coords.x == nil then
            for _,coord in pairs(location.coords) do
                if coord.id == zoneName then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    SetPedCoordsKeepVehicle(ped, coord.coords.x, coord.coords.y, coord.coords.z)
                    SetEntityHeading(ped, coord.coords.w)
                end
            end
        else
            local vehicle = GetVehiclePedIsIn(ped, false)
            SetPedCoordsKeepVehicle(ped, location.coords.x, location.coords.y, location.coords.z)
            SetEntityHeading(ped, location.coords.w)
        end
        DoScreenFadeIn(800)
        JustTeleported = true
    end
end

function TeleportMenu(teleports)
    local teleportMenu = {{header = Config.Teleports[CurrentLocation].header, isMenuHeader = true}}

    for  i=#teleports,1,-1 do
        local tp = teleports[i]
        print(tp.coords.z)
        local params = {
            event = "Teleport:Client:Location",
            args = {
                targetLocation = tp
            }
        }
        if tp.coords.x == nil then
            params = {
                event = "qb-teleport:client:openMenu",
                args = {
                    data = {
                        teleports = tp.coords
                    }
                }
            }
        end
        teleportMenu[#teleportMenu + 1] = {
            header = tp.title,
            txt = "",
            disabled = tp.id == CurrentTeleport,
            params = params
        }
    end

    teleportMenu[#teleportMenu + 1] = {
        header = 'Close',
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(teleportMenu)
end

ResetTeleport = function()
    SetTimeout(1000, function() JustTeleported = false end)
end

RegisterNetEvent('Teleport:Client:Location', function(data)
    if not JustTeleported then
        TriggerServerEvent('Teleport:Server:ToLocation', CurrentLocation, CurrentTeleport, data.targetLocation, CurrentZone)
    end
end)

RegisterNetEvent("Teleport:Client:ToLocation", function(location, zoneName)
    teleportToCoords(location, zoneName)
    ResetTeleport()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        DoScreenFadeIn()
        print("the resource: " .. resource .. " has been restarted")
        Wait(3000)
        ExecuteCommand("restart qb-radialmenu")
    end
end)

