QBCore = exports['qb-core']:GetCoreObject()

display = false
maxLength = 800
minLength = 1

Citizen.CreateThread(function()
  while QBCore.Functions.GetPlayerData().job == nil do
    Citizen.Wait(1000)
  end

  QBCore.PlayerData = QBCore.Functions.GetPlayerData()
      Citizen.Wait(1000)
end)



RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
  QBCore.PlayerData = xPlayer
end)



RegisterNetEvent('QBCore:Client:OnJobUptade')
AddEventHandler('QBCore:Client:OnJobUptade', function(job)
  QBCore.PlayerData.job = job
end)


-- Citizen.CreateThread(function()
--   local Player = QBCore.Functions.GetPlayerData(source)
--     while true do
--         Citizen.Wait(0)
--         local ped = GetPlayerPed(-1)
--         local coords = GetEntityCoords(ped)
--         local distanceToForm = 30000
--         for k, v in pairs(forms) do
--           local distance = #(coords - v.pos)
--           if distance < distanceToForm then
--             distanceToForm = distance
--           end
--           if not display then
--             if distance < 1.0 then
--                   DrawText3D(v.pos, '~g~[E]~w~ '..v.label)
--                   if IsControlJustReleased(0, 38) then
--                     SetDisplay(true, k, v.label)
--                   end
--             end
--           end
--         end
--         if distanceToForm > Config.load_distance then
--           Citizen.Wait(2000)
--         end
--     end
-- end)



RegisterNUICallback("send_form", function(data)
  SetDisplay(false)
  SetNuiFocus(false, false)
  if data ~= nil then
    local joininglength = string.len(data.joinreason)
    local qualitieslength = string.len(data.qualities)
    if (joininglength < minLength) or (qualitieslength < minLength) then
      QBCore.Functions.Notify('Your form is too short'..minLength..' min. characters!', "error")
    else
      if (joininglength > maxLength) or (qualitieslength > maxLength) then
        QBCore.Functions.Notify('Your form is too long - '..maxLength..' max. characters!', "error")
      else
        sendForm(data)
        QBCore.Functions.Notify('Your form has been sent to - '..data.job)
      end
    end
  else
    QBCore.Functions.Notify('Your form is empty!', "error")
  end
end)

-- RegisterNUICallback("send_form", function(data)
--   SetDisplay(false)
--   SetNuiFocus(false, false)
--   if data ~= nil then
--     print("the data has been parsed: ", json.encode(data))
--   else
--     QBCore.Functions.Notify('Your form is empty!', "error")
--   end
-- end)



RegisterNUICallback("exit_form", function(data)
  if data.error ~= nil then
    QBCore.Functions.Notify(data.error)
  end
  SetDisplay(false)
  SetNuiFocus(false, false)
end)

function RemoteApplication(bool, form_job)
  local form_label = forms[form_job].label

  SetDisplay(bool, form_job, form_label)

end


function SetDisplay(bool, form_job, form_label)
    display = bool
    SetNuiFocus(bool, bool)
    local Player = QBCore.Functions.GetPlayerData()
    Citizen.Wait(10)
    local firstname = Player.charinfo.firstname
    local lastname = Player.charinfo.lastname
    local phone = Player.charinfo.phone
    

    while phone == nil do
      Citizen.Wait(100)

    end
    SendNUIMessage({
        type = "ui",
        status = bool,
        job = form_job,
        label = form_label,
        player = {
          firstname = firstname,
          lastname = lastname,
          phone = phone
        }
    })
end



function sendForm(data)
  TriggerServerEvent('strin_jobform:sendWebhook', data)
end


function DrawText3D(coords, text)
  local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
  SetTextScale(Config.draw_text_scale.x, Config.draw_text_scale.y)
  SetTextFont(Config.draw_text_font)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  if Config.draw_react then
    local factor = (string.len(text)) / 200
    DrawRect(_x,_y+0.0105, 0.015+ factor, 0.035, 44, 44, 44, 100)
  end
end


exports('ShowApplication', RemoteApplication)
