RegisterNetEvent('qb-chopshop:StartMenu', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Chop Parts",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Door",
            txt = "",
            params = {
                event = "qb-chopshop:chopdoor",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Wheel",
            txt = "",
            params = {
                event = "qb-chopshop:chopwheel",
                args = {
                    number = 1,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Hood",
            txt = "",
            params = {
                event = "qb-chopshop:chophood",
                args = {
                    number = 1,
                    id = 4
                }
            }
        },
        {
            id = 5,
            header = "Trunk",
            txt = "",
            params = {
                event = "qb-chopshop:choptrunk",
                args = {
                    number = 1,
                    id = 5
                }
            }
        },
    })
end)

RegisterNetEvent('qb-chopshop:chopdoor')
AddEventHandler('qb-chopshop:chopdoor', function()
    TriggerEvent('qb-chopshop:doorchopanim')
end)

RegisterNetEvent('qb-chopshop:chopwheel')
AddEventHandler('qb-chopshop:chopwheel', function()
    TriggerEvent('qb-chopshop:wheelchopanim')
end)

RegisterNetEvent('qb-chopshop:chophood')
AddEventHandler('qb-chopshop:chophood', function()
    TriggerEvent('qb-chopshop:hoodchopanim')
end)

RegisterNetEvent('qb-chopshop:choptrunk')
AddEventHandler('qb-chopshop:choptrunk', function()
    TriggerEvent('qb-chopshop:trunkchopanim')
end)