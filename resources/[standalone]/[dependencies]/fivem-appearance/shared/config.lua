Config = {}

Config.Debug = false

Config.ClothingCost = 250
Config.BarberCost = 250
Config.TattooCost = 500
Config.SurgeonCost = 25000

Config.UseTarget = GetConvar("UseTarget", "false") == "false"
Config.UseRadialMenu = false

Config.EnablePedsForShops = false
Config.EnablePedsForClothingRooms = false
Config.EnablePedsForPlayerOutfitRooms = false

Config.EnablePedMenu = true
Config.PedMenuGroup = "admin"

Config.NewCharacterSections = {
    Ped = false,
    HeadBlend = true,
    FaceFeatures = true,
    HeadOverlays = true,
    Components = true,
    Props = true,
    Tattoos = true
}

Config.AlwaysKeepProps = true

Config.PersistUniforms = true -- Keeps Job / Gang Outfits on player reconnects / logout

Config.OnDutyOnlyClothingRooms = false -- Set to `true` to make the clothing rooms accessible only to players who are On Duty

Config.ReloadSkinCooldown = 5000

-- ACE Permissions Config
Config.EnableACEPermissions = false
Config.ACEResetCooldown = 5000
Config.ACEListCooldown = 60 * 60 * 1000 -- 1 Hour

Config.DisableComponents = {
    Masks = false,
    UpperBody = false,
    LowerBody = false,
    Bags = false,
    Shoes = false,
    ScarfAndChains = false,
    BodyArmor = false,
    Shirts = false,
    Decals = false,
    Jackets = false
}

Config.DisableProps = {
    Hats = false,
    Glasses = false,
    Ear = false,
    Watches = false,
    Bracelets = false
}

Config.Blips = {
    ["clothing"] = {
        Show = true,
        Sprite = 366,
        Color = 47,
        Scale = 0.7,
        Name = "Clothing Store",
    },
    ["barber"] = {
        Show = true,
        Sprite = 71,
        Color = 0,
        Scale = 0.7,
        Name = "Barber",
    },
    ["tattoo"] = {
        Show = true,
        Sprite = 75,
        Color = 4,
        Scale = 0.7,
        Name = "Tattoo Shop",
    },
    ["surgeon"] = {
        Show = false,
        Sprite = 102,
        Color = 4,
        Scale = 0.7,
        Name = "Plastic Surgeon",
    }
}

Config.TargetConfig = {
    ["clothing"] = {
        model = "s_f_m_shop_high",
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        icon = "fas fa-tshirt",
        label = "Open Clothing Store",
        distance = 3
    },
    ["barber"] = {
        model = "s_m_m_hairdress_01",
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        icon = "fas fa-scissors",
        label = "Open Barber Shop",
        distance = 3
    },
    ["tattoo"] = {
        model = "u_m_y_tattoo_01",
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        icon = "fas fa-pen",
        label = "Open Tattoo Shop",
        distance = 3
    },
    ["surgeon"] = {
        model = "s_m_m_doctor_01",
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        icon = "fas fa-scalpel",
        label = "Open Surgeon",
        distance = 3
    },
    ["clothingroom"] = {
        model = "mp_g_m_pros_01",
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        icon = "fas fa-sign-in-alt",
        label = "Open Job / Gang Clothes Menu",
        distance = 3
    },
    ["playeroutfitroom"] = {
        model = "mp_g_m_pros_01",
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        icon = "fas fa-sign-in-alt",
        label = "Open Outfits Menu",
        distance = 3
    },
}

Config.Stores = {
    {
        shopType = "clothing",
        coords = vector4(1693.2, 4828.11, 42.07, 188.66),
        width = 4,
        length = 4,
        showBlip = true, -- showBlip overrides the blip visibilty configured above for the group
        zone = {
            shape = {
                vector2(1686.9018554688, 4829.8330078125),
                vector2(1698.8566894531, 4831.4604492188),
                vector2(1700.2448730469, 4817.7734375),
                vector2(1688.3682861328, 4816.2954101562)
            },
            minZ = 42.07 - 1.5,
            maxZ = 42.07 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-705.5, -149.22, 37.42, 122),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-719.86212158203, -147.83151245117),
                vector2(-709.10491943359, -141.53076171875),
                vector2(-699.94342041016, -157.44494628906),
                vector2(-710.68774414062, -163.64665222168)
            },
            minZ = 37.42 - 1.5,
            maxZ = 37.42 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-1192.61, -768.4, 17.32, 216.6),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-1206.9552001953, -775.06304931641),
                vector2(-1190.6080322266, -764.03198242188),
                vector2(-1184.5672607422, -772.16949462891),
                vector2(-1199.24609375, -783.07928466797)
            },
            minZ = 17.32 - 1.5,
            maxZ = 17.32 + 1.5,
        }
    },

    {
        shopType = "clothing",
        coords = vector4(425.91, -801.03, 29.49, 177.79),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(419.55020141602, -798.36547851562),
                vector2(431.61773681641, -798.31909179688),
                vector2(431.19784545898, -812.07122802734),
                vector2(419.140625, -812.03594970703)
            },
            minZ = 29.49 - 1.5,
            maxZ = 29.49 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-168.73, -301.41, 39.73, 238.67),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-160.82145690918, -313.85919189453),
                vector2(-172.56513977051, -309.82858276367),
                vector2(-166.5775604248, -292.48077392578),
                vector2(-154.84906005859, -296.51647949219)
            },
            minZ = 39.73 - 1.5,
            maxZ = 39.73 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(75.39, -1398.28, 29.38, 6.73),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(81.406135559082, -1400.7791748047),
                vector2(69.335029602051, -1400.8251953125),
                vector2(69.754981994629, -1387.078125),
                vector2(81.500122070312, -1387.3002929688)
            },
            minZ = 29.38 - 1.5,
            maxZ = 29.38 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-827.39, -1075.93, 11.33, 294.31),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-826.26251220703, -1082.6293945312),
                vector2(-832.27856445312, -1072.2819824219),
                vector2(-820.16442871094, -1065.7727050781),
                vector2(-814.08953857422, -1076.1878662109)
            },
            minZ = 11.33 - 1.5,
            maxZ = 11.33 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-1445.86, -240.78, 49.82, 36.17),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-1448.4829101562, -226.39401245117),
                vector2(-1439.2475585938, -234.70428466797),
                vector2(-1451.5389404297, -248.33193969727),
                vector2(-1460.7554931641, -240.02815246582)
            },
            minZ = 49.82 - 1.5,
            maxZ = 49.82 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(9.22, 6515.74, 31.88, 131.27),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(6.4955291748047, 6522.205078125),
                vector2(14.737417221069, 6513.3872070312),
                vector2(4.3691010475159, 6504.3452148438),
                vector2(-3.5187695026398, 6513.1538085938)
            },
            minZ = 31.88 - 1.5,
            maxZ = 31.88 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(615.35, 2762.72, 42.09, 170.51),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(612.58312988281, 2747.2814941406),
                vector2(612.26214599609, 2767.0520019531),
                vector2(622.37548828125, 2767.7614746094),
                vector2(623.66833496094, 2749.5180664062)
            },
            minZ = 42.09 - 1.5,
            maxZ = 42.09 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(1191.61, 2710.91, 38.22, 269.96),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(1188.7923583984, 2704.2021484375),
                vector2(1188.7498779297, 2716.2661132812),
                vector2(1202.4979248047, 2715.8479003906),
                vector2(1202.3558349609, 2703.9294433594)
            },
            minZ = 38.22 - 1.5,
            maxZ = 38.22 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-3171.32, 1043.56, 20.86, 334.3),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-3162.0075683594, 1056.7303466797),
                vector2(-3170.8247070312, 1039.0412597656),
                vector2(-3180.0979003906, 1043.1201171875),
                vector2(-3172.7292480469, 1059.8623046875)
            },
            minZ = 20.86 - 1.5,
            maxZ = 20.86 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-1105.52, 2707.79, 19.11, 317.19),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-1103.3004150391, 2700.8195800781),
                vector2(-1111.3771972656, 2709.884765625),
                vector2(-1100.8548583984, 2718.638671875),
                vector2(-1093.1976318359, 2709.7365722656)
            },
            minZ = 19.11 - 1.5,
            maxZ = 19.11 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-1207.65, -1456.89, 4.37, 38.59),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-1205.6013183594, -1458.033203125),
                vector2(-1206.1661376953, -1458.4085693359),
                vector2(-1207.8792724609, -1459.1596679688),
                vector2(-1207.5522460938, -1457.9649658203),
                vector2(-1206.0816650391, -1457.181640625)
            },
            minZ = 4.37 - 1.5,
            maxZ = 4.37 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(124.82, -224.36, 54.56, 335.41),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(133.60948181152, -210.31390380859),
                vector2(125.8349609375, -228.48097229004),
                vector2(116.3140335083, -225.02020263672),
                vector2(122.56930541992, -207.83396911621)
            },
            minZ = 54.56 - 1.5,
            maxZ = 54.56 + 1.5,
        }
    },
    {
        shopType = "clothing",
        coords = vector4(-1433.27, -449.52, 35.91, 270.28),
        width = 4,
        length = 4,
        zone = {
            shape = {
                vector2(-1431.73, -448.61390380859),
                vector2(-1432.52, -450.88097229004),
                --vector2(116.3140335083, -225.02020263672),
                --vector2(122.56930541992, -207.83396911621)
            },
            minZ = 54.56 - 1.5,
            maxZ = 54.56 + 1.5,
        }
    },
    {
        shopType = "barber",
        coords = vector4(-814.22, -183.7, 37.57, 116.91),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(-825.06127929688, -182.67497253418),
                vector2(-808.82415771484, -179.19134521484),
                vector2(-808.55261230469, -184.9720916748),
                vector2(-819.77899169922, -191.81831359863)
            },
            minZ = 37.57 - 1.5,
            maxZ = 37.57 + 1.5,
        }
    },
    {
        shopType = "barber",
        coords = vector4(136.78, -1708.4, 29.29, 144.19),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(132.57008361816, -1710.5053710938),
                vector2(138.77899169922, -1702.6778564453),
                vector2(142.73052978516, -1705.6853027344),
                vector2(135.49719238281, -1712.9750976562)
            },
            minZ = 29.29 - 1.5,
            maxZ = 29.29 + 1.5,
        }
    },
    {
        shopType = "barber",
        coords = vector4(-1282.57, -1116.84, 6.99, 89.25),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(-1287.4735107422, -1115.4364013672),
                vector2(-1277.5638427734, -1115.1229248047),
                vector2(-1277.2469482422, -1120.1147460938),
                vector2(-1287.4561767578, -1119.2506103516)
            },
            minZ = 6.9 - 1.5,
            maxZ = 6.9 + 1.5,
        }
    },
    {
        shopType = "barber",
        coords = vector4(1931.41, 3729.73, 32.84, 212.08),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(1932.4931640625, 3725.3374023438),
                vector2(1927.2720947266, 3733.7663574219),
                vector2(1931.4379882812, 3736.5327148438),
                vector2(1936.0697021484, 3727.2839355469)
            },
            minZ = 32.8 - 1.5,
            maxZ = 32.8 + 1.5,
        }
    },
    {
        shopType = "barber",
        coords = vector4(1212.8, -472.9, 65.2, 60.94),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(1208.3327636719, -469.84338378906),
                vector2(1217.9066162109, -472.40216064453),
                vector2(1216.9870605469, -477.00939941406),
                vector2(1206.1077880859, -473.83499145508)
            },
            minZ = 65.2 - 1.5,
            maxZ = 65.2 + 1.5,
        }
    },
    {
        shopType = "barber",
        coords = vector4(-32.9, -152.3, 56.1, 335.22),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(-29.730783462524, -148.67495727539),
                vector2(-32.919719696045, -158.04254150391),
                vector2(-37.612594604492, -156.62759399414),
                vector2(-33.30192565918, -147.31649780273)
            },
            minZ = 56.1 - 1.5,
            maxZ = 56.1 + 1.5,
        }
    },
    {
        shopType = "barber",
        coords = vector4(-278.1, 6228.5, 30.7, 49.32),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(-280.29818725586, 6232.7265625),
                vector2(-273.06427001953, 6225.9692382812),
                vector2(-276.25280761719, 6222.4013671875),
                vector2(-282.98211669922, 6230.015625)
            },
            minZ = 30.7 - 1.5,
            maxZ = 30.7 + 1.5,
        }
    },
    {
        shopType = "tattoo",
        coords = vector4(1322.6, -1651.9, 51.2, 42.47),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(1323.9360351562, -1649.2370605469),
                vector2(1328.0186767578, -1654.3087158203),
                vector2(1322.5780029297, -1657.7045898438),
                vector2(1319.2043457031, -1653.0885009766)
            },
            minZ = 51.2 - 1.5,
            maxZ = 51.2 + 1.5,
        }
    },
    {
        shopType = "tattoo",
        coords = vector4(-1154.01, -1425.31, 4.95, 23.21),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(-1152.7110595703, -1422.8382568359),
                vector2(-1149.0043945312, -1428.1975097656),
                vector2(-1154.6730957031, -1431.1898193359),
                vector2(-1157.7064208984, -1426.3433837891)
            },
            minZ = 4.95 - 1.5,
            maxZ = 4.95 + 1.5,
        }
    },
    {
        shopType = "tattoo",
        coords = vector4(322.62, 180.34, 103.59, 156.2),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(319.28741455078, 179.9383392334),
                vector2(321.537109375, 186.04516601562),
                vector2(327.24526977539, 183.12303161621),
                vector2(325.01351928711, 177.8542175293)
            },
            minZ = 103.5 - 1.5,
            maxZ = 103.5 + 1.5,
        }
    },
    {
        shopType = "tattoo",
        coords = vector4(-3169.52, 1074.86, 20.83, 253.29),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(-3169.5861816406, 1072.3740234375),
                vector2(-3175.4802246094, 1075.0703125),
                vector2(-3172.2041015625, 1080.5860595703),
                vector2(-3167.076171875, 1078.0391845703)
            },
            minZ = 20.83 - 1.5,
            maxZ = 20.83 + 1.5,
        }
    },
    {
        shopType = "tattoo",
        coords = vector4(1864.1, 3747.91, 33.03, 17.23),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(1860.2752685547, 3750.1608886719),
                vector2(1866.390625, 3752.8081054688),
                vector2(1868.6164550781, 3747.3562011719),
                vector2(1863.65234375, 3744.5034179688)
            },
            minZ = 33.03 - 1.5,
            maxZ = 33.03 + 1.5,
        }
    },
    {
        shopType = "tattoo",
        coords = vector4(-294.24, 6200.12, 31.49, 195.72),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(-289.42239379883, 6198.68359375),
                vector2(-294.69515991211, 6194.5366210938),
                vector2(-298.23013305664, 6199.2451171875),
                vector2(-294.1501159668, 6203.2700195312)
            },
            minZ = 31.49 - 1.5,
            maxZ = 31.49 + 1.5,
        }
    },
    --[[{
        shopType = "surgeon",
        coords = vector4(298.78, -572.81, 43.26, 114.27),
        width = 2,
        length = 2,
        zone = {
            shape = {
                vector2(298.84417724609, -572.92205810547),
                vector2(296.39556884766, -575.65942382812),
                vector2(293.56317138672, -572.60675048828),
                vector2(296.28656005859, -570.330078125)
            },
            minZ = 43.26 - 1.5,
            maxZ = 43.26 + 1.5,
        }
    }]]--
}

Config.ClothingRooms = {
    {
        job = "police",
        coords = vector3(462.04, -996.02, 30.69),
        width = 3,
        length = 3,
        zone = {
            shape = {
                vector2(460.41918945312, -993.11444091797),
                vector2(449.39508056641, -993.60614013672),
                vector2(449.88696289062, -990.23779296875),
                vector2(450.97882080078, -989.71411132812),
                vector2(451.0325012207, -987.89904785156),
                vector2(453.47863769531, -987.76928710938),
                vector2(454.35513305664, -988.46459960938),
                vector2(460.4231262207, -987.94573974609)
            },
            minZ = 28.49,
            maxZ = 32.49,
        }
    },
    {
        job = "cardealer",
        coords = vector3(153.83, -3011.36, 7.04),
        width = 1.25,
        length = 2,
        zone = {
            shape = {
                vector2(154.21995544434, -3009.9587402344),
                vector2(151.63647460938, -3009.4938964844),
                vector2(152.32452392578, -3015.0659179688),
                vector2(154.20715332031, -3015.0659179688)
            },
            minZ = 7.04,
            maxZ = 7.48,
        }
    },
    {
        job = "ambulance",
        coords = vector4(300.34, -598.94, 43.28, 339),
        width = 4,
        length = 3,
        zone = {
            shape = {
                -- vector2(154.21995544434, -3009.9587402344),
                -- vector2(151.63647460938, -3009.4938964844),
                -- vector2(152.32452392578, -3015.0659179688),
                -- vector2(154.20715332031, -3015.0659179688)
                vector2(302.9, -597.88),
                vector2(301.94, -601.15),
                vector2(298.17, -599.44),
                vector2(298.84, -596.45)
            },
            minZ = 43.28 - 1,
            maxZ = 43.28 + 1,
        }
    },
}


Config.PlayerOutfitRooms = {
    -- Sample outfit room config
--[[
    {
        coords = vector4(287.28, -573.41, 43.16, 79.61),
        width = 3,
        length = 3,
        citizenIDs = {
            "BHH65156",
        }
    },
    ]]--
}

Config.Outfits = {
    ["police"] = { -- Police Clothing
        ["male"] = {
            {
                outfitLabel = "Patrol Uniform (Short Sleeve)",
                order = "1",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 71, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 417, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 173, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Firearms Uniform - AFO",
                order = "2",
                outfitData = {
                    ["pants"] = {item = 149, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 195, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 74, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 424, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 163, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 177, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 210, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 135, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = "firearms",
                    flagLevel = 3
                }
            },
            {
                outfitLabel = "Firearms Uniform - SFO",
                order = "3",
                outfitData = {
                    ["pants"] = {item = 149, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 195, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 75, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 425, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 163, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 111, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 177, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 210, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 135, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = "firearms",
                    flagLevel = 4
                }
            },
            {
                outfitLabel = "Firearms Uniform - Operations (AFO)",
                order = "4",
                outfitData = {
                    ["pants"] = {item = 149, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 195, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 74, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 424, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 163, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 178, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 210, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 135, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = "firearms",
                    flagLevel = 3
                }
            },
            {
                outfitLabel = "Firearms Uniform - Operations (SFO)",
                order = "5",
                outfitData = {
                    ["pants"] = {item = 149, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 195, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 75, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 425, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 163, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 111, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 178, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 210, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 135, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = "firearms",
                    flagLevel = 3
                }
            },
            {
                outfitLabel = "Traffic Uniform (Standard)",
                order = "6",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 71, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 417, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 175, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "traffic",
                    flagLevel = 1
                }
            },
            {
                outfitLabel = "Traffic Uniform (High Vis)",
                order = "7",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 72, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 417, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 175, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "traffic",
                    flagLevel = 1
                }
            },
            -- {
            --     outfitLabel = "CTSFO Uniform",
            --     order = "6",
            --     outfitData = {
            --         ["pants"] = {item = 144, texture = 2}, -- Pants (build 2372: 138, 2)
            --         ["arms"] = {item = 17, texture = 2}, -- Arms (build 2372: 17, 2)
            --         ["t-shirt"] = {item = 193, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
            --         ["vest"] = {item = 67, texture = 0}, -- Body Vest (build 2372: 66)
            --         ["torso2"] = {item = 399, texture = 1}, -- Jacket (build 2372: 395, 1)
            --         ["shoes"] = {item = 51, texture = 0}, -- Shoes (build 2372: 51)
            --         ["accessory"] = {item = 152, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
            --         ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
            --         ["hat"] = {item = 165, texture = 0}, -- Hat (build 2372: 157)
            --         ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
            --         ["mask"] = {item = 52, texture = 5} -- Mask (build 2372: 52)
            --     },
            --     -- grades = {0, 1, 2, 3, 4},
            --     access = {
            --         jobGrade = 1,
            --         flagName = "firearms",
            --         flagLevel = 3
            --     }
            -- },
            -- {
            --     outfitLabel = "AFO Uniform",
            --     order = "7",
            --     outfitData = {
            --         ["pants"] = {item = 144, texture = 0}, -- Pants (build 2372: 138, 2)
            --         ["arms"] = {item = 17, texture = 0}, -- Arms (build 2372: 17)
            --         ["t-shirt"] = {item = 193, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
            --         ["vest"] = {item = 57, texture = 0}, -- Body Vest (build 2372: 56)
            --         ["torso2"] = {item = 399, texture = 0}, -- Jacket (build 2372: 395)
            --         ["shoes"] = {item = 51, texture = 0}, -- Shoes (build 2372: 51)
            --         ["accessory"] = {item = 152, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
            --         ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
            --         ["hat"] = {item = 166, texture = 0}, -- Hat (build 2372: 158)
            --         ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
            --         ["mask"] = {item = 52, texture = 0} -- Mask (build 2372: 52)
            --     },
            --     -- grades = {0, 1, 2, 3, 4},
            --     access = {
            --         jobGrade = 1,
            --         flagName = "firearms",
            --         flagLevel = 2
            --     }
            -- },
            -- {
            --     outfitLabel = "SFO Uniform",
            --     order = "8",
            --     outfitData = {
            --         ["pants"] = {item = 144, texture = 0}, -- Pants (build 2372: 138, 2)
            --         ["arms"] = {item = 194, texture = 0}, -- Arms (build 2372: 17)
            --         ["t-shirt"] = {item = 190, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
            --         ["vest"] = {item = 63, texture = 0}, -- Body Vest (build 2372: 55)
            --         ["torso2"] = {item = 398, texture = 0}, -- Jacket (build 2372: 395)
            --         ["shoes"] = {item = 51, texture = 0}, -- Shoes (build 2372: 51)
            --         ["accessory"] = {item = 152, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
            --         ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
            --         ["hat"] = {item = 166, texture = 1}, -- Hat (build 2372: 158)
            --         ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
            --         ["mask"] = {item = 52, texture = 0} -- Mask (build 2372: 52)
            --     },
            --     -- grades = {0, 1, 2, 3, 4},
            --     access = {
            --         jobGrade = 1,
            --         flagName = "firearms",
            --         flagLevel = 3
            --     }
            -- },
            {
                outfitLabel = "Patrol Uniform (Hi-Vis Short Sleeve)",
                order = "11",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 72, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 417, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 173, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Patrol Uniform (Hi-Vis Long Sleeve)",
                order = "12",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 72, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 422, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 173, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Patrol Uniform (Hi-Vis Jacket)",
                order = "13",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 414, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 173, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Formal Uniform (Long Sleeve)",
                order = "14",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 419, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 175, texture = 1}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Formal Uniform (Short Sleeve)",
                order = "15",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 420, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 175, texture = 1}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Command Uniform",
                order = "16",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 419, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 175, texture = 1}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 4,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Personal Uniform (Jarvis Parker) - Short",
                order = "17",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 420, texture = 11}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 175, texture = 1}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0,
                    personalId = "GDA51316"
                }
            },
            {
                outfitLabel = "Personal Uniform (Jarvis Parker) - Long",
                order = "18",
                outfitData = {
                    ["pants"] = {item = 148, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 11, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 419, texture = 11}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 97, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 175, texture = 1}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 209, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0,
                    personalId = "GDA51316"
                }
            },
            {
                outfitLabel = "Patrol Vest (Response 1)",
                order = "19",
                extra = true,
                outfitData = {
                    ["vest"] = {item = 71, texture = 0}, -- Body Vest (build 2372: 68)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Patrol Vest (Response 2)",
                order = "20",
                extra = true,
                outfitData = {
                    ["vest"] = {item = 73, texture = 0}, -- Body Vest (build 2372: 68)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Patrol Vest (High Vis)",
                order = "21",
                extra = true,
                outfitData = {
                    ["vest"] = {item = 72, texture = 0}, -- Body Vest (build 2372: 68)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Firearm Holster",
                order = "22",
                extra = true,
                outfitData = {
                    ["accessory"] = {item = 154, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 2
                }
            },
            {
                outfitLabel = "Firearm Holster (FIREARMS)",
                order = "23",
                extra = true,
                outfitData = {
                    ["accessory"] = {item = 163, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 2
                }
            },
            {
                outfitLabel = "Taser Belt",
                order = "24",
                extra = true,
                outfitData = {
                    ["t-shirt"] = {item = 194, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 1
                }
            },
            {
                outfitLabel = "Custodian",
                order = "25",
                extra = true,
                outfitData = {
                    ["hat"] = {item = 174, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Peaked Hat",
                order = "26",
                extra = true,
                outfitData = {
                    ["hat"] = {item = 175, texture = 1},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 2,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Peaked Hat Traffic",
                order = "27",
                extra = false,
                outfitData = {
                    ["hat"] = {item = 175, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "traffic",
                    flagLevel = 1
                }
            },
            {
                outfitLabel = "Smart Trousers",
                order = "28",
                extra = true,
                outfitData = {
                    ["pants"] = {item = 143, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Tough Trousers",
                order = "29",
                extra = true,
                outfitData = {
                    ["pants"] = {item = 148, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Long Sleeve T-Shirt",
                order = "30",
                extra = true,
                outfitData = {
                    ["torso2"] = {item = 423, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Shell Jacket",
                order = "31",
                extra = true,
                outfitData = {
                    ["torso2"] = {item = 416, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "BodyWorn Camera",
                order = "32",
                extra = true,
                outfitData = {
                    ["decals"] = {item = 134, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "CID - Formal Suit 1 (Grey)",
                order = "33",
                outfitData = {
                    ["pants"] = {item = 24, texture = 1}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 1, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 31, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 70, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 31, texture = 1}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 10, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 160, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 173, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 210, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "cid",
                    flagLevel = 2
                },
            },
            {
                outfitLabel = "CID - Suit 2",
                order = "34",
                outfitData = {
                    ["pants"] = {item = 24, texture = 1}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 1, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (build 2372: 184)
                    ["vest"] = {item = 70, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 321, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 10, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 160, texture = 0}, -- Neck Accessory (build 2372: 152)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 173, texture = 0}, -- Hat (build 2372: -1)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 210, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "cid",
                    flagLevel = 2
                },
            },
            {
                outfitLabel = "Police Lanyard",
                order = "35",
                extra = true,
                outfitData = {
                    ["accessory"] = {item = 160, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "cid",
                    flagLevel = 2
                }
            },
            {
                outfitLabel = "CID Vest",
                order = "36",
                extra = true,
                outfitData = {
                    ["vest"] = {item = 70, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "cid",
                    flagLevel = 2
                }
            },
            {
                outfitLabel = "Operations Helmet (Goggles & Palters up)",
                order = "37",
                extra = true,
                outfitData = {
                    ["hat"] = {item = 178, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 3
                }
            },
            {
                outfitLabel = "Operations Helmet (Goggles & Palters Down)",
                order = "38",
                extra = true,
                outfitData = {
                    ["hat"] = {item = 176, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 3
                }
            },
            {
                outfitLabel = "Operations Balaclava",
                order = "39",
                extra = true,
                outfitData = {
                    ["mask"] = {item = 211, texture = 0},
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 3
                }
            },
        },
        ["female"] = {
            {
                outfitLabel = "Patrol Uniform (Long Sleeve)",
                order = "1",
                outfitData = {
                    ["pants"] = {item = 156, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 1, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 236, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 64, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 440, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 127, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 172, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 144, texture = 0} -- Bodyworn
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Patrol Uniform (High Vis)",
                order = "2",
                outfitData = {
                    ["pants"] = {item = 156, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 1, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 236, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 63, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 440, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 172, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 146, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Formal Uniform (Short Sleeve)",
                order = "3",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 243, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 236, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 442, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 172, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Formal Uniform (Long Sleeve)",
                order = "4",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 243, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 236, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 443, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 172, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Vest (Standard)",
                order = "5",
                extra = true,
                outfitData = {

                    ["vest"] = {item = 64, texture = 0}, -- Body Vest (build 2372: 57)

                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Vest (High Vis)",
                order = "6",
                extra = true,
                outfitData = {

                    ["vest"] = {item = 63, texture = 0}, -- Body Vest (build 2372: 57)

                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Firearm Holster",
                order = "7",
                extra = true,
                outfitData = {
                    ["accessory"] = {item = 123, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 2
                }
            },
            {
                outfitLabel = "Taser Belt",
                order = "8",
                extra = true,
                outfitData = {
                    ["t-shirt"] = {item = 236, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["bag"] = {item = 111, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = "firearms",
                    flagLevel = 1
                }
            },
            {
                outfitLabel = "Body Worn Camera (1)",
                order = "9",
                extra = true,
                outfitData = {
                    ["decals"] = {item = 144, texture = 0}, -- Body Worn
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Body Worn Camera (2)",
                order = "10",
                extra = true,
                outfitData = {
                    ["decals"] = {item = 145, texture = 0}, -- Body Worn
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Body Worn Camera (3)",
                order = "11",
                extra = true,
                outfitData = {
                    ["decals"] = {item = 146, texture = 0}, -- Body Worn
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
        }
    },
    ["ambulance"] = { -- NHS Clothing
        ["male"] = {
            {
                outfitLabel = "Short Sleeve Closed Button",
                order = "1",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 92, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 432, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 126, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Short Sleeve Open Button",
                order = "2",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 92, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 431, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 126, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Long Sleeve Jumper",
                order = "3",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 92, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 428, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 126, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Open Jacket",
                order = "4",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 92, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 430, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Closed Jacket",
                order = "5",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 92, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 427, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Half Closed Jacket",
                order = "6",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 90, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 31, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 426, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Motorbike",
                order = "7",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 92, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 79, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 433, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 62, texture = 8}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Critical Care Paramedic",
                order = "8",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 92, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 429, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = 'hems',
                    flagLevel = 1
                }
            },
            {
                outfitLabel = "Formal Uniform",
                order = "9",
                outfitData = {
                    ["pants"] = {item = 150, texture = 0}, -- Pants (build 2372: 25)
                    ["arms"] = {item = 1, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 184)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 68)
                    ["torso2"] = {item = 434, texture = 0}, -- Jacket (build 2372: 384)
                    ["shoes"] = {item = 111, texture = 2}, -- Shoes (build 2372: 51)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 152)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = -1, texture = 0}, -- Hat (build 2372: -1)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Stab Vest 1",
                order = "10",
                outfitData = {
                    ["vest"] = {item = 77, texture = 0}, -- Body Vest (build 2372: 68)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
            {
                outfitLabel = "Stab Vest 2",
                order = "11",
                outfitData = {
                    ["vest"] = {item = 78, texture = 0}, -- Body Vest (build 2372: 68)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = 0
                }
            },
        },
        ["female"] = {
            {
                outfitLabel = "NHS Short Sleeve",
                order = "1",
                outfitData = {
                    ["pants"] = {item = 157, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 168, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 445, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 101, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 96, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 0, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "NHS Long Sleeve",
                order = "2",
                outfitData = {
                    ["pants"] = {item = 157, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 168, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 446, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 101, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 96, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 112, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 0, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "NHS Polo",
                order = "3",
                outfitData = {
                    ["pants"] = {item = 159, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 168, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 238, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 448, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 101, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 96, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 0, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "NHS Jacket",
                order = "4",
                outfitData = {
                    ["pants"] = {item = 159, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 168, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 238, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 451, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 101, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 0, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
            {
                outfitLabel = "Formal Uniform",
                order = "5",
                outfitData = {
                    ["pants"] = {item = 159, texture = 0}, -- Pants (build 2372: 145)
                    ["arms"] = {item = 243, texture = 0}, -- Arms (build 2372: 15)
                    ["t-shirt"] = {item = 238, texture = 0}, -- T Shirt (handcuffs belt) (build 2372: 0)
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest (build 2372: 57)
                    ["torso2"] = {item = 452, texture = 0}, -- Jacket (build 2372: 400)
                    ["shoes"] = {item = 107, texture = 0}, -- Shoes (build 2372: 52)
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory (leg Holster) (build 2372: 0)
                    ["bag"] = {item = 0, texture = 0}, -- Bag (build 2372: 0)
                    ["hat"] = {item = 0, texture = 0}, -- Hat (build 2372: 0)
                    ["glass"] = {item = 0, texture = 0}, -- Glasses (build 2372: 0)
                    ["mask"] = {item = 0, texture = 0}, -- Mask (build 2372: 0)
                    ["decals"] = {item = 0, texture = 0} -- Bodyworn and radio
                },
                access = {
                    jobGrade = 0,
                    flagName = nil,
                    flagLevel = nil
                }
            },
        }
    },
    ["realestate"] = {
        ["male"] = {
            {
                -- Outfits
                outfitLabel = "Worker",
                order = "1",
                outfitData = {
                    ["pants"]       = { item = 28, texture = 0},  -- Pants
                    ["arms"]        = { item = 1, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 31, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 294, texture = 0},  -- Jacket
                    ["shoes"]       = { item = 10, texture = 0},  -- Shoes
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = 12, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = nil,
                    flagLevel = nil
                }
            }
        },
        ["female"] = {
            {
                outfitLabel = "Worker",
                order = "1",
                outfitData = {
                    ["pants"]       = { item = 57, texture = 2},  -- Pants
                    ["arms"]        = { item = 0, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 34, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 105, texture = 7},  -- Jacket
                    ["shoes"]       = { item = 8, texture = 5},  -- Shoes
                    ["accessory"]   = { item = 11, texture = 3},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = nil,
                    flagLevel = nil
                }
            }
        }
    },
    ["cardealer"] = {
        ["male"] = {
            {
                -- Outfits
                outfitLabel = "Worker",
                order = "1",
                outfitData = {
                    ["pants"]       = { item = 24, texture = 0},  -- Pants (build 2372: 24)
                    ["arms"]        = { item = 1, texture = 0},  -- Arms (build 2372: 1)
                    ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt (build 2372: 15)
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest (build 2372: 0)
                    ["torso2"]      = { item = 371, texture = 13},  -- Jacket (build 2372: 371)
                    ["shoes"]       = { item = 51, texture = 0},  -- Shoes (build 2372: 51)
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory (build 2372: 0)
                    ["bag"]         = { item = 0, texture = 0},  -- Bag (build 2372: 0)
                    ["hat"]         = { item = 0, texture = 0},  -- Hat (build 2372: 0)
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses (build 2372: 0)
                    ["mask"]        = { item = 0, texture = 0},  -- Mask (build 2372: 0)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = nil,
                    flagLevel = nil
                }
            }
        },
        ["female"] = {
            {
                outfitLabel = "Worker",
                order = "1",
                outfitData = {
                    ["pants"]       = { item = 57, texture = 2},  -- Pants (build 2372: 57,2)
                    ["arms"]        = { item = 0, texture = 0},  -- Arms (build 2372: 0)
                    ["t-shirt"]     = { item = 34, texture = 0},  -- T Shirt (build 2372: 34)
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest (build 2372: 0)
                    ["torso2"]      = { item = 105, texture = 7},  -- Jacket (build 2372: 105,7)
                    ["shoes"]       = { item = 8, texture = 5},  -- Shoes (build 2372: 8,5)
                    ["accessory"]   = { item = 11, texture = 3},  -- Neck Accessory (build 2372: 11,3)
                    ["bag"]         = { item = 0, texture = 0},  -- Bag (build 2372: 0)
                    ["hat"]         = { item = -1, texture = -1},  -- Hat (build 2372: -1)
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses (build 2372: 0)
                    ["mask"]        = { item = 0, texture = 0},  -- Mask (build 2372: 0)
                },
                -- grades = {0, 1, 2, 3, 4},
                access = {
                    jobGrade = 1,
                    flagName = nil,
                    flagLevel = nil
                }
            }
        }
    }
}

Config.InitialPlayerClothes = {
    Male = {
        Components = {
            {
                component_id = 0, -- Face
                drawable = 0,
                texture = 0
            },
            {
                component_id = 1, -- Mask
                drawable = 0,
                texture = 0
            },
            {
                component_id = 2, -- Hair
                drawable = 0,
                texture = 0
            },
            {
                component_id = 3, -- Upper Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 4, -- Lower Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 5, -- Bag
                drawable = 0,
                texture = 0
            },
            {
                component_id = 6, -- Shoes
                drawable = 0,
                texture = 0
            },
            {
                component_id = 7, -- Scarf & Chains
                drawable = 0,
                texture = 0
            },
            {
                component_id = 8, -- Shirt
                drawable = 0,
                texture = 0
            },
            {
                component_id = 9, -- Body Armor
                drawable = 0,
                texture = 0
            },
            {
                component_id = 10, -- Decals
                drawable = 0,
                texture = 0
            },
            {
                component_id = 11, -- Jacket
                drawable = 0,
                texture = 0
            }
        },
        Props = {
            {
                prop_id = 0, -- Hat
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 1, -- Glasses
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 2, -- Ear
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 6, -- Watch
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 7, -- Bracelet
                drawable = -1,
                texture = -1
            }
        },
        Hair = {
            color = 0,
            highlight = 0,
            style = 0,
            texture = 0
        }
    },
    Female = {
        Components = {
            {
                component_id = 0, -- Face
                drawable = 0,
                texture = 0
            },
            {
                component_id = 1, -- Mask
                drawable = 0,
                texture = 0
            },
            {
                component_id = 2, -- Hair
                drawable = 0,
                texture = 0
            },
            {
                component_id = 3, -- Upper Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 4, -- Lower Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 5, -- Bag
                drawable = 0,
                texture = 0
            },
            {
                component_id = 6, -- Shoes
                drawable = 0,
                texture = 0
            },
            {
                component_id = 7, -- Scarf & Chains
                drawable = 0,
                texture = 0
            },
            {
                component_id = 8, -- Shirt
                drawable = 0,
                texture = 0
            },
            {
                component_id = 9, -- Body Armor
                drawable = 0,
                texture = 0
            },
            {
                component_id = 10, -- Decals
                drawable = 0,
                texture = 0
            },
            {
                component_id = 11, -- Jacket
                drawable = 0,
                texture = 0
            }
        },
        Props = {
            {
                prop_id = 0, -- Hat
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 1, -- Glasses
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 2, -- Ear
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 6, -- Watch
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 7, -- Bracelet
                drawable = -1,
                texture = -1
            }
        },
        Hair = {
            color = 0,
            highlight = 0,
            style = 0,
            texture = 0
        }
    }
}
