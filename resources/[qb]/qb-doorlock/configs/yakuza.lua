

-- yakuza_rear created by Jacko
Config.DoorList['yakuza-yakuza_rear'] = {
    doorType = 'double',
    doorLabel = 'Rear Door',
    authorizedGangs = { ['yakuza'] = 0 },
    doors = {
        {objName = 1215119726, objYaw = 302.31954956055, objCoords = vec3(-643.156067, -1229.270508, 11.682079)},
        {objName = -636132164, objYaw = 122.31954193115, objCoords = vec3(-644.483337, -1227.172607, 11.682079)}
    },
    distance = 2,
    doorRate = 1.0,
    locked = true,
}

-- yakuza_slide1 created by Jacko
Config.DoorList['yakuza-yakuza_slide1'] = {
    doorType = 'doublesliding',
    doorLabel = 'Sliding Doors 1',
    authorizedGangs = { ['yakuza'] = 0 },
    doors = {
        {objName = -932312205, objYaw = 302.31958007813, objCoords = vec3(-643.390015, -1235.914795, 10.570587)},
        {objName = -932312205, objYaw = 122.31952667236, objCoords = vec3(-644.381531, -1234.347656, 10.570587)}
    },
    distance = 2,
    doorRate = 1.0,
    locked = true,
}

-- yakuza_owner created by Jacko
Config.DoorList['yakuza-yakuza_owner'] = {
    doorType = 'door',
    doorLabel = 'Managers Office',
    fixText = false,
    objName = -1592535808,
    authorizedGangs = { ['yakuza'] = 0 },
    objCoords = vec3(-649.851013, -1242.966064, 11.748600),
    locked = true,
    distance = 2,
    doorRate = 1.0,
    objYaw = 212.31956481934,
}

-- yakuza_meet created by Jacko
Config.DoorList['yakuza-yakuza_meet'] = {
    doorType = 'door',
    doorLabel = 'Meeting Room',
    fixText = false,
    objName = -1592535808,
    authorizedGangs = { ['yakuza'] = 0 },
    objCoords = vec3(-650.955627, -1233.176636, 11.748600),
    locked = true,
    distance = 2,
    doorRate = 1.0,
    objYaw = 212.31954956055,
}

-- yakuza_front created by Jacko
Config.DoorList['yakuza-yakuza_front'] = {
    doorType = 'double',
    doorLabel = 'Front Door',
    authorizedGangs = { ['yakuza'] = 0 },
    doors = {
        {objName = -636132164, objYaw = 352.31958007813, objCoords = vec3(-637.369324, -1249.239990, 11.945559)},
        {objName = 1215119726, objYaw = 172.31953430176, objCoords = vec3(-639.829529, -1248.908203, 11.945559)}
    },
    distance = 2,
    doorRate = 1.0,
    locked = true,
}