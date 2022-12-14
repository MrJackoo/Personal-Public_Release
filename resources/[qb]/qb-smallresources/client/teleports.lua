local function DrawText3Ds(x, y, z, text)
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

JustTeleported = false

CreateThread(function()
    while true do
        local inRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for loc,_ in pairs(Config.Teleports) do
            for k, v in pairs(Config.Teleports[loc]) do
                local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                if dist < 2 then
                    local Player = QBCore.Functions.GetPlayerData()
                    if v.isJobLocked then
                        for l,m in pairs(v.allowedJobs) do
                            if Player.job.name == m then
                                inRange = true
                                --DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)

                                if dist < 1 then
                                    DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, v.drawText)
                                    if IsControlJustReleased(0, 51) then
                                        if k == 1 then
                                            if v["AllowVehicle"] then
                                                DoScreenFadeOut(1000)
                                                while not IsScreenFadedOut() do
                                                    Wait(2500)
                                                end
                                                SetPedCoordsKeepVehicle(ped, Config.Teleports[loc][2].coords.x, Config.Teleports[loc][2].coords.y, Config.Teleports[loc][2].coords.z)
                                                DoScreenFadeIn(1000)
                                            else
                                                DoScreenFadeOut(1000)
                                                while not IsScreenFadedOut() do
                                                    Wait(2500)
                                                end
                                                SetEntityCoords(ped, Config.Teleports[loc][2].coords.x, Config.Teleports[loc][2].coords.y, Config.Teleports[loc][2].coords.z)
                                                DoScreenFadeIn(1000)
                                            end

                                            if type(Config.Teleports[loc][2].coords) == "vector4" then
                                                SetEntityHeading(ped, Config.Teleports[loc][2].coords.w)
                                            end
                                            
                                        elseif k == 2 then
                                            if v["AllowVehicle"] then
                                                DoScreenFadeOut(1000)
                                                while not IsScreenFadedOut() do
                                                    Wait(2500)
                                                end
                                                SetPedCoordsKeepVehicle(ped, Config.Teleports[loc][1].coords.x, Config.Teleports[loc][1].coords.y, Config.Teleports[loc][1].coords.z)
                                                DoScreenFadeIn(1000)
                                            else
                                                DoScreenFadeOut(1000)
                                                while not IsScreenFadedOut() do
                                                    Wait(2500)
                                                end
                                                SetEntityCoords(ped, Config.Teleports[loc][1].coords.x, Config.Teleports[loc][1].coords.y, Config.Teleports[loc][1].coords.z)
                                                DoScreenFadeIn(1000)
                                            end

                                            if type(Config.Teleports[loc][1].coords) == "vector4" then
                                                SetEntityHeading(ped, Config.Teleports[loc][1].coords.w)
                                            end
                                        end
                                        ResetTeleport()
                                    end
                                end
                            end
                        end
                    else
                        inRange = true
                        --DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)

                        if dist < 1 then
                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, v.drawText)
                            if IsControlJustReleased(0, 51) then
                                if k == 1 then
                                    if v["AllowVehicle"] then
                                        DoScreenFadeOut(1000)
                                        while not IsScreenFadedOut() do
                                            Wait(2500)
                                        end
                                        SetPedCoordsKeepVehicle(ped, Config.Teleports[loc][2].coords.x, Config.Teleports[loc][2].coords.y, Config.Teleports[loc][2].coords.z)
                                        DoScreenFadeIn(1000)
                                    else
                                        DoScreenFadeOut(1000)
                                        while not IsScreenFadedOut() do
                                            Wait(2500)
                                        end
                                        SetEntityCoords(ped, Config.Teleports[loc][2].coords.x, Config.Teleports[loc][2].coords.y, Config.Teleports[loc][2].coords.z)
                                        DoScreenFadeIn(1000)
                                    end

                                    if type(Config.Teleports[loc][2].coords) == "vector4" then
                                        SetEntityHeading(ped, Config.Teleports[loc][2].coords.w)
                                    end
                                elseif k == 2 then
                                    if v["AllowVehicle"] then
                                        DoScreenFadeOut(1000)
                                        while not IsScreenFadedOut() do
                                            Wait(2500)
                                        end
                                        SetPedCoordsKeepVehicle(ped, Config.Teleports[loc][1].coords.x, Config.Teleports[loc][1].coords.y, Config.Teleports[loc][1].coords.z)
                                        DoScreenFadeIn(1000)
                                    else
                                        DoScreenFadeOut(1000)
                                        while not IsScreenFadedOut() do
                                            Wait(2500)
                                        end
                                        SetEntityCoords(ped, Config.Teleports[loc][1].coords.x, Config.Teleports[loc][1].coords.y, Config.Teleports[loc][1].coords.z)
                                        DoScreenFadeIn(1000)
                                    end

                                    if type(Config.Teleports[loc][1].coords) == "vector4" then
                                        SetEntityHeading(ped, Config.Teleports[loc][1].coords.w)
                                    end
                                end
                                ResetTeleport()
                            end
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(1000)
        end

        Wait(3)
    end
end)

ResetTeleport = function()
    SetTimeout(4000, function()
        JustTeleported = false
    end)
end

