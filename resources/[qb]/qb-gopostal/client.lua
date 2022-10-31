-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local delivering = false
local zone = 0
local deliveryPed = 0
local dArea = 0
local visits = 0
local pedCreated = false 
local deliveryVehicle = nil

-- Functions
function DrawText3Ds(x,y,z, text)
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

function CoolDown()
    CreateThread(function()
    Wait(300000)
    isCoolDown = false
    end)
end

Citizen.CreateThread(function()
    modelHash = GetHashKey("s_m_m_postal_01")
    local model = modelHash
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    createPostalPED()
end)

function createPostalPED()
    local postal_ped = {x = 59.85, y = 130.38, z = 78.22, rotation = 190.15}
	startingPed = CreatePed(0, modelHash, postal_ped.x, postal_ped.y, postal_ped.z, postal_ped.rotation, false, false)
	FreezeEntityPosition(startingPed, true)
	SetEntityInvincible(startingPed, true)
	SetBlockingOfNonTemporaryEvents(startingPed, true)
	TaskStartScenarioInPlace(startingPed, "WORLD_HUMAN_COP_IDLES", 0, true)
    exports['qb-target']:AddTargetEntity(startingPed, {
        options = {
            {
                type = "client",
                event = 'qb-gopostal:city:TakeOutVehicle',
                label = 'Start Delivering',
                icon = 'fas fa-mailbox',
            },
            {
                type = "client",
                event = 'qb-gopostal:city:stopDelivering',
                label = 'Stop Delivering',
                icon = 'fas fa-mailbox',
            },
            {
                type = "client",
                event = 'qb-gopostal:city:returnVan',
                label = 'Return Van',
                icon = 'fas fa-mailbox',
            },
        },
        distance = 2.0,
    })
end

function CreateDeliveryPed()
    local hashKey = "a_m_y_stwhi_01"
    local pedType = 5
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(10)
    end

	deliveryPed = CreatePed(pedType, hashKey, Config.DeliveryPoints[dArea].x, Config.DeliveryPoints[dArea].y, Config.DeliveryPoints[dArea].z)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)
end

function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)

		Citizen.Wait(20)
		DeletePed(deliveryPed)
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function playerAnim() 
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function giveAnim()
    if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function stopDeliver()
    delivering = false    
end

function delivered()
    TriggerServerEvent('qb-gopostal:city:Success')
    if visits == 10 then --change 3 to however many runs you want a person to be able to make before having to return to the depot
        RemoveBlip(deliveryblip)
        visits = 0
        QBCore.Functions.Notify("No more packages to deliver", "error", 10000)
        DeleteCreatedPed()
        stopDeliver()
    else
        RemoveBlip(deliveryblip)
        DeleteCreatedPed()
        startDeliver()
        visits = visits + 1
    end
end

function startDeliver()
    delivering = true
    zone = math.random(1,5)
    if zone == 1 then
       dArea = math.random(1,75)
    end
    if zone == 2 then 
       dArea = math.random(76,150)
    end
    if zone == 3 then
       dArea  = math.random(151,200)
    end
    if zone == 4 then
       dArea = math.random(201, 250)
    end
    if zone == 5 then 
       dArea = math.random(1,285)
    end
 
    deliveryblip = (AddBlipForCoord(Config.DeliveryPoints[dArea].x, Config.DeliveryPoints[dArea].y, Config.DeliveryPoints[dArea].z))
    SetBlipSprite(deliveryblip, 280)
    SetNewWaypoint(Config.DeliveryPoints[dArea].x, Config.DeliveryPoints[dArea].y)
    QBCore.Functions.Notify("You have packages to deliver, follow the waypoint", "success", 10000)
end

local function isTruckerVehicle(vehicle)
    local retval = false
    -- for k, v in pairs(Config.Vehicle) do
        if GetEntityModel(vehicle) == GetHashKey(Config.Vehicle) then
            -- print("Yo Brad im working fam: ", Config.Vehicle, "and the car is this: ", vehicle)
            retval = true
        end
    -- end
    return retval
end

-- Events
RegisterNetEvent('qb-gopostal:city:deliver', function()
    startDeliver()
    TriggerEvent('qb-gopostal:city:Email')
end)

RegisterNetEvent('qb-gopostal:city:stopDelivering', function()
    delivering = false
    visits = 0
    RemoveBlip(deliveryblip)
    DeleteCreatedPed()
    ClearPedTasks(PlayerPedId())
	SetWaypointOff()
    QBCore.Functions.Notify("You stopped delivering", "error", 5000)   
end)

RegisterNetEvent('qb-gopostal:city:TakeOutVehicle', function()
    local coords = vector3(62.01, 124.0, 79.19)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if #(pos - coords) < 10 then
        TriggerServerEvent('qb-gopostal:city:RentVehicle', true)
        TriggerEvent('qb-gopostal:city:deliver')
    else
        QBCore.Functions.Notify('You are too far away', 'error')
    end
end)

RegisterNetEvent('qb-gopostal:city:SpawnVehicle', function()
    isCoolDown = true
    CoolDown()
    local vehicleInfo = Config.Vehicle
    local coords = Config.JobLocations["vehicle"].coords 
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "GOP"..tostring(math.random(1000, 9999)))
        deliveryVehicle = veh
        NetworkRegisterEntityAsNetworked(deliveryVehicle)
        SetVehicleDirtLevel(veh, 0)
        SetVehicleColours(veh, 111, 73)
        SetEntityHeading(veh, coords.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

RegisterNetEvent("qb-gopostal:city:returnVan", function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local vehpos = GetEntityCoords(vehicle)
    local coords = vector3(62.01, 124.0, 79.19)
    if #(coords - vehpos) < 10 then
        if isTruckerVehicle(vehicle) then
            DeleteVehicle(vehicle)
            TriggerServerEvent('qb-gopostal:city:RentVehicle', false)
        else
            QBCore.Functions.Notify('This is not a Go-Postal Van', 'error')
        end
    end
end)

RegisterNetEvent('qb-gopostal:city:Email', function()
    Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Go-Postal",
        subject = "Employment",
        message = "Hello Employee, <br />Your first delivery location is marked on your GPS, go there and deliver the packages<br /><br />Your next delivery point will be automatically marked after you deliver each package"
	})
	Wait(3000)
end)

-- RegisterNetEvent('qb-gopostal:cityMenu', function()
--     exports['qb-menu']:openMenu({
--         {
--             isMenuHeader = true,
--             header = 'Go-Postal',
--             txt = 'Headquarters'
--         },
--         {
--             header = 'Start Delivering',
--             txt = 'Deliver for Go-Postal',
--             params = {
--                 event = 'qb-gopostal:city:TakeOutVehicle',
--             }
--         },
--         {
--             header = 'Stop Delivering',
--             txt = 'Clock Off',
--             params = {
--                 event = 'qb-gopostal:city:stopDelivering',
--             }
--         },
--         {

--             header = 'Return Van',
--             txt = 'Return a Go-Postal Van',
--             params = {
--                 event = 'qb-gopostal:city:returnVan',
--             }
--         },
--         {
--             header = 'Close',
--             txt = '',
--             params = {
--                 event = 'qb-menu:closeMenu',
--             }
--         },
--     })
-- end)


-- Threads
CreateThread(function()
    mainblip = AddBlipForCoord(59.73, 123.91, 79.26)
    SetBlipSprite (mainblip, 318)
    SetBlipDisplay(mainblip, 4)
    SetBlipScale  (mainblip, 0.6)
    SetBlipColour (mainblip, 3)
    SetBlipAsShortRange(mainblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("GoPostal")
    EndTextCommandSetBlipName(mainblip)
end)

-- Threads
-- CreateThread(function()
--     local alreadyEnteredZone = false
--     while true do
--         wait = 5
--         local ped = PlayerPedId()
--         local inZone = false
--         local dist = #(GetEntityCoords(ped)-vector3(60.14, 129.91, 79.22))
--         if dist <= 2.5 then
--             wait = 5
--             inZone  = true
--             if IsControlJustReleased(0, 38) then
--                 exports['qb-core']:KeyPressed()
--                 TriggerEvent('qb-gopostal:cityMenu')
--             end
--         else
--             wait = 1000
--         end
--         if inZone and not alreadyEnteredZone then
--             alreadyEnteredZone = true
--             exports['qb-core']:DrawText('[E] GoPostal HQ', 'left')
--         end
--         if not inZone and alreadyEnteredZone then
--             alreadyEnteredZone = false
--             exports['qb-core']:HideText()
--         end
--         Wait(wait)
--     end
-- end)

CreateThread(function()
    while true do   
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehicleCoords = GetEntityCoords(deliveryVehicle)
        if delivering == true then
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.DeliveryPoints[dArea].x, Config.DeliveryPoints[dArea].y, Config.DeliveryPoints[dArea].z)
            if dist < 150.0 and not pedCreated then
                pedCreated = true
                CreateDeliveryPed()
                QBCore.Functions.Notify('You are close to the drop off', 'error', 3500)
            end  
            if dist <= 2.5 and not IsPedInAnyVehicle(PlayerPedId()) then
                DrawText3Ds(Config.DeliveryPoints[dArea].x, Config.DeliveryPoints[dArea].y, Config.DeliveryPoints[dArea].z+1, ('Press [~g~E~w~] to deliver the package'))
                if IsControlJustPressed(0, 38) then
                    if DoesEntityExist(deliveryVehicle) and #(GetEntityCoords(ped) - vehicleCoords) < 100 then 
                        TriggerEvent('animations:client:EmoteCommandStart', {"box"})
                        QBCore.Functions.Progressbar("deliver_package", "Delivering Package", 5000, false, true, {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                            delivered()
                            pedCreated = false
                        end, function() -- Cancel
                            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                            QBCore.Functions.Notify("Cancelled Delivering", "error")
                        end)
                    else
                        QBCore.Functions.Notify('You must have your GoPostal van nearby', 'error', 3000)
                    end
                end
            end
        end
    end
end)