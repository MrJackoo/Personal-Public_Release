onlinePlayers = {}

RegisterServerEvent('axiomid:add-id')
AddEventHandler('axiomid:add-id', function()
    TriggerClientEvent("axiomid:client:add-id", source, onlinePlayers)
    local topText = "undefined " .. Config.identifier
    local identifiers = GetPlayerIdentifiers(source)

    if Config.identifier == "steam" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'steam:') then
                topText = v
                break
            end
        end
    elseif Config.identifier == "steamv2" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'steam:') then
                topText = string.sub(v, 7)
                break
            end
        end
    elseif Config.identifier == "license" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'license:') then
                topText = v
                break
            end
        end
    elseif Config.identifier == "licensev2" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'license:') then
                topText = string.sub(v, 9)
                break
            end
        end
    elseif Config.identifier == "fivem" then 
        for k,v in ipairs(identifiers) do
            if string.match(v, 'fivem:') then
                topText = v
                break
            end
        end
    elseif Config.identifier == "name" then 
        topText = GetPlayerName(source)
    end
    
    onlinePlayers[tostring(source)] = topText
    TriggerClientEvent("axiomid:client:add-id", -1, topText, tostring(source))
end)

AddEventHandler('playerDropped', function(reason)
    onlinePlayers[tostring(source)] = nil
end)