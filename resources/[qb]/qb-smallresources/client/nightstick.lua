--[[
    Local ragdoll mechanic for some dumb shit
]]--


CreateThread(function()
    while true do
        Wait(50)
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)

        if weapon == GetHashKey(("WEAPON_NIGHTSTICK")) then
            SetWeaponDamageModifier("WEAPON_NIGHTSTICK", 0.02)
        end
        ClearPedLastWeaponDamage(ped)


        ClearEntityLastWeaponDamage(ped)
        if HasEntityBeenDamagedByWeapon(ped, GetHashKey("WEAPON_NIGHTSTICK"), 0) then
            SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
            Wait(0)
        end
    end
end)