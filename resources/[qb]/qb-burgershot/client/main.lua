-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local processingFood = false
local PlayerData = {}
local PlayerJob = {}
local onDuty = false

-- Functions
function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Handlers
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "BurgerShot" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent("qb-burgershot:client:createMurderMeal", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientMurderMeal', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("bs_murdermeal", "Making A Murder Meal..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
                    TriggerServerEvent('qb-burgershort:server:createMurderMeal')
                    QBCore.Functions.Notify("You made a A Murder Meal", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("You dont have the items to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end  
end)

RegisterNetEvent("qb-burgershot:MurderMeal", function()
	TriggerServerEvent('qb-burgershort:server:MurderMeal')
end)


RegisterNetEvent("qb-burgershot:foodBag", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerBag")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerBag", {maxweight = 10000, slots = 6,})
end)

RegisterNetEvent("qb-burgershot:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage", {maxweight = 250000, slots = 40,})
end)

RegisterNetEvent("qb-burgershot:Fridge", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgershotfridge")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgershotfridge", {maxweight = 250000,slots = 40,})
end)

RegisterNetEvent("qb-burgershot:foodSlide", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgershotfood")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgershotfood", {maxweight = 250000,slots = 40,})
end)

-- Burger
RegisterNetEvent('qb-burgershot:client:inputMeat', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Cook Meat',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'meat',
                    text = 'Enter Number to Cook'
                }
            }
        })
    if dialog then
        if not dialog.meat then return end
        TriggerServerEvent('qb-burgershot:server:processMeat', dialog.meat)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processMeat', function(burgerNumber)
    local finaltime = tonumber(burgerNumber * 3000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('cooking_meat', 'Cooking Meat ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:cookMeat', burgerNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Fries
RegisterNetEvent('qb-burgershot:client:inputFries', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Cook Fries',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'potato',
                    text = 'Enter Number to Cook'
                }
            }
        })
    if dialog then
        if not dialog.potato then return end
        TriggerServerEvent('qb-burgershot:server:processFries', dialog.potato)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processFries', function(friesNumber)
    local finaltime = tonumber(friesNumber * 3000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('cooking_meat', 'Cooking Fries ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:cookFries', friesNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Soft Drink
RegisterNetEvent('qb-burgershot:client:inputSoftDrink', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Soft Drink',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'softdrink',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.softdrink then return end
        TriggerServerEvent('qb-burgershot:server:processSoftDrink', dialog.softdrink)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processSoftDrink', function(drinkNumber)
    local finaltime = tonumber(drinkNumber * 2000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('pouring_drink', 'Pouring Soft Drink ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "",
        anim = "",
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeSoftDrink', drinkNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Milkshake
RegisterNetEvent('qb-burgershot:client:inputMilkshake', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Milkshake',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'milkshake',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.milkshake then return end
        TriggerServerEvent('qb-burgershot:server:processMilkshake', dialog.milkshake)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processMilkshake', function(milkshakeNumber)
    local finaltime = tonumber(milkshakeNumber * 2000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('pouring_milkshake', 'Pouring Milkshake ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "",
        anim = "",
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeMilkshake', milkshakeNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- MoneyShot Burger
RegisterNetEvent('qb-burgershot:client:inputBurger', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Prepare Burgers',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'burger',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.burger then return end
        TriggerServerEvent('qb-burgershot:server:processBurger', dialog.burger)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processBurger', function(burgerNumber)
    local finaltime = tonumber(burgerNumber * 2000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('preparing_burger', 'Preparing Burger ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeBurger', burgerNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Bleeder Burger
RegisterNetEvent('qb-burgershot:client:inputBurger2', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Prepare Burgers',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'burger',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.burger then return end
        TriggerServerEvent('qb-burgershot:server:processBurger2', dialog.burger)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processBurger2', function(burgerNumber)
    local finaltime = tonumber(burgerNumber * 2000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('preparing_burger', 'Preparing Burger ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeBurger2', burgerNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- HeartStopper Burger
RegisterNetEvent('qb-burgershot:client:inputBurger3', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Prepare Burgers',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'burger',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.burger then return end
        TriggerServerEvent('qb-burgershot:server:processBurger3', dialog.burger)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processBurger3', function(burgerNumber)
    local finaltime = tonumber(burgerNumber * 2000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('preparing_burger', 'Preparing Burger ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeBurger3', burgerNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Torpedo Roll
RegisterNetEvent('qb-burgershot:client:inputBurger4', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Prepare Torpdeo Roll',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'burger',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.burger then return end
        TriggerServerEvent('qb-burgershot:server:processBurger4', dialog.burger)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processBurger4', function(burgerNumber)
    local finaltime = tonumber(burgerNumber * 2000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('preparing_torepdo', 'Preparing Torpedo Roll ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeBurger4', burgerNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Meat Free
RegisterNetEvent('qb-burgershot:client:inputBurger5', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Prepare Meat Free',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'burger',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.burger then return end
        TriggerServerEvent('qb-burgershot:server:processBurger5', dialog.burger)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processBurger5', function(burgerNumber)
    local finaltime = tonumber(burgerNumber * 2000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('preparing_meatfree', 'Preparing Meat Free ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeBurger5', burgerNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Murdermeal
RegisterNetEvent('qb-burgershot:client:inputBurger6', function()
    if processingFood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Prepare Murder Meal',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'burger',
                    text = 'Enter Number to Make'
                }
            }
        })
    if dialog then
        if not dialog.burger then return end
        TriggerServerEvent('qb-burgershot:server:processBurger6', dialog.burger)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-burgershot:client:processBurger6', function(burgerNumber)
    local finaltime = tonumber(burgerNumber * 4000)
    local processTime = finaltime / 1000
    local processingFood = true
    QBCore.Functions.Progressbar('preparing_murdermeal', 'Preparing Murder Meal ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 8,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        TriggerServerEvent('qb-burgershot:server:makeBurger6', burgerNumber)
        ClearPedTasks(PlayerPedId())
        local processingFood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingFood = false
    end)
end)

-- Menus
RegisterNetEvent('qb-burgershot:Burgers', function()
    exports['qb-menu']:openMenu({
        {
            header = "🍔 Burger Station",
            isMenuHeader = true
        },
        {
            header = "Moneyshot Burger",
            txt = "Bun • Cooked Patty • Tomato • Lettuce",
            params = {
                event = "qb-burgershot:client:inputBurger"
            }
        },
        {
            header = "Bleeder Burger",
            txt = "Bun • Cooked Patty • Tomato • Lettuce",
            params = {
                event = "qb-burgershot:client:inputBurger2"
            }
        },
        {
            header = "The Heart Stopper",
            txt = "Bun • Cooked Patty • Tomato • Lettuce",
            params = {
                event = "qb-burgershot:client:inputBurger3"
            }
        },
        {
            header = "Torpedo Roll",
            txt = "Bun • Cooked Meat",
            params = {
                event = "qb-burgershot:client:inputBurger4"
            }
        },
        {
            header = "Meat Free Burger",
            txt = "Bun • Tomato • Lettuce",
            params = {
                event = "qb-burgershot:client:inputBurger5"
            }
        },
        {
            header = "Murder Meal",
            txt = "The Heart Stopper • Fries • SoftDrink",
            params = {
                event = "qb-burgershot:client:inputBurger6"
            }
        },
    })
end)

RegisterNetEvent('qb-burgershot:OrderMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "📦 Fridge",
            isMenuHeader = true
        },
        {
            header = "Order Items",
            txt = "Order New Ingredients!",
            params = {
                event = "qb-burgershot:shop"
            }
        },
        {
            header = "Open Fridge",
            txt = "See what you have in storage",
            params = {
                event = "qb-burgershot:Fridge"
            }
        },
    })
end)

RegisterNetEvent('qb-burgershot:DrinkMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "🥤 Drinks",
            isMenuHeader = true
        },
        {
            header = "Soft Drink",
            txt = "Soda Syrup",
            params = {
                event = "qb-burgershot:client:inputSoftDrink"
            }
        },
        {
            header = "Milkshake",
            txt = "Milkshake Formula",
            params = {
                event = "qb-burgershot:client:inputMilkshake"
            }
        },
    })
end)

RegisterNetEvent('qb-burgershot:Prices', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "💷 Burgershot Prices",
            txt = "",
        },
        {
            header = "Soft Drinks: £250",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            },
        },
        {
            header = "Milkshakes: £250",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            },
        },
        {
            header = "Fries: £300",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            },
        },
        {
            header = "Burgers: £500",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            },
        },
        {
            header = "Murder Meal: £1,000",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            },
        },
        {
            header = "Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            },
        },
    })
end)

RegisterNetEvent("qb-burgershot:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "burgershot", Config.Items)
end)

RegisterNetEvent('qb-burgershot:client:BillPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        print (playerId)
        TriggerServerEvent("qb-burgershot:server:BillPlayer", playerId)
    else
        QBCore.Functions.Notify('No one nearby', 'error')
    end
end)

RegisterNetEvent('qb-burgershot:client:bill', function()
    local bill = exports['qb-input']:ShowInput({
        header = '💷 Burgershot Receipt',
        submitText = "Submit",
        inputs = {
            
            {
                text = "Paypal ID", -- text you want to be displayed as a place holder
                name = "serverid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                text = 'Payment Amount',
                type = 'number', -- number doesn't accept decimals??
                name = 'amount',
                isRequired = true
            },
            {
                text = "Payment Option",
                name = "payment",
                type = "radio",
                options = {
                    { value = "cash", text = "Cash" },
                    { value = "bank", text = "Debit Card"},
                },
                isRequired = true
            },
        }
    })
    if bill then
        if not bill.serverid then return end
        if tonumber(bill.amount) > 0 then 
        	TriggerServerEvent('qb-burgershot:server:bill', bill.serverid, bill.amount, bill.payment)
    	end
    end
end)

-- Threads
CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        if PlayerJob.name =="burgershot" then
            local dist = #(GetEntityCoords(ped)-vector3(-1197.92, -895.65, 13.97))
            if dist <= 1.0 then
                wait = 5
                inZone  = true
                if IsControlJustReleased(0, 38) then
                    exports['qb-core']:KeyPressed()
                    TriggerEvent('qb-burgershot:client:inputMeat')
                end
            else
                wait = 1000
            end
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Cook Meat', 'left')
        end
        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['qb-core']:HideText()
        end
        Wait(wait)
    end
end)

CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        if PlayerJob.name =="burgershot" then
            local dist = #(GetEntityCoords(ped)-vector3(-1200.55, -897.43, 13.97))
            if dist <= 1.0 then
                wait = 5
                inZone  = true
                if IsControlJustReleased(0, 38) then
                    exports['qb-core']:KeyPressed()
                    TriggerEvent('qb-burgershot:client:inputFries')
                end
            else
                wait = 1000
            end
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Cook Fries', 'left')
        end
        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['qb-core']:HideText()
        end
        Wait(wait)
    end
end)

CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        if PlayerJob.name =="burgershot" then
            local dist = #(GetEntityCoords(ped)-vector3(-1197.78, -897.74, 13.97))
            if dist <= 1.0 then
                wait = 5
                inZone  = true
                if IsControlJustReleased(0, 38) then
                    exports['qb-core']:KeyPressed()
                    TriggerEvent('qb-burgershot:Burgers')
                end
            else
                wait = 1000
            end
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Burger Station', 'left')
        end
        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['qb-core']:HideText()
        end
        Wait(wait)
    end
end)

CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        if PlayerJob.name =="burgershot" then
            local dist = #(GetEntityCoords(ped)-vector3(-1196.2, -894.55, 13.90))
            if dist <= 1.0 then
                wait = 5
                inZone  = true
                if IsControlJustReleased(0, 38) then
                    exports['qb-core']:KeyPressed()
                    TriggerEvent('qb-burgershot:DrinkMenu')
                end
            else
                wait = 1000
            end
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Drinks Dispenser', 'left')
        end
        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['qb-core']:HideText()
        end
        Wait(wait)
    end
end)

CreateThread(function()
    local alreadyEnteredZone = false
    local text = '[E] Storage'
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        if PlayerJob.name =="burgershot" then
            local dist = #(GetEntityCoords(ped)-vector3(-1200.88, -901.19, 13.97))
            if dist <= 1.0 then
                wait = 5
                inZone  = true
                if IsControlJustReleased(0, 38) then
                    exports['qb-core']:KeyPressed()
                    TriggerEvent('qb-burgershot:OrderMenu')
                end
            else
                wait = 1000
            end
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Storage', 'left')
        end
        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['qb-core']:HideText()
        end
        Wait(wait)
    end
end)

CreateThread(function()
    BurgerShot = AddBlipForCoord(-1197.32, -897.655, 13.995)
    SetBlipSprite (BurgerShot, 384)
    SetBlipDisplay(BurgerShot, 4)
    SetBlipAlpha (BurgerShot, 0.9)
    SetBlipScale  (BurgerShot, 0.75)
    SetBlipAsShortRange(BurgerShot, true)
    SetBlipColour(BurgerShot, 0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("BurgerShot")
    EndTextCommandSetBlipName(BurgerShot)
end) 
