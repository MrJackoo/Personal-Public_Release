Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.IdleCamera = true
Config.EnableProne = true
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- carwash
Config.DirtLevel = 0.1 --carwash dirt level

ConsumeablesEat = {
    ["sandwich"] = math.random(35, 54),
    ["tosti"] = math.random(40, 50),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
    ["apple"] = math.random(10, 20),
    ["beef"] = math.random(35, 50),
    ["corncob"] = math.random(25, 40),
    ["canofcorn"] = math.random(35, 50),
    ["grapes"] = math.random(10, 20),
    ["greenpepper"] = math.random(10, 20),
    ["chillypepper"] = math.random(10, 20),
    ["tomato"] = math.random(10, 20),
    ["tomatopaste"] = math.random(25, 40),
    ["cooked_bacon"] = math.random(35, 50),
    ["cooked_sausage"] = math.random(35, 50),
    ["cooked_pork"] = math.random(35, 50),
    ["cooked_ham"] = math.random(35, 50),
    ["vu_peanuts"] = math.random(20, 40),
}

ConsumeablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["kurkakola"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
    ["apple_juice"] = math.random(25, 45),
    ["grapejuice"] = math.random(25, 45),
    ["hotsauce"] = math.random(10, 15),
    ["milk"] = math.random(15, 25),
    ["vu_softdrink"] = math.random(20, 40),
    ["vu_mshake"] = math.random(20, 40),
}

ConsumablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
    ["vu_whiskey"] = math.random(20, 40),
    ["vu_cocktail"] = math.random(20, 40),
    ["vu_sourz"] = math.random(20, 40),
    ["vu_jagerbomb"] = math.random(20, 40),
    ["vu_dontstopdrinking"] = math.random(20, 40),
}

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`AIRTUG`] = true,
    [`akula`] = true,
    [`AKULA`] = true,
    [`ANNIHILATOR`] = true,
    [`ANNIHILATOR2`] = true,
    [`APC`] = true,
    [`armytanker`] = true,
    [`avenger`] = true,
    [`AVENGER`] = true,
    [`AVENGER2`] = true,
    [`BARRAGE`] = true,
    [`BESRA`] = true,
    [`BLIMP`] = true,
    [`blimp3`] = true,
    [`BOMBUSHKA`] = true,
    [`BUZZARD`] = true,
    [`BUZZARD2`] = true,
    [`CABLECAR`] = true,  
    [`CAMPER`] = true,
    [`caracara`] = true,
    [`CARGOBOB`] = true,   
    [`CARGOBOB2`] = true,  
    [`CARGOBOB3`] = true,  
    [`CARGOBOB4`] = true,
    [`CARGOPLANE`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`chernobog`] = true,
    [`CUTTER`] = true,
    [`deluxo`] = true,
    [`dinghy5`] = true,
    [`dominator4`] = true,
    [`dominator5`] = true,
    [`dominator6`] = true,
    [`dukes2`] = true,
    [`FIRETRUK`] = true,
    [`FREIGHT`] = true,
    [`FREIGHTCAR`] = true,
    [`FREIGHTCON1`] = true,
    [`FREIGHTCON2`] = true,
    [`FREIGHTGRAIN`] = true,
    [`HALFTRACK`] = true,
    [`HUNTER`] = true,
    [`HYDRA`] = true,
    [`INSURGENT`] = true,
    [`insurgent3`] = true,
    [`JET`] = true,
    [`KHANJALI`] = true,
    ['speedo4'] = true,
    [`kosatka`] = true,
    [`LAZER`] = true,
    [`LUXOR`] = true,
    [`LUXOR2`] = true,
    [`mammatus`] = true,
    [`MAVERICK`] = true,
    [`MENACER`] = true,
    [`METROTRAIN`] = true,
    [`miljet`] = true,
    [`MINITANK`] = true,
    [`MOGUL`] = true,
    [`MOLOTOK`] = true,
    [`NOKOTA`] = true,
    [`OPPRESSOR`] = true,
    [`oppressor2`] = true,
    [`patrolboat`] = true,
    [`phantom2`] = true,
    [`PYRO`] = true,
    [`Revolter`] = true,
    [`RHINO`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`SAVAGE`] = true,
    [`Savestra`] = true,
    [`scarab`] = true,
    [`SCARAB`] = true,
    [`scarab2`] = true,
    [`SCARAB2`] = true,
    [`scarab3`] = true,
    [`SCARAB3`] = true,
    [`scramjet`] = true,
    [`SHAMAL`] = true,
    [`STARLING`] = true,
    [`STRIKEFORCE`] = true,
    [`tampa3`] = true,
    [`tanker`] = true,
    [`tanker2`] = true,
    [`tankercar`] = true,
    [`TANKERCAR`] = true,
    [`TECHNICAL`] = true,
    [`technical1`] = true,
    [`TECHNICAL2`] = true,
    [`TECHNICAL3`] = true,
    [`terbyte`] = true,
    [`thruster`] = true,
    [`TITAN`] = true,
    [`TRAILERSMALL2`] = true,
    [`tug`] = true,
    [`TULA`] = true,
    [`VALKYRIE`] = true,
    [`VALKYRIE2`] = true,
    [`velum`] = true,
    [`velum2`] = true,
    [`vestra`] = true,
    [`vigilante`] = true,
    [`Viseris`] = true,
    [`volatol`] = true,
    [`VOLATOL`] = true,    
    [`volatus`] = true,
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

Config.Teleports = {
    --Black Market Medical
    [1] = {
        [1] = {
            coords = vector4(241.13, -1378.85, 33.74, 136.6),
            ["AllowVehicle"] = false, 
            drawText = '[E] Shady Medical Clinic'
        },
        [2] = {
            coords = vector4(275.69, -1361.47, 24.54, 46.23),
            ["AllowVehicle"] = false,
            drawText = '[E] Leave'
        },
    },
    --Elevator @ labs
    [2] = {
        [1] = {
            coords = vector4(3540.74, 3675.59, 20.99, 167.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Up'
        },
        [2] = {
            coords = vector4(3540.74, 3675.59, 28.11, 172.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Down'
        },

    },
    --Coke Processing
    [3] = {
        [1] = {
            coords = vector4(1098.24, -1275.12, 20.72, 157.86),
            ["AllowVehicle"] = false,
            drawText = '[E] Enter'
        },
        [2] = {
            coords = vector4(1088.68, -3187.68, -38.99, 176.04),
            ["AllowVehicle"] = false,
            drawText = '[E] Exit'
        },
    },
    -- Weed Processing
    [4] = {
        [1] = {
            coords = vector4(-592.57, -1765.24, 23.18, 54.59),
            ["AllowVehicle"] = false,
            drawText = '[E] Enter'
        },
        [2] = {
            coords = vector4(1066.3, -3183.46, -39.16, 269.56),
            ["AllowVehicle"] = false,
            drawText = '[E] Exit'
        },
    },
    -- Brotherhood Office
    -- [5] = {
    --     [1] = {
    --         coords = vector4(-70.99, -801.01, 44.23, 159.98),
    --         ["AllowVehicle"] = false,
    --         drawText = '[E] Enter'
    --     },
    --     [2] = {
    --         coords = vector4(-76.57, -830.29, 243.39, 250.65),
    --         ["AllowVehicle"] = false,
    --         drawText = '[E] Exit'
    --     },
    -- },
}

Config.Weapons = {
    "WEAPON_BAT",
    "WEAPON_CROWBAR",
    "WEAPON_GOLFLCUB",
    "WEAPON_HAMMER",
    "WEAPON_KNUCKLE",
    "WEAPON_POOLCUE",
    "WEAPON_UNARMED",
    "WEAPON_WRENCH",
}

-- Config.CarWash = { -- carwash
--     [1] = {
--         ["label"] = "Hands Free Carwash",
--         ["coords"] = vector3(25.29, -1391.96, 29.33),
--     },
--     [2] = {
--         ["label"] = "Hands Free Carwash",
--         ["coords"] = vector3(174.18, -1736.66, 29.35),
--     },
--     [3] = {
--         ["label"] = "Hands Free Carwash",
--         ["coords"] = vector3(-74.56, 6427.87, 31.44),
--     },
--     [5] = {
--         ["label"] = "Hands Free Carwash",
--         ["coords"] = vector3(1363.22, 3592.7, 34.92),
--     },
--     [6] = {
--         ["label"] = "Hands Free Carwash",
--         ["coords"] = vector3(-699.62, -932.7, 19.01),
--     }
-- }
