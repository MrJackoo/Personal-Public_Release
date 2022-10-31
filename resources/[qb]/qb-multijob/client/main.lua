local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('jobMenu', function(source, args)
    local Player = QBCore.Functions.GetPlayerData()
    local onDuty = Player.job.onduty
    local job = Player.job.name
    local currentGrade = Player.job.grade.level
    QBCore.Functions.TriggerCallback('qb-multijob:server:getJobs', function(result)
        if result ~= nil then 
            openMenu(onDuty, job, result, currentGrade)
        end
    end)
end)

RegisterKeyMapping('jobMenu', "Open Multi-Job Menu", "keyboard", Config.Keybind)

function openMenu(onDuty, job, jobInfo, currentGrade)
    SendNUIMessage({
        action = "open",
        duty = onDuty,
        jobInfo = jobInfo,
        job = job,
        currentGrade = currentGrade
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('close', function() 
    SetNuiFocus(false, false)
end)

RegisterNUICallback('deleteJob', function(data)
    TriggerServerEvent('qb-multijob:server:deleteJob', data.job)
end)

RegisterNUICallback('changeJob', function(data) 
    TriggerServerEvent('qb-multijob:server:changeJob', data.job, data.grade)
end)

RegisterNUICallback('toggleDuty', function() 
    local player = QBCore.Functions.GetPlayerData()
    local jobName = player.job.name
    if jobName ~= 'police' and jobName ~= 'ambulance' then 
        TriggerServerEvent("QBCore:ToggleDuty")
    else
        QBCore.Functions.Notify('Please use the duty system at the station', 'error') 
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    TriggerServerEvent('qb-multijob:server:newJob', JobInfo)
end)