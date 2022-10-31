-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
PlayerJob = {}

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function(Player)
  PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
end)

RegisterNetEvent('ax-forms:client:EmailPlayer', function()
  local dialog = exports['qb-input']:ShowInput({
      header = "Staff Email",
      submitText = "Send",
      inputs = {
        {
          text = "Players Citizen ID", -- text you want to be displayed as a place holder
          name = "cid", -- name of the input should be unique otherwise it might override
          type = "text", -- type of the input
          isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
        },
        {
          text = "Email Title", -- text you want to be displayed as a place holder
          name = "title", -- name of the input should be unique otherwise it might override
          type = "text", -- type of the input
          isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
        },
        {
          text = "Email Message", -- text you want to be displayed as a place holder
          name = "email", -- name of the input should be unique otherwise it might override
          type = "text", -- type of the input
          isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
        },
      },
    })
  
    if dialog then
      if not dialog.cid and dialog.email and dialog.title then return end
      TriggerServerEvent('ax-forms:server:EmailPlayer', dialog.cid, dialog.title, dialog.email)
    end
end)

RegisterNetEvent('ax-forms:client:courtEmail', function()
  if PlayerJob.name == "judge" then
    local dialog = exports['qb-input']:ShowInput({
        header = "Court Email",
        submitText = "Send",
        inputs = {
          {
            text = "Players Citizen ID", -- text you want to be displayed as a place holder
            name = "cid", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Email Title", -- text you want to be displayed as a place holder
            name = "title", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Email Message", -- text you want to be displayed as a place holder
            name = "email", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
        },
      })
    
      if dialog then
        if not dialog.cid and dialog.email and dialog.title then return end
        TriggerServerEvent('ax-forms:server:courtEmail', dialog.cid, dialog.title, dialog.email)
      end
    else
      QBCore.Functions.Notify('You must be a Judge to use this feature', 'error', 3000)
  end
end)

RegisterNetEvent('ax-forms:client:comprequestForm', function()
  local dialog = exports['qb-input']:ShowInput({
      header = "Compensation Request",
      submitText = "Submit",
      inputs = {
          {
            text = "Briefly Explain the Issue", -- text you want to be displayed as a place holder
            name = "message", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Time of Incident (16:38)", -- text you want to be displayed as a place holder
            name = "time", -- name of the input should be unique otherwise it might override
            type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Link to Evidence (Video/Screenshot)", -- text you want to be displayed as a place holder
            name = "evidence", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Request Reason", -- text you want to be displayed as a input header
            name = "reason", -- name of the input should be unique otherwise it might override
            type = "select", -- type of the input - Select is useful for 3+ amount of "or" options e.g; someselect = none OR other OR other2 OR other3...etc
            options = { -- Select drop down options, the first option will by default be selected
              { value = "bug", text = "Bug" }, -- Options MUST include a value and a text option
              { value = "hacker", text = "Hacker" }, -- Options MUST include a value and a text option
              { value = "servercrash", text = "Server Crash" }, -- Options MUST include a value and a text option
              { value = "rulebreak", text = "Rule Break" }, -- Options MUST include a value and a text option
              { value = "usererror", text = "User Error" }, -- Options MUST include a value and a text option
              { value = "other", text = "Other" }, -- Options MUST include a value and a text option
            }
          }
      },
    })
  
    if dialog then
      if not dialog.message and dialog.evidence and dialog.time and dialog.reason then return end
      TriggerServerEvent('ax-forms:server:sendCompRequest', dialog.message, dialog.evidence, dialog.time, dialog.reason)
    end
end)

RegisterNetEvent('ax-forms:courtMenu', function()
    exports['qb-menu']:openMenu({
        {
          isMenuHeader = true,
          header = 'Supreme Court of Los Santos',
          txt = 'Reception'
        },
        {
          header = 'Request a Court Case',
          txt = 'Coming Soon',
          params = {
              event = '',
          }
        },
        {
          header = 'Request a Lawyer',
          txt = 'Coming Soon',
          params = {
              event = '',
          }
        },
        {
          header = 'Submit a Warrant',
          txt = '',
          params = {
              event = 'ax-forms:client:submitWarrant',
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

RegisterNetEvent('ax-forms:client:submitWarrant', function()
  if PlayerJob.name == "police" then
    local dialog = exports['qb-input']:ShowInput({
        header = "Warrant Application",
        submitText = "Submit",
        inputs = {
          {
            text = "Submitting Officer's Rank", -- text you want to be displayed as a place holder
            name = "rank", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Authorising Officer's Name & Rank", -- text you want to be displayed as a place holder
            name = "auth", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
          {
            text = "Warrant Type", -- text you want to be displayed as a input header
            name = "warrant", -- name of the input should be unique otherwise it might override
            type = "select", -- type of the input - Select is useful for 3+ amount of "or" options e.g; someselect = none OR other OR other2 OR other3...etc
            isRequired = true,
            options = { -- Select drop down options, the first option will by default be selected
              { value = "Arrest", text = "Arrest Warrant" }, -- Options MUST include a value and a text option
              { value = "Search", text = "Search Warrant" }, -- Options MUST include a value and a text optionon
            },
          },
          {
            text = "Link to Warrant Application", -- text you want to be displayed as a place holder
            name = "application", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
          },
        },
      })
      
      if dialog then
        if not dialog.rank and dialog.auth and dialog.warrant and dialog.application then return end
        TriggerServerEvent('ax-forms:server:submitWarrant', dialog.rank, dialog.auth, dialog.warrant, dialog.application)
      end
      
    else
      QBCore.Functions.Notify('You must be a police officer to submit a warrant', 'error', 3000)
  end
end)

-- Threads
CreateThread(function()
  local alreadyEnteredZone = false
  while true do
      wait = 5
      local ped = PlayerPedId()
      local inZone = false
      local dist = #(GetEntityCoords(ped)-vector3(243.5, -1090.69, 29.29))
      if dist <= 2.5 then
          wait = 5
          inZone  = true
          if IsControlJustReleased(0, 38) then
              exports['qb-core']:KeyPressed()
              TriggerEvent('ax-forms:courtMenu')
          end
      else
          wait = 1000
      end
      if inZone and not alreadyEnteredZone then
          alreadyEnteredZone = true
          exports['qb-core']:DrawText('[E] Supreme Court')
      end
      if not inZone and alreadyEnteredZone then
          alreadyEnteredZone = false
          exports['qb-core']:HideText()
      end
      Wait(wait)
  end
end)

