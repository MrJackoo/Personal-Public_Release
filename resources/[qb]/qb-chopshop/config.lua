Config = {}

-- EITHER "new" or "old"    If new Remove shared_scripts from the fxmanifest.lua
Config.Version = "new" -- If you use a newer version of QBCores "qb-core" (around 1 month old) then set to new otherwise set it to old

Config.Target = "qb"   -- use either "qb", "berkie" or "bt" depending on which target you use (qb-target, berkie-target or bt-target)

Config.CallCops = "false"   -- True or False, do you want police to be notified when a vehicle is being chopped.

Config.CoolDown = 10   -- How long people must wait before starting another job (in minutes)

Config.StartLoc = vector4(472.22, -1308.63, 28.24, 209.27) -- Starting Location with target and PED
Config.ChopLoc = vector3(733.74, -1093.62, 21.17)  -- Chop Location

Config.WheelItems = {      -- Items you get when chopping a wheel
    [1] = {
        ["item"] = "aluminum",
        ["amount"] = math.random(40, 100)
    },
    [2] = {
        ["item"] = "plastic",
        ["amount"] = math.random(40, 100)
    },
    [3] = {
        ["item"] = "rubber",
        ["amount"] = math.random(40, 100)
    },
}

Config.DoorItems = {    -- Items you get when chopping a door (also includes the trunk and hood)
    [1] = {
        ["item"] = "steel",
        ["amount"] = math.random(40, 100)
    },
    [2] = {
        ["item"] = "plastic",
        ["amount"] = math.random(40, 100)
    },
    [3] = {
        ["item"] = "metalscrap",
        ["amount"] = math.random(40, 100)
    },
    [4] = {
        ["item"] = "iron",
        ["amount"] = math.random(40, 100)
    },
    [5] = {
        ["item"] = "aluminum",
        ["amount"] = math.random(40, 100)
    },
    [6] = {
        ["item"] = "copper",
        ["amount"] = math.random(40, 100)
    },
}

Config.TrunkItems = {      -- Items that players can find in the trunk of the vehicle
    [1] = {
        ["item"] = "lockpick",
        ["amount"] = math.random(1, 20)
    },
    [2] = {
        ["item"] = "weedbaggy",
        ["amount"] = math.random(1, 15)
    },
    [3] = {
        ["item"] = "weapon_bat",
        ["amount"] = 1,
    },
    [4] = {
        ["item"] = "cryptostick",
        ["amount"] = math.random(1, 5)
    },
}

Config.CarItems = {
    "metalscrap",
    "plastic",
    "copper",
    "iron",
    "aluminum",
    "steel",
    "glass",
	"rubber",
}

-- ***If you add or remove any of these please also change line 108 in cl_main.lua***
Config.DeliveryCoords = {  -- Locations for the scrapyards **Chosen from random every time you start a new job**
    [1] = {
        coords = vector4(479.72, -1318.2, 29.2, 117.27),
    },
}

-- ***If you add or remove any of these please also change line 106 in cl_main.lua***
Config.VehicleList =  {       -- All the different types of vehicles that can spawn. **Chosen from random every time you start a new job**
    [1]  = {vehicle = "Asterope"},
    [2]  = {vehicle = "Premier"},
    [3]  = {vehicle = "Primo2"},
    [4]  = {vehicle = "sultanrs"},
    [5]  = {vehicle = "Stanier"},
    [6]  = {vehicle = "Stratum"},
    [7]  = {vehicle = "Surge"},
    [8]  = {vehicle = "Tailgater"},
    [9]  = {vehicle = "Warrener"},
    [10] = {vehicle = "Washington"},
    [11] = {vehicle = "Asea"},
    [12] = {vehicle = "sultan2"},
    [13] = {vehicle = "Cog55"},
    [14] = {vehicle = "Cognoscenti"},
    [15] = {vehicle = "Emperor"},
    [16] = {vehicle = "Emperor2"},
    [17] = {vehicle = "Fugitive"},
    [18] = {vehicle = "Glendale"},
    [19] = {vehicle = "Ingot"},
    [20] = {vehicle = "Intruder"},
    [21] = {vehicle = "Buffalo"},
    [22] = {vehicle = "Kuruma"},
    [23] = {vehicle = "Schafter2"},
    [24] = {vehicle = "Schwarzer"},
    [25] = {vehicle = "Pigalle"},
    [26] = {vehicle = "Superd"},
    [27] = {vehicle = "Buffalo2"},
    [28] = {vehicle = "Felon"},
    [29] = {vehicle = "Jackal"},
    [30] = {vehicle = "Oracle"},
    [31] = {vehicle = "Sentinel"},
    [32] = {vehicle = "Dilettante"},
    [33] = {vehicle = "Blista"},
    [34] = {vehicle = "Blista2"},
    [35] = {vehicle = "Zion"},
    [36] = {vehicle = "Zion2"},
    [37] = {vehicle = "Feltzer2"},
    [38] = {vehicle = "Ninef"},
    [39] = {vehicle = "Fusilade"},
    [40] = {vehicle = "Jester"},
    [41] = {vehicle = "Carbonizzare"},
    [42] = {vehicle = "Sultan"},
    [43] = {vehicle = "Peyote"},
    [44] = {vehicle = "Buccaneer2"},
    [45] = {vehicle = "Picador"},
    [46] = {vehicle = "Virgo2"},
    [47] = {vehicle = "Brawler"},
}

-- ***If you add or remove any of these please also change line 107 in cl_main.lua***
Config.VehicleCoords = {        -- Locations of where the vehicle can spawn **Chosen from random every time you start a new job**
    [1] = {coords = vector4(-114.9003, -2526.6394, 5.3918, 235.8066)},
    [2] = {coords = vector4(-115.1422, -2526.6729, 5.3931, 236.1575)},
    [3] = {coords = vector4(-1074.953, -1160.545, 1.661577, 119.0)},
    [4] = {coords = vector4( -1023.625, -890.4014, 5.202, 216.0399)},
    [5] = {coords = vector4(-1609.647, -382.792, 42.70383, 52.535)},
    [6] = {coords = vector4(-1527.88, -309.8757, 47.88678, 323.43)},
    [7] = {coords = vector4(-1658.969, -205.17310, 154.8448, 71.138)},
    [8] = {coords = vector4(97.57888, -1946.472, 20.27978, 215.933)},
    [9] = {coords = vector4(-61.59007, -1844.621, 26.1685, 138.9848)},
    [10] = {coords = vector4(28.51439, -1734.881, 28.5415, 231.968)},
    [11] = {coords = vector4(437.5428, -1925.465, 24.004, 28.82286)},
    [12] = {coords = vector4(406.5316, -1920.471, 24.51589, 224.6432)},
    [13] = {coords = vector4(438.4482, -1838.672, 27.47369, 42.8129)},
    [14] = {coords = vector4(187.353, -1542.984, 28.72487, 39.00627)},
    [15] = {coords = vector4(1153.467, -330.2682, 68.60548, 7.20)},
    [16] = {coords = vector4(1144.622, -465.7694, 66.20689, 76.612770)},
    [17] = {coords = vector4(1295.844, -567.6, 70.77858, 166.552)},
    [18] = {coords = vector4(1319.566, -575.9492, 72.58221, 155.9249)},
    [19] = {coords = vector4(1379.466, -596.0999, 73.89736, 230.594)},
    [20] = {coords = vector4(1256.648, -624.0594, 68.93141, 117.415)},
    [21] = {coords = vector4(1368.127, -748.2613, 66.62316, 231.535)},
    [22] = {coords = vector4(981.7167, -709.7389, 57.18427, 128.729)},
    [23] = {coords = vector4(958.206, -662.7545, 57.57119, 116.9299)},
    [24] = {coords = vector4(-2012.404, 484.0458, 106.5597, 78.13)},
    [25] = {coords = vector4(-2001.294, 454.7647, 102.0194, 108.1178)},
    [26] = {coords = vector4(-1994.725, 377.4933, 94.04324, 89.64067)},
    [27] = {coords = vector4(-1967.549, 262.1507, 86.23506, 109.1846)},
    [28] = {coords = vector4(-989.6796, 418.4977, 74.731, 20.262)},
    [29] = {coords = vector4(-979.6517, 518.119, 81.03075, 328.386)},
    [30] = {coords = vector4(-1040.915, 496.5622, 82.52803, 54.439)},
    [31] = {coords = vector4(-1094.621, 439.2605, 74.84596, 84.936)},
    [32] = {coords = vector4(-1236.895, 487.9722, 92.82943, 330.6634)},
    [33] = {coords = vector4(-1209.098, 557.9588, 99.04235, 3.2526)},
    [34] = {coords = vector4(-1155.296, 565.4297, 101.3919, 7.4106)},
    [35] = {coords = vector4(-1105.378, 551.5797, 102.1759, 211.7110)},
    [36] = {coords = vector4(1708.02, 3775.486, 34.08183, 35.04580)},
    [37] = {coords = vector4(2113.365, 4770.113, 40.72895, 297.5323)},
    [38] = {coords = vector4(2865.448, 1512.715, 24.12726, 252.3262)},
    [39] = {coords = vector4(1413.973, 1119.024, 114.3981, 305.99868)},
    [40] = {coords = vector4(-78.39651, 497.4749, 143.9646, 160.2948)},
    [41] = {coords = vector4(-248.9841, 492.9105, 125.0711, 208.5761)},
    [42] = {coords = vector4(14.097910, 1548.8402, 175.7571, 241.4019775)},
    [43] = {coords = vector4(51.48445, 562.2509, 179.8492, 203.159)},
    [44] = {coords = vector4(-319.3912, 478.9731, 111.7186, 298.7645)},
    [45] = {coords = vector4(-202.0035, 410.2064, 110.0086, 195.6136)},
    [46] = {coords = vector4(-187.1009, 379.9514, 108.0138, 176.9462)},
    [47] = {coords = vector4(213.5159, 389.3123, 106.4154, 348.890255)},
    [48] = {coords = vector4(323.7256, 343.3308, 104.761, 345.49426)},
    [49] = {coords = vector4(701.1197, 254.4424, 92.85217, 240.6288)},
    [50] = {coords = vector4(656.4758, 184.8482, 94.53828, 248.9376)},
    [51] = {coords = vector4(615.5524, 161.4801, 96.91451, 69.2577)},
    [52] = {coords = vector4(899.2693, -41.99047, 78.32366, 28.13086)},
    [53] = {coords = vector4(873.3314, 9.008331, 78.32432, 329.343)},
    [54] = {coords = vector4(941.2477, -248.0161, 68.15629, 328.122)},
    [55] = {coords = vector4(842.7501, -191.9954, 72.1975, 329.2124)},
    [56] = {coords = vector4(534.3583, -26.7027, 70.18916, 30.70978)},
    [57] = {coords = vector4(302.5077, -176.5727, 56.95071, 249.3339)},
    [58] = {coords = vector4(85.26346, -214.7179, 54.05132, 160.2142)},
    [59] = {coords = vector4(78.38569, -198.41810, 155.79539, 70.1377)},
    [60] = {coords = vector4(-30.09893, -89.37914, 56.8136, 340.32879)},
}

-- All Text used in the script (you can change any of the text you want)
Config.Locale = {
    -- Notifications
    ["Reminder"] 			= "Remove parts from the vehicle then get back into it to to crush it!",
	["FarAway"] 			= "You are to far away from the vehicle. It has been sent to the crusher!",
    ["CoolDown"]            = "There is currently no new jobs, please come back later!",
    ["JobActive"]           = "You have not yet completed the active job!",
    ["Email"]               = "I will send information to your email.",
    ["WrongVeh"]            = "This Is not the correct Vehicle",
    ["FoundVeh"]            = "Nice, You found the right car!",
    ["ScrapBlip"]           = "Sending scrapyard location to your GPS...",


    -- Draw Text
    ["chop"] 			    = "~g~E~w~ - Start Chopping",
	["remove"] 				= "~g~E~w~ - Remove the ",
	["destroy"] 			= "~g~E~w~ - Destroy car ",
    ["reqjob"] 			    = "~g~E~w~ - Request Vehicle Information.",
	["Trunk"]				= "Trunk",				
	["Hood"]				= "Hood",				
	["Frontleftdoor"]		= "front left door",	
	["Backleftdoor"]		= "back left door",		
	["Frontrightdoor"]		= "front right door",	
	["Backrightdoor"]		= "back right door",	
	["Frontleftwheel"]		= "front left wheel",	
	["Backleftwheel"]		= "back left wheel",	
	["Rightfrontwheel"]		= "front right wheel",	
	["Rightbackwheel"]		= "back right wheel",	

    -- Progress Bars
    ["Wheel"] 				= "Removing The Wheel...",
	["Door1"] 		        = "Loosening Bolts...",
	["Door2"] 		        = "Pulling From Hinges..",
	["crushing"] 			= "Sending car for crushing",
    ["searching"]           = "Looting Trunk...",

    ["chopwheel"]           = "Cutting Down the wheel..",
    ["chopdoor"]           = "Cutting Down the door..",
    ["choptrunk"]           = "Cutting Down the trunk..",
    ["chophood"]           = "Cutting Down the hood..",
}

Config.CarTable = {
    {name = Config.Locale["Trunk"],			    coords = 0,	    vehBone = "boot", 		        distance = 1.5,		chopped = false,	anim = "trunk",	    	destroy = 5,	getin = 5},
	{name = Config.Locale["Hood"],			    coords = 0,	    vehBone = "overheat",		    distance = 0.8,		chopped = false,	anim = "hood",	    	destroy = 4,	getin = 4},
	{name = Config.Locale["Frontleftdoor"],	    coords = 0,	    vehBone = "door_dside_f",       distance = 0.8,	 	chopped = false,	anim = "door",	    	destroy = 0, 	getin = 0},
	{name = Config.Locale["Backleftdoor"],	    coords = 0,	    vehBone = "door_dside_r",	    distance = 0.8,		chopped = false,	anim = "door",	    	destroy = 2, 	getin = 2},
	{name = Config.Locale["Frontrightdoor"],	coords = 0,	    vehBone = "door_pside_f",	    distance = 0.8,		chopped = false,	anim = "door",	    	destroy = 1, 	getin = -1},
	{name = Config.Locale["Backrightdoor"],	    coords = 0,	    vehBone = "door_pside_r",	    distance = 0.8,		chopped = false,	anim = "door",	   	 	destroy = 3, 	getin = 1},
	{name = Config.Locale["Frontleftwheel"],	coords = 0,	    vehBone = "wheel_lf", 	        distance = 1.3,	 	chopped = "cando",	anim = "wheel1",	    destroy = 0,	getin = 0},
	{name = Config.Locale["Backleftwheel"],	    coords = 0,	    vehBone = "wheel_lr",		    distance = 1.3,		chopped = "cando",	anim = "wheel2",	    destroy = 4,	getin = 0},
	{name = Config.Locale["Rightfrontwheel"],	coords = 0,	    vehBone = "wheel_rf",		    distance = 1.3,		chopped = "cando",	anim = "wheel3",	    destroy = 1,	getin = 0},
	{name = Config.Locale["Rightbackwheel"],	coords = 0,	    vehBone = "wheel_rr",		    distance = 1.3,		chopped = "cando",	anim = "wheel4",	    destroy = 5,	getin = 0},
}
