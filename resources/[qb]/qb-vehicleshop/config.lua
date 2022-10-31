Config = {}
Config.UsingTarget = GetConvar('UseTarget', 'false') == 'false'
Config.Commission = 0.15 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.05 -- Percent that goes to sales person from a finance sale 5%
--Config.FinanceZone = vector3(-29.53, -1103.67, 26.42)-- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.Shops = {

    -- PDM
    ['pdm'] = {
        ['Type'] = 'free-use', -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-59.171298980713, -1098.0219726562),
                vector2(-52.382118225098, -1079.4240722656),
                vector2(-45.066371917725, -1081.2681884766),
                vector2(-27.219314575195, -1088.2438964844),
                vector2(-33.021835327148, -1108.6146240234)
            },
            ['minZ'] = 26.0,  -- min height of the shop zone
            ['maxZ'] = 28.0,  -- max height of the shop zone
            ['size'] = 3.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Premium Deluxe Motorsport', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 326, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['Categories'] = {-- Categories available to browse
            ['sportsclassics'] = 'Sports Classics',
            ['sedans'] = 'Sedans',
            ['coupes'] = 'Coupes',
            ['suvs'] = 'SUVs',
            ['offroad'] = 'Offroad',
            ['muscle'] = 'Muscle',
            ['compacts'] = 'Compacts',
            ['vans'] = 'Vans',
            ['motorbikes'] = 'Motorbikes'
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-45.67, -1098.34, 26.42), -- Blip Location
        ['ReturnLocation'] = vector3(-44.74, -1082.58, 26.68), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-42.14, -1101.5, 26.32, 19.46),
                defaultVehicle = 'zr350',
                chosenVehicle = 'zr350',
            },
            [2] = {
                coords = vector4(-54.58, -1097.09, 26.32, 31.02),
                defaultVehicle = 'calico',
                chosenVehicle = 'calico',
            },
            [3] = {
                coords = vector4(-50.01, -1083.48, 26.32, 251.83),
                defaultVehicle = 'jester4',
                chosenVehicle = 'jester4',
            },
            [4] = {
                coords = vector4(-37.05, -1093.44, 26.32, 18.96),
                defaultVehicle = 'rt3000',
                chosenVehicle = 'rt3000',
            },
            [5] = {
                coords = vector4(-47.3, -1091.95, 26.32, 94.8),
                defaultVehicle = 'comet6',
                chosenVehicle = 'comet6',
            },
        },
    },
    -- Lux
    -- ['lux'] = {
    --     ['Type'] = 'free-use', -- no player interaction is required to purchase a car
    --     ['Zone'] = {
    --         ['Shape'] = { --polygon that surrounds the shop
    --             vector2(-799.80560302734, -227.12475585938),
    --             vector2(-787.78771972656, -248.08302307129),
    --             vector2(-780.35687255859, -244.75801086426),
    --             vector2(-782.95764160156, -240.10861206055),
    --             vector2(-781.89318847656, -239.32829284668),
    --             vector2(-784.345703125, -235.47833251953),
    --             vector2(-785.49664306641, -235.77374267578),
    --             vector2(-786.47052001953, -234.21997070313),
    --             vector2(-785.60919189453, -231.37341308594),
    --             vector2(-783.81390380859, -230.48321533203),
    --             vector2(-778.96179199219, -228.04901123047),
    --             vector2(-778.28887939453, -226.81434631348),
    --             vector2(-777.67266845703, -222.67346191406),
    --             vector2(-780.07733154297, -218.80859375),
    --             vector2(-784.49133300781, -217.49891662598)
    --         },
    --             ['minZ'] = 36.50,  -- min height of the shop zone
    --             ['maxZ'] = 38.50,  -- max height of the shop zone
    --             ['size'] = 2.75, -- size of the vehicles zones
    --     },
    --     ['Job'] = 'none', -- Name of job or none
    --     ['ShopLabel'] = 'Luxury Autos', -- Blip name
    --     ['showBlip'] = true, -- true or false
    --     ['blipSprite'] = 326, -- Blip sprite
    --     ['blipColor'] = 3, -- Blip color
    --     ['Categories'] = {
    --         ['super'] = 'Super',
    --         ['sports'] = 'Sports',
    --     },
    --     ['TestDriveTimeLimit'] = 0.0, -- Time in minutes until the vehicle gets deleted
    --     ["Location"] = vector3(-789.92, -228.77, 37.08), -- Blip Location
    --     ["ReturnLocation"] = vector3(-765.25, -246.03, 37.21), -- Location to return vehicle, only enables if the vehicleshop has a job owned
    --     ["VehicleSpawn"] = vector4(-772.75, -231.9, 37.08, 204.99), -- Spawn location when vehicle is bought
    --     ['TestDriveSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location for test drive
    --     ['ShowroomVehicles'] = {
    --         [1] = {
    --             coords = vector4(-792.24, -233.11, 36.07, 76.05),
    --             defaultVehicle = 'italirsx',
    --             chosenVehicle = 'italirsx',
    --         },
    --         [2] = {
    --             coords = vector4(-789.94, -237.66, 36.07, 80.80),
    --             defaultVehicle = 'italigtb',
    --             chosenVehicle = 'italigtb',
    --         },
    --         [3] = {
    --             coords = vector4(-787.18, -242.66, 36.07, 78.72),
    --             defaultVehicle = 'nero',
    --             chosenVehicle = 'nero',
    --         },
    --         [4] = {
    --             coords = vector4(-783.56, -223.544, 36.32, 131.01),
    --             defaultVehicle = 'comet2',
    --             chosenVehicle = 'comet2',
    --         },
    --     },
    -- },

    -- Tuners
    ['Tuners'] = {
        ['Type'] = 'managed',  -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {
                vector2(948.51, -981.85),
                vector2(915.53, -984.94),
                vector2(912.83, -956.84),
                vector2(949.46, -953.61)
            },
                ['minZ'] = 39.0,
                ['maxZ'] = 42.0,
                ['size'] = 5.5 -- size of the vehicles zones
        },
        ['Job'] = 'cardealer', -- Name of job or none
        ['ShopLabel'] = 'LS Imports',
        ['showBlip'] = true,  --- true or false
        ['blipSprite'] = 820, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['Categories'] = {
            -- ['Aston Martin'] = 'Aston Martin',
            ['Audi'] = 'Audi',
            ['Bentley'] = 'Bentley',
            ['BMW'] = 'BMW',
            ['BUGATTI'] = 'Bugatti',
            ['Ford'] = 'Ford',
            ['Mitsibuishi'] = 'Mitsibuishi',
            -- ['Chevrolet'] = 'Chevrolet',
            ['Dodge'] = 'Dodge',
            -- ['Ducati'] = 'Ducati',
            -- ['Ferrari'] = 'Ferrari',
            ['Ford'] = 'Ford',
            -- ['Honda'] = 'Honda',
            -- ['Hyundai'] = 'Hyundai',
            -- ['Jaguar'] = 'Jaguar',
            ['Mini'] = 'Mini',
            ['Kawasaki'] = 'Kawasaki',
            ['Lamborghini'] = 'Lamborghini',
            ['Lexus'] = 'Lexus',
            -- ['Lotus'] = 'Lotus',
            -- ['Mazda'] = 'Mazda',
            ['Mercedes'] = 'Mercedes',
            --- ['Mclaren'] = 'Mclaren',
            ['Nissan'] = 'Nissan',
            -- ['Peugeot'] = 'Peugeot',
            ['Porsche'] = 'Porsche',
            -- ['Pagani'] = 'Pagani',
            -- ['Range Rover'] = 'Range Rover',
            -- ['Renault'] = 'Renault',
             ['Toyota'] = 'Toyota',
             ['Subaru'] = 'Subaru',
            -- ['Volkswagen'] = 'Volkswagen',
            -- ['Rolls'] = 'Rolls-Royce'
        },
        ['TestDriveTimeLimit'] = 5.0,
        ['Location'] = vector3(943.29, -977.54, 39.5),
        ['ReturnLocation'] = vector4(951.99, -943.96, 39.5, 172.93),
        ['VehicleSpawn'] = vector4(944.92, -980.87, 39.5, 190.78),
        ['TestDriveSpawn'] = vector4(943.71, -944.9, 39.5, 186.77), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(937.67, -970.77, 39.54, 274.95),
                defaultVehicle = 'pts21',
                chosenVehicle = 'pts21',
            },
        },
    },

    ['jdm'] = {
        ['Type'] = 'managed',  -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {
                vector2(959.32, -1774.65),
                vector2(949.38, -1773.82),
                vector2(950.11, -1764.84),
                vector2(960.25, -1765.63)
            },
                ['minZ'] = 19,
                ['maxZ'] = 22,
                ['size'] = 5 -- size of the vehicles zones
        },
        ['Job'] = 'jdm', -- Name of job or none
        ['ShopLabel'] = 'Top Secret Mechanic',
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 825, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['Categories'] = {
            ['Mazda3'] = 'Mazda',
            ['Lexus3'] = 'Lexus',
            ['Toyota3'] = 'Toyota',
            ['BMW3'] = 'BMW',
        },
        ['TestDriveTimeLimit'] = 15.0,
        ['Location'] = vector3(952.61, -1698.22, 29.86),
        ['ReturnLocation'] = vector4(973.97, -1758.27, 21.03, 87.97),
        ['VehicleSpawn'] = vector4(971.1, -1777.42, 21.03, 85.01),
        ['TestDriveSpawn'] = vector4(970.35, -1773.43, 21.03, 86.2), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(957.2, -1769.48, 21.03, 10.97),
                defaultVehicle = 'fd',
                chosenVehicle = 'fd',
            },
            [2] = {
                coords = vector4(952.8, -1769.48, 21.03, 10.97),
                defaultVehicle = 'lfa',
                chosenVehicle = 'lfa',
            },
        },
    },
    
    -- Tuners (Browse)
    -- ['Tuners2'] = {
    --     ['Type'] = 'free-use', -- no player interaction is required to purchase a car
    --     ['Zone'] = {
    --         ['Shape'] = { --polygon that surrounds the shop
    --             vector2(148.60932922363, -3049.5534667969),
    --             vector2(136.70344543457, -3049.5393066406),
    --             vector2(136.54130554199, -3041.9841308594),
    --             vector2(148.50517272949, -3042.1276855469)
    --         },
    --         ['minZ'] = 7.0,
    --         ['maxZ'] = 7.1,
    --         ['size'] = 2.75 -- size of the vehicles zones
    --     },
    --     ['Job'] = 'none', -- Name of job or none
    --     ['ShopLabel'] = 'Tuners Showroom (You Cannot buy vehicles here)', -- Blip name
    --     ['showBlip'] = false, -- true or false
    --     ['blipSprite'] = 326, -- Blip sprite
    --     ['blipColor'] = 3, -- Blip color
    --     ['Categories'] = {-- Categories available to browse
    --         ['Aston Martin2'] = 'Aston Martin',
    --         ['Audi2'] = 'Audi',
    --         ['Bentley2'] = 'Bentley',
    --         ['BMW2'] = 'BMW',
    --         ['Brabus2'] = 'Brabus',
    --         ['Bugatti2'] = 'Bugatti',
    --         ['Chevrolet2'] = 'Chevrolet',
    --         ['Dodge2'] = 'Dodge',
    --         ['Ducati2'] = 'Ducati',
    --         ['Ferrari2'] = 'Ferrari',
    --         ['Ford2'] = 'Ford',
    --         ['Honda2'] = 'Honda',
    --         ['Hyundai2'] = 'Hyundai',
    --         ['Jaguar2'] = 'Jaguar',
    --         ['Kawasaki2'] = 'Kawasaki',
    --         ['Lamborghini2'] = 'Lamborghini',
    --         ['Lexus2'] = 'Lexus',
    --         ['Lotus2'] = 'Lotus',
    --         ['Mazda2'] = 'Mazda',
    --         ['M2'] = 'Mercedes',
    --         ['Mitsubishi2'] = 'Mitsubishi',
    --         ['Mclaren2'] = 'Mclaren',
    --         ['Nissan2'] = 'Nissan',
    --         ['Peugeot2'] = 'Peugeot',
    --         ['Porsche2'] = 'Porsche',
    --         ['Pagani2'] = 'Pagani',
    --         ['Range Rover2'] = 'Range Rover',
    --         ['Renault2'] = 'Renault',
    --         ['Toyota2'] = 'Toyota',
    --         ['Volkswagen2'] = 'Volkswagen',
    --         ['Rolls2'] = 'Rolls-Royce'
    --     },
    --     ['TestDriveTimeLimit'] = 0.0, -- Time in minutes until the vehicle gets deleted
    --     ['Location'] = vector3(140.61065, -3035.94, 6.4677233),
    --     ['ReturnLocation'] = vector4(123.57, -3047.39, 7.04, 266.44),
    --     ['VehicleSpawn'] = vector4(162.49, -3043.98, 5.95, 266.23),
    --     ['TestDriveSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location for test drive
    --     ['ShowroomVehicles'] = {
    --         [1] = {
    --             coords = vector4(146.13, -3046.44, 7.04, 0.3),
    --             defaultVehicle = 'pts21',
    --             chosenVehicle = 'pts21',
    --         },
    --         [2] = {
    --             coords = vector4(138.65, -3046.24, 7.04, 359.72),
    --             defaultVehicle = 'gxr35',
    --             chosenVehicle = 'gxr35',
    --         },
    --         [3] = {
    --             coords = vector4(142.38, -3046.11, 7.04, 1.32), 
    --             defaultVehicle = 'rmodmi8lb',
    --             chosenVehicle = 'rmodmi8lb',
    --         },
    --     },
    -- },

    -- Add your next table under this comma
    -- ['boats'] = {
    --     ['Type'] = 'free-use', -- no player interaction is required to purchase a vehicle
    --     ['Zone'] = {
    --         ['Shape'] = {--polygon that surrounds the shop
    --             vector2(-729.39, -1315.84),
    --             vector2(-766.81, -1360.11),
    --             vector2(-754.21, -1371.49),
    --             vector2(-716.94, -1326.88)
    --         },
    --         ['minZ'] = 0.0, -- min height of the shop zone
    --         ['maxZ'] = 5.0, -- max height of the shop zone
    --         ['size'] = 6.2 -- size of the vehicles zones
    --     },
    --     ['Job'] = 'none', -- Name of job or none
    --     ['ShopLabel'] = 'Marina Shop', -- Blip name
    --     ['showBlip'] = true, -- true or false
    --     ['blipSprite'] = 410, -- Blip sprite
    --     ['blipColor'] = 3, -- Blip color
    --     ['Categories'] = {-- Categories available to browse
    --         ['boats'] = 'Boats'
    --     },
    --     ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
    --     ['Location'] = vector3(-738.25, -1334.38, 1.6), -- Blip Location
    --     ['ReturnLocation'] = vector3(-714.34, -1343.31, 0.0), -- Location to return vehicle, only enables if the vehicleshop has a job owned
    --     ['VehicleSpawn'] = vector4(-727.87, -1353.1, -0.17, 137.09), -- Spawn location when vehicle is bought
    --     ['TestDriveSpawn'] = vector4(-722.23, -1351.98, 0.14, 135.33), -- Spawn location for test drive
    --     ['ShowroomVehicles'] = {
    --         [1] = {
    --             coords = vector4(-727.05, -1326.59, 0.00, 229.5), -- where the vehicle will spawn on display
    --             defaultVehicle = 'seashark', -- Default display vehicle
    --             chosenVehicle = 'seashark' -- Same as default but is dynamically changed when swapping vehicles
    --         },
    --         [2] = {
    --             coords = vector4(-732.84, -1333.5, -0.50, 229.5),
    --             defaultVehicle = 'dinghy',
    --             chosenVehicle = 'dinghy'
    --         },
    --         [3] = {
    --             coords = vector4(-737.84, -1340.83, -0.50, 229.5),
    --             defaultVehicle = 'speeder',
    --             chosenVehicle = 'speeder'
    --         },
    --         [4] = {
    --             coords = vector4(-741.53, -1349.7, -2.00, 229.5),
    --             defaultVehicle = 'marquis',
    --             chosenVehicle = 'marquis'
    --         },
    --     },
    -- },
    -- ['air'] = {
    --     ['Type'] = 'free-use', -- no player interaction is required to purchase a vehicle
    --     ['Zone'] = {
    --         ['Shape'] = {--polygon that surrounds the shop
    --             vector2(-1607.58, -3141.7),
    --             vector2(-1672.54, -3103.87),
    --             vector2(-1703.49, -3158.02),
    --             vector2(-1646.03, -3190.84)
    --         },
    --         ['minZ'] = 12.99, -- min height of the shop zone
    --         ['maxZ'] = 16.99, -- max height of the shop zone
    --         ['size'] = 7.0, -- size of the vehicles zones
    --     },
    --     ['Job'] = 'none', -- Name of job or none
    --     ['ShopLabel'] = 'Air Shop', -- Blip name
    --     ['showBlip'] = true, -- true or false
    --     ['blipSprite'] = 251, -- Blip sprite
    --     ['blipColor'] = 3, -- Blip color
    --     ['Categories'] = {-- Categories available to browse
    --         ['helicopters'] = 'Helicopters',
    --         ['planes'] = 'Planes'
    --     },
    --     ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
    --     ['Location'] = vector3(-1652.76, -3143.4, 13.99), -- Blip Location
    --     ['ReturnLocation'] = vector3(-1628.44, -3104.7, 13.94), -- Location to return vehicle, only enables if the vehicleshop has a job owned
    --     ['VehicleSpawn'] = vector4(-1617.49, -3086.17, 13.94, 329.2), -- Spawn location when vehicle is bought
    --     ['TestDriveSpawn'] = vector4(-1625.19, -3103.47, 13.94, 330.28), -- Spawn location for test drive
    --     ['ShowroomVehicles'] = {
    --         [1] = {
    --             coords = vector4(-1651.36, -3162.66, 12.99, 346.89), -- where the vehicle will spawn on display
    --             defaultVehicle = 'volatus', -- Default display vehicle
    --             chosenVehicle = 'volatus' -- Same as default but is dynamically changed when swapping vehicles
    --         },
    --         [2] = {
    --             coords = vector4(-1668.53, -3152.56, 12.99, 303.22),
    --             defaultVehicle = 'luxor2',
    --             chosenVehicle = 'luxor2'
    --         },
    --         [3] = {
    --             coords = vector4(-1632.02, -3144.48, 12.99, 31.08),
    --             defaultVehicle = 'nimbus',
    --             chosenVehicle = 'nimbus'
    --         },
    --         [4] = {
    --             coords = vector4(-1663.74, -3126.32, 12.99, 275.03),
    --             defaultVehicle = 'frogger',
    --             chosenVehicle = 'frogger'
    --         },
    --     },
    -- },
}
