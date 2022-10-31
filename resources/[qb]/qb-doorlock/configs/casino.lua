-- casino_door_manager created by Jacko
Config.DoorList['casino-casino_door_manager'] = {
    doorType = 'double',
    authorizedJobs = { ['casino'] = 0 },
    doorRate = 1.0,
    doorLabel = 'Management Door',
    locked = true,
    distance = 2,
    doors = {
        {objName = 680601509, objYaw = 89.999992370605, objCoords = vec3(1122.351074, 263.516083, -50.890934)},
        {objName = 680601509, objYaw = 270.0, objCoords = vec3(1122.351074, 265.515808, -50.890934)}
    },
}

-- casino_door_manager_2 created by Jacko
Config.DoorList['casino-casino_door_manager_2'] = {
    distance = 2,
    authorizedJobs = { ['casino'] = 0 },
    doors = {
        {objName = -643593781, objYaw = 0.0, objCoords = vec3(1110.051880, 251.043213, -45.690933)},
        {objName = -643593781, objYaw = 179.99998474121, objCoords = vec3(1112.051636, 251.043213, -45.690933)}
    },
    doorLabel = 'Management Door 2',
    locked = true,
    doorRate = 1.0,
    doorType = 'double',
}