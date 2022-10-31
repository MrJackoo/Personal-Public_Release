print("^2Jim^7-^2Recycle v^42^7.^42 ^7- ^2Recycling Script by ^1Jimathy^7")

Config = {
	Debug = false, -- Toggle Debug Mode
	Blips = true, -- Enable Blips?
	BlipNamer = false, -- Enable to Name Blips different things, disable if you already have too many blips as this will group them together
	Pedspawn = true, -- Do you want to spawn peds for main locations?
	img = "lj-inventory/html/images/", -- Set this to your inventory
	JimMenu = false, -- If using updated qb-menu icons, set this true
	JobRole = nil, -- Whats the job role you want to use this? "nil" for none
	EnableOpeningHours = false, -- Enable opening hours? If disabled you can always open the pawnshop.
	OpenHour = 9, -- From what hour should the pawnshop be open?
	CloseHour = 21, -- From what hour should the pawnshop be closed?
	PayAtDoor = nil, -- Set to nil stop turn this off, set to a number to enable

	useQBLock = true, -- Enable to use qb-lock instead of qb-skillbar when searching

	OutsideTele = vector4(747.15, -1399.39, 26.62, 11.81),
	InsideTele = vector4(993.16, -3097.61, -39.90, 82.95),

	MapBlip = vector2(747.15, -1399.39),

	Locations =  {
		['Recycle'] = {
			{ name = "Recycle Seller", coords = vector4(-560.63, 5282.79, 73.05, 164.86), blipTrue = true, sprite = 500, col = 2, model = `G_M_M_ChemWork_01`, scenario = "WORLD_HUMAN_CLIPBOARD", },
		},
		['Trade'] ={
			{ name = "Recyclable Trader", coords = vector4(997.48, -3097.44, -39.0, 234.53), blipTrue = false, sprite = 365, col = 2, model = `G_M_M_ChemWork_01`, scenario = "WORLD_HUMAN_CLIPBOARD", },
		},
		['BottleBanks'] = {
			{ name = "Bottle Bank", coords = vector4(-1267.97, -812.08, 17.11 , 128.12), blipTrue = true, sprite = 642, col = 2, model = `G_M_M_ChemWork_01`, scenario = "WORLD_HUMAN_CLIPBOARD", },
		},
	},
	Prices = {
		['copper'] = 6,
		['plastic'] = 6,
		['metalscrap'] = 6,
		['steel'] = 6,
		['glass'] = 6,
		['iron'] = 6,
		['rubber'] = 6,
		['aluminum'] = 6,
		['bottle'] = 3,
		['can'] = 4,
	},
	TradeTable = {
		"copper",
		"plastic",
		"metalscrap",
		"steel",
		"glass",
		"iron",
		"rubber",
		"aluminum",
		"bottle",
		"can",
	},
	DumpItems = {
		"bottle",
		"can",
		"sandwich",
	},
	ScrapItems = {
		"steel",
		"copper",
		"iron",
		"glass",
		"bottle",
		"can",
	},
	RecycleAmounts = {
		recycleMin = 4,
		recycleMax = 21,

		oneMin = 1,
		oneMax = 6,

		tenMin = 5,
		tenMax = 11,

		hundMin = 10,
		hundMax = 12,

		thouMin = 14,
		thouMax = 19,
	}
}