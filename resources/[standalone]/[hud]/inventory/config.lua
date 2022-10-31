Config = {}

Config.CleanupDropTime = 15 * 60 -- How many seconds it takes for drops to be untouched before being deleted
Config.MaxDropViewDistance = 12.5 -- The distance in GTA Units that a drop can be seen
Config.UseItemDrop = false -- This will enable item object to spawn on drops instead of markers
Config.ItemDropObject = "prop_paper_bag_01" -- if Config.UseItemDrop is true, this will be the prop that spawns for the item

-- Config.VendingObjects = {
--     "prop_vend_soda_01",
--     "prop_vend_soda_02",
-- }

-- Config.VendingWaterObjects = {
--     "prop_vend_water_01",
--     "prop_watercooler",
-- }

-- Config.VendingFoodObjects = {
--     "prop_vend_snak_01",
-- }

-- Config.VendingCoffeeObjects = {
--     "prop_vend_coffe_01",
-- }

Config.VendingObjects = {
    [1] = {
        model = 'prop_vend_soda_01',
        name = "Soda 1"
    },
    [2] = {
        model = 'prop_vend_soda_02',
        name = "Soda 2"
    },
    [3] = {
        model = 'prop_vend_snak_01',
        name = "Food 1"
    },
    [4] = {
        model = 'prop_watercooler',
        name = "Water 1"
    },
    [5] = {
        model = 'prop_vend_coffe_01',
        name = "Coffee 1"
    },
}

Config.BinObjects = {
    "prop_bin_05a",
    "prop_bin_04a",
    "prop_bin_10a",
    "prop_bin_10b",
    "prop_bin_11a",
    "prop_bin_11b",
    "prop_bin_12a",
    "prop_bin_13a",
    "prop_bin_14a",
    "prop_bin_14b",
    "prop_bin_beach_01d",
    "prop_bin_delpiero",
    "prop_bin_delpiero_b",
    "prop_dumpster_3a",
    "prop_dumpster_3step",
    "prop_dumpster_4a",
    "prop_dumpster_4b",
}

--Config.CraftingObject = `prop_toolchest_05` -- Only needed if not using target | Line 928 to change Target Models

-- Config.VendingItem = {
--     [1] = {
--         name = "kurkakola",
--         price = 100,
--         amount = 10,
--         info = {},
--         type = "item",
--         slot = 1,
--     },
--     [2] = {
--         name = "apple_juice",
--         price = 100,
--         amount = 10,
--         info = {},
--         type = "item",
--         slot = 2,
--     },
--     [3] = {
--         name = "grapejuice",
--         price = 100,
--         amount = 10,
--         info = {},
--         type = "item",
--         slot = 3,
--     },
--     [4] = {
--         name = "milk",
--         price = 100,
--         amount = 10,
--         info = {},
--         type = "item",
--         slot = 4,
--     },
-- }

-- Config.VendingFoodItem = {
--     [1] = {
--         name = "sandwich",
--         price = 125,
--         amount = 15,
--         info = {},
--         type = "item",
--         slot = 1,
--     },
--     [2] = {
--         name = "tosti",
--         price = 125,
--         amount = 15,
--         info = {},
--         type = "item",
--         slot = 2,
--     },
--     [3] = {
--         name = "twerks_candy",
--         price = 125,
--         amount = 15,
--         info = {},
--         type = "item",
--         slot = 3,
--     },
--     [4] = {
--         name = "snikkel_candy",
--         price = 125,
--         amount = 15,
--         info = {},
--         type = "item",
--         slot = 4,
--     },
-- }

-- Config.VendingWaterItem = {
--     [1] = {
--         name = "water_bottle",
--         price = 10,
--         amount = 10,
--         info = {},
--         type = "item",
--         slot = 1,
--     },
-- }

-- Config.VendingCoffeeItem = {
--     [1] = {
--         name = "coffee",
--         price = 25,
--         amount = 10,
--         info = {},
--         type = "item",
--         slot = 1,
--     },
-- }

Config.VendingSoda1 = {
    [1] = {
        name = "kurkakola",
        price = 100,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "apple_juice",
        price = 100,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
}

Config.VendingSoda2 = {
    [1] = {
        name = "grapejuice",
        price = 100,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "milk",
        price = 100,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
}

Config.VendingSnacks = {
    [1] = {
        name = "sandwich",
        price = 125,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "tosti",
        price = 125,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "twerks_candy",
        price = 125,
        amount = 50,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "snikkel_candy",
        price = 125,
        amount = 50,
        info = {},
        type = "item",
        slot = 4,
    },
}

Config.Vendingwater = {
    [1] = {
        name = "water_bottle",
        price = 25,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
}

Config.VendingCoffee = {
    [1] = {
        name = "coffee",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
}

MaxInventorySlots = 41

BackEngineVehicles = {
    [`ninef`] = true,
    [`adder`] = true,
    [`vagner`] = true,
    [`t20`] = true,
    [`infernus`] = true,
    [`zentorno`] = true,
    [`reaper`] = true,
    [`comet2`] = true,
    [`comet3`] = true,
    [`jester`] = true,
    [`jester2`] = true,
    [`cheetah`] = true,
    [`cheetah2`] = true,
    [`prototipo`] = true,
    [`turismor`] = true,
    [`pfister811`] = true,
    [`ardent`] = true,
    [`nero`] = true,
    [`nero2`] = true,
    [`tempesta`] = true,
    [`vacca`] = true,
    [`bullet`] = true,
    [`osiris`] = true,
    [`entityxf`] = true,
    [`turismo2`] = true,
    [`fmj`] = true,
    [`re7b`] = true,
    [`tyrus`] = true,
    [`italigtb`] = true,
    [`penetrator`] = true,
    [`monroe`] = true,
    [`ninef2`] = true,
    [`stingergt`] = true,
    [`surfer`] = true,
    [`surfer2`] = true,
    [`gp1`] = true,
    [`autarch`] = true,
    [`tyrant`] = true
}

Config.MaximumAmmoValues = {
    ["pistol"] = 250,
    ["smg"] = 250,
    ["shotgun"] = 200,
    ["rifle"] = 250,
}