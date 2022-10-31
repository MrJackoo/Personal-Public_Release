QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}
local quantity = 1
local NPC

-- Functions
local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Events
RegisterNetEvent('qb-sales:client:salesmenu' ,function()
    local Shop = {
        {
        header = "Sales",
        isMenuHeader = true
        },
    }
    for k, v in pairs(Config.SellItems) do
        Shop[#Shop+1] = {
            header = QBCore.Shared.Items[v.name].label,
            txt = "Purchase Price £" ..v.minprice.." - £"..v.maxprice.."",
            params = {
            event = "qb-sales:client:sales",
            args = {
                name = v.name,
                sellmin = v.minprice,
                sellmax = v.maxprice
                }
            }
        }
    end
    Shop[#Shop+1] = {
        header = "Close Shop",
			params = {
				event = "qb-menu:client:closeMenu",
			}
    }
    exports['qb-menu']:openMenu(Shop)
end)


RegisterNetEvent('qb-sales:client:sales' ,function(data)
    local name = data.name
    local sellmin = data.sellmin
    local sellmax = data.sellmax
    local quantity = exports['qb-input']:ShowInput({
        header = "Enter Quantity",
        submitText = "Confirm",
        inputs = {
            {
                text = "Quantity",
                name = "charge",
                type = "number",
                isRequired = true
            }
        }
    })
    if not quantity.charge then return
        elseif tonumber(quantity["charge"]) > 0 then
            quantity = tonumber(quantity["charge"])
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    TriggerServerEvent('qb-sales:server:sales', name, sellmin, sellmax, quantity)
                else
                    QBCore.Functions.Notify('You don\'t have that many items to sell', 'error', 2500)
            end
        end, name, quantity)
    else
        TriggerEvent('qb-sales:client:salesmenu')
    end
end)

-- Threads
-- CreateThread(function()
--     local blip1 = AddBlipForCoord(462.14, -778.61, 27.36)
--     SetBlipSprite(blip1, 120)
-- 	SetBlipDisplay(blip1, 4)
-- 	SetBlipScale(blip1, 0.7)
-- 	SetBlipAsShortRange(blip1, true)
-- 	SetBlipColour(blip1, 0)
-- 	BeginTextCommandSetBlipName("STRING")
-- 	AddTextComponentSubstringPlayerName("Sales Broker")
--     EndTextCommandSetBlipName(blip1)
-- end)

CreateThread(function()
    local alreadyEnteredZone = false
    while true do
    wait = 10
    local PlayerPed = PlayerPedId()
    local PlayerPos = GetEntityCoords(PlayerPed)
    local inZone = false
    for k, v in pairs(Config.Locations["salespeds"]) do
        local dist = #(PlayerPos - vector3(v.x, v.y, v.z))
        if dist <= 2.0 then
        wait = 10
        inZone  = true
        if IsControlJustReleased(0, 38) then
            TriggerEvent('qb-sales:client:salesmenu')
            exports['qb-core']:KeyPressed()
        end
            break
        else
            wait = 2000
        end
    end
    if inZone and not alreadyEnteredZone then
        alreadyEnteredZone = true
        exports['qb-core']:DrawText('[E] Sales Shop', 'left')
    end
    if not inZone and alreadyEnteredZone then
        alreadyEnteredZone = false
        exports["qb-core"]:HideText()
    end
        Wait(wait)
    end
end)

