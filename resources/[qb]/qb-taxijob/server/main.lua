local QBCore = exports['qb-core']:GetCoreObject()

function NearTaxi(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.NPCLocations.DeliverLocations) do
        local dist = #(coords - vector3(v.x,v.y,v.z))
        if dist < 20 then
            return true
        end
    end
end

RegisterNetEvent('qb-taxi:server:NpcPay', function(Payment)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randomAmount = math.random(1, 100)
    
    if Player.PlayerData.job.name == "taxi" then
        if NearTaxi(src) then
            
            if randomAmount >= 1 and randomAmount < 25 then 
                bonus = math.random(250, 500)
            elseif randomAmount >= 25 and randomAmount < 50 then 
                bonus = math.random(500, 750)
            elseif randomAmount >= 50 and randomAmount < 75 then 
                bonus = math.random(750, 1000)
            elseif randomAmount > 75 then 
                bonus = math.random(1000, 1250)
            end
            
            local pay = Payment + bonus
            local fuckyourtaxi = 4500
            
            if pay > 4500 then
                Player.Functions.AddMoney('cash', fuckyourtaxi, 'Taxi Services')
                TriggerClientEvent('QBCore:Notify', src, 'Total Pay: £'..fuckyourtaxi..'', 'success', 5000)
                TriggerEvent("qb-log:server:CreateLog", "jobpay", "Job Pay (Taxi Driver)", "green", "**"..Player.PlayerData.charinfo.firstname .. " ".. Player.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(src) .. " - Citizen ID: "..Player.PlayerData.citizenid.." | ID: "..Player.PlayerData.source.." ] has received **£" .. fuckyourtaxi .. "** for driving a taxi")
            else
                Player.Functions.AddMoney('cash', pay, 'Taxi Services')
                TriggerClientEvent('QBCore:Notify', src, 'Total Pay: £'..pay.. '', 'success', 5000)
                TriggerEvent("qb-log:server:CreateLog", "jobpay", "Job Pay (Taxi Driver)", "green", "**"..Player.PlayerData.charinfo.firstname .. " ".. Player.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(src) .. " - Citizen ID: "..Player.PlayerData.citizenid.." | ID: "..Player.PlayerData.source.." ] has received **£" .. pay .. "** for driving a taxi")
            end



            local chance = math.random(1, 100)
            if chance < 10 then
                Player.Functions.AddItem("cryptostick", 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cryptostick"], "add")
                TriggerClientEvent('QBCore:Notify', src, 'The customer left a crysptostick for you', 'success') 
            end
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)

