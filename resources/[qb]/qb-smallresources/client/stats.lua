local QBCore = exports['qb-core']:GetCoreObject()

-- Adds stats
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    -- StatSetInt(`MPPLY_KILLS_PLAYERS`, 1337, true) -- Kills
    -- StatSetInt(`MP0_SHOOTING_ABILITY`, 100, true) -- Shooting
    -- StatSetInt(`MP0_STEALTH_ABILITY`, 10, true) -- Stealth
    -- StatSetInt(`MP0_FLYING_ABILITY`, 5, true) -- Flying
    -- StatSetInt(`MP0_WHEELIE_ABILITY`, 25, true) -- Wheelies
    StatSetInt(`MP0_LUNG_CAPACITY`, 50, true) -- Underwater Swimming
    StatSetInt(`MP0_STRENGTH`, 25, true) -- Strength
    StatSetInt(`MP0_STAMINA`, 25, true) -- Stamina
end)

-- Removes Stats
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        -- StatSetInt(`MPPLY_KILLS_PLAYERS`, 1337, true) -- Kills
    -- StatSetInt(`MP0_SHOOTING_ABILITY`, 100, true) -- Shooting
    -- StatSetInt(`MP0_STEALTH_ABILITY`, 10, true) -- Stealth
    -- StatSetInt(`MP0_FLYING_ABILITY`, 5, true) -- Flying
    -- StatSetInt(`MP0_WHEELIE_ABILITY`, 25, true) -- Wheelies
    StatSetInt(`MP0_LUNG_CAPACITY`, 0, true) -- Underwater Swimming
    StatSetInt(`MP0_STRENGTH`, 0, true) -- Strength
    StatSetInt(`MP0_STAMINA`, 0, true) -- Stamina
end)