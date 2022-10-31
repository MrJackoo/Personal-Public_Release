local QBCore = exports['qb-core']:GetCoreObject()

local pedsSpawned = false
local inbikerental = false
local timeout = false

BikeRentalConfig = {}

BikeRentalConfig.UseTarget = GetConvar('UseTarget', 'false') == 'false'

BikeRentalConfig.BikeLocations = {
    [1] = {
        name = "MRPD Bike",
        coords = vector3(389.65, -948.9, 28.42),
        heading = 123,
    },
    [2] = {
        name = "Pillbox",
        coords = vector3(294.34, -617.23, 42.45),
        heading = 340.0,
    }
}

BikeRentalConfig.fee = 2000


Citizen.CreateThread(function()
    bikemodel = "bmx"
    bikehash = GetHashKey("bmx")
    bikerack = GetHashKey(bikemodel)
    RequestModel(bikerack)
    RequestModel(bikehash)
    while not HasModelLoaded(bikehash) and not HasModelLoaded(bikerack) do
        Wait(1)
    end
    createBikeHire()
    Wait(1000)
end)

Citizen.CreateThread(function()
    while true do
    Wait(0)
        if timeout then
            Wait(5000)
            timeout = false
        end
    end
end)

function DrawText3D2(coords, text)
    SetTextScale(0.4, 0.4)
    SetTextFont(2)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x,coords.y,coords.z + 1, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    ClearDrawOrigin()
end

function createBikeHire()
    for i = 1, #BikeRentalConfig.BikeLocations do
        local current = BikeRentalConfig.BikeLocations[i]

        local blip = AddBlipForCoord(current.coords.x, current.coords.y, current.coords.z)
        
        SetBlipSprite(blip, 226)
        SetBlipColour(blip, 26)
        SetBlipScale(blip, 0.75)

        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)
        
        AddTextEntry("BIKEHIRE", "Rental Bikes")
        BeginTextCommandSetBlipName("BIKEHIRE")
        EndTextCommandSetBlipName(blip)        

        


        if BikeRentalConfig.UseTarget then
            local bike = CreateObject(bikerack, current.coords.x, current.coords.y, current.coords.z, true, false)
            SetEntityInvincible(bike, true)
            FreezeEntityPosition(bike, true)
            SetEntityCanBeDamaged(bike, false)
            SetEntityHeading(bike, current.heading)
            SetEntityProofs(bike, true, true, true, true, true)

            exports['qb-target']:AddTargetEntity(bike, {
                options = {
                    {
                        label = 'Rent Bike',
                        icon = 'fa-solid fa-city',
                        event = 'JackoBikes:rentbike'
                    },
                    {
                        label = 'Return Bike',
                        icon = 'fa-solid fa-city',
                        event = 'JackoBikes:returnbike'
                    },
                },
                distance = 3.0
            })
        else
            local zone = BoxZone:Create(current.coords, 3, 5, {
                name = current.name,
                heading = current.heading,
                minZ = current.coords.z - 1.0,
                maxZ = current.coords.z + 5.0,
                debugPoly = false
            })
        
            zone:onPlayerInOut(function (isPointInside)
                if isPointInside then
                    inbikerental = true
                    exports['qb-core']:DrawText('[E] Rent/Return Bike')
                else
                    exports['qb-core']:HideText()
                    inbikerental = false
                end
            end)
        end
    end
    pedsSpawned = true
end

Citizen.CreateThread(function()
    while true do
    Wait(0)      
        for k,v in pairs(BikeRentalConfig.BikeLocations) do
            local plycoords = GetEntityCoords(PlayerPedId())
            local dist = Vdist(plycoords.x, plycoords.y, plycoords.z, v.coords.x, v.coords.y, v.coords.z)
            if dist <= 7 then
                DrawText3D2(v.coords, "~h~BIKE HIRE")
            end
        end
        if inbikerental then
            if IsControlJustPressed(0, 38) then
                
                if GetEntityModel(GetVehiclePedIsIn(PlayerPedId())) == bikehash then
                    TriggerEvent('JackoBikes:returnbike')
                    exports['qb-core']:KeyPressed()
                    Wait(500)
                    exports['qb-core']:HideText()
                else
                    TriggerEvent('JackoBikes:rentbike')
                    exports['qb-core']:KeyPressed()
                    Wait(500)
                    exports['qb-core']:HideText()
                end
            end
        end
    end
end)

RegisterNetEvent('JackoBikes:rentbike', function()
    if not timeout then
        local playercoords = GetEntityCoords(PlayerPedId())

        QBCore.Functions.SpawnVehicle(bikehash, function(veh)

            SetEntityHeading(veh, playercoords.w)
            exports['ps-fuel']:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)

            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            QBCore.Functions.Notify("Bike Rented", "success")
            timeout = true

        end, playercoords, true)
    else
        QBCore.Functions.Notify("Error: You recently rented a bike", "error")
    end    
end)

RegisterNetEvent('JackoBikes:returnbike', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if GetEntityModel(vehicle) == bikehash then
        DeleteVehicle(vehicle)
        QBCore.Functions.Notify("Bike Returned", "success")
    end    
end)

RegisterNetEvent('JackoBikes:refreshInt', function()
    refreshinterior()
    QBCore.Functions.Notify("Interior Refreshed", "primary", 3000)
end)

function refreshinterior()
	GetEntityCoords(entity)
	local intcoords = GetEntityCoords(PlayerPedId(), true)
	local interior = GetInteriorAtCoords(intcoords.x, intcoords.y, intcoords.z)
    local interior2 = GetInteriorFromEntity(PlayerPedId())
	RefreshInterior(interior)
    RefreshInterior(interior2)
end