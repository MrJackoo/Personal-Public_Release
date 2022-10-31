Config = {}
Config.Teleports = {
    ['moneylaundering'] = {
        drawText = 'Door',
        drawTextLocation = 'left',
        radialTitle = "Door",
        boxZoneWidth = 2,
        boxZoneLength = 2,
        header = 'Money Wash',
        debug = false,
        teleports = {
            [1] = {
                id="exit",
                title = "Inside",
                coords = vector4(1138.19, -3199.13, -39.67, 175.01),
                range = 2.5,
                soundfile = "DoorOpen", -- soundfile in [standalon]/interact-sound/client/html/sounds
                soundDistance = 1.0,
            },
            [2] = {
                id = "entrance",
                title = "Outside",
                coords = vector4(1017.56, -2529.06, 28.3, 262.23),
                range = 1.5,
                soundfile = "DoorClose",
                soundDistance = 1.0,
            },
        }
    },
    -- ['weaponcrafting'] = {
    --     drawText = 'Door',
    --     drawTextLocation = 'left',
    --     radialTitle = "Door",
    --     boxZoneWidth = 2,
    --     boxZoneLength = 2,
    --     header = 'Unknown Location',
    --     debug = false,
    --     teleports = {
    --         [1] = {
    --             id="roof",
    --             title = "Entrance",
    --             coords = vector4(1242.202637, -3196.683838, 6.028232, 281.251617),
    --             requiredItem = 'purple_key',
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0
    --         },
    --         [2] = {
    --             id = "basement",
    --             title = "Basement",
    --             coords = vector4(857.21, -3250.11, -99.32, 357.46),
    --             requiredItem = 'purple_key',
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0
    --         },
    --     }
    -- },
    --Maze Bank
    ['mazebank'] = {
        drawText = 'Elevator',
        drawTextLocation = 'left',
        radialTitle = "Elevator",
        boxZoneWidth = 3,
        boxZoneLength = 3,
        header = 'Maze Bank',
        debug = false,
        teleports = {
            [1] = {
                id = "ground",
                title = "Ground floor",
                coords = {
                    [1] = {
                        id = "frontdoor1",
                        title = "Front Door 1",
                        coords = vector4(-66.9, -802.48, 43.23, 150.95),
                        range = 2.5,
                        vehicleTeleport = false,
                        soundfile = "elevator",
                        soundDistance = 1.0
                    },
                    [2] = {
                        id = "frontdoor2",
                        title = "Front Door 2",
                        coords = vector4(-71.29, -801.03, 43.23, 338.55),
                        range = 2.5,
                        vehicleTeleport = false,
                        soundfile = "elevator",
                        soundDistance = 1.0
                    },
                },
                range = 2.5,
                vehicleTeleport = false,
                soundfile = "elevator",
                soundDistance = 1.0
            },
            [2] = {
                id = "brotherhood_garage",
                title = "Brotherhood Garage",
                coords = vector4(-91.86, -821.20, 221.00, 248.3),
                drawText = 'Elevator',
                range = 2.5,
                vehicleTeleport = false,
                soundfile = "elevator",
                soundDistance = 1.0
            },
            [3] = {
                id = "brotherhood_office",
                title = "Brotherhood Office",
                coords = vector4(-76.69, -830.38, 242.39, 79.89),
                drawText = 'Elevator',
                range = 2.5,
                vehicleTeleport = false,
                soundfile = "elevator",
                soundDistance = 1.0
            },
            [4] = {
                id = "roof",
                title = "Roof",
                coords = vector4(-74.98, -824.33, 320.29, 346.57),
                drawText = 'Elevator',
                range = 2.5,
                vehicleTeleport = false,
                soundfile = "elevator",
                soundDistance = 1.0
            },
        }
    },
    ['mazebankgarage'] = {
        drawText = 'Vehicle Elevator',
        drawTextLocation = 'left',
        radialTitle = "Vehicle Elevator",
        boxZoneWidth = 5,
        boxZoneLength = 5,
        header = 'Maze Bank Vehicle Elevator',
        debug = false,
        teleports = {
            [1] = {
                id = "ground",
                title = "Ground floor",
                coords = vector4(-84.28, -821.71, 36.03, 351.74),
                range = 5,
                vehicleTeleport = true,
                soundfile = "elevator",
                soundDistance = 1.0,
            },
            [2] = {
                id = "brotherhood_vehicle_garage",
                title = "Brotherhood Vehicle Elevator",
                coords = vector4(-85.15, -831.39, 222.0, 349.44),
                drawText = 'Vehicle Elevator',
                range = 5,
                vehicleTeleport = true,
                soundfile = "elevator",
                soundDistance = 1.0
            },
        }
    },

    ['lfbgarage'] = {
        drawText = 'Enter Garage',
        drawTextLocation = 'left',
        radialTitle = "Enter Garage",
        boxZoneWidth = 5,
        boxZoneLength = 5,
        header = 'Syndicate Garage',
        debug = false,
        teleports = {
            [1] = {
                id = "enter",
                title = "Outside",
                coords = vector4(1407.54, 1118.36, 114.84, 179.05),
                drawText = 'Outside',
                range = 5,
                vehicleTeleport = true
            },
            [2] = {
                id = "syndicate_vehicle_garage",
                title = "Syndicate Vehicle Garage",
                coords = vector4(173.17, -1006.21, -99.0, 0.54),
                drawText = 'Syndicate Vehicle Garage',
                range = 5,
                vehicleTeleport = true
            },
        }
    },
    -- ['eclipsetower'] = {
    --     drawText = 'Elevator',
    --     drawTextLocation = 'left',
    --     radialTitle = "Elevator",
    --     boxZoneWidth = 3,
    --     boxZoneLength = 3,
    --     header = 'Eclipse Tower',
    --     debug = false,
    --     teleports = {
    --         [1] = {
    --             id = 'ground',
    --             coords = vector4(-770.58, 312.93, 84.7, 173.63),
    --             title = 'Ground floor',
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0,
    --         },
    --         [2] = {
    --             id = 'floor14',
    --             coords = vector4(-781.85, 325.96, 175.8, 175.87),
    --             title = "Floor 14",
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0
    --         },
    --         [3] = {
    --             id = 'floor15',
    --             coords = vector4(-787.45, 315.73, 186.91, 273.17),
    --             title = "Floor 15",
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0
    --         },
    --         [4] = {
    --             id = 'floor19',
    --             coords = vector4(-785.21, 323.8, 211.0, 271.35),
    --             title = "Floor 19",
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0
    --         },
    --         [5] = {
    --             id = 'floor21',
    --             coords = vector4(-781.98, 326.23, 222.26, 190.06),
    --             title = "Floor 21",
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0
    --         },
    --         [6] = {
    --             id = 'roof',
    --             coords = vector4(-754.91, 334.69, 229.64, 81.08),
    --             title = "Roof",
    --             range = 2.5,
    --             soundfile = "elevator",
    --             soundDistance = 1.0
    --         },
    --     }
    -- },
}



