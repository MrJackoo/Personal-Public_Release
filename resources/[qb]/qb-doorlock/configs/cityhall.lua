

-- Gov Office created by Johnny
Config.DoorList['cityhall-Gov Office'] = {
    objYaw = 209.99301147461,
    doorRate = 1.0,
    doorLabel = 'Gov Office',
    authorizedJobs = { ['government'] = 0 },
    distance = 2,
    doorType = 'door',
    objCoords = vec3(-536.187256, -189.414230, 43.469841),
    fixText = false,
    locked = false,
    objName = 1762042010,
}

-- Judge Room created by NULL
Config.DoorList['cityhall-Judge Room'] = {
    objYaw = 119.9930267334,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['judge'] = 0 },
    distance = 2,
    doorType = 'door',
    objCoords = vec3(-582.504150, -207.498291, 38.324986),
    fixText = false,
    objName = 1762042010,
}

-- Jury created by NULL
Config.DoorList['cityhall-Jury'] = {
    objYaw = 299.99304199219,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['judge'] = 0, ['police'] = 0, ['lawyer'] = 0, ['government'] = 0 },
    distance = 2,
    doorType = 'door',
    objCoords = vec3(-577.245911, -216.608414, 38.324986),
    fixText = false,
    objName = 1762042010,
}

-- Hallway created by NULL
Config.DoorList['cityhall-Hallway'] = {
    objYaw = 209.99301147461,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['judge'] = 0, ['police'] = 0, ['lawyer'] = 0, ['government'] = 0 },
    distance = 2,
    doorType = 'door',
    objCoords = vec3(-574.585754, -216.934006, 38.324986),
    fixText = false,
    objName = 1762042010,
}

-- Cells created by NULL
Config.DoorList['cityhall-Cells'] = {
    objYaw = 119.99295806885,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['judge'] = 0, ['police'] = 0, ['lawyer'] = 0, ['government'] = 0 },
    distance = 2,
    doorType = 'door',
    objCoords = vec3(-562.688843, -231.688843, 34.372242),
    fixText = false,
    objName = 1762042010,
}

-- Cell 1 created by NULL
Config.DoorList['cityhall-Cell 1'] = {
    objYaw = 209.99299621582,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['judge'] = 0, ['police'] = 0, ['government'] = 0 },
    distance = 2,
    doorType = 'door',
    objCoords = vec3(-557.944092, -233.110657, 34.477104),
    fixText = false,
    objName = 918828907,
}

-- Cell 2 created by NULL
Config.DoorList['cityhall-Cell 2'] = {
    objYaw = 209.99299621582,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['judge'] = 0, ['police'] = 0, ['government'] = 0 },
    distance = 2,
    doorType = 'door',
    objCoords = vec3(-560.542358, -234.610321, 34.477104),
    fixText = false,
    objName = 918828907,
}

-- Back Doors created by NULL
Config.DoorList['cityhall-Back Doors'] = {
    doorType = 'double',
    doorRate = 1.0,
    doors = {
        {objName = 297112647, objYaw = 299.99304199219, objCoords = vec3(-567.488220, -236.265335, 34.357502)},
        {objName = 830788581, objYaw = 119.99298858643, objCoords = vec3(-568.551086, -234.423874, 34.357502)}
    },
    locked = true,
    authorizedJobs = { ['judge'] = 0, ['police'] = 0, ['government'] = 0 },
    distance = 2,
}

-- Court Doors created by NULL
Config.DoorList['cityhall-Court Doors'] = {
    doorType = 'double',
    doorRate = 1.0,
    doors = {
        {objName = -1940023190, objYaw = 119.9930267334, objCoords = vec3(-562.777954, -201.440475, 38.436642)},
        {objName = -1940023190, objYaw = 299.99304199219, objCoords = vec3(-562.128296, -202.566101, 38.436642)}
    },
    locked = false,
    authorizedJobs = { ['judge'] = 0, ['police'] = 0, ['government'] = 0 },
    distance = 2,
}