local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = QBCore.Functions.GetPlayerData().job
local shownBossMenu = false

-- UTIL
local function CloseMenuFull()
    exports['qb-menu']:closeMenu()
    exports['qb-core']:HideText()
    shownBossMenu = false
end

local function comma_value(amount)
    local formatted = amount
    while true do
        local k
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    TriggerServerEvent('QBCore:UpdatePlayer')
end)

RegisterNetEvent('qb-bossmenu:client:OpenMenu', function()
    if not PlayerJob.name or not PlayerJob.isboss then return end

    if PlayerJob.name == ("police" or "ambulance") then
        bossMenu = {
            {
                header = "Boss Menu - " .. string.upper(PlayerJob.label),
                icon = "fa-solid fa-circle-info",
                isMenuHeader = true,
            },
            {
                header = "Manage Employees",
                txt = "Check your Employees List",
                icon = "fa-solid fa-list",
                params = {
                    event = "qb-bossmenu:client:employeelist",
                }
            },
            {
                header = "Hire Employees",
                txt = "Hire Nearby Civilians",
                icon = "fa-solid fa-hand-holding",
                params = {
                    event = "qb-bossmenu:client:HireMenu",
                }
            },
            {
                header = "Storage Access",
                txt = "Open Storage",
                icon = "fa-solid fa-box-open",
                params = {
                    event = "qb-bossmenu:client:Stash",
                }
            },
            {
                header = "Outfits",
                txt = "See Saved Outfits",
                icon = "fa-solid fa-shirt",
                params = {
                    event = "qb-bossmenu:client:Wardrobe",
                }
            },
            {
                header = "Money Management",
                txt = "Check your Company Balance",
                icon = "fa-solid fa-sack-dollar",
                params = {
                    event = "qb-bossmenu:client:SocietyMenu",
                }
            },
            {
                header = "Exit",
                icon = "fa-solid fa-angle-left",
                params = {
                    event = "qb-menu:closeMenu",
                }
            },
        }    
    else
        bossMenu = {
            {
                header = "Boss Menu - " .. string.upper(PlayerJob.label),
                icon = "fa-solid fa-circle-info",
                isMenuHeader = true,
            },
            {
                header = "Manage Employees",
                txt = "Check your Employees List",
                icon = "fa-solid fa-list",
                params = {
                    event = "qb-bossmenu:client:employeelist",
                }
            },
            {
                header = "Hire Employees",
                txt = "Hire Nearby Civilians",
                icon = "fa-solid fa-hand-holding",
                params = {
                    event = "qb-bossmenu:client:HireMenu",
                }
            },
            {
                header = "Outfits",
                txt = "See Saved Outfits",
                icon = "fa-solid fa-shirt",
                params = {
                    event = "qb-bossmenu:client:Wardrobe",
                }
            },
            {
                header = "Money Management",
                txt = "Check your Company Balance",
                icon = "fa-solid fa-sack-dollar",
                params = {
                    event = "qb-bossmenu:client:SocietyMenu",
                }
            },
            {
                header = "Exit",
                icon = "fa-solid fa-angle-left",
                params = {
                    event = "qb-menu:closeMenu",
                }
            },
        }
    end
    exports['qb-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('qb-bossmenu:client:employeelist', function()
    local EmployeesMenu = {
        {
            header = "Manage Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            EmployeesMenu[#EmployeesMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "qb-bossmenu:client:ManageEmployee",
                    args = {
                        player = v,
                        work = PlayerJob,
                        targetId = v.empSource,
                        whitelistflags = v.whitelistingflags
                    }
                }
            }
        end
        EmployeesMenu[#EmployeesMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-bossmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(EmployeesMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:ManageEmployee', function(data)
    local EmployeeMenu = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info"
        },
    }
    -- for k, v in pairs(QBCore.Shared.Jobs[data.work.name].grades) do
    --     EmployeeMenu[#EmployeeMenu + 1] = {
    --         header = v.name,
    --         txt = "Grade: " .. k,
    --         params = {
    --             isServer = true,
    --             event = "qb-bossmenu:server:GradeUpdate",
    --             icon = "fa-solid fa-file-pen",
    --             args = {
    --                 cid = data.player.empSource,
    --                 grade = tonumber(k),
    --                 gradename = v.name
    --             }
    --         }
    --     }
    -- end

    -- altered to allow for custom whitelist @jackbatchiee
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Change Grades",
        params = {
            event = "qb-bossmenu:client:Gradechanging",
            args = {
                CitizenId = data.targetId,
                playername = data.player.name,
                work = data.work

            }
        }
    }

    if PlayerJob.name == "police" or PlayerJob.name == "ambulance" then
        if PlayerJob.name == "police" and PlayerJob.grade.level >= 5 then
            EmployeeMenu[#EmployeeMenu + 1] = {
                header = "Change Units Access",
                params = {
                    event = "qb-bossmenu:client:flagsystem",
                    args = {
                        CitizenId = data.targetId,
                        playername = data.player.name,
                        work = data.work,
                        flaglist = data.whitelistflags

                    }
                }
            }
        end
        if PlayerJob.name == "ambulance" and PlayerJob.grade.level >= 6 then
            EmployeeMenu[#EmployeeMenu + 1] = {
                header = "Change Units Access",
                params = {
                    event = "qb-bossmenu:client:flagsystem",
                    args = {
                        CitizenId = data.targetId,
                        playername = data.player.name,
                        work = data.work,
                        flaglist = data.whitelistflags

                    }
                }
            }
        end
    end
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Fire Employee",
        icon = "fa-solid fa-user-large-slash",
        params = {
            isServer = true,
            event = "qb-bossmenu:server:FireEmployee",
            args = data.player.empSource
        }
    }
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Return",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "qb-bossmenu:client:OpenMenu",
        }
    }
    exports['qb-menu']:openMenu(EmployeeMenu)
end)

-- added to allow for custom whitelist @jackbatchiee
RegisterNetEvent('qb-bossmenu:client:Gradechanging', function(data)
    local Gradechanging = {
        {
            header = "Manage Grades - " .. data.playername .. " - " .. data.CitizenId,
            isMenuHeader = true,
        },
    }
    for k, v in pairs(QBCore.Shared.Jobs[data.work.name].grades) do
        Gradechanging[#Gradechanging + 1] = {
            header = v.name,
            txt = "Grade: " .. k,
            params = {
                isServer = true,
                event = "qb-bossmenu:server:GradeUpdate",
                args = {
                    cid = data.CitizenId,
                    grade = tonumber(k),
                    gradename = v.name
                }
            }
        }
    end

    Gradechanging[#Gradechanging + 1] = {
        header = "< Return",
        params = {
            event = "qb-bossmenu:client:OpenMenu",
        }
    }
    exports['qb-menu']:openMenu(Gradechanging)
end)

-- added to allow for custom whitelist @jackbatchiee
local flagchangingtypes = {
    ['police'] = {
		label = 'Los Santos Police Flags',
		flags = {
            ['firearms'] = {
                name = 'Firearms',
                defaultlevel = 0
            }, -- DO NOT USE
            ['traffic'] = {
                name = 'Traffic',
                defaultlevel = 0
            },
			['npas'] = {
                name = 'NPAS',
                defaultlevel = 0
            },
			['dsu'] = {
                name = 'DSU',
                defaultlevel = 0
            },
			['cid'] = {
                name = 'CID',
                defaultlevel = 0
            },
        },
	},
    ['ambulance'] = {
		label = 'Los Santos NHS Flags',
		flags = {
            ['hems'] = {
                name = 'HEMS',
                defaultlevel = 0
            }, -- DO NOT USE
            ['hart'] = {
                name = 'HART',
                defaultlevel = 0
            }
        },
	},
}
-- added to allow for custom whitelist @jackbatchiee
local flagselectedtoedit = {
    ['firearms'] = {
        label = 'Firearms',
        levels = {
            ['0'] = {
                name = 'no access',
                number = 0
            },
            ['1'] = {
                name = 'tazer',
                number = 1
            },
            ['2'] = {
                name = 'gun',
                number = 2
            },
            ['3'] = {
                name = 'afo',
                number = 3
            },
            ['4'] = {
                name = 'sfo',
                number = 4
            },
            ['5'] = {
                name = 'ctsfo',
                number = 5
            },
            ['6'] = {
                name = 'firearms command',
                number = 6
            },
            ['7'] = {
                name = 'full access',
                number = 7
            },
        }
    },
    ['traffic'] = {
        label = 'Traffic',
        levels = {
            ['0'] = {
                name = 'nothing',
                number = 0
            },
            ['1'] = {
                name = 'probationary',
                number = 1
            },
            ['2'] = {
                name = 'driver',
                number = 2
            },
            ['3'] = {
                name = 'advanced',
                number = 3
            },
            ['4'] = {
                name = 'interceptor',
                number = 4
            },
            ['5'] = {
                name = 'trainer',
                number = 5
            },
            ['6'] = {
                name = 'traffic command',
                number = 6
            },
            ['7'] = {
                name = 'full access',
                number = 7
            },
        }
    },
    ['npas'] = {
        label = 'NPAS',
        levels = {
            ['0'] = {
                name = 'nothing',
                number = 0
            },
            ['1'] = {
                name = 'trainee',
                number = 1
            },
            ['2'] = {
                name = 'pilot',
                number = 2
            },
            ['3'] = {
                name = 'advanced',
                number = 3
            },
            ['4'] = {
                name = 'trainer',
                number = 4
            },
            ['5'] = {
                name = 'senior',
                number = 5
            },
            ['6'] = {
                name = 'npas command',
                number = 6
            },
            ['7'] = {
                name = 'full access',
                number = 7
            },
        }
    },
    ['dsu'] = {
        label = 'DSU',
        levels = {
            ['0'] = {
                name = 'nothing',
                number = 0
            },
            ['1'] = {
                name = 'trainee',
                number = 1
            },
            ['2'] = {
                name = 'handler',
                number = 2
            },
            ['3'] = {
                name = 'advanced handler',
                number = 3
            },
            ['4'] = {
                name = 'trainer',
                number = 4
            },
            ['5'] = {
                name = 'senior',
                number = 5
            },
            ['6'] = {
                name = 'dsu command',
                number = 6
            },
            ['7'] = {
                name = 'full access',
                number = 7
            },
        }
    },
    ['cid'] = {
        label = 'CID',
        levels = {
            ['0'] = {
                name = 'nothing',
                number = 0
            },
            ['1'] = {
                name = 'fingerprints',
                number = 1
            },
            ['2'] = {
                name = 'covert',
                number = 2
            },
            ['3'] = {
                name = 'trainee detective',
                number = 3
            },
            ['4'] = {
                name = 'detective',
                number = 4
            },
            ['5'] = {
                name = 'detective sergeant',
                number = 5
            },
            ['6'] = {
                name = 'cid command',
                number = 6
            },
            ['7'] = {
                name = 'full access',
                number = 7
            },
        }
    },
    ['hems'] = {
        label = 'HEMS',
        levels = {
            ['0'] = {
                name = 'nothing',
                number = 0
            },
            ['1'] = {
                name = 'Trainee',
                number = 1
            },
            ['2'] = {
                name = 'Technician',
                number = 2
            },
            ['3'] = {
                name = 'Doctor',
                number = 3
            },
            ['4'] = {
                name = 'Co-Pilot',
                number = 4
            },
            ['5'] = {
                name = 'Pilot',
                number = 5
            },
            ['6'] = {
                name = 'Command',
                number = 6
            }
        }
    },
    ['hart'] = {
        label = 'HART',
        levels = {
            ['0'] = {
                name = 'nothing',
                number = 0
            },
            ['1'] = {
                name = 'Trainee',
                number = 1
            },
            ['2'] = {
                name = 'Advanced Medical Training',
                number = 2
            },
            ['3'] = {
                name = 'HART Command',
                number = 3
            }
        }
    },
}
-- added to allow for custom whitelist @jackbatchiee
RegisterNetEvent('qb-bossmenu:client:flagsystem', function(data)
    local flagsystem = {
        {
            header = "Manage Units Access - " .. data.playername .. " - " .. data.CitizenId,
            isMenuHeader = true,
        },
    }

    for k, v in pairs(flagchangingtypes[data.work.name].flags) do
        flagsystem[#flagsystem + 1] = {
            header = v.name,
            txt = "Units Access: " .. v.name .. " Current Grade: ".. data.flaglist[string.lower(v.name)],
            params = {
                event = "qb-bossmenu:client:flagselected",
                args = {
                    citizenId = data.CitizenId,
                    flagname = k,
                    playername = data.playername,
                    oldvalue = data.flaglist[string.lower(v.name)]
                }
            }
        }
    end

    flagsystem[#flagsystem + 1] = {
        header = "< Return",
        params = {
            event = "qb-bossmenu:client:OpenMenu",
        }
    }
    exports['qb-menu']:openMenu(flagsystem)
end)

RegisterNetEvent('qb-bossmenu:client:flagselected', function(data)
    local flagselected = {
        {
            header = "Manage Units Access - " .. data.playername .. " - " .. data.citizenId.. " Current: ".. data.oldvalue,
            isMenuHeader = true,
        },
    }

    for k, v in pairs(flagselectedtoedit[data.flagname].levels) do
        flagselected[#flagselected + 1] = {
            header = v.name,
            txt = "Units Access: " .. v.name .. " Grade: ".. k,
            params = {
                isServer = true,
                event = "qb-bossmenu:server:FlagUpdate",
                args = {
                    cid = data.citizenId,
                    grade = tonumber(k),
                    playername = data.playername,
                    flagname = data.flagname,
                    newlevel = v.name
                }
            }
        }
    end

    flagselected[#flagselected + 1] = {
        header = "< Return",
        params = {
            event = "qb-bossmenu:client:OpenMenu",
        }
    }
    exports['qb-menu']:openMenu(flagselected)
end)

RegisterNetEvent('qb-bossmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerJob.name, {
        maxweight = 4000000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:Wardrobe', function()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qb-bossmenu:client:HireMenu', function()
    local HireMenu = {
        {
            header = "Hire Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMenu[#HireMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    icon = "fa-solid fa-user-check",
                    params = {
                        isServer = true,
                        event = "qb-bossmenu:server:HireEmployee",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMenu[#HireMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-bossmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(HireMenu)
    end)
end)

RegisterNetEvent('qb-bossmenu:client:SocietyMenu', function()
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Balance: £" .. comma_value(cb) .. " - " .. string.upper(PlayerJob.label),
                isMenuHeader = true,
                icon = "fa-solid fa-circle-info",
            },
            {
                header = "Deposit",
                icon = "fa-solid fa-money-bill-transfer",
                txt = "Deposit Money into account",
                params = {
                    event = "qb-bossmenu:client:SocetyDeposit",
                    args = comma_value(cb)
                }
            },
            {
                header = "Withdraw",
                icon = "fa-solid fa-money-bill-transfer",
                txt = "Withdraw Money from account",
                params = {
                    event = "qb-bossmenu:client:SocetyWithDraw",
                    args = comma_value(cb)
                }
            },
            {
                header = "Return",
                icon = "fa-solid fa-angle-left",
                params = {
                    event = "qb-bossmenu:client:OpenMenu",
                }
            },
        }
        exports['qb-menu']:openMenu(SocietyMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:SocetyDeposit', function(money)
    local deposit = exports['qb-input']:ShowInput({
        header = "Deposit Money <br> Available Balance: £" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        TriggerServerEvent("qb-bossmenu:server:depositMoney", tonumber(deposit.amount))
    end
end)

RegisterNetEvent('qb-bossmenu:client:SocetyWithDraw', function(money)
    local withdraw = exports['qb-input']:ShowInput({
        header = "Withdraw Money <br> Available Balance: £" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("qb-bossmenu:server:withdrawMoney", tonumber(withdraw.amount))
    end
end)

-- REMOTE EMPLOYEE MANAGEMENT VIA RADIAL

RegisterNetEvent('qb-bossmenu:client:Remote', function()
    if not PlayerJob.name or not PlayerJob.isboss then return end

    local remotemenu = {
        {
            header = "Boss Menu - " .. string.upper(PlayerJob.label),
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        },
        {
            header = "Manage Employees",
            txt = "Check your Employees List",
            icon = "fa-solid fa-list",
            params = {
                event = "qb-bossmenu:client:remotelist",
            }
        },
        {
            header = "Exit",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(remotemenu)
end)

-- REMOTE EMPLOYEE LIST VIA RADIAL
RegisterNetEvent('qb-bossmenu:client:remotelist', function()
    local remotelist = {
        {
            header = "Manage Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            remotelist[#remotelist + 1] = {
                header = v.name,
                txt = v.grade.name,
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "qb-bossmenu:client:remoteflags",
                    args = {
                        player = v,
                        work = PlayerJob,
                        targetId = v.empSource,
                        whitelistflags = v.whitelistingflags
                    }
                }
            }
        end
        remotelist[#remotelist + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-bossmenu:client:Remote",
            }
        }
        exports['qb-menu']:openMenu(remotelist)
    end, PlayerJob.name)
end)

-- REMOTE EMPLOYEE JOB FLAGS VIA RADIAL

RegisterNetEvent('qb-bossmenu:client:remoteflags', function(data)
    local remoteflags = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info"
        },
    }

    if PlayerJob.name == "police" or PlayerJob.name == "ambulance" then 
        remoteflags[#remoteflags + 1] = {
            header = "Change Units Access",
            params = {
                event = "qb-bossmenu:client:remoteflagtochange",
                args = {
                    CitizenId = data.targetId,
                    playername = data.player.name,
                    work = data.work,
                    flaglist = data.whitelistflags

                }
            }
        }
    end
    remoteflags[#remoteflags + 1] = {
        header = "Return",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "qb-bossmenu:client:Remote",
        }
    }
    exports['qb-menu']:openMenu(remoteflags)
end)

-- REMOTE EMPLOYEE JOB FLAGS CHANGE VIA RADIAL

RegisterNetEvent('qb-bossmenu:client:remoteflagtochange', function(data)
    local remoteflagsystem = {
        {
            header = "Manage Units Access - " .. data.playername .. " - " .. data.CitizenId,
            isMenuHeader = true,
        },
    }

    for k, v in pairs(flagchangingtypes[data.work.name].flags) do
        remoteflagsystem[#remoteflagsystem + 1] = {
            header = v.name,
            txt = "Units Access: " .. v.name .. " Current Grade: ".. data.flaglist[string.lower(v.name)],
            params = {
                event = "qb-bossmenu:client:remoteflagchanging",
                args = {
                    citizenId = data.CitizenId,
                    flagname = k,
                    playername = data.playername,
                    oldvalue = data.flaglist[string.lower(v.name)]
                }
            }
        }
    end

    remoteflagsystem[#remoteflagsystem + 1] = {
        header = "< Return",
        params = {
            event = "qb-bossmenu:client:Remote",
        }
    }
    exports['qb-menu']:openMenu(remoteflagsystem)
end)

-- REMOTE EMPLOYEE JOB FLAGS CHANGE VIA RADIAL

RegisterNetEvent('qb-bossmenu:client:remoteflagchanging', function(data)
    local remotechanging = {
        {
            header = "Manage Units Access - " .. data.playername .. " - " .. data.citizenId .. " Current: "..data.oldvalue,
            isMenuHeader = true,
        },
    }

    for k, v in pairs(flagselectedtoedit[data.flagname].levels) do
        remotechanging[#remotechanging + 1] = {
            header = v.name,
            txt = "Units Access: " .. v.name .. " Grade: ".. k,
            params = {
                isServer = true,
                event = "qb-bossmenu:server:FlagUpdate",
                args = {
                    cid = data.citizenId,
                    grade = tonumber(k),
                    playername = data.playername,
                    flagname = data.flagname,
                    newlevel = v.name
                }
            }
        }
    end

    remotechanging[#remotechanging + 1] = {
        header = "< Return",
        params = {
            event = "qb-bossmenu:client:Remote",
        }
    }
    exports['qb-menu']:openMenu(remotechanging)
end)

-- MAIN THREAD
CreateThread(function()
    if Config.UseTarget then
        for job, zones in pairs(Config.BossMenuZones) do
            for index, data in ipairs(zones) do
                exports['qb-target']:AddBoxZone(job.."-BossMenu-"..index, data.coords, data.length, data.width, {
                    name = job.."-BossMenu-"..index,
                    heading = data.heading,
                    debugPoly = false,
                    minZ = data.minZ,
                    maxZ = data.maxZ,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "qb-bossmenu:client:OpenMenu",
                            icon = "fas fa-sign-in-alt",
                            label = "Boss Menu",
                            canInteract = function() return job == PlayerJob.name and PlayerJob.isboss end,
                        },
                    },
                    distance = 2.5
                })
            end
        end
    else
        while true do
            local wait = 2500
            local pos = GetEntityCoords(PlayerPedId())
            local inRangeBoss = false
            local nearBossmenu = false
            if PlayerJob then
                wait = 0
                for k, menus in pairs(Config.BossMenus) do
                    for _, coords in ipairs(menus) do
                        if k == PlayerJob.name and PlayerJob.isboss then
                            if #(pos - coords) < 5.0 then
                                inRangeBoss = true
                                if #(pos - coords) <= 1.5 then
                                    nearBossmenu = true
                                    if not shownBossMenu then
                                        exports['qb-core']:DrawText('[E] Open Job Management', 'left')
                                        shownBossMenu = true
                                    end
                                    if IsControlJustReleased(0, 38) then
                                        exports['qb-core']:HideText()
                                        TriggerEvent("qb-bossmenu:client:OpenMenu")
                                    end
                                end

                                if not nearBossmenu and shownBossMenu then
                                    CloseMenuFull()
                                    shownBossMenu = false
                                end
                            end
                        end
                    end
                end
                if not inRangeBoss then
                    Wait(1500)
                    if shownBossMenu then
                        CloseMenuFull()
                        shownBossMenu = false
                    end
                end
            end
            Wait(wait)
        end
    end
end)
