Config = {}

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = false},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = false},
    ["tent"] = {model = `prop_gazebo_03`, freeze = false},
    ["light"] = {model = `prop_worklight_03b`, freeze = false},
}

Config.MaxSpikes = 5

-- For Police Garage Polyzones
Config.AllowSpawningFromAnywhere = true
Config.CarSpawnDistance = 5

-- For Police Impound and sieze vehicle time
Config.ImpoundTime = 10  -- in seconds
Config.SeizeTime = 10 -- in seconds

-- Maximum Values for fines and sentences
Config.MaxSentence = 240 -- in minutes
Config.MaxFine = 100000 -- Amount for example this is £100,000

Config.HandCuffItem = 'handcuffs'
Config.PlasticCuffs = 'zipties'
Config.RaidLevel = 1




Config.policepeds = {
    -- MRPD helipad ped
    {
        model = 'mp_m_freemode_01',
        name = "MRPD Helipad",
        eyelocation = "MRPD_AIR",
        coords = vector3(459.08, -979.57, 43.69),
        heading = 97.02,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },

    -- MRPD armory ped
    {
        model = 'mp_m_freemode_01',
        name = "MRPD Armoury",
        eyelocation = "MRPD_ARMORY",
        coords = vector3(480.20, -996.75, 29.69),
        heading = 97.63,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    
    },
}

Config.LicenseRank = 2

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Locations = {
    ["duty"] = {
        [1] = vector3(441.93, -981.95, 30.69), -- done @jackbatchiee
        -- [2] = vector3(-449.811, 6012.909, 31.815), paleto
    },
    ["vehicle"] = {
        [1] = vector4(458.58, -992.52, 25.7, 42.02),        
        [2] = vector3(-467.26, 6014.23, 31.34), -- Paleto PD @jackbatchiee
    },
    ["stash"] = {
        [1] = vector3(484.38, -995.18, 30.69), -- done @jackbatchiee
    },
    -- ["impound"] = {
    --     [1] = vector4(425.94, -976.84, 25.7, 246.08),
    --     -- [2] = vector4(-436.14, 5982.63, 31.34, 136.0),
    -- },
    ["helicopter"] = {
        [1] = vector4(449.168, -981.325, 43.691, 87.234),
        [2] = vector4(-475.43, 5988.353, 31.716, 31.34),
    },
    ["armory"] = {
        [1] = vector3(479.71, -996.35, 30.69), -- done @jackbatchiee
    },
    ["trash"] = {
        -- [1] = vector3(439.0907, -976.746, 30.776), -- Does not need as its linked to evidence @jackbatchiee
    },
    ["fingerprint"] = {
        [1] = vector3(473.12, -1007.60, 26.4), -- done @jackbatchiee
    },
    ["evidence"] = {
        [1] = {
            name = "Mission Row",
            coords = vector3(473.72, -994.79, 26.28),
            zones = {
                vector2(475.98, -992.65),
                vector2(471.63, -992.54),
                vector2(471.77, -997.5),
                vector2(476.08, -997.57),
            },
            debug = false,
            Minz = 26.27 - 0.9,
            Maxz = 26.27 + 1.5,
        },
    },
    ["stations"] = {
        [1] = {label = "Police Station", coords = vector4(428.23, -984.28, 29.76, 3.5)},
        [2] = {label = "Prison", coords = vector4(1845.903, 2585.873, 45.672, 272.249)},
        -- [3] = {label = "Police Station Paleto", coords = vector4(-451.55, 6014.25, 31.716, 223.81)},
    },
}

Config.RepairLocations = {
    ["mrpd"] = {
        coords = vector3(450.09, -975.92, 25.7)
    },
}

Config.ArmoryWhitelist = {}

-- Config.PoliceHelicopter = "POLMAV"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", coords = vector3(257.45, 210.07, 109.08), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", coords = vector3(232.86, 221.46, 107.83), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", coords = vector3(252.27, 225.52, 103.99), r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", coords = vector3(-53.1433, -1746.714, 31.546), r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", coords = vector3(-1482.9, -380.463, 42.363), r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", coords = vector3(-1224.874, -911.094, 14.401), r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", coords = vector3(-718.153, -909.211, 21.49), r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", coords = vector3(23.885, -1342.441, 31.672), r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", coords = vector3(1133.024, -978.712, 48.515), r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", coords = vector3(1151.93, -320.389, 71.33), r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", coords = vector3(383.402, 328.915, 105.541), r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", coords = vector3(-1832.057, 789.389, 140.436), r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", coords = vector3(-2966.15, 387.067, 17.393), r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", coords = vector3(-3046.749, 592.491, 9.808), r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", coords = vector3(-3246.489, 1010.408, 14.705), r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", coords = vector3(539.773, 2664.904, 44.056), r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", coords = vector3(1169.855, 2711.493, 40.432), r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", coords = vector3(2673.579, 3281.265, 57.541), r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", coords = vector3(1966.24, 3749.545, 34.143), r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", coords = vector3(1729.522, 6419.87, 37.262), r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", coords = vector3(309.341, -281.439, 55.88), r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", coords = vector3(144.871, -1043.044, 31.017), r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", coords = vector3(-355.7643, -52.506, 50.746), r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", coords = vector3(-1214.226, -335.86, 39.515), r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", coords = vector3(-2958.885, 478.983, 17.406), r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", coords = vector3(-102.939, 6467.668, 33.424), r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", coords = vector3(-163.75, 6323.45, 33.424), r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", coords = vector3(166.42, 6634.4, 33.69), r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", coords = vector3(163.74, 6644.34, 33.69), r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", coords = vector3(169.54, 6640.89, 33.69), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Jewelery CAM#1", coords = vector3(-627.54, -239.74, 40.33), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Jewelery CAM#2", coords = vector3(-627.51, -229.51, 40.24), r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Jewelery CAM#3", coords = vector3(-620.3, -224.31, 40.23), r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Jewelery CAM#4", coords = vector3(-622.57, -236.3, 40.31), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}


-- DO NOT USE THIS @jackbatchiee
-- Config.AuthorizedVehicles = {
-- 	-- Grade 0
-- 	[0] = {
-- 		["police"] = "Police Car 1",
-- 	},
-- 	-- Grade 1
-- 	[1] = {
-- 		["police"] = "Police Car 1",
-- 		["police2"] = "Police Car 2",
-- 	},
-- 	-- Grade 2
-- 	[2] = {
-- 		["police"] = "Police Car 1",
-- 		["police2"] = "Police Car 2",
-- 		["police3"] = "Police Car 3",
-- 	},
-- 	-- Grade 3
-- 	[3] = {
-- 		["police"] = "Police Car 1",
-- 		["police2"] = "Police Car 2",
-- 		["police3"] = "Police Car 3",
-- 		["police4"] = "Police Car 4",
-- 	},
-- 	-- Grade 4
-- 	[4] = {
-- 		["police"] = "Police Car 1",
-- 		["police2"] = "Police Car 2",
-- 		["police3"] = "Police Car 3",
-- 		["police4"] = "Police Car 4",
-- 		["policeb"] = "Police Car 5",

-- 	}
-- }


-- USE THIS FOR POLICE VEHICLES @jackbatchiee 
-- Any Car Additions make sure they are ordered-Johnny
Config.PoliceGarage = {
    cars = {

        -- [[START OF PATROL VEHICLES]] --

        [1] = {
            ["model"] = "polskodakaroq",
            ["name"] = "Skoda Karoq",
            ["order"] = "1",
            ["access"] = {
                jobGrade = 1,
                flagName = nil,
                flagLevel = nil
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        [2] = {
            ["model"] = "polfordtransit",
            ["name"] = "Ford Transit",
            ["order"] = "2",
            ["access"] = {
                jobGrade = 1,
                flagName = nil,
                flagLevel = nil
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        [3] = {
            ["model"] = "polvolvov90",
            ["name"] = "Volvo V90 Estate",
            ["order"] = "3",
            ["access"] = {
                jobGrade = 2,
                flagName = nil,
                flagLevel = nil
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        [4] = {
            ["model"] = "polbmw530epat",
            ["name"] = "BMW 530e",
            ["order"] = "4",
            ["access"] = {
                jobGrade = 2,
                flagName = nil,
                flagLevel = nil
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        [5] = {
            ["model"] = "polbmw1200rt",
            ["name"] = "BMW 1200 RT",
            ["order"] = "5",
            ["access"] = {
                jobGrade = 2,
                flagName = nil,
                flagLevel = nil
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        [6] = {
            ["model"] = "poljaguarxfr",
            ["name"] = "Jaguar XFR",
            ["order"] = "6",
            ["access"] = {
                jobGrade = 3,
                flagName = nil,
                flagLevel = nil
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        [7] = {
            ["model"] = "polvolvoxc90",
            ["name"] = "Volvo XC90",
            ["order"] = "7",
            ["access"] = {
                jobGrade = 3,
                flagName = nil,
                flagLevel = nil
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        
        -- [[END OF BASIC PATROL VEHICLES]] --



        -- [[START OF TRAFFIC VEHICLES]] --

        [8] = {
            ["model"] = "polbmw530etrf", 
            ["name"] = "BMW 530e (Traffic)",
            ["order"] = "8",
            ["access"] = {
                jobGrade = 4,
                flagName = "traffic",
                flagLevel = 1 -- Trainee (TTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [9] = {
            ["model"] = "polskodaoctaviatrf",
            ["name"] = "Skoda Octavia (Traffic)",
            ["order"] = "9",
            ["access"] = {
                jobGrade = 4,
                flagName = "traffic",
                flagLevel = 2 -- Standard Rank (STO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [10] = {
            ["model"] = "polaudis3",
            ["name"] = "Audi S3 (Traffic)",
            ["order"] = "10",
            ["access"] = {
                jobGrade = 4,
                flagName = "traffic",
                flagLevel = 2 -- Standard Rank (STO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [11] = {
            ["model"] = "polbmw1200rttrf",
            ["name"] = "BMW 1200 RT (Traffic)",
            ["order"] = "11",
            ["access"] = {
                jobGrade = 4,
                flagName = "traffic",
                flagLevel = 3 -- Authorised Rank (ATO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [12] = {
            ["model"] = "polbmwm5trf",
            ["name"] = "BMW M5 (Traffic)",
            ["order"] = "12",
            ["access"] = {
                jobGrade = 4,
                flagName = "traffic",
                flagLevel = 3 -- Authorised Rank (ATO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [13] = {
            ["model"] = "polbmwm3",
            ["name"] = "BMW M3 (Traffic)",
            ["order"] = "13",
            ["access"] = {
                jobGrade = 4,
                flagName = "traffic",
                flagLevel = 3 -- Authorised Rank (ATO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [14] = {
            ["model"] = "shelby",
            ["name"] = "Ford Mustang Shelby (Traffic)",
            ["order"] = "14",
            ["access"] = {
                jobGrade = 4,
                flagName = "traffic",
                flagLevel = 4 -- Highest Rank (ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },

        -- [[END OF TRAFFIC VEHICLES]] --


        --[START OF CID VEHICLES]
        
        [15] = {
            ["model"] = "mache",
            ["name"] = "Ford MACHE (CID)",
            ["order"] = "15",
            ["access"] = {
                jobGrade = 3,
                flagName = "cid",
                flagLevel = 1 -- Rank 1 (ICTO)
            },
            ["mods"] = {
                turbo = 0,
            },
        },
        [16] = {
            ["model"] = "polcupraunm",
            ["name"] = "Cupra Leon Unmarked (CID)",
            ["order"] = "16",
            ["access"] = {
                jobGrade = 3,
                flagName = "cid",
                flagLevel = 2 -- Rank 2(ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [17] = {
            ["model"] = "polaudia4unm",
            ["name"] = "Audi A4 Unmarked (CID)",
            ["order"] = "17",
            ["access"] = {
                jobGrade = 3,
                flagName = "cid",
                flagLevel = 4  -- Incident Command Rank (ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [18] = {
            ["model"] = "polbmwm5unm",
            ["name"] = "BMW M5 Unmarked (CID)",
            ["order"] = "18",
            ["access"] = {
                jobGrade = 3,
                flagName = "cid",
                flagLevel = 4 -- Incident Command Rank (ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },

        [19] = {
            ["model"] = "um1",
            ["name"] = "Hammercats' Unmarked EVO 9",
            ["order"] = "19",
            ["access"] = {
                jobGrade = 3,
                flagName = "cid",
                flagLevel = 2 -- Incident Command Rank (ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },

        --[END OF CID VEHICLES]--

        --[START OF FIREARM VEHICLES]--


        [20] = {
            ["model"] = "polbmwx5sco",
            ["name"] = "BMW X5 ARV (SCO)",
            ["order"] = "20",
            ["access"] = {
                jobGrade = 3,
                flagName = "firearms",
                flagLevel = 1 -- Incident Command Rank (ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [21] = {
            ["model"] = "bmwarv",
            ["name"] = "BMW X5 ARV Unmarked (SCO)",
            ["order"] = "21",
            ["access"] = {
                jobGrade = 3,
                flagName = "firearms",
                flagLevel = 1 -- Incident Command Rank (ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [22] = {
            ["model"] = "skodaarv",
            ["name"] = "Skoda Octavia ARV (SCO)",
            ["order"] = "22",
            ["access"] = {
                jobGrade = 3,
                flagName = "firearms",
                flagLevel = 2 -- Incident Command Rank (ICTO)
            },
            ["mods"] = {
                turbo = 1,
            },
        },
        [23] = {
            ["model"] = "pollandrover",
            ["name"] = "Armoured LandRover (SCO)",
            ["order"] = "23",
            ["access"] = {
                jobGrade = 5,
                flagName = "firearms",
                flagLevel = 3 -- Incident Command Rank (ICTO)
            },
            ["mods"] = {
                turbo = 0,
            },
        },

        --[END OF FIREARM VEHICLES]--






        -- [16] = {
        --     ["model"] = "rppolice102",
        --     ["name"] = "Audi A4 (Interceptor)",
        --     ["order"] = "16",
        --     ["access"] = {
        --         jobGrade = 4,
        --         flagName = "traffic",
        --         flagLevel = 1
        --     },
        --     ["mods"] = {
        --         turbo = 1,
        --     },
        -- },
        -- [17] = {
        --     ["model"] = "21g30",
        --     ["name"] = "BMW G30 Unmarked ARV (Firearms)",
        --     ["order"] = "17",
        --     ["access"] = {
        --         jobGrade = 4,
        --         flagName = "firearms",
        --         flagLevel = 1
        --     },
        --     ["mods"] = {
        --         turbo = 1,
        --     },
        -- }
    },

    air = {
        [1] = {
            ["model"] = "polindia99",
            ["name"] = "EC 145",
            ["order"] = "1",
            ["access"] = {
                jobGrade = 3,
                flagName = "npas",
                flagLevel = 1
            },
        }
    }
    
}

Config.PoliceimpoundLocation = vector3(455.04, -1025.25, 28.48)

Config.GarageZones = {
    ['mrpd'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(463.69967651367, -973.04180908203),
                vector2(463.69543457031, -999.49151611328),
                vector2(423.46057128906, -998.91326904297),
                vector2(423.15774536133, -973.04022216797)
            },
            ['minZ'] = 24.0,  -- min height of the parking zone
            ['maxZ'] = 27.0,  -- max height of the parking zone
        },
        label = 'MRPD Service Vehicles',
        type = 'vehicle',
        drawText = 'MRPD Garage',
        ["ParkingSpots"] = {
            vector4(445.9, -986.29, 25.7, 90.0),
            vector4(446.06, -988.58, 25.7, 90.0),
            vector4(445.54, -991.43, 25.7, 90.0),
            vector4(445.75, -994.01, 25.7, 90.0),
            vector4(445.93, -996.65, 25.7, 90.0),
            vector4(437.69, -996.92, 25.7, 270.0),
            vector4(437.54, -994.62, 25.7, 270.0),
            vector4(437.31, -991.76, 25.7, 270.0),
            vector4(436.93, -988.94, 25.7, 270.0),
            vector4(437.18, -986.24, 25.7, 270.0)
        },
        ParkingDistance = 15.0,
        debug = false
    },
    ['paleto'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-470.9677734375, 6007.0146484375),
                vector2(-488.33682250977, 6024.4282226563),
                vector2(-460.90090942383, 6051.8676757813),
                vector2(-450.41876220703, 6041.3833007813),
                vector2(-464.59060668945, 6026.6733398438),
                vector2(-457.82373046875, 6020.765625)
            },
            ['minZ'] = 30.0,  -- min height of the parking zone
            ['maxZ'] = 34.0,  -- max height of the parking zone
        },
        label = 'Paleto PD Vehicles',
        type = 'vehicle',
        drawText = 'Paleto Garage',
        ["ParkingSpots"] = {
            vector4(-483.58, 6025.71, 31.34, 220.0), -- Paleto PD Normal Bay 1
            vector4(-479.46, 6028.37, 31.34, 220.0), -- Paleto PD Normal Bay 2
            vector4(-476.1, 6032.06, 31.34, 220.0), -- Paleto PD Normal Bay 3
            vector4(-472.9, 6035.88, 31.34, 220.0), -- Paleto PD Normal Bay 4
            vector4(-468.63, 6038.8, 31.34, 220.0), -- Paleto PD Normal Bay 5
            vector4(-461.15, 6047.36, 31.34, 135.86), -- Paleto PD Disabled Bay 1
            vector4(-458.09, 6044.18, 31.34, 128.49), -- Paleto PD Disabled Bay 2
            vector4(-455.15, 6040.73, 31.34, 172.74) -- Paleto PD Disabled Bay 3
        },
        ParkingDistance = 15.0,
        debug = false
    },
    ['policeimpound'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(451.79711914063, -1027.884765625),
                vector2(459.03997802734, -1026.5734863281),
                vector2(458.97213745117, -1022.85546875),
                vector2(451.64916992188, -1023.7705078125)
            },
            ['minZ'] = 28,  -- min height of the parking zone
            ['maxZ'] = 29,  -- max height of the parking zone
            debug = false,
        },
        label = "Police Impound",
        showBlip = false,
        blipName = "Impound Lot",
        blipNumber = 68,
        type = 'policeimpound', --public, job, gang, depot, policeimpound
        vehicleCategories = {'car', 'motorcycle', 'other'},
        drawText = 'Police Impound',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(446.23, -1024.74, 28.64, 6.03), -- MRPD Upper Bay 1
            vector4(442.41, -1025.3, 28.71, 1.93), -- MRPD Upper Bay 2
            vector4(438.71, -1026.01, 28.78, 1.48), -- MRPD Upper Bay 3
            vector4(434.8, -1026.36, 28.85, 10.3), -- MRPD Upper Bay 4
            vector4(431.04, -1026.29, 28.92, 3.43), -- MRPD Upper Bay 5
            vector4(427.46, -1026.47, 28.98, 3.21)  -- MRPD Upper Bay 6
        }
    },
}

Config.WhitelistedVehicles = {}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm parabellum bullet",
    ["AMMO_FAKETASER"] = "Taser cartrige for the X26 Taser",
    ["AMMO_STUNGUN"] = "Taser cartrige for the Taser 7",
    ["AMMO_SMG"] = "9x19mm parabellum bullet",
    ["AMMO_RIFLE"] = "7.62x39mm bullet",
    ["AMMO_MG"] = "7.92x57mm mauser bullet",
    ["AMMO_SHOTGUN"] = "12-gauge bullet",
    ["AMMO_SNIPER"] = "Large caliber bullet",
}

Config.Radars = {
	vector4(-623.44421386719, -823.08361816406, 25.25704574585, 145.0),
	vector4(-652.44421386719, -854.08361816406, 24.55704574585, 325.0),
	vector4(1623.0114746094, 1068.9924316406, 80.903594970703, 84.0),
	vector4(-2604.8994140625, 2996.3391113281, 27.528566360474, 175.0),
	vector4(2136.65234375, -591.81469726563, 94.272926330566, 318.0),
	vector4(2117.5764160156, -558.51013183594, 95.683128356934, 158.0),
	vector4(406.89505004883, -969.06286621094, 29.436267852783, 33.0),
	vector4(657.315, -218.819, 44.06, 320.0),
	vector4(2118.287, 6040.027, 50.928, 172.0),
	vector4(-106.304, -1127.5530, 30.778, 230.0),
	vector4(-823.3688, -1146.980, 8.0, 300.0),
}

Config.CarItems = {
    -- [1] = {
    --     name = "heavyarmor",
    --     amount = 2,
    --     info = {},
    --     type = "item",
    --     slot = 1,
    -- },
    -- [2] = {
    --     name = "empty_evidence_bag",
    --     amount = 10,
    --     info = {},
    --     type = "item",
    --     slot = 2,
    -- },
    -- [3] = {
    --     name = "police_stormram",
    --     amount = 1,
    --     info = {},
    --     type = "item",
    --     slot = 3,
    -- },
}

Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {

        ---------- STARTING WEAPONS/ITEMS

        [1] = {
            name = "handcuffs",
            price = 100,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            authorizedFirearms = {0, 1, 2, 3, 4, 5, 6, 7}
        },

        [2] = {
            name = "radio",
            price = 100,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
            authorizedFirearms = {0, 1, 2, 3, 4, 5, 6, 7}
        },

        [3] = {
            name = "weapon_nightstick",
            price = 1000,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3,
            authorizedFirearms = {0, 1, 2, 3, 4, 5, 6, 7}
        },

        [4] = {
            name = "ifak",
            price = 100,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
            authorizedFirearms = {0, 1, 2, 3, 4, 5, 6, 7}
        },

        [5] = {
            name = "weapon_flashlight",
            price = 500,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 5,
            authorizedFirearms = {0, 1, 2, 3, 4, 5, 6, 7}
        },

        [6] = {
            name = "empty_evidence_bag",
            price = 10,
            amount = 50,
            info = {},
            type = "item",
            slot = 6,
            authorizedFirearms = {0, 1, 2, 3, 4, 5, 6, 7}
        },

        [7] = {
            name = "heavyarmor",
            price = 1000,
            amount = 10,
            info = {},
            type = "item",
            slot = 7,
            authorizedFirearms = {0, 1, 2, 3, 4, 5, 6, 7}
        },

        ---------- Firearms Level 1 (Weapons Proficiency Taser only)

        -- [8] = {
        --     name = "weapon_stungun",
        --     price = 2000,
        --     amount = 1,
        --     info = {
        --         serie = "",
        --     },
        --     type = "weapon",
        --     slot = 8,
        --     authorizedFirearms = {1, 2, 3, 4, 5, 6, 7}
        -- },

        [8] = {
            name = "weapon_policetaser",
            price = 2000,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 8,
            authorizedFirearms = {1, 2, 3, 4, 5, 6, 7}
        },

        -- [9] = {
        --     name = "taser_prongs",
        --     price = 100,
        --     amount = 5,
        --     info = {},
        --     type = "item",
        --     slot = 9,
        --     authorizedFirearms = {1, 2, 3, 4, 5, 6, 7}
        -- },
        
        [9] = {
            name = "taser7_prongs",
            price = 100,
            amount = 5,
            info = {},
            type = "item",
            slot = 9,
            authorizedFirearms = {1, 2, 3, 4, 5, 6, 7}
        },

        ---------- Firearms Level 2 (Weapons Proficiency Tazer and Gun)

        [10] = {
            name = "weapon_pglock",
            price = 10000,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 10,
            authorizedFirearms = {2, 3, 4, 5, 6, 7}
        },

        [11] = {
            name = "pistol_ammobox",
            price = 1000,
            amount = 5,
            info = {},
            type = "item",
            slot = 11,
            authorizedFirearms = {2, 3, 4, 5, 6, 7}
        },

        ---------- Firearms Level 3 (AFO Weapons)

        [12] = {
            name = "weapon_smg",
            price = 14500,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "1x Scope"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_SMG_CLIP_02", label = "Extended Magazine"},
                }
            },
            type = "weapon",
            slot = 12,
            authorizedFirearms = {3, 4, 5, 6, 7}
        },

        [13] = {
            name = "smg_ammo",
            price = 500,
            amount = 5,
            info = {},
            type = "item",
            slot = 13,
            authorizedFirearms = {3, 4, 5, 6, 7}
        },

        ---------- Firearms Level 4 (SFO Weapons)

        [14] = {
            name = "weapon_pumpshotgun",
            price = 12000,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 14,
            authorizedFirearms = {4, 5, 6, 7}
        },

        [15] = {
            name = "weapon_pumpshotgun_mk2",
            price = 14000,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SR_SUPP_03", label = "Suppressor"},
                    {component = "COMPONENT_AT_SIGHTS", label = "Holo Sight"},
                }
            },
            type = "weapon",
            slot = 15,
            authorizedFirearms = {4, 5, 6, 7}
        },

        [16] = {
            name = "shotgun_ammo",
            price = 300,
            amount = 5,
            info = {},
            type = "item",
            slot = 16,
            authorizedFirearms = {4, 5, 6, 7}
        },
        
        [17] = {
            name = "weapon_carbinerifle",
            price = 18000,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                    {component = "COMPONENT_AT_AR_AFGRIP", label = "Grip"},
                    {component = "COMPONENT_CARBINERIFLE_CLIP_02", label = "Extended Clip"},
                }
            },
            type = "weapon",
            slot = 17,
            authorizedFirearms = {4, 5, 6, 7}
        },

        [18] = {
            name = "weapon_specialcarbine",
            price = 20000,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                    {component = "COMPONENT_AT_AR_AFGRIP", label = "Grip"},
                    {component = "COMPONENT_SPECIALCARBINE_CLIP_02", label = "Extended Clip"},
                }
            },
            type = "weapon",
            slot = 18,
            authorizedFirearms = {4, 5, 6, 7}
        },

        [19] = {
            name = "rifle_ammo",
            price = 500,
            amount = 5,
            info = {},
            type = "item",
            slot = 19,
            authorizedFirearms = {4, 5, 6, 7}
        },

        -- [20] = {
        --     name = "police_stormram",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 20,
        --     authorizedFirearms = {4, 5, 6, 7}
        -- },

        -----------  Firearms Level 5 (CTSFO AND COMMAND ITEMS)

        -- [21] = {
        --     name = "weapon_carbinerifle_mk2",
        --     price = 0,
        --     amount = 1,
        --     info = {
        --         serie = "",
        --         attachments = {
        --             {component = "COMPONENT_CARBINERIFLE_MK2_CLIP_02", label = "Extended Clip"},
        --             {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
        --             {component = "COMPONENT_AT_SIGHTS", label = "Holosight"},
        --             {component = "COMPONENT_AT_AR_SUPP", label = "Suppressor"},
        --             {component = "COMPONENT_AT_MUZZLE_05", label = "Heavy Duty Muzzle"},
        --             {component = "COMPONENT_AT_AR_AFGRIP_02", label = "Grip"},
        --             {component = "COMPONENT_AT_CR_BARREL_02", label = "Heavy Barrel"},
        --             {component = "COMPONENT_CARBINERIFLE_MK2_CAMO", label = "CTSFO Camo"},
        --         }
        --     },
        --     type = "weapon",
        --     slot = 21,
        --     authorizedFirearms = {5, 6, 7}
        -- },

        -- [22] = {
        --     name = "weapon_specialcarbine_mk2",
        --     price = 0,
        --     amount = 1,
        --     info = {
        --         serie = "",
        --         attachments = {
        --             {component = "COMPONENT_SPECIALCARBINE_MK2_CLIP_02", label = "Extended Clip"},
        --             {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
        --             {component = "COMPONENT_AT_SIGHTS", label = "Holosight"},
        --             {component = "COMPONENT_AT_AR_SUPP_02", label = "Suppressor"},
        --             {component = "COMPONENT_AT_MUZZLE_05", label = "Heavy Duty Muzzle"},
        --             {component = "COMPONENT_AT_AR_AFGRIP_02", label = "Grip"},
        --             {component = "COMPONENT_AT_SC_BARREL_02", label = "Heavy Barrel"},
        --             {component = "COMPONENT_SPECIALCARBINE_MK2_CAMO", label = "CTSFO Camo"},
        --         }
        --     },
        --     type = "weapon",
        --     slot = 22,
        --     authorizedFirearms = {5, 6, 7}
        -- },

        [27] = {
            name = "weapon_trainingglock",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_COMBATPISTOL_CLIP_01", label = "Magazine"},
                }
            },
            type = "weapon",
            slot = 27,
            authorizedFirearms = {7}
        },

        [28] = {
            name = "trainingrounds",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 28,
            authorizedFirearms = {7}
        },
        [29] = {
            name = "advancedrepairkit",
            price = 4500,
            amount = 5,
            info = {},
            type = "item",
            slot = 29,
            authorizedFirearms = {0,1,2,3,4,5,6,7}
        },

        -- [21] = {
        --     name = "weapon_bzgas",
        --     price = 0,
        --     amount = 5,
        --     info = {
        --         serie = "",
        --     },
        --     type = "weapon",
        --     slot = 31,
        --     authorizedFirearms = {5, 6, 7}
        -- },

        -- [22] = {
        --     name = "weapon_smokegrenade",
        --     price = 0,
        --     amount = 5,
        --     info = {
        --         serie = "",
        --     },
        --     type = "weapon",
        --     slot = 32,
        --     authorizedFirearms = {5, 6, 7}
        -- },
        
        [20] = {
            name = "breaching_charge",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 30,
            authorizedFirearms = {5, 6, 7}
        },
    }
}

Config.VehicleSettings = {
    ["car1"] = { --- Model name
        ["extras"] = {
            ["1"] = true, -- on/off
            ["2"] = true,
            ["3"] = true,
            ["4"] = true,
            ["5"] = true,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = true,
            ["12"] = true,
            ["13"] = true,
        },
		["livery"] = 1,
    },
    ["car2"] = {
        ["extras"] = {
            ["1"] = true,
            ["2"] = true,
            ["3"] = true,
            ["4"] = true,
            ["5"] = true,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = true,
            ["12"] = true,
            ["13"] = true,
        },
		["livery"] = 1,
    }
}
