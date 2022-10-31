local objects = {
    {x = 266.09, y = -349.35, z = 44.74, model = "prop_sec_barier_02b"},
    {x = 285.28, y = -355.78, z = 45.13, model = "prop_sec_barier_02a"},

    -- Casino Tables
    {x = 1036.43, y = 51.77, z = 69.06, model = "vw_prop_casino_blckjack_01"},
    {x = 1044.12, y = 53.47, z = 69.06, model = "vw_prop_casino_blckjack_01"}, 
    {x = 1043.52, y = 56.33, z = 69.06, model = "vw_prop_casino_blckjack_01"}, 
    {x = 1038.22, y = 55.68, z = 69.06, model = "vw_prop_casino_blckjack_01"},
    {x = 1025.9, y = 61.5, z = 69.87, model = "vw_prop_casino_blckjack_01b"},
    {x = 1030.79, y = 40.68, z = 69.87, model = "vw_prop_casino_blckjack_01b"},
}

CreateThread(function()
    while true do
        for k in pairs(objects) do
            local ent = GetClosestObjectOfType(objects[k].x, objects[k].y, objects[k].z, 2.0, GetHashKey(objects[k].model), false, false, false)

            SetEntityAsMissionEntity(ent, 1, 1)
            DeleteObject(ent)
            SetEntityAsNoLongerNeeded(ent)
        end

        Wait(5000)
    end
end)
