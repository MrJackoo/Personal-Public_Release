local QBCore = exports['qb-core']:GetCoreObject()
local washers = {
    [1] = {washing = false, pickup = false, cleaned = 0},
    [2] = {washing = false, pickup = false, cleaned = 0},
    [3] = {washing = false, pickup = false, cleaned = 0},
}

-- Callbacks
QBCore.Functions.CreateCallback("qb-moneywash:isWashing", function(source, cb, washerId)
    cb(washers[washerId].washing)
end)

QBCore.Functions.CreateCallback("qb-moneywash:isReady", function(source, cb, washerId)
    cb(washers[washerId].pickup)
end)

-- Functions
function GetWasherItems(washerId)
	local items = {}
    local stash = 'washer'..washerId
    local result = MySQL.Sync.fetchAll('SELECT items FROM stashitems WHERE stash = ?', {stash})
    Wait(500)
	if result[1] then 
		if result[1].items then
			result[1].items = json.decode(result[1].items)
			if result[1].items then 
				for k, item in pairs(result[1].items) do
					local itemInfo = QBCore.Shared.Items[item.name:lower()]
					items[item.slot] = {
						name = itemInfo["name"],
						amount = tonumber(item.amount),
						info = item.info ~= nil and item.info or "",
						label = itemInfo["label"],
						description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
						weight = itemInfo["weight"], 
						type = itemInfo["type"], 
						unique = itemInfo["unique"], 
						useable = itemInfo["useable"], 
						image = itemInfo["image"],
						slot = item.slot,
					}
				end
			end
		end
	end
	return items
end

function wash(washerId, source)
    local stash = 'washer'..washerId
    local items = GetWasherItems(washerId)
    local cleaned = 0
    local amount = tonumber(items.amount)
    
    for item, data in pairs(items) do 
        if data.name == "markedbills" then
            if data.info.worth ~= nil and data.amount ~= nil then
                --cleaned = cleaned + (500 * amount) -- This gives £500 per bag.
                cleaned = cleaned + (data.info.worth * data.amount)
            end
        end 
    end

    if cleaned > 0 then 
        washers[washerId].washing = true
        TriggerClientEvent('QBCore:Notify', source, "Your washing will be done in 60 minutes.", 'primary')
        local cleaned = math.round(cleaned * 0.9)
        Wait(180000 * 20)
        TriggerClientEvent('qb-moneywash:Notification', source)
        washers[washerId].cleaned = cleaned
        washers[washerId].pickup = true
        MySQL.Async.execute("UPDATE stashitems SET items = '[]' WHERE stash = ?", { stash })
    else 
        TriggerClientEvent('QBCore:Notify', source, "There is nothing to wash!", 'error')
    end
end

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- Events
RegisterServerEvent("qb-moneywash:startwasher", function(data)
    src = source
    if not washers[data.id].washing then
        wash(data.id, src)
    else 
        TriggerClientEvent('QBCore:Notify', src, "This washer is already started!", 'error')
    end
end)

RegisterServerEvent("qb-moneywash:collect", function(data)
    src = source
    local player = QBCore.Functions.GetPlayer(src)

    if washers[data.id].pickup then 
        if washers[data.id].cleaned > 0 then
            player.Functions.AddMoney("cash", washers[data.id].cleaned, "Money Washed")
            washers[data.id].cleaned = 0
            washers[data.id].pickup = false
            washers[data.id].washing = false
        else 
            TriggerClientEvent('QBCore:Notify', src, "There is no clean money to collect!", 'error')
            washers[data.id].cleaned = 0
            washers[data.id].pickup = false
            washers[data.id].washing = false
        end
    else 
        TriggerClientEvent('QBCore:Notify', src, "This washer is currently cleaning!", 'error')
    end
end)