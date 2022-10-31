-- local density = {
--     ['parked'] = 0.6,
--     ['vehicle'] = 0.6,
--     ['multiplier'] = 0.8,
--     ['peds'] = 0.8,
--     ['scenario'] = 0.8,
-- }

-- CreateThread(function()
-- 	while true do
-- 		SetParkedVehicleDensityMultiplierThisFrame(density['parked'])
-- 		SetVehicleDensityMultiplierThisFrame(density['vehicle'])
-- 		SetRandomVehicleDensityMultiplierThisFrame(density['multiplier'])
-- 		SetPedDensityMultiplierThisFrame(density['peds'])
-- 		SetScenarioPedDensityMultiplierThisFrame(density['scenario'], density['scenario']) -- Walking NPC Density
-- 		Wait(0)
-- 	end
-- end)

-- function DecorSet(Type, Value)
--     if Type == 'parked' then
--         density['parked'] = Value
--     elseif Type == 'vehicle' then
--         density['vehicle'] = Value
--     elseif Type == 'multiplier' then
--         density['multiplier'] = Value
--     elseif Type == 'peds' then
--         density['peds'] = Value
--     elseif Type == 'scenario' then
--         density['scenario'] = Value
--     end
-- end

-- exports('DecorSet', DecorSet)

local defaultDensity = 0.5
local parkeddensity = 0.3
local PlayerCount = 0
local PlayerCoords = nil

local zonename = "UNDEFINED"

local densityzones = {
    {
        name = "MRPD Zone",
        coords = vector3(419.36, -986.87, 29.38),
        radius = 125,
        density = 0.2,
        parked_density = 0.2,
    },
    {
        name = "Pillbox Zone",
        coords = vector3(300.74, -585.18, 43.28),
        radius = 125,
        density = 0.2,
        parked_density = 0.2,
    },

    {
        name = "Legion Zone",
        coords = vector3(181.78, -921.96, 30.69),
        radius = 125,
        density = 0.2,
        parked_density = 0.2,
    },
}


CreateThread(function()
    while not PlayerCoords do
		Wait(1000)
	end

    while true do 
        Wait(0)
        for k,v in pairs(densityzones) do
            if #(PlayerCoords - v.coords) <= v.radius then
                zonename = v.name
                defaultDensity = v.density
                if v.parked_density then
                    parkeddensity = v.parked_density
                else
                    parkeddensity = defaultDensity
                end
                break
            else
                zonename = "External Density Area"
                if PlayerCount <= 10 then
                    defaultDensity = 0.6
                end
            end
        end

        SetParkedVehicleDensityMultiplierThisFrame(parkeddensity)
		SetVehicleDensityMultiplierThisFrame(defaultDensity)
		SetRandomVehicleDensityMultiplierThisFrame(defaultDensity)
		SetPedDensityMultiplierThisFrame(defaultDensity)
		SetScenarioPedDensityMultiplierThisFrame(defaultDensity, defaultDensity) -- Walking NPC Density
    end

end)

CreateThread(function()
	while true do
		Wait(2000)
		PlayerCount = TableInfo(GetActivePlayers())
		PlayerCoords = GetEntityCoords(PlayerPedId())
	end
end)

function TableInfo(data)
    local count = 0
    for k in pairs(data) do
        count = count + 1
    end
    return count
end

RegisterNetEvent("density:checkme")
AddEventHandler("density:checkme",function()
    TriggerEvent("QBCore:Notify", "The current Zone is: ".. zonename, "primary")
    TriggerEvent("QBCore:Notify", "The Playercount is: ".. PlayerCount, "primary")
    TriggerEvent("QBCore:Notify", "The current Density is: ".. defaultDensity, "primary")
end)