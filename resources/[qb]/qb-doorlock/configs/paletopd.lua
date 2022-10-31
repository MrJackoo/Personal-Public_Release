

-- paletopd_main_bollards created by Jacko
Config.DoorList['paletopd-paletopd_main_bollards'] = {
    locked = true,
    authorizedJobs = { ['police'] = 0 },
    doorLabel = 'BOLLARDS',
    objName = -470936668,
    doorRate = 1.0,
    objYaw = 44.84627532959,
    distance = 1,
    doorType = 'garage',
    objCoords = vec3(-456.473358, 6031.135742, 31.137466),
    textCoords = vector3(-453.38, 6028.42, 31.34),
    setText = true
}

-- paletopd_chain_1 created by Jacko
Config.DoorList['paletopd-paletopd_chain_1'] = {
    fixText = true,
    distance = 1,
    objYaw = 135.0,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(-449.691406, 6024.354980, 32.157413),
    authorizedJobs = { ['police'] = 0 },
    objName = -1156020871,
    doorLabel = 'Paleto PD Gate 1',
    locked = true,
}

-- paletopd_rear_1 created by Jacko
Config.DoorList['paletopd-paletopd_rear_1'] = {
    locked = true,
    doorRate = 1.0,
    distance = 1,
    doors = {
        {objName = 965382714, objYaw = 134.99992370605, objCoords = vec3(-453.486755, 5996.637207, 32.288513)},
        {objName = 733214349, objYaw = 314.99981689453, objCoords = vec3(-454.901672, 5998.051758, 32.288513)}
    },
    doorLabel = 'PALETO REAR DOOR 1',
    authorizedJobs = { ['police'] = 0 },
    doorType = 'double',
}

-- paletopd_stairwell_reception created by Jacko
Config.DoorList['paletopd-paletopd_stairwell_reception'] = {
    locked = true,
    doorRate = 1.0,
    distance = 1,
    doors = {
        {objName = 1857649811, objYaw = 224.99992370605, objCoords = vec3(-450.009827, 6004.835449, 32.288513)},
        {objName = 1362051455, objYaw = 44.999935150146, objCoords = vec3(-451.424713, 6003.420410, 32.288513)}
    },
    doorLabel = 'PALETO RECEPTION STAIRS',
    authorizedJobs = { ['police'] = 0 },
    doorType = 'double',
}

-- paletopd_reception created by Jacko
Config.DoorList['paletopd-paletopd_reception'] = {
    locked = true,
    doorRate = 1.0,
    distance = 1,
    doors = {
        {objName = 1362051455, objYaw = 134.99996948242, objCoords = vec3(-446.656403, 6003.453125, 32.288513)},
        {objName = 1857649811, objYaw = 314.99981689453, objCoords = vec3(-448.071289, 6004.868164, 32.288513)}
    },
    doorLabel = 'PALETO RECEPTION',
    authorizedJobs = { ['police'] = 0 },
    doorType = 'double',
}

-- paletopd_reception_main created by Jacko
Config.DoorList['paletopd-paletopd_reception_main'] = {
    locked = false,
    doorRate = 1.0,
    distance = 1,
    doors = {
        {objName = 733214349, objYaw = 134.99996948242, objCoords = vec3(-437.171692, 6012.947266, 32.288513)},
        {objName = 965382714, objYaw = 314.99981689453, objCoords = vec3(-438.586548, 6014.361816, 32.288513)}
    },
    doorLabel = 'PALETO RECEPTION FRONT',
    authorizedJobs = { ['police'] = 0 },
    doorType = 'double',
}

-- paletopd_reception_desk created by Jacko
Config.DoorList['paletopd-paletopd_reception_desk'] = {
    doorRate = 1.0,
    distance = 1,
    objName = 1362051455,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    objCoords = vec3(-443.959991, 6017.162109, 32.288513),
    fixText = false,
    doorLabel = 'PALETO RECEPTION DESK',
    objYaw = 224.99992370605,
    doorType = 'door',
}

-- paletopd_custody_stairwell created by Jacko
Config.DoorList['paletopd-paletopd_custody_stairwell'] = {
    locked = true,
    doorRate = 1.0,
    distance = 1,
    doors = {
        {objName = 1362051455, objYaw = 44.999923706055, objCoords = vec3(-451.424713, 6003.420410, 27.581215)},
        {objName = 1857649811, objYaw = 224.99992370605, objCoords = vec3(-450.009827, 6004.835449, 27.581215)}
    },
    doorLabel = 'PALETO CUSTODY STAIRWELL',
    authorizedJobs = { ['police'] = 0 },
    doorType = 'double',
}

-- paletopd_custody_metal created by Jacko
Config.DoorList['paletopd-paletopd_custody_metal'] = {
    doorRate = 1.0,
    distance = 1,
    objName = -594854737,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    objCoords = vec3(-443.640503, 6006.972656, 27.731001),
    fixText = false,
    doorLabel = 'PALETO CUSTODY METAL',
    objYaw = 314.99984741211,
    doorType = 'door',
}

-- paletopd_custody_metal_2 created by Jacko
Config.DoorList['paletopd-paletopd_custody_metal_2'] = {
    doorRate = 1.0,
    distance = 1,
    objName = -594854737,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    objCoords = vec3(-442.243347, 6012.619629, 27.731001),
    fixText = false,
    doorLabel = 'PALETO CUSTODY METAL 2',
    objYaw = 44.999942779541,
    doorType = 'door',
}

-- paletopd_custody_metal_3 created by Jacko
Config.DoorList['paletopd-paletopd_custody_metal_3'] = {
    doorRate = 1.0,
    distance = 1,
    objName = -594854737,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    objCoords = vec3(-443.390076, 6015.436035, 27.731001),
    fixText = false,
    doorLabel = 'PALETO CUSTODY METAL 3',
    objYaw = 134.99992370605,
    doorType = 'door',
}

-- paletopd_custody_metal_4 created by Jacko
Config.DoorList['paletopd-paletopd_custody_metal_4'] = {
    doorRate = 1.0,
    distance = 1,
    objName = -594854737,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    objCoords = vec3(-445.945679, 6012.880371, 27.731001),
    fixText = false,
    doorLabel = 'PALETO CUSTODY METAL 4',
    objYaw = 134.99992370605,
    doorType = 'door',
}

-- paletopd_custody_metal_5 created by Jacko
Config.DoorList['paletopd-paletopd_custody_metal_5'] = {
    doorRate = 1.0,
    distance = 1,
    objName = -594854737,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    objCoords = vec3(-448.916046, 6015.851074, 27.731001),
    fixText = false,
    doorLabel = 'PALETO CUSTODY METAL 5',
    objYaw = 134.99992370605,
    doorType = 'door',
}

-- paletopd_custody_metal_6 created by Jacko
Config.DoorList['paletopd-paletopd_custody_metal_6'] = {
    doorRate = 1.0,
    distance = 1,
    objName = -594854737,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    objCoords = vec3(-446.360443, 6018.406738, 27.731001),
    fixText = false,
    doorLabel = 'PALETO CUSTODY METAL 6',
    objYaw = 134.99992370605,
    doorType = 'door',
}

-- paletopd_roof_access created by Jacko
Config.DoorList['paletopd-paletopd_roof_access'] = {
    authorizedJobs = { ['police'] = 0 },
    doors = {
        {objName = 1362051455, objYaw = 44.999923706055, objCoords = vec3(-451.424713, 6003.420410, 36.995815)},
        {objName = 1857649811, objYaw = 224.99992370605, objCoords = vec3(-450.009827, 6004.835449, 36.995815)}
    },
    doorLabel = 'PALETO PD ROOF DOOR ',
    locked = true,
    distance = 1,
    doorRate = 1.0,
    doorType = 'double',
}