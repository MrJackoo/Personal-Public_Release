-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686

CreateThread(function()
    while true do

        local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
        if VehName == "NULL" then VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) end
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
        local StreetHash = GetStreetNameAtCoord(x, y, z)
        local pId = GetPlayerServerId(PlayerId())
        local pName = GetPlayerName(PlayerId())

        -- This is the Application ID (Replace this with you own)
	    SetDiscordAppId(1005933768525230091)

        -- Here you will have to put the image name for the "large" icon.
	    SetDiscordRichPresenceAsset('ax-logo')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Server_NAME')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('logo_name')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Server_NAME')

        QBCore.Functions.TriggerCallback('smallresources:server:GetCurrentPlayers', function(result)
            SetRichPresence('Players: '..result..'/64')
        end)

        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        -- ]]--
        -- SetDiscordRichPresenceAction(0, "Discord", "discord.gg/axiomroleplay")
        -- SetDiscordRichPresenceAction(1, "Join Our Server", "fivem://connect/localhost:30120")

        -- It updates every minute just in case.

        SetDiscordRichPresenceAction(0, "Join Server!", "fivem://connect/url_to_server")
        SetDiscordRichPresenceAction(1, "Join Discord!", "DISCORD_INVITE_URL")

        Wait(180000)
        if StreetHash ~= nil then
            StreetName = GetStreetNameFromHashKey(StreetHash)
            if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
                if IsPedSprinting(PlayerPedId()) then
                    SetRichPresence("ID: "..pId.." | "..pName.." is sprinting down "..StreetName)
                elseif IsPedRunning(PlayerPedId()) then
                    SetRichPresence("ID: "..pId.." | "..pName.." is running down "..StreetName)
                elseif IsPedWalking(PlayerPedId()) then
                    SetRichPresence("ID: "..pId.." | "..pName.." is walking down "..StreetName)
                elseif IsPedStill(PlayerPedId()) then
                    SetRichPresence("ID: "..pId.." | "..pName.." is standing on "..StreetName)
                end
            elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
                local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
                if MPH > 50 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is speeding down "..StreetName.." at "..MPH.."MPH in a "..VehName)
                elseif MPH <= 50 and MPH > 0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is cruising down "..StreetName.." at "..MPH.."MPH in a "..VehName)
                elseif MPH == 0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is parked on "..StreetName.." in a "..VehName)
                end
            elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
                if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is flying over "..StreetName.." in a "..VehName)
                else
                    SetRichPresence("ID: "..pId.." | "..pName.." is landed at "..StreetName.." in a "..VehName)
                end
            elseif IsEntityInWater(PlayerPedId()) then
                SetRichPresence("ID: "..pId.." | "..pName.." is swimming")
            elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
                SetRichPresence("ID: "..pId.." | "..pName.." is sailing in a "..VehName)
            elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
                SetRichPresence("ID: "..pId.." | "..pName.." is in a yellow submarine!")
            end
        end

	Wait(180000)
    end
end)










