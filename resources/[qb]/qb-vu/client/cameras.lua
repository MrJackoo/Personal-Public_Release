local currentCameraIndex = 0
local createdCamera = 0

local function GetCurrentTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if hours < 10 then
        hours = tostring(0 .. GetClockHours())
    end
    if minutes < 10 then
        minutes = tostring(0 .. GetClockMinutes())
    end
    return tostring(hours .. ":" .. minutes)
end

local function ChangeSecurityCamera(x, y, z, r)
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
        createdCamera = 0
    end

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, x, y, z)
    SetCamRot(cam, r.x, r.y, r.z, 2)
    RenderScriptCams(1, 0, 0, 1, 1)
    Citizen.Wait(250)
    createdCamera = cam
end

local function CloseSecurityCamera()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    if Config.SecurityCameras.hideradar then
        DisplayRadar(true)
    end
    FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
end

local function InstructionButton(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Close Camera")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

-- Events

RegisterNetEvent('qb-vu:client:ActiveCamera', function(cameraId)
    if Config.SecurityCameras.cameras[cameraId] then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
        SendNUIMessage({
            type = "enablecam",
            label = Config.SecurityCameras.cameras[cameraId].label,
            id = cameraId,
            connected = Config.SecurityCameras.cameras[cameraId].isOnline,
            time = GetCurrentTime(),
        })
        local firstCamx = Config.SecurityCameras.cameras[cameraId].coords.x
        local firstCamy = Config.SecurityCameras.cameras[cameraId].coords.y
        local firstCamz = Config.SecurityCameras.cameras[cameraId].coords.z
        local firstCamr = Config.SecurityCameras.cameras[cameraId].r
        SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
        ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)
        currentCameraIndex = cameraId
        DoScreenFadeIn(250)
    elseif cameraId == 0 then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
        CloseSecurityCamera()
        SendNUIMessage({
            type = "disablecam",
        })
        DoScreenFadeIn(250)
    else
        QBCore.Functions.Notify("Camera doesn\'t exist..", "error")
    end
end)

RegisterNetEvent('qb-vu:client:DisableAllCameras', function()
    for k, v in pairs(Config.SecurityCameras.cameras) do 
        Config.SecurityCameras.cameras[k].isOnline = false
    end
end)

RegisterNetEvent('qb-vu:client:EnableAllCameras', function()
    for k, v in pairs(Config.SecurityCameras.cameras) do 
        Config.SecurityCameras.cameras[k].isOnline = true
    end
end)

RegisterNetEvent('qb-vu:client:SetCamera', function(key, isOnline)
    Config.SecurityCameras.cameras[key].isOnline = isOnline
end)

-- Threads

CreateThread(function()
    while true do
        sleep = 2000
        if createdCamera ~= 0 then
            sleep = 5
            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)

            if Config.SecurityCameras.hideradar then
                DisplayRadar(false)
            end

            -- CLOSE CAMERAS
            if IsControlJustPressed(1, 177) then
                DoScreenFadeOut(250)
                while not IsScreenFadedOut() do
                    Citizen.Wait(0)
                end
                CloseSecurityCamera()
                SendNUIMessage({
                    type = "disablecam",
                })
                DoScreenFadeIn(250)
                TriggerEvent('qb-vu:cameraMenu')
            end

            ---------------------------------------------------------------------------
            -- CAMERA ROTATION CONTROLS
            ---------------------------------------------------------------------------
            if Config.SecurityCameras.cameras[currentCameraIndex].canRotate then
                local getCameraRot = GetCamRot(createdCamera, 2)

                -- ROTATE UP
                if IsControlPressed(0, 32) then
                    if getCameraRot.x <= 0.0 then
                        SetCamRot(createdCamera, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                    end
                end

                -- ROTATE DOWN
                if IsControlPressed(0, 8) then
                    if getCameraRot.x >= -50.0 then
                        SetCamRot(createdCamera, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                    end
                end

                -- ROTATE LEFT
                if IsControlPressed(0, 34) then
                    SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
                end

                -- ROTATE RIGHT
                if IsControlPressed(0, 9) then
                    SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('qb-vu:cameraMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "Vanilla Unicorn",
            txt = "CCTV"
        },
        {
            header = "Main Stage CAM#1",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '1'
            }
        },
        {
            header = "Main Stage CAM#2",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '2'
            }
        },
        {
            header = "Bar CAM#1",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '3'
            }
        },
        {
            header = "Bar CAM#2",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '4'
            }
        },
        {
            header = "Inside Entrance",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '5'
            }
        },
        {
            header = "Private Booths",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '6'
            }
        },
        {
            header = "VIP",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '7'
            }
        },
        {
            header = "Front Door CAM#1",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '8'
            }
        },
        {
            header = "Front Door CAM#2",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '9'
            }
        },
        {
            header = "Front Door CAM#3",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '10'
            }
        },
        {
            header = "Staff Entrance",
			txt = "",
			params = {
                event = 'qb-vu:camera',
                args = '11'
            }
        },
        {
            header = "Close Menu",
			txt = "",
			params = {
                event = 'qb-menu:closeMenu',
            }
        },
    })
end)

RegisterNetEvent('qb-vu:camera', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(1))
    elseif args == 2 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(2))
    elseif args == 3 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(3))
    elseif args == 4 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(4))
    elseif args == 5 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(5))
    elseif args == 6then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(6))
    elseif args == 7 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(7))
    elseif args == 8 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(8))
    elseif args == 9 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(9))
    elseif args == 10 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(10))
    elseif args == 11 then 
        TriggerEvent("qb-vu:client:ActiveCamera", tonumber(11))
    end
end)


-- Threads
-- CreateThread(function()
--     local alreadyEnteredZone = false
--     local text = '[E] Cameras'
--     while true do
--     wait = 5
--     local ped = PlayerPedId()
--     local inZone = false
--     local dist = #(GetEntityCoords(ped)-vector3(95.66, -1294.01, 29.26))
--     if PlayerJob.name =="vu" then
--         if dist <= 2.0 then
--         wait = 10
--         inZone  = true
--             if IsControlJustReleased(0, 38) then
--                 TriggerEvent('qb-vu:cameraMenu')
--                 TriggerEvent('qb-drawtext:client:KeyPressed')
--             end
--         else
--             wait = 1000
--         end
--     end
--     if inZone and not alreadyEnteredZone then
--         alreadyEnteredZone = true
--         TriggerEvent('qb-drawtext:client:DrawText', text, left)
--     end
--     if not inZone and alreadyEnteredZone then
--         alreadyEnteredZone = false
--         TriggerEvent('qb-drawtext:client:HideText')
--     end
--         Wait(wait)
--     end
-- end)

-- exports['qb-target']:AddBoxZone("vu_camera", vector3(95.66, -1294.01, 29.26), 2, 2 {
--     name = "vu_camera",
--     debugPoly = true,
--     minZ = 28,
--     maxZ = 30,
--     }, {
--     options = {
--         {
--             type = "client",
--             event = 'qb-vu:cameraMenu',
--             label = 'Access Cameras',
--             icon = 'fas fa-camera',
--         },
--     },
--     distance = 2.0,
-- })

exports['qb-target']:AddBoxZone("vu_camera", vector3(96.22, -1292.84, 29.59), 5, 5, {
	name = "vu_camera",
	heading = 206,
	debugPoly = false,
	minZ = 28,
	maxZ = 30,
	}, {
		options = {
			{
            	type = "client",
            	event = "qb-vu:cameraMenu",
				icon = "fas fa-camera",
				label = "Access Cameras",
			},
		},
	distance = 2.5
})