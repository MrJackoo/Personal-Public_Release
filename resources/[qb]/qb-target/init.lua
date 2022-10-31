function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 7.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = false

-- The default distance to draw the Sprite
Config.DrawDistance = 10.0

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = {30, 144, 255, 255}

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = {23, 166, 49, 255}

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = false

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = true

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 237

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {
	["HayesPayment"] = {
        name = "HayesPayment",
        coords = vector3(-1429.69, -453.97, 35.91),
        radius = 0.2,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "ax-mechanic:client:BillPlayer",
                icon = "fa-solid fa-cash-register",
                label = "Bill Customer",
                job = "mechanic",
            },
            -- {
            --     type = "client",
            --     event = "ax-police:client:MeetingSlides",
            --     icon = "fas fa-clipboard-list",
            --     label = "Meeting Notes",
            --     job = "police",
            -- },
        },
        distance = 2.0
    },
}

Config.BoxZones = {
	["HayesDuty"] = {
        name = "HayesDuty",
        coords = vector3(-1425.81, -457.15, 35.91),
        length = 1.4,
        width = 0.6,
        heading = 30,
        debugPoly = false,
        minZ = 34.91,
        maxZ = 36.91,
        options = {
            {
                type = "client",
                event = "ax-mechanic:ChangeOutfit",
                icon = "fas fa-sign-in-alt",
                label = "Change Outfit",
                job = "mechanic",
            },
        },
        distance = 2.0
    },
	["HayesCraft"] = {
        name = "Mechanic Toolbox",
        coords = vector3(-1421.65, -456.44, 35.91),
        length = 3.6,
        width = 1,
        heading = 120,
        debugPoly = false,
        minZ=34.91,
        maxZ=36.91,
        options = {
            {
                type = "client",
                event = "ax-mechanic:mechanicparts", 
                icon = "fas fa-wrench",
                label = "Craft",
                job = "mechanic",
            },
        },
        distance = 2.5
    },
	["PrisonItems"] = {
        name = "PrisonItems",
        coords = vector3(1840.19, 2578.5, 46.01),
        length = 0.35,
        width = 0.3,
        heading = 0,
        debugPoly = false,
        minZ=45.88,
        maxZ=46.10,
        options = {
            {
              type = "server",
              event = "prison:server:GiveJailItems",
              icon = "fas fa-file-signature",
              label = "Reclaim Possessions",
            },
        },
        distance = 2.5
    },
	["WeedProTrim"] = {
        name = "WeedProTrim",
        coords = vector3(258.0, 2584.65, 44.95),
        length = 1.8,
        width = 0.8,
        heading = 9,
        debugPoly = false,
		minZ=41.35,
		maxZ=45.35,
        options = {
            {
              type = "client",
              event = "ps-drugprocessing:client:inputCannabis",
              icon = "fas fa-cannabis",
              label = "Prepare Cannabis Plants",
            },
        },
        distance = 2.5
    },
	["WeedProPack"] = {
        name = "WeedProPack",
        coords = vector3(257.69, 2586.41, 44.95),
        length = 1.6,
        width = 0.8,
        heading = 9,
        debugPoly = false,
		minZ=41.55,
		maxZ=45.55,
        options = {
            {
              type = "client",
              event = "ps-drugprocessing:client:inputWeedPackage",
              icon = "fas fa-scale-balanced",
              label = "Package Weed",
            },
        },
        distance = 2.5
    },
	["MedicDuty"] = {
        name = "PillboxDutyClipboard",
        coords = vector3(307.53, -595.34, 43.28),
        length = 0.8,
        width = 0.55,
        heading = 335,
        debugPoly = false,
        minZ = 43.00,
        maxZ = 44.00,
        options = {
            {
				type = "client",
				event = "EMSToggle:Duty",
				icon = "fa fa-clipboard",
				label = "Sign On/Off duty",
				job = "ambulance"
            },
			{
				type = "client",
				event = "qb-ambulancejob:AccessApplication",
				icon = "fa fa-clipboard",
				label = "Apply for the NHS",
            },
        },
        distance = 3.0
    },
    -- ["HospitalCheckIn"] = {
    --     name = "PillboxCheckIn",
    --     coords = vector3(312.04, -593.78, 43.28),
    --     length = 2.0,
    --     width = 1.7,
    --     heading = 250,
    --     debugPoly = false,
    --     minZ = 42.50,
    --     maxZ = 44.00,
    --     options = {
    --         {
    --           event = 'Hospital:CheckIn',
    --           icon = 'fas fa-notes-medical',
    --           label = "Medical Assistance (£250)",
    --         },
    --     },
    --     distance = 3.0
    -- },
	-- Burgershot
	["BurgershotTil1"] = {
		name = "BurgershotTil1",
		coords = vector3(-1194.92, -893.23, 13.97),    
		length = 0.4,
		width = 0.3,
		heading = 35,
		debugPoly = false,
		minZ=10.57,
		maxZ=14.57,
		options = {
			{
				event = "qb-burgershot:Prices",
				icon = "fas fa-cash-register",
				label = "Burgershot Prices",
				job = "burgershot",
			},
			{
				event = "qb-burgershot:client:BillPlayer",
				icon = "fas fa-money-bill-wave",
				label = "Bill Customer",
				job = "burgershot",
			},
		},
		distance = 1.5
	},
	["BurgershotTil2"] = {
		name = "BurgershotTil2",
		coords = vector3(-1193.9, -894.73, 13.97), 
		length = 0.42,
		width = 0.30,
		heading = 35,
		debugPoly = false,
		minZ=10.57,
		maxZ=14.57,
		options = {
			{
				event = "qb-burgershot:Prices",
				icon = "fas fa-cash-register",
				label = "Burgershot Prices",
				job = "burgershot",
			},
			{
				event = "qb-burgershot:client:BillPlayer",
				icon = "fas fa-money-bill-wave",
				label = "Bill Customer",
				job = "burgershot",
			},
		},
		distance = 1.5
	},
	["BurgershotTil3"] = {
		name = "BurgershotTil3",
		coords = vector3(-1192.61, -896.05, 13.97),
		length = 0.45,
		width = 0.90,
		heading = 35,
		debugPoly = false,
		minZ=10.57,
		maxZ=14.57,
		options = {
			{
				event = "qb-burgershot:Prices",
				icon = "fas fa-cash-register",
				label = "Burgershot Prices",
				job = "burgershot",
			},
			{
				event = "qb-burgershot:client:BillPlayer",
				icon = "fas fa-money-bill-wave",
				label = "Bill Customer",
				job = "burgershot",
			},
		},
		distance = 1.5
	},
	["BurgershotBag"] = {
		name = "BurgershotBag",
		coords = vector3(-1191.92, -897.66, 13.97),
		length = 0.25,
		width = 0.40,
		heading = 12.0,
		debugPoly = false,
		minZ=10.77,
		maxZ=14.77,
		options = {
			{
				event = "qb-burgershot:foodBag",
				icon = "fas fa-hamburger",
				label = "Burgershot Bag",
			},
		},
		distance = 1.5
	},
	["BurgershotFood"] = {
		name = "BurgershotFood",
		coords = vector3(-1195.45, -897.6, 13.97),
		length = 3.15,
		width = 0.7,
		heading = 35,
		debugPoly = false,
		minZ=10.77,
		maxZ=14.77,
		options = {
			{
				event = "qb-burgershot:foodSlide",
				icon = "fas fa-hamburger",
				label = "Food Slide",
			},
		},
		distance = 1.5
	},
}

Config.PolyZones = {}

Config.TargetBones = {
	["mechanic"] = {
        bones = {
            "door_dside_f",
            "door_dside_r",
            "door_pside_f",
            "door_pside_r"
        },
        options = {
            {
                type = "client",
                event = "ax-mechanic:vehmenu",
                icon = "fas fa-key",
                label = "Vehicle Menu",
                job = "mechanic",
            },
        },
        distance = 3.0
    },
}

Config.TargetModels = {
    ["slushies"] = {
        models  = {
            `prop_juice_dispenser`
        },
        options = {
            {
                type = "client",
                event = "qb-shops:client:MixSlushies",
                parameters = {},
                icon = "fas fa-blender",
                label = "Mix Slushies",
            },
        },
        distance = 2.5
    },
    ["Dumpsters"] = {
        models = {
            218085040, 
            666561306, 
            -58485588, 
            -206690185, 
            1511880420, 
            682791951,
        },
        options = {
            {
                type = "client",
                event = "qb-dumpster:Dive",
                icon = "fas fa-trash-alt",
                label = "Search Dumpster",
            },
        },
        distance = 2.5,
    },
   ["Boombox"] = {
        models = {
            1729911864,
        },
        options = {
            {
                type = "client",
                event = "qb-boombox:client:playMusic",
                icon = "fas fa-volume-up",
                label = "Boombox",
                -- job = "admin",
            },
        },
        distance = 2.5,
    },
}

Config.GlobalPedOptions = {}

Config.GlobalVehicleOptions = {}

Config.GlobalObjectOptions = {}

Config.GlobalPlayerOptions = {}

Config.Peds = {
	-- Foundry
	[1] = {
		model = 's_m_y_construct_01',
		coords = vector4(1111.84, -2004.75, 35.44, 285.3),
		minusOne = true,
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	-- Rock Washing
	[2] = {
		model = 's_m_y_construct_02',
		coords = vector4(287.05, 2843.48, 44.7, 27.8),
		minusOne = true,
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	-- Wood Processing
	[3] = {
		model = 'cs_old_man2',
		coords = vector4(-569.61, 5332.35, 70.21, 41.09),
		minusOne = true,
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	-- Pet Shop
	[4] = {
		model = 'cs_tracydisanto',
		coords = vector4(-582.7, -1056.77, 22.35, 300.39),
		minusOne = true,
		freeze = true,
		invincible = true,
		blockevents = true,
	},
}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function ItemCheck() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('qb-core')
	if state ~= 'missing' then
		local timeout = 0
		while state ~= 'started' and timeout <= 100 do
			timeout += 1
			state = GetResourceState('qb-core')
			Wait(0)
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCheck = function(items)
			local isTable = type(items) == 'table'
			local isArray = isTable and table.type(items) == 'array' or false
			local finalcount = 0
			local count = 0
			if isTable then for _ in pairs(items) do finalcount += 1 end end
			for _, v in pairs(PlayerData.items) do
				if isTable then
					if isArray then -- Table expected in this format {'itemName1', 'itemName2', 'etc'}
						for _, item in pairs(items) do
							if v and v.name == item then
								count += 1
							end
						end
					else -- Table expected in this format {['itemName'] = amount}
						local itemAmount = items[v.name]
						if itemAmount and v and v.amount >= itemAmount then
							count += 1
						end
					end
					if count == finalcount then -- This is to make sure it checks all items in the table instead of only one of the items
						return true
					end
				else -- When items is a string
					if v and v.name == items then
						return true
					end
				end
			end
			return false
		end

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.item and not ItemCheck(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end