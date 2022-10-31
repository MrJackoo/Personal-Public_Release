

-- mrpd_front_door created by Jacko
Config.DoorList['mrpd-mrpd_front_door'] = {
    locked = false,
    doors = {
        {objName = -1547307588, objYaw = 269.98272705078, objCoords = vec3(434.744446, -980.755554, 30.815304)},
        {objName = -1547307588, objYaw = 90.017288208008, objCoords = vec3(434.744446, -983.078125, 30.815304)}
    },
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0 },
    doorLabel = 'MRPD FRONT',
    distance = 2,
    doorType = 'double',
}

-- mrpd_reception_door_l created by Jacko
Config.DoorList['mrpd-mrpd_reception_door_l'] = {
    locked = true,
    objYaw = 0.0,
    authorizedJobs = { ['police'] = 0 },
    fixText = false,
    doorLabel = 'MRPD RECEPTION L',
    objCoords = vec3(440.520081, -977.601074, 30.823193),
    objName = -1406685646,
    doorRate = 1.0,
    doorType = 'door',
    distance = 2,
}

-- mrpd_reception_door_r created by Jacko
Config.DoorList['mrpd-mrpd_reception_door_r'] = {
    locked = true,
    objYaw = 180.00001525879,
    authorizedJobs = { ['police'] = 0 },
    fixText = false,
    doorLabel = 'MRPD RECEPTION R',
    objCoords = vec3(440.520081, -986.233459, 30.823193),
    objName = -96679321,
    doorRate = 1.0,
    doorType = 'door',
    distance = 2,
}

-- mrpd_side_door created by Jacko
Config.DoorList['mrpd-mrpd_side_door'] = {
    locked = true,
    doors = {
        {objName = -1547307588, objYaw = 0.0, objCoords = vec3(440.739197, -998.746216, 30.815304)},
        {objName = -1547307588, objYaw = 180.00001525879, objCoords = vec3(443.061768, -998.746216, 30.815304)}
    },
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0 },
    doorLabel = 'MRPD SIDE DOOR',
    distance = 2,
    doorType = 'double',
}

-- mrpd_entry_bollards created by Jacko
Config.DoorList['mrpd-mrpd_entry_bollard'] = {
	textCoords = vector3(410.0258, -1028.32, 29.2202),
	objCoords = vector3(410.0258, -1024.22, 29.2202),
	objHeading = 270,
	setText = true,
	doorType = 'garage',
    doorLabel = 'MRPD ENTRY BOLLARDS',
	objHash = -1635161509, -- gabz_mrpd_bollards1
	maxDistance = 5,
	fixText = false,
	locked = true,
	lockpick = false,
	authorizedJobs = {
		['police'] = 0,
	}
}

-- mrpd_exit_bollards created by Jacko
Config.DoorList['mrpd-mrpd_exit_bollard'] = {
	textCoords = vector3(410.0258, -1020.19, 29.2202),
	objCoords = vector3(410.0258, -1024.226, 29.22022),
	objHeading = 270,
	setText = true,
	doorType = 'garage',
    doorLabel = 'MRPD EXIT BOLLARDS',
	objHash = -1868050792, -- gabz_mrpd_bollards2
	maxDistance = 5,
	fixText = false,
	locked = true,
	lockpick = false,
	authorizedJobs = {
		['police'] = 0,
	}
}

-- mrpd_garage_exit created by Jacko
Config.DoorList['mrpd-mrpd_garage_exit'] = {
    objYaw = 0.0,
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    doorLabel = 'Garage Exit',
    objName = 2130672747,
    fixText = false,
    objCoords = vec3(431.411926, -1000.771667, 26.696609),
    doorType = 'garage',
    distance = 5,
    locked = true,
    remoteTrigger = true,
}

-- mrpd_garage_entriy created by Jacko
Config.DoorList['mrpd-mrpd_garage_entry'] = {
    objYaw = 0.0,
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    doorLabel = 'Garage Entry',
    objName = 2130672747,
    fixText = false,
    objCoords = vec3(452.300507, -1000.771667, 26.696609),
    doorType = 'garage',
    distance = 5,
    locked = true,
    remoteTrigger = true,
}

-- mrpd_garage_right created by Jacko
Config.DoorList['mrpd-mrpd_garage_right'] = {
    objYaw = 89.870010375977,
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    doorLabel = 'Garage Right Door',
    objName = 1830360419,
    fixText = false,
    fixText = true,
    objCoords = vec3(464.16, -997.51, 26.37),
    textCoords = vector3(410.0258, -1020.19, 29.2202),
    doorType = 'door',
    distance = 1,
    locked = true,
}

-- mrpd_garage_left created by Jacko
Config.DoorList['mrpd-mrpd_garage_left'] = {
    doorRate = 1.0,
    objCoords = vec3(464.159058, -974.665588, 26.370705),
    doorLabel = 'GARAGE LEFT',
    authorizedJobs = { ['police'] = 0 },
    objYaw = 269.79000854492,
    fixText = true,
    locked = true,
    doorType = 'door',
    objName = 1830360419,
    distance = 1,
}

-- mrpd_ground_double_custody_white created by Jacko
Config.DoorList['mrpd-mrpd_ground_double_custody_white'] = {
    locked = true,
    doors = {
        {objName = -288803980, objYaw = 0.0, objCoords = vec3(467.522217, -1000.543701, 26.405483)},
        {objName = -288803980, objYaw = 180.00001525879, objCoords = vec3(469.927368, -1000.543701, 26.405483)}
    },
    doorType = 'double',
    authorizedJobs = { ['police'] = 0 },
    distance = 2,
    doorRate = 1.0,
    doorLabel = 'Double doors to custody corridor',
}

-- mrpd_ground_double_custody_outside created by Jacko
Config.DoorList['mrpd-mrpd_ground_double_custody_outside'] = {
    locked = true,
    doors = {
        {objName = -692649124, objYaw = 0.0, objCoords = vec3(467.368622, -1014.406006, 26.483816)},
        {objName = -692649124, objYaw = 180.00001525879, objCoords = vec3(469.774261, -1014.406006, 26.483816)}
    },
    doorType = 'double',
    authorizedJobs = { ['police'] = 0 },
    distance = 2,
    doorRate = 1.0,
    doorLabel = 'Double doors to custody corridor',
}

-- mrpd_back_gate created by Jacko
Config.DoorList['mrpd-mrpd_back_gate'] = {
    locked = true,
    authorizedJobs = { ['police'] = 0 },
    distance = 3,
    slides = true,
    objCoords = vector3(488.88, -1019.84, 28.21),
    doorType = 'sliding',
    fixtext = true,
    doorLabel = 'back gate',
    doorRate = 1.0,
    objYaw = 90.0,
    objName = -1603817716,
}

-- mrpd_custody_double_finger created by Jacko
Config.DoorList['mrpd-mrpd_custody_double_finger'] = {
    doorLabel = 'MRPD CUSTODY DOORS',
    authorizedJobs = { ['police'] = 0 },
    doors = {
        {objName = 149284793, objYaw = 89.999977111816, objCoords = vec3(471.375824, -1010.197876, 26.405483)},
        {objName = 149284793, objYaw = 270.19003295898, objCoords = vec3(471.367859, -1007.793396, 26.405483)}
    },
    distance = 2,
    locked = true,
    doorRate = 1.0,
    doorType = 'double',
}

-- mrpd_custody_metal_door created by Jacko
Config.DoorList['mrpd-mrpd_custody_metal_door'] = {
    doorLabel = 'MRPD CUSTODY METAL DOORS',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(476.615692, -1008.875427, 26.480055),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 270.13998413086,
    objName = -53345114,
    fixText = false,
}

-- mrpd_custody_cell_1 created by Jacko
Config.DoorList['mrpd-mrpd_custody_cell_1'] = {
    doorLabel = 'MRPD CUSTODY CELL 1',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(477.912598, -1012.188660, 26.480055),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 0.0,
    objName = -53345114,
    fixText = false,
}

-- mrpd_custody_cell_2 created by Jacko
Config.DoorList['mrpd-mrpd_custody_cell_2'] = {
    doorLabel = 'MRPD CUSTODY CELL 2',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(480.912811, -1012.188660, 26.480055),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 0.0,
    objName = -53345114,
    fixText = false,
}

-- mrpd_custody_cell_3 created by Jacko
Config.DoorList['mrpd-mrpd_custody_cell_3'] = {
    doorLabel = 'MRPD CUSTODY CELL 3',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(483.912720, -1012.188660, 26.480055),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 0.0,
    objName = -53345114,
    fixText = false,
}

-- mrpd_custody_cell_4 created by Jacko
Config.DoorList['mrpd-mrpd_custody_cell_4'] = {
    doorLabel = 'MRPD CUSTODY CELL 4',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(486.913116, -1012.188660, 26.480055),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 0.0,
    objName = -53345114,
    fixText = false,
}

-- mrpd_custody_cell_5 created by Jacko
Config.DoorList['mrpd-mrpd_custody_cell_5'] = {
    doorLabel = 'MRPD CUSTODY CELL 5',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(484.176422, -1007.734375, 26.480055),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 180.00001525879,
    objName = -53345114,
    fixText = false,
}

-- mrpd_custody_metal_interview created by Jacko
Config.DoorList['mrpd-mrpd_custody_metal_interview'] = {
    doorLabel = 'MRPD CUSTODY METAL TO INT',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(481.008362, -1004.117981, 26.480055),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 180.00001525879,
    objName = -53345114,
    fixText = false,
}

-- mrpd_custody_double_interrogation created by Jacko
Config.DoorList['mrpd-mrpd_custody_double_interrogation'] = {
    doorLabel = 'MRPD CUSTODY INTERROGATION DOUBLE',
    authorizedJobs = { ['police'] = 0 },
    doors = {
        {objName = 149284793, objYaw = 180.00001525879, objCoords = vec3(482.068573, -997.909973, 26.406504)},
        {objName = 149284793, objYaw = 0.0, objCoords = vec3(479.663757, -997.909973, 26.406504)}
    },
    distance = 1,
    locked = true,
    doorRate = 1.0,
    doorType = 'double',
}

-- mrpd_custody_interrogation_1 created by Jacko
Config.DoorList['mrpd-mrpd_custody_interrogation_1'] = {
    doorLabel = 'MRPD CUSTODY INTERROGATION 1',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(482.670258, -995.728516, 26.405483),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 270.00003051758,
    objName = -1406685646,
    fixText = true,
}

-- mrpd_custody_interrogation_2 created by Jacko
Config.DoorList['mrpd-mrpd_custody_interrogation_2'] = {
    doorLabel = 'MRPD CUSTODY INTERROGATION 2',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(482.669922, -992.299133, 26.405483),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 270.00003051758,
    objName = -1406685646,
    fixText = true,
}

-- mrpd_custody_interrogation_3 created by Jacko
Config.DoorList['mrpd-mrpd_custody_interrogation_3'] = {
    doorLabel = 'MRPD CUSTODY INTERROGATION 3',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(482.670135, -987.579163, 26.405483),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 270.00003051758,
    objName = -1406685646,
    fixText = true,
}

-- mrpd_custody_interrogation_4 created by Jacko
Config.DoorList['mrpd-mrpd_custody_interrogation_4'] = {
    doorLabel = 'MRPD CUSTODY INTERROGATION 4',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(482.669434, -983.986816, 26.405483),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 270.00003051758,
    objName = -1406685646,
    fixText = true,
}

-- mrpd_custody_interrogation_double_main created by Jacko
Config.DoorList['mrpd-mrpd_custody_interrogation_double_main'] = {
    doorLabel = 'MRPD CUSTODY DOUBLE DOOR MAIN',
    authorizedJobs = { ['police'] = 0 },
    doors = {
        {objName = 149284793, objYaw = 89.999977111816, objCoords = vec3(479.062408, -987.437561, 26.405483)},
        {objName = 149284793, objYaw = 270.00003051758, objCoords = vec3(479.062408, -985.032349, 26.405483)}
    },
    distance = 1,
    locked = true,
    doorRate = 1.0,
    doorType = 'double',
}

-- mrpd_evidence_outer created by Jacko
Config.DoorList['mrpd-mrpd_evidence_outer'] = {
    doorLabel = 'MRPD EVIDENCE OUTER',
    locked = true,
    doorType = 'door',
    doorRate = 1.0,
    objCoords = vec3(475.832336, -990.483948, 26.405483),
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objYaw = 134.97177124023,
    objName = -692649124,
    fixText = true,
}

-- mrpd_evidence_inner created by Jacko
Config.DoorList['mrpd-mrpd_evidence_inner'] = {
    fixText = false,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objCoords = vec3(475.611389, -992.048218, 26.511806),
    doorRate = 1.0,
    objName = -1258679973,
    doorLabel = 'MRPD EVIDENCE INNER',
    objYaw = 0.0,
}

-- mrpd_right_side_doors created by Jacko
Config.DoorList['mrpd-mrpd_right_side_doors'] = {
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    doors = {
        {objName = -1547307588, objYaw = 180.00001525879, objCoords = vec3(458.208740, -972.254272, 30.815308)},
        {objName = -1547307588, objYaw = 0.0, objCoords = vec3(455.886169, -972.254272, 30.815308)}
    },
    doorType = 'double',
    locked = true,
    doorLabel = 'MRPD RIGHT SIDE ENTRANCE',
    doorRate = 1.0,
}

-- mrpd_roof_entrance created by Jacko
Config.DoorList['mrpd-mrpd_roof_entrance'] = {
    fixText = true,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['police'] = 0 },
    distance = 1,
    objCoords = vec3(464.308563, -984.528442, 43.771240),
    doorRate = 1.0,
    objName = -692649124,
    doorLabel = 'MRPD_ROOF_ENTRANCE',
    objYaw = 89.999977111816,
}