QB = {}
Config = {}

-- Default Spawns
QB.Spawns = {
    -- ["legion"] = {
    --     coords = vector4(162.4, -983.56, 30.09, 133.25),
    --     location = "legion",
    --     label = "Legion Square",
    -- },
}

 -- Factions Spawns
QB.PoliceSpawns = {
    ["mrpd"] = { -- Needs to be unique
        coords = vector4(427.06, -984.96, 30.71, 3.24), -- Coords player will be spawned
        location = "mrpd", -- Needs to be unique
        label = "Mission Row Police Station", -- This is the label which will show up in selection menu.
    },
}

QB.NHSSpawns = {
    ["pillbox"] = { -- Needs to be unique
        coords = vector4(287.94, -613.28, 43.41, 342.95), -- Coords player will be spawned
        location = "pillbox", -- Needs to be unique
        label = "Main Hospital", -- This is the label which will show up in selection menu.
    },
}

QB.SpawnsJailed = {
    ["prison"] = { -- Needs to be unique
        coords = vector4(1746.58, 2511.08, 45.57, 30.38), -- Coords player will be spawned
        location = "prison", -- Needs to be unique
        label = "Bolingbroke Prison", -- This is the label which will show up in selection menu.
    },
}

Config.Houses = {}
