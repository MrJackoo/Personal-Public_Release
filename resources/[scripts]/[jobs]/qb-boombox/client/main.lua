-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local currentData = nil

-- Functions

local function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

local function helpText(text)
	SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Events
RegisterNetEvent('qb-boombox:client:placeBoombox', function()

    QBCore.Functions.TriggerCallback("qb-boom:checkaces", function(result)
        if result then 
            loadAnimDict("anim@heists@money_grab@briefcase")
            TaskPlayAnim(PlayerPedId(), "anim@heists@money_grab@briefcase", "put_down_case", 8.0, -8.0, -1, 1, 0, false, false, false)
            Wait(1000)
            ClearPedTasks(PlayerPedId())
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            local object = CreateObject(GetHashKey('prop_boombox_01'), x, y, z, true, false, false)
            PlaceObjectOnGroundProperly(object)
            SetEntityHeading(object, heading)
            FreezeEntityPosition(object, true)
            currentData = NetworkGetNetworkIdFromEntity(object)
            TriggerServerEvent('QBCore:Server:RemoveItem', "boombox", 1)
            TriggerEvent('QBCore:Notify', 'You have just dropped the BoomBox', 'primary')
        else
            QBCore.Functions.Notify('You are not authorised to put this down', 'error')
        end
    end)
end)

RegisterNetEvent('qb-boombox:client:placeBoomboxVu', function()
    local object = GetClosestObjectOfType(120.48, -1281.51, 29.48, 5.0, -12643427, false, false, false)
    FreezeEntityPosition(object, true)
    currentData = NetworkGetNetworkIdFromEntity(object)
end)

RegisterNetEvent('qb-boombox:client:pickupBoombox', function()

    QBCore.Functions.TriggerCallback("qb-boom:checkaces", function(result)
        if result then 
            local obj = NetworkGetEntityFromNetworkId(currentData)
            local objCoords = GetEntityCoords()
            NetworkRequestControlOfEntity(obj)
            loadAnimDict("anim@heists@narcotics@trash")
            TaskPlayAnim(PlayerPedId(), "anim@heists@narcotics@trash", "pickup", 8.0, -8.0, -1, 1, 0, false, false, false)
            Wait(700)
            SetEntityAsMissionEntity(obj,false,true)
            DeleteEntity(obj)
            DeleteObject(obj)
            if not DoesEntityExist(obj) then
                TriggerServerEvent('qb-boombox:server:pickedup', currentData)
                TriggerServerEvent('QBCore:Server:AddItem', 'boombox', 1)
                currentData = nil
            end
            Wait(500)
            ClearPedTasks(PlayerPedId())
        else
            QBCore.Functions.Notify('You are not authorised to pick this up', 'error')
        end
    end)
end)

RegisterNetEvent('qb-boombox:client:playMusic', function()
    local musicMenu = {
      {
          isMenuHeader = true,
          header = '💿 | Boombox'
      },
      {
          header = '🎶 | Play a song',
          txt = 'Enter a youtube URL',
          params = {
              event = 'qb-boombox:client:musicMenu',
              args = {

              }
          }
      },
      {
          header = '⏸️ | Pause Music',
          txt = 'Pause currently playing music',
          params = {
              isServer = true,
              event = 'qb-boombox:server:pauseMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '▶️ | Resume Music',
          txt = 'Resume playing paused music',
          params = {
              isServer = true,
              event = 'qb-boombox:server:resumeMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '🔈 | Change Volume',
          txt = 'Resume playing paused music',
          params = {
              event = 'qb-boombox:client:changeVolume',
              args = {

              }
          }
      },
      {
          header = '❌ | Turn off music',
          txt = 'Stop the music & choose a new song',
          isServer = true,
          params = {
              isServer = true,
              event = 'qb-boombox:server:stopMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '❌ | Pickup',
          txt = 'Stop the music & pick up the boombox',
          params = {
              event = 'qb-boombox:client:pickupBoombox',
              args = {
              }
          }
      }
    }
    exports['qb-menu']:openMenu(musicMenu)
end)

RegisterNetEvent('qb-boombox:client:playMusicVU', function()
    local musicMenu = {
      {
          isMenuHeader = true,
          header = '💿 | VU DJ'
      },
      {
          header = '🎶 | Play a song',
          txt = 'Enter a youtube URL',
          params = {
              event = 'qb-boombox:client:musicMenuVU',
              args = {

              }
          }
      },
      {
          header = '⏸️ | Pause Music',
          txt = 'Pause currently playing music',
          params = {
              isServer = true,
              event = 'qb-boombox:server:pauseMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '▶️ | Resume Music',
          txt = 'Resume playing paused music',
          params = {
              isServer = true,
              event = 'qb-boombox:server:resumeMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '🔈 | Change Volume',
          txt = 'Resume playing paused music',
          params = {
              event = 'qb-boombox:client:changeVolume',
              args = {

              }
          }
      },
      {
          header = '❌ | Turn off music',
          txt = 'Stop the music & choose a new song',
          isServer = true,
          params = {
              isServer = true,
              event = 'qb-boombox:server:stopMusicVU',
              args = {
                  entity = currentData,
              }
          }
      }
    }
    exports['qb-menu']:openMenu(musicMenu)
end)

RegisterNetEvent('qb-boombox:client:musicMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Song Selection',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'song',
                text = 'YouTube URL'
            }
        }
    })
    if dialog then
        if not dialog.song then return end
        print("here")
        TriggerServerEvent('qb-boombox:server:playMusic', dialog.song, currentData, GetEntityCoords(NetworkGetEntityFromNetworkId(currentData)))
    end
end)

RegisterNetEvent('qb-boombox:client:musicMenuVU', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Song Selection',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'song',
                text = 'YouTube URL'
            }
        }
    })
    if dialog then
        if not dialog.song then return end
        print("here")
        TriggerServerEvent('qb-boombox:server:playMusic', dialog.song, currentData, GetEntityCoords(PlayerPedId()))
    end
end)

RegisterNetEvent('qb-boombox:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-boombox:server:changeVolume', dialog.volume, currentData)
    end
end)