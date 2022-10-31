

-- Pillbox-Reception created by NULL
Config.DoorList['nhs-Pillbox-Reception'] = {
    distance = 1.5,
    objCoords = vec3(313.480072, -595.458313, 43.433910),
    locked = true,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = true,
    objYaw = 249.98275756836,
}

-- Pillbox-Staff created by NULL
Config.DoorList['nhs-Pillbox-Staff'] = {
    distance = 1.5,
    objCoords = vec3(309.133728, -597.751465, 43.433910),
    locked = true,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = true,
    objYaw = 160.00003051758,
}

-- Pillbox-Closet created by NULL
Config.DoorList['nhs-Pillbox-Closet'] = {
    distance = 2,
    objCoords = vec3(303.959625, -572.557922, 43.433910),
    locked = true,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = false,
    objYaw = 70.01732635498,
}

-- Pillbox-Lab created by NULL
Config.DoorList['nhs-Pillbox-Lab'] = {
    distance = 2,
    objCoords = vec3(307.118195, -569.568970, 43.433910),
    locked = true,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = false,
    objYaw = 340.00003051758,
}

-- Pillbox-Surgery1 created by NULL
Config.DoorList['nhs-Pillbox-Surgery1'] = {
    distance = 2,
    locked = false,
    doorType = 'double',
    authorizedJobs = { ['ambulance'] = 0 },
    doorRate = 1.0,
    doors = {
        {objName = -434783486, objYaw = 340.00003051758, objCoords = vec3(312.005127, -571.341187, 43.433910)},
        {objName = -1700911976, objYaw = 340.00003051758, objCoords = vec3(314.424103, -572.221558, 43.433910)}
    },
}

-- Pillbox-Surgery2 created by NULL
Config.DoorList['nhs-Pillbox-Surgery2'] = {
    distance = 2,
    locked = false,
    doorType = 'double',
    authorizedJobs = { ['ambulance'] = 0 },
    doorRate = 1.0,
    doors = {
        {objName = -434783486, objYaw = 340.00003051758, objCoords = vec3(317.842560, -573.465881, 43.433910)},
        {objName = -1700911976, objYaw = 340.00003051758, objCoords = vec3(320.261536, -574.346313, 43.433910)}
    },
}

-- Pillbox-Surgery3 created by NULL
Config.DoorList['nhs-Pillbox-Surgery3'] = {
    distance = 2,
    locked = false,
    doorType = 'double',
    authorizedJobs = { ['ambulance'] = 0 },
    doorRate = 1.0,
    doors = {
        {objName = -434783486, objYaw = 340.00003051758, objCoords = vec3(323.237549, -575.429443, 43.433910)},
        {objName = -1700911976, objYaw = 340.00003051758, objCoords = vec3(325.656525, -576.309937, 43.433910)}
    },
}

-- Pillbox-ICU created by NULL
Config.DoorList['nhs-Pillbox-ICU'] = {
    distance = 2,
    locked = false,
    doorType = 'double',
    authorizedJobs = { ['ambulance'] = 0 },
    doorRate = 1.0,
    doors = {
        {objName = -434783486, objYaw = 160.00003051758, objCoords = vec3(318.484680, -579.228149, 43.433910)},
        {objName = -1700911976, objYaw = 160.00003051758, objCoords = vec3(316.065704, -578.347717, 43.433910)}
    },
}

-- Pillbox-Admin created by NULL
Config.DoorList['nhs-Pillbox-Admin'] = {
    distance = 2,
    objCoords = vec3(339.004974, -586.703369, 43.433910),
    locked = true,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = false,
    objYaw = 340.00003051758,
}

-- Pillbox-MRI created by NULL
Config.DoorList['nhs-Pillbox-MRI'] = {
    distance = 2,
    objCoords = vec3(336.162842, -580.140320, 43.433910),
    locked = false,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = false,
    objYaw = 340.00003051758,
}

-- Pillbox-Diag created by NULL
Config.DoorList['nhs-Pillbox-Diag'] = {
    distance = 2,
    objCoords = vec3(340.781830, -581.821472, 43.433910),
    locked = false,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = false,
    objYaw = 340.00003051758,
}

-- Pillbox-Xray created by NULL
Config.DoorList['nhs-Pillbox-Xray'] = {
    distance = 2,
    objCoords = vec3(346.773926, -584.002441, 43.433910),
    locked = false,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = false,
    objYaw = 340.00003051758,
}

-- Pillbox-DoctorsOffice created by NULL
Config.DoorList['nhs-Pillbox-DoctorsOffice'] = {
    distance = 2,
    objCoords = vec3(358.726532, -593.881409, 43.433910),
    locked = true,
    objName = 854291622,
    doorRate = 1.0,
    doorType = 'door',
    authorizedJobs = { ['ambulance'] = 0 },
    fixText = false,
    objYaw = 340.00003051758,
}

-- NHSrightelevator created by Jacko
Config.DoorList['nhs-NHSrightelevator'] = {
    doorType = 'doublesliding',
    distance = 0,
    hideLabel = true,
    doorLabel = 'Right Elevator',
    doorRate = 1.0,
    locked = true,
    doors = {
        {objName = 1674289593, objYaw = 70.006050109863, objCoords = vec3(345.668213, -581.525513, 27.796816)},
        {objName = -1048421071, objYaw = 70.006050109863, objCoords = vec3(345.022400, -583.300537, 27.796816)}
    },
}

-- NHSleftelevator created by Jacko
Config.DoorList['nhs-NHSleftelevator'] = {
    doorType = 'doublesliding',
    distance = 0,
    hideLabel = true,
    doorLabel = 'left Elevator',
    doorRate = 1.0,
    locked = true,
    doors = {
        {objName = 1674289593, objYaw = 70.04524230957, objCoords = vec3(344.319275, -585.232971, 27.796816)},
        {objName = -1048421071, objYaw = 70.000968933105, objCoords = vec3(343.673431, -587.007996, 27.796816)}
    },
}

-- NHSleftelevator1 created by Jacko
Config.DoorList['nhs-NHSleftelevator1'] = {
    doorType = 'doublesliding',
    distance = 0,
    hideLabel = true,
    doorLabel = 'left Elevator1',
    doorRate = 1.0,
    locked = true,
    doors = {
        {objName = 1674289593, objYaw = 70.006050109863, objCoords = vec3(340.771179, -583.942017, 27.796816)},
        {objName = -1048421071, objYaw = 70.006530761719, objCoords = vec3(340.125336, -585.717041, 27.796816)}
    },
}

-- NHSrightelevator1 created by Jacko
Config.DoorList['nhs-NHSrightelevator1'] = {
    doorType = 'doublesliding',
    distance = 0,
    hideLabel = true,
    doorLabel = 'right Elevator1',
    doorRate = 1.0,
    locked = true,
    doors = {
        {objName = -1048421071, objYaw = 69.903396606445, objCoords = vec3(341.474304, -582.009583, 27.796816)},
        {objName = 1674289593, objYaw = 70.006050109863, objCoords = vec3(342.120148, -580.234558, 27.796816)}
    },
}

-- nhslowergarage1 created by Jacko
Config.DoorList['nhs-nhslowergarage1'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    doorLabel = 'NHS Lower Garage 1',
    doorType = 'double',
    doors = {
        {objName = -434783486, objYaw = 70.006050109863, objCoords = vec3(338.446655, -590.052979, 28.947092)},
        {objName = -1700911976, objYaw = 70.006050109863, objCoords = vec3(339.326599, -587.634521, 28.947092)}
    },
    distance = 2,
    locked = true,
    doorRate = 1.0,
}