local QBCore = exports['qb-core']:GetCoreObject()

-- Events
RegisterNetEvent('qb-burgershot:server:BillPlayer', function(playerId)
    local src = source
    TriggerClientEvent('qb-burgershot:client:bill', src)
end)

RegisterServerEvent('qb-burgershot:server:bill', function(serverid, amount, payment)
    local src = source
    local biller = QBCore.Functions.GetPlayer(src)
    local billed = QBCore.Functions.GetPlayer(tonumber(serverid))
    local amount = tonumber(amount)

    if biller.PlayerData.job.name == 'burgershot' then
        if billed ~= nil then
            if amount and amount > 0 then
                if payment == 'cash' then
                    billed.Functions.RemoveMoney('cash', amount, 'Burgershot Purchase')
                    TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'You paid £'..amount..' for your food')
                    TriggerClientEvent('QBCore:Notify', src, 'You charged the customer £'..amount..'', 'success')
                    TriggerEvent("qb-log:server:CreateLog", "jobpay", "Burgershot (Cash Transaction)", "green", "**"..biller.PlayerData.charinfo.firstname .. " ".. biller.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(src) .. " - Citizen ID: "..biller.PlayerData.citizenid.." | ID: "..biller.PlayerData.source.." ] has billed **"..billed.PlayerData.charinfo.firstname .. " ".. billed.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(serverid) .. " - Citizen ID: "..billed.PlayerData.citizenid.." | ID: "..billed.PlayerData.source.." ] **£" .. amount .. "** for greasy fast food")
                    exports['qb-management']:AddMoney("burgershot", amount)
                elseif payment == 'bank' then
                    billed.Functions.RemoveMoney('bank', amount, 'Burgershot Purchase')
                    TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'You debit card was charged £'..amount..' for your food')
                    TriggerClientEvent('QBCore:Notify', src, 'You debited the customer £'..amount..'', 'success')
                    TriggerEvent("qb-log:server:CreateLog", "jobpay", "Burgershot (Bank Transaction)", "green", "**"..biller.PlayerData.charinfo.firstname .. " ".. biller.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(src) .. " - Citizen ID: "..biller.PlayerData.citizenid.." | ID: "..biller.PlayerData.source.." ] has billed **"..billed.PlayerData.charinfo.firstname .. " ".. billed.PlayerData.charinfo.lastname.. "** [ "..GetPlayerName(serverid) .. " - Citizen ID: "..billed.PlayerData.citizenid.." | ID: "..billed.PlayerData.source.." ] **£" .. amount .. "** for greasy fast food")
                    exports['qb-management']:AddMoney("burgershot", amount)
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
    end
end)

-- Cook Meat
RegisterServerEvent('qb-burgershot:server:processMeat', function(rawMeat)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local burger = Player.Functions.GetItemByName('burger-raw')
    local burgerNumber = tonumber(rawMeat)
    if not tonumber(rawMeat) then return end
    if burger ~= nil and burgerNumber > 0 then
        if burger.amount >= burgerNumber then
            TriggerClientEvent('qb-burgershot:client:processMeat', src, burgerNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:cookMeat', function(burgerNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local burger = Player.Functions.GetItemByName('burger-raw')
    local burgerNumber = tonumber(burgerNumber)

	if Player.PlayerData.items ~= nil then 
        if burger ~= nil then
            if burger.amount >= burgerNumber then 
                Player.Functions.AddItem('burger-meat', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-meat'], 'add')
                Player.Functions.RemoveItem('burger-raw', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-raw'], 'remove')
            end
        end
	end
end)

-- Cook Fries
RegisterServerEvent('qb-burgershot:server:processFries', function(potato)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local fries = Player.Functions.GetItemByName('burger-potato')
    local friesNumber = tonumber(potato)
    if not tonumber(potato) then return end
    if fries ~= nil and friesNumber  > 0 then
        if fries.amount >= friesNumber  then
            TriggerClientEvent('qb-burgershot:client:processFries', src, friesNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:cookFries', function(friesNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local fries = Player.Functions.GetItemByName('burger-potato')
    local friesNumber = tonumber(friesNumber)

	if Player.PlayerData.items ~= nil then 
        if fries ~= nil then
            if fries.amount >= friesNumber then 
                Player.Functions.AddItem('burger-fries', 1 * friesNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-fries'], 'add')
                Player.Functions.RemoveItem('burger-potato', 1 * friesNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-potato'], 'remove')
            end
        end
	end
end)

-- Soft Drink
RegisterServerEvent('qb-burgershot:server:processSoftDrink', function(softdrink)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local syrup = Player.Functions.GetItemByName('burger-sodasyrup')
    local drinkNumber = tonumber(softdrink)
    if not tonumber(softdrink) then return end
    if syrup ~= nil and drinkNumber > 0 then
        if syrup.amount >= drinkNumber then
            TriggerClientEvent('qb-burgershot:client:processSoftDrink', src, drinkNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeSoftDrink', function(drinkNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local syrup = Player.Functions.GetItemByName('burger-sodasyrup')
    local drinkNumber = tonumber(drinkNumber)

	if Player.PlayerData.items ~= nil then 
        if syrup ~= nil then
            if syrup.amount >= drinkNumber then
                Player.Functions.AddItem('burger-softdrink', 1 * drinkNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-softdrink'], 'add')
                Player.Functions.RemoveItem('burger-sodasyrup', 1 * drinkNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-sodasyrup'], 'remove')
            end
        end
	end
end)

-- Milkshake
RegisterServerEvent('qb-burgershot:server:processMilkshake', function(milkshake)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local formula = Player.Functions.GetItemByName('burger-mshakeformula')
    local milkshakeNumber = tonumber(milkshake)
    if not tonumber(milkshake) then return end
    if formula ~= nil and milkshakeNumber > 0 then
        if formula.amount >= milkshakeNumber then
            TriggerClientEvent('qb-burgershot:client:processMilkshake', src, milkshakeNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeMilkshake', function(milkshakeNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local formula = Player.Functions.GetItemByName('burger-mshakeformula')
    local milkshakeNumber = tonumber(milkshakeNumber)

	if Player.PlayerData.items ~= nil then 
        if formula ~= nil then
            if formula.amount >= milkshakeNumber then
                Player.Functions.AddItem('burger-mshake', 1 * milkshakeNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-mshake'], 'add')
                Player.Functions.RemoveItem('burger-mshakeformula', 1 * milkshakeNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-mshakeformula'], 'remove')
            end
        end
	end
end)

-- Moneyshot Burgers
RegisterServerEvent('qb-burgershot:server:processBurger', function(burger)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local lettuce = Player .Functions.GetItemByName('burger-lettuce')
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burger)
    if not tonumber(burger) then return end
    if (lettuce ~= nil and meat ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
        if (lettuce.amount >= burgerNumber and meat.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
            TriggerClientEvent('qb-burgershot:client:processBurger', src, burgerNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeBurger', function(burgerNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local lettuce = Player.Functions.GetItemByName('burger-lettuce')
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burgerNumber)

	if Player.PlayerData.items ~= nil then 
        if (lettuce ~= nil and meat ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
            if (lettuce.amount >= burgerNumber and meat.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
                Player.Functions.AddItem('burger-moneyshot', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-moneyshot'], 'add')
                Player.Functions.RemoveItem('burger-lettuce', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-lettuce'], 'remove')
                Player.Functions.RemoveItem('burger-meat', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-meat'], 'remove')
                Player.Functions.RemoveItem('burger-bun', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-bun'], 'remove')
                Player.Functions.RemoveItem('burger-tomato', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-tomato'], 'remove')
            end
        end
	end
end)

-- Bleeder Burgers
RegisterServerEvent('qb-burgershot:server:processBurger2', function(burger)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local lettuce = Player .Functions.GetItemByName('burger-lettuce')
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burger)
    if not tonumber(burger) then return end
    if (lettuce ~= nil and meat ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
        if (lettuce.amount >= burgerNumber and meat.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
            TriggerClientEvent('qb-burgershot:client:processBurger2', src, burgerNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeBurger2', function(burgerNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local lettuce = Player.Functions.GetItemByName('burger-lettuce')
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burgerNumber)

	if Player.PlayerData.items ~= nil then 
        if (lettuce ~= nil and meat ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
            if (lettuce.amount >= burgerNumber and meat.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
                Player.Functions.AddItem('burger-bleeder', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-bleeder'], 'add')
                Player.Functions.RemoveItem('burger-lettuce', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-lettuce'], 'remove')
                Player.Functions.RemoveItem('burger-meat', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-meat'], 'remove')
                Player.Functions.RemoveItem('burger-bun', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-bun'], 'remove')
                Player.Functions.RemoveItem('burger-tomato', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-tomato'], 'remove')
            end
        end
	end
end)

-- Heart Stopper Burgers
RegisterServerEvent('qb-burgershot:server:processBurger3', function(burger)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local lettuce = Player .Functions.GetItemByName('burger-lettuce')
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burger)
    if not tonumber(burger) then return end
    if (lettuce ~= nil and meat ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
        if (lettuce.amount >= burgerNumber and meat.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
            TriggerClientEvent('qb-burgershot:client:processBurger3', src, burgerNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeBurger3', function(burgerNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local lettuce = Player.Functions.GetItemByName('burger-lettuce')
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burgerNumber)

	if Player.PlayerData.items ~= nil then 
        if (lettuce ~= nil and meat ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
            if (lettuce.amount >= burgerNumber and meat.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
                Player.Functions.AddItem('burger-heartstopper', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-heartstopper'], 'add')
                Player.Functions.RemoveItem('burger-lettuce', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-lettuce'], 'remove')
                Player.Functions.RemoveItem('burger-meat', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-meat'], 'remove')
                Player.Functions.RemoveItem('burger-bun', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-bun'], 'remove')
                Player.Functions.RemoveItem('burger-tomato', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-tomato'], 'remove')
            end
        end
	end
end)

-- Torpedo Roll
RegisterServerEvent('qb-burgershot:server:processBurger4', function(burger)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local burgerNumber = tonumber(burger)
    if not tonumber(burger) then return end
    if (meat ~= nil and bun ~= nil and burgerNumber > 0) then
        if (meat.amount >= burgerNumber and bun.amount >= burgerNumber) then
            TriggerClientEvent('qb-burgershot:client:processBurger4', src, burgerNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeBurger4', function(burgerNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local meat = Player.Functions.GetItemByName('burger-meat')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local burgerNumber = tonumber(burgerNumber)

	if Player.PlayerData.items ~= nil then 
        if (meat ~= nil and bun ~= nil and burgerNumber > 0) then
            if (meat.amount >= burgerNumber and bun.amount >= burgerNumber) then
                Player.Functions.AddItem('burger-torpedo', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-torpedo'], 'add')
                Player.Functions.RemoveItem('burger-meat', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-meat'], 'remove')
                Player.Functions.RemoveItem('burger-bun', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-bun'], 'remove')
            end
        end
	end
end)

-- Meat Free
RegisterServerEvent('qb-burgershot:server:processBurger5', function(burger)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local lettuce = Player .Functions.GetItemByName('burger-lettuce')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burger)
    if not tonumber(burger) then return end
    if (lettuce ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
        if (lettuce.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
            TriggerClientEvent('qb-burgershot:client:processBurger5', src, burgerNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeBurger5', function(burgerNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local lettuce = Player.Functions.GetItemByName('burger-lettuce')
    local bun = Player.Functions.GetItemByName('burger-bun')
    local tomato = Player.Functions.GetItemByName('burger-tomato')
    local burgerNumber = tonumber(burgerNumber)

	if Player.PlayerData.items ~= nil then 
        if (lettuce ~= nil and bun ~= nil and tomato ~= nil and burgerNumber > 0) then
            if (lettuce.amount >= burgerNumber and bun.amount >= burgerNumber and tomato.amount >= burgerNumber) then
                Player.Functions.AddItem('burger-meatfree', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-meatfree'], 'add')
                Player.Functions.RemoveItem('burger-lettuce', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-lettuce'], 'remove')
                Player.Functions.RemoveItem('burger-bun', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-bun'], 'remove')
                Player.Functions.RemoveItem('burger-tomato', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-tomato'], 'remove')
            end
        end
	end
end)

-- Murder Meal
RegisterServerEvent('qb-burgershot:server:processBurger6', function(burger)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local fries = Player.Functions.GetItemByName('burger-fries')
    local drink = Player.Functions.GetItemByName('burger-heartstopper')
    local heartstopper = Player.Functions.GetItemByName('burger-softdrink')
    local burgerNumber = tonumber(burger)
    if not tonumber(burger) then return end
    if (fries ~= nil and drink ~= nil and heartstopper ~= nil and burgerNumber > 0) then
        if (fries.amount >= burgerNumber and drink.amount >= burgerNumber and heartstopper.amount >= burgerNumber) then
            TriggerClientEvent('qb-burgershot:client:processBurger6', src, burgerNumber)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the correct items', 'error')
    end
end)

RegisterServerEvent('qb-burgershot:server:makeBurger6', function(burgerNumber)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local fries = Player.Functions.GetItemByName('burger-fries')
    local drink = Player.Functions.GetItemByName('burger-heartstopper')
    local heartstopper = Player.Functions.GetItemByName('burger-softdrink')
    local burgerNumber = tonumber(burgerNumber)

	if Player.PlayerData.items ~= nil then 
        if (fries ~= nil and drink ~= nil and heartstopper ~= nil and burgerNumber > 0) then
            if (fries.amount >= burgerNumber and drink.amount >= burgerNumber and heartstopper.amount >= burgerNumber) then
                
                Player.Functions.AddItem('burger-murdermeal', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-murdermeal'], 'add')
                
                Player.Functions.RemoveItem('burger-fries', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-fries'], 'remove')
                
                Player.Functions.RemoveItem('burger-heartstopper', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-heartstopper'], 'remove')
                
                Player.Functions.RemoveItem('burger-softdrink', 1 * burgerNumber)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-softdrink'], 'remove')
            end
        end
	end
end)

RegisterServerEvent('qb-burgershort:server:MurderMeal', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local toyChance = math.random(1, 10)
    local toyChance2 = math.random(1, 10)
    local toyChance3 = math.random(1, 25)
    local toyChance4 = math.random(1, 50)
    local toyChance5 = math.random(1, 50)    
    local toyChance6 = math.random(1, 50)   
    local toyChance7 = math.random(1, 75)   
    local toyChance8 = math.random(1, 75)   
    local toyChance9 = math.random(1, 100)    
    local toyChance10 = math.random(1, 100)   
    local toyChance11 = math.random(1, 100)    
    local toyChance12 = math.random(1, 250)    
    local toyChance13 = math.random(1, 500)    
    local toyChance14 = math.random(1, 750)
    
    -- Give Murder Meal Food
    Player.Functions.AddItem('burger-fries', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['burger-fries'], 'add')
    Player.Functions.AddItem('burger-heartstopper', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['burger-heartstopper'], 'add')
    Player.Functions.AddItem('burger-softdrink', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['burger-softdrink'], 'add')

    Player.Functions.RemoveItem('burger-murdermeal', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', QBCore.Shared.Items['burger-murdermeal'], 'remove')
    
    
    if toyChance == 1 then
        Player.Functions.AddItem('bstoy1', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy1'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance2 == 1 then
        Player.Functions.AddItem('bstoy2', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy2'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance3 == 1 then
        Player.Functions.AddItem('bstoy3', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy3'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance4 == 1 then
        Player.Functions.AddItem('bstoy4', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy4'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance5 == 1 then
        Player.Functions.AddItem('bstoy5', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy5'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance6 == 1 then
        Player.Functions.AddItem('bstoy6', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy6'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance7 == 1 then
        Player.Functions.AddItem('bstoy7', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy7'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance8 == 1 then
        Player.Functions.AddItem('bstoy8', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy8'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance9 == 1 then
        Player.Functions.AddItem('bstoy9', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy9'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance10 == 1 then
        Player.Functions.AddItem('bstoy10', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy10'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance11 == 1 then
        Player.Functions.AddItem('bstoy11', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy11'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance12 == 1 then
        Player.Functions.AddItem('bstoy12', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy12'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance13 == 1 then
        Player.Functions.AddItem('bstoy13', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy13'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    elseif
        toyChance14 == 1 then
        Player.Functions.AddItem('bstoy14', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bstoy14'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'Wohooo, You got a toy!', 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You didn\'t get a toy this time', 'error', 2000)
    end
end)


QBCore.Functions.CreateUseableItem('burger-murdermeal', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-burgershot:MurderMeal', source, item.name)
end)