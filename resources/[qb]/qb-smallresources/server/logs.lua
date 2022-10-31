local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = '',

    -- Anticheat
    ['bans'] = '',
    ['anticheat'] = '',

    -- Chat
    ['me'] = '',
    ['ooc'] = '',
    ['report'] = '',

    -- Deaths
    ['death'] = '',
    ['medical']= '',

    -- Inventory
    ['playerinventory'] = '',
    ['SetInventory'] = '',
    ['robbing'] = '',
    ['drop'] = '',
    ['trunk'] = '',
    ['stash'] = '',
    ['glovebox'] = '',

    -- Money
    ['banking'] = '',
    ['playermoney'] = '',
    ['shops'] = '',
    ['money'] = '',
    ['casino'] = '',

    -- Job
    ['jobpay'] = '',

    -- Players
    ['joinleave'] = '',
    ['chardel'] = '',

    -- Robberies
    ['storerobbery'] = '',
    ['bankrobbery'] = '',

    -- Staff
    ['staff'] = '',

    -- Police
    ['police'] = '',


    -- Vehicles
    ['vehicleshop'] = '',
    ['vehiclesales'] = '',
    ['vehicleupgrades'] = '',
    ['carboosting'] = ''

}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
    ["cyan"] = 5416892,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = '',
                ['icon_url'] = 'https://i.imgur.com/BG2Yczh.png',
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', content = '<@&>'}), { ['Content-Type'] = 'application/json' })
    end
end)
