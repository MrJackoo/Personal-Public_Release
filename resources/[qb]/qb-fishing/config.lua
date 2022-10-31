Config = {}

Config.Fish24hours = true                                       -- [true = fish anytime] [false = fishing only available moring to night (6am to 11pm in-game time)]
Config.FishingWaitTime = {
    minTime = 5000,
    maxTime = 10000
}     -- How long a player will be waiting to fish, during or after casting fishingrod
Config.RentalBoat = "tug"                                    -- Fishing boat of Choice
Config.StopFishing =  73                                        -- Stop Fishing Key [X] (https://docs.fivem.net/docs/game-references/controls/)
Config.BoatPrice = 100                                          -- Price of the boat rental, price is divided when boat is returned
Config.TestFish = false											-- Test Fish with commands /startfish or /spawnfish
Config.Skillbar = "np-skillbar"                             	-- Must choose one of the avalible skillbars ["reload-skillbar","np-skillbar","qb-skillbar"]
Config.targetExport = "qb-target"  

Config.PearlsSellsBlip = vector3(-1816.406, -1193.334, 13.305)  -- Blip to sell fish you have caught

-- Config.BoatSpawnLocation = {
--     -- LaPuerta	= vector4(-802.05, -1504.36, -0.47, 112.27),
-- }
-- Config.PlayerReturnLocation = {
--     -- LaPuerta = vector4(-802.883, -1495.654, 1.595, 294.265),      
-- }

Config.FishingAreas = {
	-- {
	-- 	label = "Fishing",
    --     name = "Pier Fishing 1"
	-- 	coords = vector3(-1845.56, -1253.18, 8.62),
    --     width = 2.5,
    --     length = 51.9,
    --     heading = 230,
	-- },
    {
        label = "Pier Fishing",
        coords = vector3(-3427.75, 967.17, 8.35)
    }
}


-- Gear
Config.fishingRodPrice = 75                                     -- Price of a fishing rod
Config.fishingBaitPrice = 10                                     -- Price of fishing bait
-- Config.BoatAnchorPrice = 500                                  -- Price of a Boat Anchor
Config.FishingBoxPrice = 1000                                    -- Price of a Fishing Ice Box

Config.MaxAmountOfBait = 100

-- Regular Fish
Config.mackerelPrice     = 50                                    -- Price of Mackerel
Config.codfishPrice      = 100                                   -- Price of Cod
Config.bassPrice         = 220                                   -- Price of Normal Fish
Config.flounderPrice     = 300                                   -- Price of Flounder
Config.stingrayPrice     = 300                                   -- Price of Stingrays

-- Exotic Fish
Config.dolphinPrice      = 600                                  -- Price of Dolphins
Config.sharktigerPrice   = 800                                  -- Price of Tigersharks
Config.sharkhammerPrice  = 900                                  -- Price of Hammerhead Sharks
Config.killerwhalePrice  = 700                                  -- Price of Killer whales

-- Rewards
Config.smallLootboxCash = 100                                   -- Price of the cash reward for the "Metal Box"
Config.smallLootboxReward = 'diamond_ring'                       -- Item reward besides the "Corroded Key"

Config.largeLootboxRewards = {                                   -- Rewards found in the treasure chest (keep price = 0)
    [1] = { name = "goldbar", amount = 1},
	[2] = { name = "rolex", amount = 1},
    [3] = { name = "diamond_ring", amount = 1},
    [4] = { name = "weapon_switchblade", amount = 1},
    [5] = { name = "brokenlaptop", amount = 1},
}

Config.Shop = {
    ["name"] = "fishingshop",
    ["label"] = "Fishing Shop"
}

Config.fishingShopItem = {
    [1] = {
        name = 'fishingrod',
        price = 500,
        amount = Config.MaxAmountOfBait,
        info = {},
        type = 'item',
        slot = 1
    },
    [2] = {
        name = 'fishbait',
        price = 100,
        amount = Config.MaxAmountOfBait,
        info = {},
        type = 'item',
        slot = 2
    }
    -- [3] = {
    --     name = 'fishicebox',
    --     price = 200,
    --     amount = 50,
    --     info = {},
    --     type = 'item',
    --     slot = 3
    -- }
}

-- [SOURCE: https://github.com/sjpfeiffer/ped_spawner]
-- Config.PedList = {                                              -- Peds that will be spawned in (if you change a ped model here you need to also change the ped model in client/addons.lua qb-target exports)
-- 	-- {
-- 	-- 	model = "s_m_y_ammucity_01",                            -- Boat/Gear Menu
-- 	-- 	coords = vector3(-806.17, -1496.57, 0.6),               
-- 	-- 	heading = 100.0,
-- 	-- 	gender = "male",
--     --     scenario = "WORLD_HUMAN_STAND_FISHING"
-- 	-- },
--     {
-- 		model = "s_m_y_busboy_01",
-- 		coords = vector3(-1816.406, -1193.334, 13.305),         -- Regular/Exotic Fish Sells
-- 		heading = 325.172,
-- 		gender = "male",
--         scenario = "WORLD_HUMAN_CLIPBOARD"
-- 	},
-- }

Config.Peds = {
    -- Fishing Ped
    {
        model = "s_m_y_busboy_01",
        coords = vector4(-1817.05, -1193.51, 13.3, 327.12),
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        fishingstore = true,
        illegalstore = true,

    }

}