CreateThread(function ()
    SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
end)

--Better example
local lastped = nil

CreateThread(function ()
    while true do
        if PlayerPedId() ~= lastped then
            lastped = PlayerPedId()
            SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
        end
        Wait(100)
    end
end)