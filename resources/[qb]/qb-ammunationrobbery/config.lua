Config = {}

Config.RequiredCops = 4

Config.Locations = {
    ["takeables"] = {
        -- Adams Apple/Elgin Ave
        [1] = {
            coords = vector3(16.64, -1108.25, 29.8),
            name = "Adams Apple Counter",
            width = 2.35,
            length = 1,
            heading = 250,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = math.random(1,3),
                    item = 'grip_pistol',
                    rare = false
                },
                [2] = {
                    amount = math.random(1,3),
                    item = 'pistol_ammoboxlarge',
                    rare = false
                },
                [3] = {
                    amount = math.random(1,3),
                    item = 'shotgun_ammoboxlarge',
                    rare = false
                },
                [4] = {
                    amount = 1,
                    item = 'pistol_extendedclip',
                    rare = true
                },
            },
        },
        [2] = {
            coords = vector3(19.92, -1107.68, 29.8),
            name = "Adams Apple Counter 2",
            width = 2.35,
            length = 1,
            heading = 340,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = 1,
                    item = 'heavypistol_extendedclip',
                    rare = true
                },
                [2] = {
                    amount = 1,
                    item = 'pistol_suppressor',
                    rare = true
                },
                [3] = {
                    amount = 1,
                    item = 'pistol_ammobox',
                    rare = false
                },
                -- [3] = {
                --     amount = math.random(1,3),
                --     item = 'boostinglaptop',
                --     rare = true
                -- }, 
            },
        },
        [3] = {
            coords = vector3(7.2, -1109.78, 29.8),
            name = "Adams Apple Case 1",
            width = 1,
            length = 1,
            heading = 339,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = math.random(1,3),
                    item = 'weapon_flare',
                    rare = false
                },
                [2] = {
                    amount = math.random(1,3),
                    item = 'weapon_flare',
                    rare = false
                },
            },
        },
        [4] = {
            coords = vector3(8.63, -1106.76, 29.8),
            name = "Adams Apple Case 2",
            width = 1,
            length = 1,
            heading = 339,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = 1,
                    item = 'weapon_dagger',
                    rare = true,
                },
                [2] = {
                    amount = 1,
                    item = 'weapon_knife',
                    rare = true
                },
                [3] = {
                    amount = 1,
                    item = 'weapon_poolcue',
                    rare = false
                },
                [4] = {
                    amount = math.random(1,3),
                    item = 'weapon_smokegrenade',
                    rare = false
                },
            },
        },
        [5] = {
            coords = vector3(8.98, -1105.8, 29.8),
            name = "Adams Apple Case 3",
            width = 1,
            length = 1,
            heading = 340,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = math.random(1,5),
                    item = 'pistol_ammoboxlarge',
                    rare = false,
                },
                -- [2] = {
                --     amount = math.random(1,3),
                --     item = 'boostinglaptop',
                --     rare = true
                -- }, 
            },
        },
        [6] = {
            coords = vector3(14.5, -1112.56, 29.8),
            name = "Adams Apple Case 4",
            width = 1,
            length = 1,
            heading = 340,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = math.random(1,3),
                    item = 'pistol_ammoboxlarge',
                    rare = false,
                },
            },
        },
        -- Wall Mounts
        [7] = {
            coords = vector3(3.2, -1107.14, 31),
            name = "Adams Apple Wall Mount 1",
            width = 1,
            length = 1,
            heading = 340,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = 1,
                    item = 'weapon_vintagepistol',
                    rare = true,
                },
                [2] = {
                    amount = math.random(1,3),
                    item = 'pistol_ammobox',
                    rare = false,
                },
                -- [3] = {
                --     amount = math.random(1,3),
                --     item = 'boostinglaptop',
                --     rare = true
                -- }, 
            },
        },
        [8] = {
            coords = vector3(3.95, -1105.96, 31),
            name = "Adams Apple Wall Mount 2",
            width = 1,
            length = 1,
            heading = 340,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = math.random(1,3),
                    item = 'lockpick',
                    rare = false
                },
            },
        },
        [9] = {
            coords = vector3(4.51, -1104.67, 31),
            name = "Adams Apple Wall Mount 3",
            width = 1,
            length = 1,
            heading = 340,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = math.random(1,3),
                    item = 'heavyarmor',
                    rare = false
                },
            },
        },
        [10] = {
            coords = vector3(4.76, -1103.23, 31),
            name = "Adams Apple Wall Mount 4",
            width = 1,
            length = 1,
            heading = 340,
            debug = false,
            isDone = false,
            isBusy = false,
            reward =  {
                [1] = {
                    amount = 1,
                    item = 'heavydrill',
                    rare = true
                },
                [1] = {
                    amount = 1,
                    item = 'pistol_ammobox',
                    rare = false
                },
            },
        },
    },
}

Config.MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true,
}

Config.FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
}