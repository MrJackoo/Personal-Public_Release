local QBCore = exports['qb-core']:GetCoreObject()

function NearBus(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.NPCLocations.Locations) do
        local dist = #(coords - vector3(v.x,v.y,v.z))
        if dist < 20 then
            return true
        end
    end
end

RegisterNetEvent('qb-busjob:server:NpcPay', function(Payment)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Payment = math.random(700, 1300)

    if Player.PlayerData.job.name == "bus" then
        if NearBus(src) then
            Player.Functions.AddMoney('bank', Payment, 'Bus Paycheck')
            TriggerClientEvent('QBCore:Notify', src, 'Passenger Paid Fare: £ '..Payment, 'success', 5000)
            TriggerEvent("qb-log:server:CreateLog", "jobpay", "Job Pay (Bus)", "green", "**"..Player.PlayerData.charinfo.firstname .. " ".. Player.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(src) .. " - Citizen ID: "..Player.PlayerData.citizenid.." | ID: "..Player.PlayerData.source.." ] has received **£" .. Payment .. "** for driving a bus")

            local chance = math.random(1, 100)
            if chance < 10 then
                Player.Functions.AddItem("cryptostick", 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cryptostick"], "add")
                TriggerClientEvent('QBCore:Notify', src, 'You found a crysptostick under the seat', 'success')
        
            end
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)
