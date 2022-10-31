-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local financetimer = {}

-- Handlers
-- Store game time for player when they load
RegisterNetEvent('qb-vehicleshop:server:addPlayer', function(citizenid, gameTime)
    financetimer[citizenid] = gameTime
end)

-- Deduct stored game time from player on logout
RegisterNetEvent('qb-vehicleshop:server:removePlayer', function(citizenid)
    if financetimer[citizenid] then
        local playTime = financetimer[citizenid]
        local financetime = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ?', {citizenid})
        for _, v in pairs(financetime) do
            if v.balance >= 1 then
                local newTime = math.floor(v.financetime - (((GetGameTimer() - playTime) / 1000) / 60))
                if newTime < 0 then newTime = 0 end
                MySQL.update('UPDATE player_vehicles SET financetime = ? WHERE plate = ?', {newTime, v.plate})
            end
        end
    end
    financetimer[citizenid] = nil
end)

-- Deduct stored game time from player on quit because we can't get citizenid
AddEventHandler('playerDropped', function()
    local src = source
    local license
    for _, v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    if license then
        local vehicles = MySQL.query.await('SELECT * FROM player_vehicles WHERE license = ?', {license})
        if vehicles then
            for _, v in pairs(vehicles) do
                local playTime = financetimer[v.citizenid]
                if v.balance >= 1 and playTime then
                    local newTime = math.floor(v.financetime - (((GetGameTimer() - playTime) / 1000) / 60))
                    if newTime < 0 then newTime = 0 end
                    MySQL.update('UPDATE player_vehicles SET financetime = ? WHERE plate = ?', {newTime, v.plate})
                end
            end
            if vehicles[1] and financetimer[vehicles[1].citizenid] then financetimer[vehicles[1].citizenid] = nil end
        end
    end
end)

-- Functions
local function round(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

local function calculateFinance(vehiclePrice, downPayment, paymentamount)
    local balance = vehiclePrice - downPayment
    local vehPaymentAmount = balance / paymentamount
    return round(balance), round(vehPaymentAmount)
end

local function calculateNewFinance(paymentAmount, vehData)
    local newBalance = tonumber(vehData.balance - paymentAmount)
    local minusPayment = vehData.paymentsLeft - 1
    local newPaymentsLeft = newBalance / minusPayment
    local newPayment = newBalance / newPaymentsLeft
    return round(newBalance), round(newPayment), newPaymentsLeft
end

local function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

local function comma_value(amount)
    local formatted = amount
    local k
    while true do
        formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

-- Callbacks
QBCore.Functions.CreateCallback('qb-vehicleshop:server:getVehicles', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if player then
        local vehicles = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ?', {player.PlayerData.citizenid})
        if vehicles[1] then
            cb(vehicles)
        end
    end
end)

-- Events
-- Sync vehicle for other players
RegisterNetEvent('qb-vehicleshop:server:swapVehicle', function(data)
    local src = source
    TriggerClientEvent('qb-vehicleshop:client:swapVehicle', -1, data)
    Wait(1500)-- let new car spawn
    TriggerClientEvent('qb-vehicleshop:client:homeMenu', src)-- reopen main menu
end)

-- Send customer for test drive
RegisterNetEvent('qb-vehicleshop:server:customTestDrive', function(vehicle, playerid)
    local src = source
    local target = tonumber(playerid)
    if not QBCore.Functions.GetPlayer(target) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.Invalid_ID'), 'error')
        return
    end
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target))) < 3 then
        TriggerClientEvent('qb-vehicleshop:client:customTestDrive', target, vehicle)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.playertoofar'), 'error')
    end
end)

-- Make a finance payment
-- RegisterNetEvent('qb-vehicleshop:server:financePayment', function(paymentAmount, vehData)
--     local src = source
--     local player = QBCore.Functions.GetPlayer(src)
--     local cash = player.PlayerData.money['cash']
--     local bank = player.PlayerData.money['bank']
--     local plate = vehData.vehiclePlate
--     paymentAmount = tonumber(paymentAmount)
--     local minPayment = tonumber(vehData.paymentAmount)
--     local timer = (Config.PaymentInterval * 60)
--     local newBalance, newPaymentsLeft, newPayment = calculateNewFinance(paymentAmount, vehData)
--     if newBalance > 0 then
--         if player and paymentAmount >= minPayment then
--             if cash >= paymentAmount then
--                 player.Functions.RemoveMoney('cash', paymentAmount)
--                 MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {newBalance, newPayment, newPaymentsLeft, timer, plate})
--             elseif bank >= paymentAmount then
--                 player.Functions.RemoveMoney('bank', paymentAmount)
--                 MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {newBalance, newPayment, newPaymentsLeft, timer, plate})
--             else
--                 TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
--             end
--         else
--             TriggerClientEvent('QBCore:Notify', src, Lang:t('error.minimumallowed') .. comma_value(minPayment), 'error')
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', src, Lang:t('error.overpaid'), 'error')
--     end
-- end)


-- Pay off vehice in full
-- RegisterNetEvent('qb-vehicleshop:server:financePaymentFull', function(data)
--     local src = source
--     local player = QBCore.Functions.GetPlayer(src)
--     local cash = player.PlayerData.money['cash']
--     local bank = player.PlayerData.money['bank']
--     local vehBalance = data.vehBalance
--     local vehPlate = data.vehPlate
--     if player and vehBalance ~= 0 then
--         if cash >= vehBalance then
--             player.Functions.RemoveMoney('cash', vehBalance)
--             MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {0, 0, 0, 0, vehPlate})
--         elseif bank >= vehBalance then
--             player.Functions.RemoveMoney('bank', vehBalance)
--             MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {0, 0, 0, 0, vehPlate})
--         else
--             TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', src, Lang:t('error.alreadypaid'), 'error')
--     end
-- end)

-- Buy public vehicle outright
RegisterNetEvent('qb-vehicleshop:server:buyShowroomVehicle', function(vehicle)
    local src = source
    vehicle = vehicle.buyVehicle
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local cash = pData.PlayerData.money['cash']
    local bank = pData.PlayerData.money['bank']
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
    local plate = GeneratePlate()
    if cash > tonumber(vehiclePrice) then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'pillboxgarage',
            0
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney('cash', vehiclePrice, 'Vehicle Purchase (PDM)')
        if vehiclePrice >= 100000 then
            TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Showroom)", "green", "**"..pData.PlayerData.charinfo.firstname .. " ".. pData.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(pData.PlayerData.source) .. " - Citizen ID: "..pData.PlayerData.citizenid.." | ID: "..pData.PlayerData.source.." ] ** bought a **" .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for £**" .. vehiclePrice .. "** (Cash Transaction)", true)
        else
            TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Showroom)", "green", "**"..pData.PlayerData.charinfo.firstname .. " ".. pData.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(pData.PlayerData.source) .. " - Citizen ID: "..pData.PlayerData.citizenid.." | ID: "..pData.PlayerData.source.." ] ** bought a **" .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for £" .. vehiclePrice .. "** (Cash Transaction)", false)
        end
        elseif bank > tonumber(vehiclePrice) then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'pillboxgarage',
            0
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney('bank', vehiclePrice, 'Vehicle Purchase (PDM)')
        if vehiclePrice >= 100000 then
            TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Showroom)", "green", "**"..pData.PlayerData.charinfo.firstname .. " ".. pData.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(pData.PlayerData.source) .. " - Citizen ID: "..pData.PlayerData.citizenid.." | ID: "..pData.PlayerData.source.." ] ** bought a **" .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for **£" .. vehiclePrice .. "** (Bank Transaction)", true)
        else
            TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Showroom)", "green", "**"..pData.PlayerData.charinfo.firstname .. " ".. pData.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(pData.PlayerData.source) .. " - Citizen ID: "..pData.PlayerData.citizenid.." | ID: "..pData.PlayerData.source.." ] ** bought a **" .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for **£" .. vehiclePrice .. "** (Bank Transaction)", false)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
    end
end)

-- Finance public vehicle
-- RegisterNetEvent('qb-vehicleshop:server:financeVehicle', function(downPayment, paymentAmount, vehicle)
--     local src = source
--     downPayment = tonumber(downPayment)
--     paymentAmount = tonumber(paymentAmount)
--     local pData = QBCore.Functions.GetPlayer(src)
--     local cid = pData.PlayerData.citizenid
--     local cash = pData.PlayerData.money['cash']
--     local bank = pData.PlayerData.money['bank']
--     local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
--     local timer = (Config.PaymentInterval * 60)
--     local minDown = tonumber(round((Config.MinimumDown / 100) * vehiclePrice))
--     if downPayment > vehiclePrice then return TriggerClientEvent('QBCore:Notify', src, 'Vehicle is not worth that much', 'error') end
--     if downPayment < minDown then return TriggerClientEvent('QBCore:Notify', src, 'Down payment too small', 'error') end
--     if paymentAmount > Config.MaximumPayments then return TriggerClientEvent('QBCore:Notify', src, 'Exceeded maximum payment amount', 'error') end
--     local plate = GeneratePlate()
--     local balance, vehPaymentAmount = calculateFinance(vehiclePrice, downPayment, paymentAmount)
--     if cash >= downPayment then
--         MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
--             pData.PlayerData.license,
--             cid,
--             vehicle,
--             GetHashKey(vehicle),
--             '{}',
--             plate,
--             'pillboxgarage',
--             0,
--             balance,
--             vehPaymentAmount,
--             paymentAmount,
--             timer
--         })
--         TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
--         TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
--         pData.Functions.RemoveMoney('cash', downPayment, 'vehicle-bought-in-showroom')
--     elseif bank >= downPayment then
--         MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
--             pData.PlayerData.license,
--             cid,
--             vehicle,
--             GetHashKey(vehicle),
--             '{}',
--             plate,
--             'pillboxgarage',
--             0,
--             balance,
--             vehPaymentAmount,
--             paymentAmount,
--             timer
--         })
--         TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
--         TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
--         pData.Functions.RemoveMoney('bank', downPayment, 'vehicle-bought-in-showroom')
--     else
--         TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
--     end
-- end)

-- Sell vehicle to customer
RegisterNetEvent('qb-vehicleshop:server:sellShowroomVehicle', function(data, playerid)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local target = QBCore.Functions.GetPlayer(tonumber(playerid))
    local vehicle = data
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
    

    local commission = 0
    if #(GetEntityCoords(GetPlayerPed(src)) - vector3(936.91, -972.12, 39.54)) < 50.0 then
        commission = (vehiclePrice * Config.Commission)
        if commission > 50000 then
            commission = 50000
        end
    else
        commission = 0
    end

    if not target then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.Invalid_ID'), 'error')
        return
    end

    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target.PlayerData.source))) < 3 then
        local cid = target.PlayerData.citizenid
        local cash = target.PlayerData.money['cash']
        local bank = target.PlayerData.money['bank']
        local vehicle = data
        local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
        local salefunds = round(vehiclePrice - commission)
        local plate = GeneratePlate()
        if cash >= tonumber(vehiclePrice) then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                target.PlayerData.license,
                cid,
                vehicle,
                GetHashKey(vehicle),
                '{}',
                plate,
                'pillboxgarage',
                0
            })
            TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', target.PlayerData.source, vehicle, plate)
            target.Functions.RemoveMoney('cash', vehiclePrice, 'Vehicle Purchase (Tuners)')

            -- Car Dealer Commission
            player.Functions.AddMoney('bank', commission, 'Vehicle Sale Commission')
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')

            -- Tuners Business Sale Funds
            exports['qb-management']:AddMoney("cardealer", salefunds)
            -- TriggerEvent('qb-banking:society:server:DepositMoney', src, salefunds, 'importdealer')
            TriggerClientEvent('QBCore:Notify', target.PlayerData.source, Lang:t('success.purchased'), 'success')

            -- Logs
            TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Sold (Tuners)", "green", "**"..player.PlayerData.charinfo.firstname .. " ".. player.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(player.PlayerData.source) .. " - Citizen ID: "..player.PlayerData.citizenid.." | ID: "..player.PlayerData.source.." ] ** sold a " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " to **"..target.PlayerData.charinfo.firstname .. " ".. target.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(target.PlayerData.source) .. " - Citizen ID: "..target.PlayerData.citizenid.." | ID: "..target.PlayerData.source.." ] for £" .. vehiclePrice .. "", false)

            if vehiclePrice >= 100000 then
                TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Tuners)", "green", "**"..target.PlayerData.charinfo.firstname .. " ".. target.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(target.PlayerData.source) .. " - Citizen ID: "..target.PlayerData.citizenid.." | ID: "..target.PlayerData.source.." ] ** bought a " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for £" .. vehiclePrice .. " (Cash Transaction)", true)
            else
                TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Tuners)", "green", "**"..target.PlayerData.charinfo.firstname .. " ".. target.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(target.PlayerData.source) .. " - Citizen ID: "..target.PlayerData.citizenid.." | ID: "..target.PlayerData.source.." ] ** bought a " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for £" .. vehiclePrice .. " (Cash Transaction)", false)
            end
        elseif bank >= tonumber(vehiclePrice) then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                target.PlayerData.license,
                cid,
                vehicle,
                GetHashKey(vehicle),
                '{}',
                plate,
                'pillboxgarage',
                0
            })
            TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', target.PlayerData.source, vehicle, plate)
            target.Functions.RemoveMoney('bank', vehiclePrice, 'Vehicle Purchase (Tuners)')

            -- Car Dealer Commission
            player.Functions.AddMoney('bank', commission, 'Vehicle Sale Commission')
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')

            -- Tuners Business Sale Funds
            exports['qb-management']:AddMoney("cardealer", salefunds)
            -- TriggerEvent('qb-banking:society:server:DepositMoney', src, salefunds, 'importdealer')
            TriggerClientEvent('QBCore:Notify', target.PlayerData.source, Lang:t('success.purchased'), 'success')
            
            -- Logs
            TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Sold (Tuners)", "green", "**"..player.PlayerData.charinfo.firstname .. " ".. player.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(player.PlayerData.source) .. " - Citizen ID: "..player.PlayerData.citizenid.." | ID: "..player.PlayerData.source.." ] ** sold a " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " to **"..target.PlayerData.charinfo.firstname .. " ".. target.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(target.PlayerData.source) .. " - Citizen ID: "..target.PlayerData.citizenid.." | ID: "..target.PlayerData.source.." ] for £" .. vehiclePrice .. "", false)

            if vehiclePrice >= 100000 then
                TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Tuners)", "green", "**"..target.PlayerData.charinfo.firstname .. " ".. target.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(target.PlayerData.source) .. " - Citizen ID: "..target.PlayerData.citizenid.." | ID: "..target.PlayerData.source.." ] ** bought a " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for £" .. vehiclePrice .. " (Cash Transaction)", true)
            else
                TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (Tuners)", "green", "**"..target.PlayerData.charinfo.firstname .. " ".. target.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(target.PlayerData.source) .. " - Citizen ID: "..target.PlayerData.citizenid.." | ID: "..target.PlayerData.source.." ] ** bought a " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " for £" .. vehiclePrice .. " (Cash Transaction)", false)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.playertoofar'), 'error')
    end
end)

-- Finance vehicle to customer
-- RegisterNetEvent('qb-vehicleshop:server:sellfinanceVehicle', function(downPayment, paymentAmount, vehicle, playerid)
--     local src = source
--     local player = QBCore.Functions.GetPlayer(src)
--     local target = QBCore.Functions.GetPlayer(tonumber(playerid))

--     if not target then
--         TriggerClientEvent('QBCore:Notify', src, Lang:t('error.Invalid_ID'), 'error')
--         return
--     end

--     if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target.PlayerData.source))) < 3 then
--         downPayment = tonumber(downPayment)
--         paymentAmount = tonumber(paymentAmount)
--         local cid = target.PlayerData.citizenid
--         local cash = target.PlayerData.money['cash']
--         local bank = target.PlayerData.money['bank']
--         local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
--         local timer = (Config.PaymentInterval * 60)
--         local minDown = tonumber(round((Config.MinimumDown / 100) * vehiclePrice))
--         if downPayment > vehiclePrice then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notworth'), 'error') end
--         if downPayment < minDown then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.downtoosmall'), 'error') end
--         if paymentAmount > Config.MaximumPayments then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.exceededmax'), 'error') end
--         local commission = round(vehiclePrice * Config.Commission)
--         local plate = GeneratePlate()
--         local balance, vehPaymentAmount = calculateFinance(vehiclePrice, downPayment, paymentAmount)
--         if cash >= downPayment then
--             MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
--                 target.PlayerData.license,
--                 cid,
--                 vehicle,
--                 GetHashKey(vehicle),
--                 '{}',
--                 plate,
--                 'pillboxgarage',
--                 0,
--                 balance,
--                 vehPaymentAmount,
--                 paymentAmount,
--                 timer
--             })
--             TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', target.PlayerData.source, vehicle, plate)
--             target.Functions.RemoveMoney('cash', downPayment, 'vehicle-bought-in-showroom')
--             player.Functions.AddMoney('bank', commission)
--             TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')
--             exports['qb-management']:AddMoney(player.PlayerData.job.name, vehiclePrice)
--             TriggerClientEvent('QBCore:Notify', target.PlayerData.source, Lang:t('success.purchased'), 'success')
--         elseif bank >= downPayment then
--             MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
--                 target.PlayerData.license,
--                 cid,
--                 vehicle,
--                 GetHashKey(vehicle),
--                 '{}',
--                 plate,
--                 'pillboxgarage',
--                 0,
--                 balance,
--                 vehPaymentAmount,
--                 paymentAmount,
--                 timer
--             })
--             TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', target.PlayerData.source, vehicle, plate)
--             target.Functions.RemoveMoney('bank', downPayment, 'vehicle-bought-in-showroom')
--             player.Functions.AddMoney('bank', commission)
--             TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')
--             exports['qb-management']:AddMoney(player.PlayerData.job.name, vehiclePrice)
--             TriggerClientEvent('QBCore:Notify', target.PlayerData.source, Lang:t('success.purchased'), 'success')
--         else
--             TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', src, Lang:t('error.playertoofar'), 'error')
--     end
-- end)

-- Check if payment is due
RegisterNetEvent('qb-vehicleshop:server:checkFinance', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local query = 'SELECT * FROM player_vehicles WHERE citizenid = ? AND balance > 0 AND financetime < 1'
    local result = MySQL.query.await(query, {player.PlayerData.citizenid})
    if result[1] then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('general.paymentduein', {time = Config.PaymentWarning}))
        Wait(Config.PaymentWarning * 60000)
        local vehicles = MySQL.query.await(query, {player.PlayerData.citizenid})
        for _, v in pairs(vehicles) do
            local plate = v.plate
            MySQL.query('DELETE FROM player_vehicles WHERE plate = @plate', {['@plate'] = plate})
            --MySQL.update('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {'REPO-'..v.citizenid, plate}) -- Use this if you don't want them to be deleted
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.repossessed', {plate = plate}), 'error')
        end
    end
end)