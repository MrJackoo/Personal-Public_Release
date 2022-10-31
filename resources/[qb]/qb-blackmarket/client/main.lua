local QBCore = exports['qb-core']:GetCoreObject()

local setLocPick = math.random(1, #Config['LocationSets'])
local Locations = {
    ["coords"] = {
        [1] = {
            x = tonumber(Config['LocationSets'][setLocPick].x),
            y = tonumber(Config['LocationSets'][setLocPick].y),
            z = tonumber(Config['LocationSets'][setLocPick].z),
            w = tonumber(Config['LocationSets'][setLocPick].w),
        },
    },
}
local position = Locations["coords"]

for k, v in pairs(position) do
    TriggerServerEvent('Blackmarket:server:CreatePed', v.x, v.y, v.z, v.w) --- Ped Sync
end

-- Events
RegisterNetEvent('Blackmarket:client:CreatePed', function(x, y, z, w) --- Ped Sync
    if not DoesEntityExist(dealer) then
        RequestModel('g_m_m_chicold_01')
        while not HasModelLoaded('g_m_m_chicold_01') do
            Wait(10)
        end
        dealer = CreatePed(26, 'g_m_m_chicold_01', x, y, z - 1, true, false)
        SetEntityHeading(dealer, w)
        SetBlockingOfNonTemporaryEvents(dealer, true)
        TaskStartScenarioInPlace(dealer, 'WORLD_HUMAN_AA_SMOKE', 0, false)
        FreezeEntityPosition(dealer, true)
        SetEntityInvincible(dealer, true)
        exports["qb-target"]:AddBoxZone("marketped", vector3(x, y, z), 0.75, 0.75, {
            name = "marketped",
            heading = w,
            debugPoly = false,
            minZ = z - 1,
            maxZ = z + 1
        }, {
            options = {{
                type = "client",
                event = "qb-blackmarket:client:Homepage",
                icon = "fas fa-box",
                label = "View The Store!"
            }},
            distance = 1.5
        })
    end
end)

RegisterNetEvent('qb-blackmarket:client:Homepage', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "Blackmarket",
            txt = "The Assistant"
        },
        {
            header = "Buy Laptops",
			txt = "Useful for Hacking Bank Systems",
			params = {
                event = "qb-blackmarket:client:buy1page",
            }
        },
        {
            header = "Buy Electronics",
			txt = "Misc Electronic Items",
			params = {
                event = "qb-blackmarket:client:buy2page",
            }
        },
        {
            header = "Buy Practice Devices",
			txt = "Train your Hacking Skills",
			params = {
                event = "qb-blackmarket:client:buy3page",
            }
        },
        -- {
        --     header = "Buy Illicit Substances",
		-- 	txt = "Take that edge off",
		-- 	params = {
        --         event = "qb-blackmarket:client:buy4page",
        --     }
        -- },
        {
            header = "Close",
			txt = "",
			params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('qb-blackmarket:client:buy1page', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "Laptops",
            txt = "Loaded with the best hacking software"
        },
        {
            header = "Red Laptop",
			txt = "Purchase - 25 Qbits",
			params = {
                event = 'qb-blackmarket:client:buyLaptops',
                args = '1'
            }
        },
        {
            header = "Yellow Laptop",
			txt = "Purchase - 50 Qbits",
			params = {
                event = 'qb-blackmarket:client:buyLaptops',
                args = '2'
            }
        },
        {
            header = "Green Laptop",
			txt = "Purchase - 75 Qbits",
			params = {
                event = 'qb-blackmarket:client:buyLaptops',
                args = '3'
            }
        },
        {
            header = "Blue Laptop",
			txt = "Purchase - 100 Qbits",
			params = {
                event = 'qb-blackmarket:client:buyLaptops',
                args = '4'
            }
        },
        {
            header = "Home Page",
			txt = "Back to main menu",
			params = {
                event = "qb-blackmarket:client:Homepage",
            }
        },
    })
end)

RegisterNetEvent('qb-blackmarket:client:buy2page', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "Electronics",
            txt = "Gadgets"
        },
        {
            header = "Hacker Device",
			txt = "Purchase - 25 Qbits",
			params = {
                event = "qb-blackmarket:client:buyElectronics",
                args = '1'
            }
        },
        {
            header = "Home Page",
			txt = "Back to main menu",
			params = {
                event = "qb-blackmarket:client:Homepage",
            }
        },
    })
end)

RegisterNetEvent('qb-blackmarket:client:buy3page', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "Practice Devices",
            txt = "Improve your Hacking Skills"
        },
        {
            header = "Practice Device Mk1",
			txt = "Beginner Hacking",
			params = {
                event = "qb-blackmarket:client:buyPractice",
                args = '1'
            }
        },
        {
            header = "Practice Device Mk2",
			txt = "Novice Hacking",
			params = {
                event = "qb-blackmarket:client:buyPractice",
                args = '2'
            }
        },
        {
            header = "Practice Device Mk3",
			txt = "Advanced Hacking",
			params = {
                event = "qb-blackmarket:client:buyPractice",
                args = '3'
            }
        },
        {
            header = "Practice Device Mk4",
			txt = "Expert Hacking",
			params = {
                event = "qb-blackmarket:client:buyPractice",
                args = '4'
            }
        },
        {
            header = "Home Page",
			txt = "Back to main menu",
			params = {
                event = "qb-blackmarket:client:Homepage",
            }
        },
    })
end)

RegisterNetEvent('qb-blackmarket:client:buy4page', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "Blackmarket Drugs",
            txt = "Take the Edge Off"
        },
        {
            header = "Oxy 50mg (25)",
			txt = "Prescription Oxy",
			params = {
                event = "qb-blackmarket:client:buyDrugs",
                args = '1'
            }
        },
    })
end)

RegisterNetEvent('qb-blackmarket:client:buyLaptops', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent("qb-blackmarket:server:buyLaptops", 'laptop1')
    elseif args == 2 then 
        TriggerServerEvent("qb-blackmarket:server:buyLaptops", 'laptop2')
    elseif args == 3 then 
        TriggerServerEvent("qb-blackmarket:server:buyLaptops", 'laptop3')
    elseif args == 4 then 
        TriggerServerEvent("qb-blackmarket:server:buyLaptops", 'laptop4')
    end
end)

RegisterNetEvent('qb-blackmarket:client:buyElectronics', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent("qb-blackmarket:server:buyElectronics", 'hackerdevice')
    elseif args == 2 then 
        TriggerServerEvent("qb-blackmarket:server:buyElectronics", 'advancedscrewdriver')
    end
end)

RegisterNetEvent('qb-blackmarket:client:buyPractice', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent("qb-blackmarket:server:buyPractice", 'practicemk1')
    elseif args == 2 then 
        TriggerServerEvent("qb-blackmarket:server:buyPractice", 'practicemk2')
    elseif args == 3 then 
        TriggerServerEvent("qb-blackmarket:server:buyPractice", 'practicemk3')
    elseif args == 4 then 
        TriggerServerEvent("qb-blackmarket:server:buyPractice", 'practicemk4')
    end
end)

RegisterNetEvent('qb-blackmarket:client:buyDrugs', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent("qb-blackmarket:server:buyDrugs", 'oxy')
    end
end)
