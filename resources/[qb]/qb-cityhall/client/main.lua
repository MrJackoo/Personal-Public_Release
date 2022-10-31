local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local isLoggedIn = LocalPlayer.state.isLoggedIn
local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed)
local closestCityhall = nil
local closestDrivingSchool = nil
local inCityhallPage = false
local inRangeCityhall = false
local inRangeDrivingSchool = false
local pedsSpawned = false
local table_clone = table.clone
local blips = {}

-- Functions

local function getClosestHall()
    local distance = #(playerCoords - Config.Cityhalls[1].coords)
    local closest = 1
    for i = 1, #Config.Cityhalls do
        local hall = Config.Cityhalls[i]
        local dist = #(playerCoords - hall.coords)
        if dist < distance then
            distance = dist
            closest = i
        end
    end
    return closest
end

-- local function getClosestSchool()
--     local distance = #(playerCoords - Config.DrivingSchools[1].coords)
--     local closest = 1
--     for i = 1, #Config.DrivingSchools do
--         local school = Config.DrivingSchools[i]
--         local dist = #(playerCoords - school.coords)
--         if dist < distance then
--             distance = dist
--             closest = i
--         end
--     end
--     return closest
-- end

local function setCityhallPageState(bool, message)
    if message then
        local action = bool and "open" or "close"
        SendNUIMessage({
            action = action
        })
    end
    SetNuiFocus(bool, bool)
    inCityhallPage = bool
    if not Config.UseTarget or bool then return end
    inRangeCityhall = false
end

local function createBlip(options)
    if not options.coords or type(options.coords) ~= 'table' and type(options.coords) ~= 'vector3' then return error(('createBlip() expected coords in a vector3 or table but received %s'):format(options.coords)) end
    local blip = AddBlipForCoord(options.coords.x, options.coords.y, options.coords.z)
    SetBlipSprite(blip, options.sprite or 1)
    SetBlipDisplay(blip, options.display or 4)
    SetBlipScale(blip, options.scale or 1.0)
    SetBlipColour(blip, options.colour or 1)
    SetBlipAsShortRange(blip, options.shortRange or false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(options.title or 'No Title Given')
    EndTextCommandSetBlipName(blip)
    return blip
end

local function deleteBlips()
    if not next(blips) then return end
    for i = 1, #blips do
        local blip = blips[i]
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    blips = {}
end

local function initBlips()
    for i = 1, #Config.Cityhalls do
        local hall = Config.Cityhalls[i]
        if hall.showBlip then
            blips[#blips+1] = createBlip({
                coords = hall.coords,
                sprite = hall.blipData.sprite,
                display = hall.blipData.display,
                scale = hall.blipData.scale,
                colour = hall.blipData.colour,
                shortRange = true,
                title = hall.blipData.title
            })
        end
    end
    -- for i = 1, #Config.DrivingSchools do
    --     local school = Config.DrivingSchools[i]
    --     if school.showBlip then
    --         blips[#blips+1] = createBlip({
    --             coords = school.coords,
    --             sprite = school.blipData.sprite,
    --             display = school.blipData.display,
    --             scale = school.blipData.scale,
    --             colour = school.blipData.colour,
    --             shortRange = true,
    --             title = school.blipData.title
    --         })
    --     end
    -- end
end

local function spawnPeds()
    if not Config.Peds or not next(Config.Peds) or pedsSpawned then return end
    for i = 1, #Config.Peds do
        local current = Config.Peds[i]
        current.model = type(current.model) == 'string' and joaat(current.model) or current.model
        RequestModel(current.model)
        while not HasModelLoaded(current.model) do
            Wait(0)
        end
        local ped = CreatePed(0, current.model, current.coords.x, current.coords.y, current.coords.z, current.coords.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, current.scenario, true, true)
        current.pedHandle = ped
        if Config.UseTarget then
            local opts = nil
            -- if current.drivingschool then
            --     opts = {
            --         label = 'Take Driving Lessons',
            --         icon = 'fa-solid fa-car-side',
            --         action = function()
            --             TriggerServerEvent('qb-cityhall:server:sendDriverTest', Config.DrivingSchools[closestDrivingSchool].instructors)
            --         end
            --     }
            -- elseif current.cityhall then
            --     opts = {
            --         label = 'Open Cityhall',
            --         icon = 'fa-solid fa-city',
            --         action = function()
            --             inRangeCityhall = true
            --             setCityhallPageState(true, true)
            --         end
            --     }
            -- end

            -- New options without Driving school
            if current.cityhall then
                opts = {
                    label = 'Open Cityhall',
                    icon = 'fa-solid fa-city',
                    action = function()
                        inRangeCityhall = true
                        setCityhallPageState(true, true)
                    end
                }
            end
            if opts then
                exports['qb-target']:AddTargetEntity(ped, {
                    options = {opts},
                    distance = 2.0
                })
            end
        else
            local options = current.zoneOptions
            if options then
                local zone = BoxZone:Create(current.coords.xyz, options.length, options.width, {
                    name = "zone_cityhall_"..ped,
                    heading = current.coords.w,
                    debugPoly = false,
                    minZ = current.coords.z - 3.0,
                    maxZ = current.coords.z + 2.0
                })
                zone:onPlayerInOut(function(inside)
                    if isLoggedIn and closestCityhall then
                        if inside then
                            if current.drivingschool then
                                inRangeDrivingSchool = true
                                exports['qb-menu']('[E] Take Driving Lessons')
                            elseif current.cityhall then
                                inRangeCityhall = true
                                exports['qb-core']:DrawText('[E] Open Cityhall')
                            end
                        else
                            exports['qb-core']:HideText()
                            if current.drivingschool then
                                inRangeDrivingSchool = false
                            elseif current.cityhall then
                                inRangeCityhall = false
                            end
                        end
                    end
                end)
            end
        end
    end
    pedsSpawned = true
end

local function deletePeds()
    if not Config.Peds or not next(Config.Peds) or not pedsSpawned then return end
    for i = 1, #Config.Peds do
        local current = Config.Peds[i]
        if current.pedHandle then
            DeletePed(current.pedHandle)
        end
    end
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    isLoggedIn = true
    spawnPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    isLoggedIn = false
    deletePeds()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('qb-cityhall:client:StartingnewJob', function(data)
    ClearGpsPlayerWaypoint()
    SetNewWaypoint(jobwaypoints[data].x, jobwaypoints[data].y)
    Wait(7500)
    TriggerEvent('mythic_notify:client:SendAlert',{ type = 'inform', text = {'Go ahead and check your map \n You see that marker that is where you will need to head to get started with your job \n Now go on you dont have time to waste'}, length = 5000 })    
end)

RegisterNetEvent('qb-cityhall:client:sendDriverEmail', function(charinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('email.mr')
        if PlayerData.charinfo.gender == 1 then
            gender = Lang:t('email.mrs')
        end
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('email.sender'),
            subject = Lang:t('email.subject'),
            message =  Lang:t('email.message', {gender = gender, lastname = charinfo.lastname, firstname = charinfo.firstname, phone = charinfo.phone}),
            button = {}
        })
    end)
end)

-- Licences
RegisterNetEvent('qb-cityhall:client:idcard', function()
    TriggerServerEvent('qb-cityhall:server:getidentity')
end)

RegisterNetEvent('qb-cityhall:client:drivers', function()
    TriggerServerEvent('qb-cityhall:server:getdrivers')
end)

RegisterNetEvent('qb-cityhall:client:weapon', function()
    TriggerServerEvent('qb-cityhall:server:getweapon')
end)


-- Jobs that are paid (qb-shared Jobs)
RegisterNetEvent('qb-cityhall:client:busjob', function()
    TriggerServerEvent('qb-cityhall:server:getbusjob')
end)

RegisterNetEvent('qb-cityhall:client:garbagejob', function()
    TriggerServerEvent('qb-cityhall:server:getgarbagejob')
end)
 
RegisterNetEvent('qb-cityhall:client:reporterjob', function()
    TriggerServerEvent('qb-cityhall:server:getreporterjob')
end)

RegisterNetEvent('qb-cityhall:client:securityjob', function()
    TriggerServerEvent('qb-cityhall:server:getsecurityjob')
end)

RegisterNetEvent('qb-cityhall:client:taxijob', function()
    TriggerServerEvent('qb-cityhall:server:gettaxijob')
end)

RegisterNetEvent('qb-cityhall:client:telcojob', function()
    TriggerServerEvent('qb-cityhall:server:gettelcojob')
end)

-- RegisterNetEvent('qb-cityhall:client:towjob', function()
--     TriggerServerEvent('qb-cityhall:server:gettowjob')
-- end)

-- RegisterNetEvent('qb-cityhall:client:truckerjob', function()
--     TriggerServerEvent('qb-cityhall:server:gettruckerjob')
-- end)

RegisterNetEvent('qb-cityhall:client:gounemployed', function()
    TriggerServerEvent('qb-cityhall:server:unemployed')
end)

-- City Job Waypoints
RegisterNetEvent('qb-cityhall:client:busway', function()
    SetNewWaypoint(450.35, -651.72)
    Wait(10)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'City Hall Employment',
        subject = 'Your new job',
        message = 'Congratulations on your new bus driver job, head to the waypoint marked on your map to start the job'
    })
end)

RegisterNetEvent('qb-cityhall:client:garbageway', function()
    SetNewWaypoint(-316.36, -1537.29)
    Wait(10)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'City Hall Employment',
        subject = 'Your new job',
        message = 'Congratulations on your new garbage job, head to the waypoint marked on your map to start the job'
    })
end)

-- RegisterNetEvent('qb-cityhall:client:securityway', function()
--     SetNewWaypoint(-4.08, -659.24)
--     Wait(10)
--     TriggerServerEvent('qb-phone:server:sendNewMail', {
--         sender = 'City Hall Employment',
--         subject = 'Your new job',
--         message = 'Congratulations on your new security guard job, head to the waypoint marked on your map to start the job'
--     })
-- end)

RegisterNetEvent('qb-cityhall:client:taxiway', function()
    SetNewWaypoint(910.89, -175.52)
    Wait(10)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'City Hall Employment',
        subject = 'Your new job',
        message = 'Congratulations on your new taxi job, head to the waypoint marked on your map to start the job'
    })
end)

RegisterNetEvent('qb-cityhall:client:telcoway', function()
    SetNewWaypoint(524.66, -1600.12)
    Wait(10)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'City Hall Employment',
        subject = 'Your new job',
        message = 'Congratulations on your new telecommunications engineer job, head to the waypoint marked on your map to start the job'
    })
end)

-- RegisterNetEvent('qb-cityhall:client:towway', function()
--     SetNewWaypoint(-209.65, -1168.8)
--     Wait(10)
--     TriggerServerEvent('qb-phone:server:sendNewMail', {
--         sender = 'City Hall Employment',
--         subject = 'Your new job',
--         message = 'Congratulations on your new tow job, head to the waypoint marked on your map to start the job'
--     })
-- end)

-- RegisterNetEvent('qb-cityhall:client:truckerway', function()
--     SetNewWaypoint(141.51, -3204.83)
--     Wait(10)
--     TriggerServerEvent('qb-phone:server:sendNewMail', {
--         sender = 'City Hall Employment',
--         subject = 'Your new job',
--         message = 'Congratulations on your new trucker job, head to the waypoint marked on your map to start the job'
--     })
-- end)

-- Other Job Waypoints
RegisterNetEvent('qb-cityhall:client:cityscrap', function()
    SetNewWaypoint(746.66, -1399.339)
    QBCore.Functions.Notify('Check your map for directions', 'success', 10000)
    Wait(10)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'City Scrapyard',
        subject = 'Recycling',
        message = 'Thanks for enquiring about the job, come to the waypoint marked on your map to start the job'
    })
end)

-- NEEDS REWORKING

-- RegisterNetEvent('qb-cityhall:client:diving', function()
--     SetNewWaypoint(-1687.3, -1071.58)	
--     QBCore.Functions.Notify('Check your map for directions', 'success', 10000)
--     Wait(10)
--     TriggerServerEvent('qb-phone:server:sendNewMail', {
--         sender = 'Sea World',
--         subject = 'Diving',
--         message = 'Thanks for enquiring about the job, come to the waypoint marked on your map to start the job'
--     })
-- end)

-- RegisterNetEvent('qb-cityhall:client:fishing', function()
--     SetNewWaypoint(-1687.3, -1071.58)	
--     QBCore.Functions.Notify('Check your map for directions', 'success', 10000)
--     Wait(10)
--     TriggerServerEvent('qb-phone:server:sendNewMail', {
--         sender = 'Old Man Joe',
--         subject = 'Fishing',
--         message = 'Thanks for enquiring about the job, come to the waypoint marked on your map to start the job'
--     })
-- end)

RegisterNetEvent('qb-cityhall:client:GoPostal', function() -- DONE
    SetNewWaypoint(60.14, 129.91)
    QBCore.Functions.Notify('Check your map for directions', 'success', 10000)	
    Wait(10)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'GoPostal',
        subject = 'Deliveries',
        message = 'Thanks for enquiring about the job, come to the waypoint marked on your map to start the job'
    })
end)

-- RegisterNetEvent('qb-cityhall:client:hunting', function() -- DONE
--     SetNewWaypoint(-772.51, 5595.54)	
--     QBCore.Functions.Notify('Check your map for directions', 'success', 10000)
--     Wait(10)
--     TriggerServerEvent('qb-phone:server:sendNewMail', {
--         sender = 'Mr Huntsman',
--         subject = 'Hunting',
--         message = 'Thanks for enquiring about the job, come to the waypoint marked on your map to start the job'
--     })
-- end)

-- NO MINING JOB ATM

-- RegisterNetEvent('qb-cityhall:client:mining', function()
--     SetNewWaypoint(-598.27, 2094.13, 131.2)	
--     QBCore.Functions.Notify('Check your map for directions', 'success', 10000)
--     Wait(10)
--     TriggerServerEvent('qb-phone:server:sendNewMail', {
--         sender = 'LS Mining',
--         subject = 'Mining',
--         message = 'Thanks for enquiring about the job, come to the waypoint marked on your map to start the job'
--     })
-- end)

RegisterNetEvent('qb-cityhall:client:woodcutting', function()
    SetNewWaypoint(-573.12, 5509.7)
    QBCore.Functions.Notify('Check your map for directions', 'success', 10000)
    Wait(10)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'Lumber Mill',
        subject = 'Wood Cutting',
        message = 'Thanks for enquiring about the job, come to the waypoint marked on your map to start the job'
    })
end)

-- Menus
RegisterNetEvent('qb-cityhall:cityHallMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = '🏛️ City Hall',
            txt = ''
        },
        {
            header = 'Employment Centre',
            txt = 'Jobs',
            params = {
                event = 'qb-cityhall:jobs',
            }
        },
        {
            header = 'ID Services',
            txt = 'Licenses and ID Cards',
            params = {
                event = 'qb-cityhall:IDMenu',
            }
        },
        {
            header = 'Compensation Request',
            txt = 'Government Assistance',
            params = {
                event = 'ax-forms:client:comprequestForm',
            }
        },
        {
            header = 'Close',
            txt = '',
            params = {
                event = 'qb-menu:closeMenu'
            }
        },
    })
end)

RegisterNetEvent('qb-cityhall:jobs', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = 'Employment Centre',
            txt = ''
        },
        {
            header = 'Salaried Jobs',
            txt = 'Jobs that pay a salary',
            params = {
                event = 'qb-cityhall:employmentMenu',
            }
        },
        {
            header = 'Free Jobs',
            txt = 'Jobs that pay for collecting items etc',
            params = {
                event = 'qb-cityhall:jobMenu',
            }
        },
        {
            header = 'Back',
            txt = '',
            params = {
                event = 'qb-cityhall:cityHallMenu'
            }
        },
    })
end)

RegisterNetEvent('qb-cityhall:employmentMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = 'City Jobs',
            txt = ''
        },
        {
            header = 'Bus Driver',
            txt = 'Pick up passengers on bus routes',
            params = {
                event = 'qb-cityhall:client:busjob',
            }
        },
        {
            header = 'Garbage Collector', -- works
            txt = 'Pick up other peoples rubbish and recycle it',
            params = {
                event = 'qb-cityhall:client:garbagejob',
            }
        },
        {
            header = 'Reporter',
            txt = 'Report the latest stories around Los Santos',
            params = {
                event = 'qb-cityhall:client:reporterjob',
            }
        },
        -- {
        --     header = 'Security Guard',
        --     txt = 'Transport money for Gruppe Sechs Security',
        --     params = {
        --         event = 'qb-cityhall:client:securityjob',
        --     }
        -- },
        {
            header = 'Taxi Driver',
            txt = 'Pick up customers and drive them to their destination',
            params = {
                event = 'qb-cityhall:client:taxijob',
            }
        },
        {
            header = 'Telecomms Engineer',
            txt = 'Repair communication and electrical equipment',
            params = {
                event = 'qb-cityhall:client:telcojob',
            }
        },
        -- {
        --     header = 'Tow-Truck Driver',
        --     txt = 'Tow vehicles and take them to the impound lot',
        --     params = {
        --         event = 'qb-cityhall:client:towjob',
        --     }
        -- },
        -- {
        --     header = 'Truck Driver',
        --     txt = 'Deliver packages to their destinations',
        --     params = {
        --         event = 'qb-cityhall:client:truckerjob',
        --     }
        -- },
        {
            header = 'Unemployed',
            txt = 'Quit your job',
            params = {
                event = 'qb-cityhall:client:gounemployed',
            }
        },
        {
            header = 'Go Back',
            txt = '',
            params = {
                event = 'qb-cityhall:jobs',
            }
        },
    })
end)

RegisterNetEvent('qb-cityhall:jobMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = 'Other Jobs',
            txt = ''
        },
        {
            header = 'Deliveries',
            txt = 'Deliver for GoPostal',
            params = {
                event = 'qb-cityhall:client:GoPostal',
            }
        },
        -- {
        --     header = 'Diving',
        --     txt = 'Dive and collect coral',
        --     params = {
        --         event = 'qb-cityhall:client:diving',
        --     }
        -- },
        -- {
        --     header = 'Fishing',
        --     txt = 'Fish, pretty simple!',
        --     params = {
        --         event = 'qb-cityhall:client:fishing',
        --     }
        -- },
        -- {
        --     header = 'Hunting',
        --     txt = 'Hunt animals for meat and leather',
        --     params = {
        --         event = 'qb-cityhall:client:hunting',
        --     }
        -- },
        -- {
        --     header = 'Mining',
        --     txt = 'Mine rocks and refine for materials',
        --     params = {
        --         event = 'qb-cityhall:client:mining',
        --     }
        -- },
        {
            header = 'Recycling',
            txt = 'Recycle items for materials',
            params = {
                event = 'qb-cityhall:client:cityscrap',
            }
        },
        --[[{
            header = 'Wood Cutter',
            txt = 'Chop wood and refine for materials',
            params = {
                event = 'qb-cityhall:client:woodcutting',
            }
        },]]--
        {
            header = 'Go Back',
            txt = '',
            params = {
                event = 'qb-cityhall:jobs',
            }
        },
    })
end)

RegisterNetEvent('qb-cityhall:IDMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = 'Identity Services',
            txt = ''
        },
        {
            header = 'Drivers License (£50)',
            txt = 'Request a Drivers License',
            params = {
                event = 'qb-cityhall:client:drivers',
            }
        },
        {
            header = 'ID Card (£50)',
            txt = 'Request an Identity Card',
            params = {
                event = 'qb-cityhall:client:idcard',
            }
        },
        -- {

        --     header = 'Firearms Permit (£250)',
        --     txt = 'Request a Firearms Permit',
        --     params = {
        --         event = 'qb-cityhall:client:weapon',
        --     }
        -- },
        {
            header = 'Go Back',
            txt = '',
            params = {
                event = 'qb-cityhall:cityHallMenu',
            }
        },
    })
end)

RegisterCommand('cityhall', function()
    SetNewWaypoint(-511.78, -259.58)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    deleteBlips()
    deletePeds()
end)

-- NUI Callbacks

RegisterNUICallback('close', function(_, cb)
    setCityhallPageState(false, false)
    if not Config.UseTarget and inRangeCityhall then exports['qb-core']:DrawText('[E] Open Cityhall') end -- Reopen interaction when you're still inside the zone
    cb('ok')
end)

RegisterNUICallback('requestId', function(id, cb)
    local license = Config.Cityhalls[closestCityhall].licenses[id.type]
    if inRangeCityhall and license and id.cost == license.cost then
        TriggerServerEvent('qb-cityhall:server:requestId', id.type, closestCityhall)
        QBCore.Functions.Notify(('You have received your %s for $%s'):format(license.label, id.cost), 'success', 3500)
    else
        QBCore.Functions.Notify(Lang:t('error.not_in_range'), 'error')
    end
    cb('ok')
end)

RegisterNUICallback('requestLicenses', function(_, cb)
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = table_clone(Config.Cityhalls[closestCityhall].licenses)
    for license, data in pairs(availableLicenses) do
        if data.metadata and not licensesMeta[data.metadata] then
            availableLicenses[license] = nil
        end
    end
    cb(availableLicenses)
end)

RegisterNUICallback('applyJob', function(job, cb)
    if inRangeCityhall then
        TriggerServerEvent('qb-cityhall:server:ApplyJob', job, Config.Cityhalls[closestCityhall].coords)
    else
        QBCore.Functions.Notify(Lang:t('error.not_in_range'), 'error')
    end
    cb('ok')
end)

-- Threads

CreateThread(function()
    while true do
        if isLoggedIn then
            playerPed = PlayerPedId()
            playerCoords = GetEntityCoords(playerPed)
            closestCityhall = getClosestHall()
            -- closestDrivingSchool = getClosestSchool()
        end
        Wait(1000)
    end
end)

CreateThread(function()
    initBlips()
    spawnPeds()
    QBCore.Functions.TriggerCallback('qb-cityhall:server:receiveJobs', function(result)
        SendNUIMessage({
            action = 'setJobs',
            jobs = result
        })
    end)
    if not Config.UseTarget then
        while true do
            local sleep = 1000
            if isLoggedIn and closestCityhall then
                if inRangeCityhall then
                    if not inCityhallPage then
                        sleep = 0
                        if IsControlJustPressed(0, 38) then
                            --setCityhallPageState(true, true)
                            TriggerEvent('qb-cityhall:cityHallMenu')
                            exports['qb-core']:KeyPressed()
                            Wait(500)
                            exports['qb-core']:HideText()
                            sleep = 1000
                        end
                    end
                -- elseif inRangeDrivingSchool then
                --     sleep = 0
                --     if IsControlJustPressed(0, 38) then
                --         TriggerServerEvent('qb-cityhall:server:sendDriverTest', Config.DrivingSchools[closestDrivingSchool].instructors)
                --         sleep = 5000
                --         exports['qb-core']:KeyPressed()
                --         Wait(500)
                --         exports['qb-core']:HideText()
                --     end
                end
            end
            Wait(sleep)
        end
    end
end)
