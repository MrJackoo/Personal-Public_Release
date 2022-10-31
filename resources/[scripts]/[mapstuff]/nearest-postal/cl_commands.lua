-- optimizations
local ipairs = ipairs
local upper = string.upper
local format = string.format
local QBCore = exports['qb-core']:GetCoreObject()
-- end optimizations

---
--- [[ Nearest Postal Commands ]] ---
---

TriggerEvent('chat:addSuggestion', '/postal', 'Set the GPS to a specific postal',
             { { name = 'Postal Code', help = 'The postal code you would like to go to or delete to remove' } })

RegisterCommand('postal', function(_, args)
    if args[1] == "delete" then
        if pBlip then
            RemoveBlip(pBlip.hndl)
            pBlip = nil
            -- TriggerEvent('chat:addMessage', {
            --     color = { 255, 0, 0 },
            --     args = {
            --         'Postals',
            --         config.blip.deleteText
            --     }
            -- })
            QBCore.Functions.Notify(config.blip.deleteText, "primary", 3500)
        end
        return
    end

    if tonumber(args) then
        if pBlip then
            RemoveBlip(pBlip.hndl)
            pBlip = nil
            -- TriggerEvent('chat:addMessage', {
            --     color = { 255, 0, 0 },
            --     args = {
            --         'Postals',
            --         config.blip.deleteText
            --     }
            -- })
            QBCore.Functions.Notify(config.blip.deleteText, "primary", 3500)
        end
        return
    end

    if args == nil or args[1] == nil then return end

    local userPostal = upper(args[1])
    local foundPostal

    for _, p in ipairs(postals) do
        if upper(p.code) == userPostal then
            foundPostal = p
            break
        end
    end

    if foundPostal then
        if pBlip then RemoveBlip(pBlip.hndl) end
        local blip = AddBlipForCoord(foundPostal[1][1], foundPostal[1][2], 0.0)
        pBlip = { hndl = blip, p = foundPostal }
        SetBlipRoute(blip, true)
        SetBlipSprite(blip, config.blip.sprite)
        SetBlipColour(blip, config.blip.color)
        SetBlipRouteColour(blip, config.blip.color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(format(config.blip.blipText, pBlip.p.code))
        EndTextCommandSetBlipName(blip)

        -- TriggerEvent('chat:addMessage', {
        --     color = { 255, 0, 0 },
        --     args = {
        --         'Postals',
        --         format(config.blip.drawRouteText, foundPostal.code)
        --     }
        -- })
        QBCore.Functions.Notify("drawing a marker to postal "..foundPostal.code, "primary", 3500)
    else
        -- TriggerEvent('chat:addMessage', {
        --     color = { 255, 0, 0 },
        --     args = {
        --         'Postals',
        --         config.blip.notExistText
        --     }
        -- })
        QBCore.Functions.Notify(config.blip.notExistText, "error", 3500)
    end
end)

