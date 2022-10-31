Config = {}

Config.PawnLocation = vector3(-265.59, 235.65, 90.57)
Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = false -- Set to false if you want the pawnshop open 24/7
Config.TimeOpen = 7 -- Opening Time
Config.TimeClosed = 17 -- Closing Time
Config.SendMeltingEmail = true
Config.NPCLoc = vector4(-265.71, 236.75, 89.57, 91.17)
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.EmailSender = "Pawn Shop"
Config.EmailSubject = "Melting Items"
Config.EmailMessage = "We finished melting your items. You can come pick them up at any time."

Config.PawnItems = {
    [1] = {
        item = "goldchain",
        price = math.random(200, 250)
    },
    [2] = {
        item = "diamond_ring",
        price = math.random(250, 500)
    },
    [3] = {
        item = "rolex",
        price = math.random(500, 750)
    },
    [4] = {
        item = "10kgoldchain",
        price = math.random(250, 350)
    },
    [5] = {
        item = "tablet",
        price = math.random(500, 750)
    },
    [6] = {
        item = "iphone",
        price = math.random(250, 350)
    },
    [7] = {
        item = "samsungphone",
        price = math.random(250, 350)
    },
    [8] = {
        item = "laptop",
        price = math.random(750, 1000)
    },
    [9] = {
        item = "diamond",
        price = math.random(1000, 2500)
    },
    [10] = {
        item = "goldbar",
        price = math.random(7500, 10000)
    },
    [11] = {
        item = "sapphire_necklace",
        price = math.random(1000, 1500)
    },
    [12] = {
        item = "ruby_necklace",
        price = math.random(1500, 1750)
    },
    [13] = {
        item = "emerald_necklace",
        price = math.random(1750, 2000)
    },
    [14] = {
        item = "diamond_necklace",
        price = math.random(2000, 2500)
    },
    [15] = {
        item = "weapon_golfclub",
        price = math.random(50, 100)
    },
}