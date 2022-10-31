Config = {}

Config.Items = {'plastic','iron','glass','steel'}
Config.WaitTime = 60 -- in minutes

Config.RewardTypes = {
    [1] = {
        type = "item"
    },
    [2] = {
        type = "money",
        maxAmount = 500
    }
}

Config.DumpsterRewards = {
    ["tier1"] = {
        [1] = {item = 'water_bottle', minAmount = 1, maxAmount = 3},
    },
    ["tier2"] = {
        [1] = {item = 'hunting_bait', minAmount = 1, maxAmount = 3},
    },
    ["tier3"] = {
        [1] = {item = 'steel', minAmount = 6, maxAmount = 14},
    },
    ["tier4"] = {
        [1] = {item = 'glass', minAmount = 6, maxAmount = 14},
    },
    ["tier5"] = {
        [1] = {item = 'iron', minAmount = 10, maxAmount = 16},
    },
    ["tier6"] = {
        [1] = {item = 'plastic', minAmount = 10, maxAmount = 16},
        [1] = {item = 'weedbaggy', minAmount = 1, maxAmount = 3},
    },
    ["tier7"] = {
        [1] = {item = 'weapon_bottle', minAmount = 1, maxAmount = 2},
        [2] = {item = 'fishingrod', minAmount = 1, maxAmount = 2},
    },
    ["tier8"] = {
        [1] = {item = 'advancedlockpick', minAmount = 1, maxAmount = 1},
    },
    ["tier9"] = {
        [1] = {item = 'diamond_ring', minAmount = 2, maxAmount = 4},
        [2] = {item = 'pistol_ammobox', minAmount = 1, maxAmount = 2},
        [3] = {item = 'recoveredssd', minAmount = 1, maxAmount = 1},
        [4] = {item = 'securitycard1', minAmount = 1, maxAmount = 1},
    },
    ["tier10"] = {
        [1] = {item = '10kgoldchain', minAmount = 3, maxAmount = 5},
        [2] = {item = 'heavyarmor', minAmount = 1, maxAmount = 2},
        [3] = {item = 'barrel_pistol', minAmount = 1, maxAmount = 2},
        [4] = {item = 'frame_pistol', minAmount = 1, maxAmount = 2},
    },
}