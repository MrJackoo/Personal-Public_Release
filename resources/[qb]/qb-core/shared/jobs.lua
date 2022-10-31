QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Unemployed',
                payment = 50
            },
        },
	},
	['police'] = {
		label = 'Los Santos Police',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'CSO',
                payment = 1500
            },
			['1'] = {
                name = 'PCSO',
                payment = 2500
            },
			['2'] = {
                name = 'PC',
                payment = 3500
            },
			['3'] = {
                name = 'SGT',
                payment = 4500
            },
            ['4'] = {
                name = 'INS',
                isboss = true,
                payment = 5500
            },
            ['5'] = {
                name = 'CI',
				isboss = true,
                payment = 6500
            },
            ['6'] = {
                name = 'SI',
				isboss = true,
                payment = 7500
            },
            ['7'] = {
                name = 'CSI',
				isboss = true,
                payment = 8500
            },
            ['8'] = {
                name = 'CC',
				isboss = true,
                payment = 9500
            },
        },
	},
	['ambulance'] = {
		label = 'Los Santos NHS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Apprentice Paramedic',
                payment = 3600
            },
			['1'] = {
                name = 'Emergency Medical Technician',
                payment = 3800
            },
			['2'] = {
                name = 'Paramedic',
                payment = 4000
            },
			['3'] = {
                name = 'Senior Paramedic',
                payment = 4750
            },
            ['4'] = {
                name = 'Doctor',
                payment = 5000
            },
            ['5'] = {
                name = 'Surgeon',
                payment = 5600,
                isboss = true
            },
            ['6'] = {
                name = 'Head of Service',
                isboss = true,
                payment = 6500
            },
			['7'] = {
                name = 'Chief Executive',
				isboss = true,
                payment = 8000
            },
            ['8'] = {
                name = 'Chief Medical Officer',
				isboss = true,
                payment = 10000
            },
        },
	},
	['realestate'] = {
		label = 'AX Homes LLC',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 400
            },
			['1'] = {
                name = 'Driver',
                payment = 600
            },
			['2'] = {
                name = 'Event Driver',
                payment = 800
            },
			['3'] = {
                name = 'Sales',
                payment = 950
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 1150
            },
        },
	},
    ['bus'] = {
		label = 'First Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 250
            },
		},
	},
	['cardealer'] = {
		label = 'LS Imports',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 650
            },
			['2'] = {
                name = 'Business Sales',
                payment = 750
            },
			['3'] = {
                name = 'Finance',
                payment = 850
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 1000
            },
        },
	},
	['tuner'] = {
		label = 'Hayes Mechanics',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 400
            },
			['1'] = {
                name = 'Novice',
                payment = 500
            },
			['2'] = {
                name = 'Experienced',
                payment = 600
            },
			['3'] = {
                name = 'Advanced',
                payment = 700
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 850
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 1500
            },
        },
	},
	['lawyer'] = {
		label = 'Right Law PLC',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 500
            },
        },
	},
	['reporter'] = {
		label = 'BBC News',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 350
            },
        },
	},
	-- ['trucker'] = {
	-- 	label = 'Trucker',
	-- 	defaultDuty = true,
	-- 	offDutyPay = false,
	-- 	grades = {
    --         ['0'] = {
    --             name = 'Driver',
    --             payment = 50
    --         },
    --     },
	-- },
	-- ['tow'] = {
	-- 	label = 'Tug & Tow',
	-- 	defaultDuty = true,
	-- 	offDutyPay = false,
	-- 	grades = {
    --         ['0'] = {
    --             name = 'Driver',
    --             payment = 100
    --         },
    --     },
	-- },
	['garbage'] = {
		label = 'Los Santos Council',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 100
            },
        },
	},
    ['burgershot'] = {
		label = "Burgershot",
		defaultDuty = true,
        offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 500
            },
			['1'] = {
                name = "Employee",
                payment = 600
            },
			['2'] = {
                name = "Burger Flipper",
                payment = 700
            },
			['3'] = {
                name = "Manager",
                payment = 800
            },
			['4'] = {
                name = "CEO",
				isboss = true,
                payment = 900
            },
        },
	},
    ['locker'] = {
		label = 'Pacific Bluffs Storage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee Sales',
                payment = 400
            },
			['1'] = {
                name = 'Sales Assistant',
                payment = 600
            },
			['2'] = {
                name = 'Senior Sales Assistant',
                payment = 800
            },
			['3'] = {
                name = 'Manager',
                payment = 950
            },
			['4'] = {
                name = 'Director',
				isboss = true,
                payment = 1150
            },
        },
	},
    -- ['arcade'] = {
	-- 	label = 'Pixel Emporium',
	-- 	defaultDuty = true,
	-- 	offDutyPay = false,
	-- 	grades = {
    --         ['0'] = {
    --             name = 'Apprentice',
    --             payment = 200
    --         },
	-- 		['1'] = {
    --             name = 'Sales Assistant',
    --             payment = 400
    --         },
	-- 		['2'] = {
    --             name = 'Senior Sales Assistant',
    --             payment = 600
    --         },
	-- 		['3'] = {
    --             name = 'Manager',
    --             payment = 800
    --         },
	-- 		['4'] = {
    --             name = 'Director',
	-- 			isboss = true,
    --             payment = 1000
    --         },
    --     },
	-- },
    ['government'] = {
		label = 'LS Government',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = {
                name = 'Government Official',
				isboss = true,
                payment = 500
            },
        },
	},
    ['vu'] = {
		label = "Vanilla Unicorn Employee",
		defaultDuty = false,
		-- bossmenu = vector3(95.7, -1294.31, 29.26),
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 500
            },
			['1'] = {
                name = "Dancer",
                payment = 600
            },
			['2'] = {
                name = "Security",
                payment = 700
            },
			['3'] = {
                name = "Bartender",
                payment = 800
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 900
            },
			['5'] = {
                name = "CEO",
				isboss = true,
                payment = 1000
            },
        },
	},
    ['telco'] = {
		label = "Telecomms Employee",
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = "Communications Engineer",
                payment = 250
            },
        },
    },
    ['casino'] = {
		label = "Shackles Casino",
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = "Security",
                payment = 500
            },
			['1'] = {
                name = "Bartender",
                payment = 600
            },
			['2'] = {
                name = "Cashier",
                payment = 800
            },
			['3'] = {
                name = "Assistant Manager",
				isboss = true,
                payment = 900
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 1000
            },
            
        },
	},
    ['weaponsdealer'] = {
		label = "Wang & Windsor Arms",
		defaultDuty = false,
		grades = {
			['0'] = {
                name = "Leaders",
				isboss = true,
                payment = 1000
            },
        },
	},
    ['jdm'] = {
		label = "Top Secret Garage",
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = "Racer",
                payment = 500
            },
			['1'] = {
                name = "Mechanic",
                payment = 600
            },
			['2'] = {
                name = "Senior Mechanic",
                payment = 800
            },
			['3'] = {
                name = "Ledgendary Mechanic",
                payment = 900
            },
			['4'] = {
                name = "Godly Mechanic",
				isboss = true,
                payment = 1200
            },
        },
	},
}