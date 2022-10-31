-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local tree = 0
local tree2 = 0
local tree3 = 0
local tree4 = 0
local tree5 = 0
local tree6 = 0
local tree7 = 0
local tree8 = 0
local tree9 = 0
local tree10 = 0
local tree11 = 0
local tree12 = 0
local tree13 = 0
local tree14 = 0
local tree15 = 0
local processingWood = false
local processingCharcoal = false


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

function PrepareAnim()
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "world_human_hammering", 0, true)
end

function chopProcess()
    QBCore.Functions.Progressbar("chop_wood", "Chopping Wood..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("qb-lumber:server:woodchop")
        ClearPedTasks(PlayerPedId())
        ClearPedProp(PlayerPedId())
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        ClearPedProp(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
    end)
end

function PrepareAnim()
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "world_human_hammering", 0, true)
end


function RefiningProcess1()
    QBCore.Functions.Progressbar("refining_charcoal", "Burning Wood..", math.random(3000,6000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("qb-lumber:server:charcoal")
        ClearPedTasks(PlayerPedId())
        ClearPedProp(PlayerPedId())
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        ClearPedProp(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
    end)
end

-- Events
RegisterNetEvent('qb-lumber:LumberMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = "Lumber Mill",
            txt = "How much can a woodchuck chuck?"
        },
        {
            header = "Refine Wood",
            txt = "",
            params = {
                event = "qb-lumber:client:inputWood",
            }
        },
    })
end)

-- Wood
RegisterNetEvent('qb-lumber:client:inputWood', function()
    if processingWood == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Process Wood',
            submitText = "Submit",
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wood',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wood then return end
        TriggerServerEvent('qb-lumber:server:processWood', dialog.wood)
        else
            QBCore.Functions.Notify("You are already doing something!", "error")
        end
    end
end)

RegisterNetEvent('qb-lumber:client:processWood', function(woodNumber)
    local finaltime = tonumber(woodNumber * 3000)
    local processTime = finaltime / 1000
    local processingWood = true
    QBCore.Functions.Progressbar("process_wood", 'Processing Wood ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@base",
        anim = "base",
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("qb-lumber:server:Wood", woodNumber)
        ClearPedTasks(PlayerPedId())
        local processingWood = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
        local processingWood = false
    end)
end)

-- Charcoal
RegisterNetEvent('qb-lumber:client:inputCharcoal', function()
    if processingCharcoal == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Process Charcoal',
            submitText = "Submit",
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'charcoal',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.charcoal then return end
        TriggerServerEvent('qb-lumber:server:processCharcoal', dialog.charcoal)
        else
            QBCore.Functions.Notify("You are already doing something!", "error")
        end
    end
end)

RegisterNetEvent('qb-lumber:client:processCharcoal', function(charcoalNumber)
    local finaltime = tonumber(charcoalNumber * 3000)
    local processTime = finaltime / 1000
    local processingCharcoal = true
    QBCore.Functions.Progressbar("process_charcoal", 'Processing Charcoal ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@base",
        anim = "base",
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("qb-lumber:server:Charcoal", charcoalNumber)
        ClearPedTasks(PlayerPedId())
        local processingCharcoal = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
        local processingCharcoal = false
    end)
end)

-- Threads
CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        local dist = #(GetEntityCoords(ped)-vector3(-569.61, 5332.35, 70.21))
        if dist <= 2.5 then
            wait = 5
            inZone  = true
            if IsControlJustReleased(0, 38) then
                exports['qb-core']:KeyPressed()
                TriggerEvent('qb-lumber:LumberMenu')
            end
        else
            wait = 1000
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Lumber Yard')
        end
        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['qb-core']:HideText()
        end
        Wait(wait)
    end
end)

CreateThread(function()
	while true do
    	Wait(60000)
    	if tree > 0 then
    		tree = 0
    	end

        if tree2 > 0 then
    		tree2 = 0
    	end

        if tree3 > 0 then
    		tree3 = 0
    	end

        if tree4 > 0 then
    		tree4 = 0
    	end

        if tree5 > 0 then
    		tree5 = 0
    	end

        if tree6 > 0 then
    		tree6 = 0
    	end

        if tree7 > 0 then
    		tree7 = 0
    	end

        if tree8 > 0 then
    		tree8 = 0
    	end

        if tree9 > 0 then
    		tree9 = 0
    	end

        if tree10 > 0 then
    		tree10 = 0
    	end

        if tree11 > 0 then
    		tree11 = 0
    	end

        if tree12 > 0 then
    		tree12 = 0
    	end

        if tree13 > 0 then
            tree13 = 0
        end

        if tree14 > 0 then
            tree14 = 0
        end

        if tree15 > 0 then
            tree15 = 0
        end

	end
end)

-- wood picking
CreateThread(function()
    woodblip = AddBlipForCoord(-573.03, 5509.68, 55.56)
    SetBlipSprite (woodblip, 209)
    SetBlipDisplay(woodblip, 4)
    SetBlipScale  (woodblip, 0.8)
    SetBlipColour (woodblip, 0)
	SetBlipAlpha (woodblip, 0.9)
    SetBlipAsShortRange(woodblip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Lumber Yard")
    EndTextCommandSetBlipName(woodblip)
end)

-- wood processor
CreateThread(function()
    woodproblip = AddBlipForCoord(-569.61, 5332.35, 70.21)
    SetBlipSprite (woodproblip, 388)
    SetBlipDisplay(woodproblip, 4)
    SetBlipScale  (woodproblip, 0.8)
    SetBlipColour (woodproblip, 0)
	SetBlipAlpha (woodproblip, 0.9)
    SetBlipAsShortRange(woodproblip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Lumber Processor")
    EndTextCommandSetBlipName(woodproblip)
end)

CreateThread(function()
    while true do
        local inRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        
        local distance1 = #(PlayerPos - Config.Locations['TreeLocations'][1].coords)
        local distance2 = #(PlayerPos - Config.Locations['TreeLocations'][2].coords)
        local distance3 = #(PlayerPos - Config.Locations['TreeLocations'][3].coords)
        local distance4 = #(PlayerPos - Config.Locations['TreeLocations'][4].coords)
        local distance5 = #(PlayerPos - Config.Locations['TreeLocations'][5].coords)
        local distance6 = #(PlayerPos - Config.Locations['TreeLocations'][6].coords)
        local distance7 = #(PlayerPos - Config.Locations['TreeLocations'][7].coords)
        local distance8 = #(PlayerPos - Config.Locations['TreeLocations'][8].coords)
        local distance9 = #(PlayerPos - Config.Locations['TreeLocations'][9].coords)
        local distance10 = #(PlayerPos - Config.Locations['TreeLocations'][10].coords)
        local distance11 = #(PlayerPos - Config.Locations['TreeLocations'][11].coords)
        local distance12 = #(PlayerPos - Config.Locations['TreeLocations'][12].coords)
        local distance13 = #(PlayerPos - Config.Locations['TreeLocations'][13].coords)
        local distance14 = #(PlayerPos - Config.Locations['TreeLocations'][14].coords)
        local distance15 = #(PlayerPos - Config.Locations['TreeLocations'][15].coords)

        if distance3 < 1000 then
            inRange = true

            if distance1 < 5 then
                DrawText3Ds(-575.47, 5526.72, 53.09, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree = tree + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance2 < 5 then
                DrawText3Ds(-566.1, 5504.29, 57.79, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree2 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree2 = tree2 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance3 < 5 then
                DrawText3Ds(-589.18, 5496.71, 53.99, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree3 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree3 = tree3 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance4 < 5 then
                DrawText3Ds(-582.88, 5492.31, 55.64, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree4 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree4 = tree4 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance5 < 5 then
                DrawText3Ds(-572.67, 5467.62, 61.41, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree5 ==0 then
                    chopProcess()
                    PrepareAnim()
                    tree5 = tree5 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance6 < 5 then
                DrawText3Ds(-577.47, 5469.25, 60.68, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree6 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree6 = tree6 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance7 < 5 then
                DrawText3Ds(-581.79, 5471.16, 59.4, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree7 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree7 = tree7 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance8 < 5 then
                DrawText3Ds(-596.78, 5473.56, 56.41, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree8 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree8 = tree8 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance9 < 5 then
                DrawText3Ds(-617.85, 5488.53, 51.6, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree9 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree9 = tree9 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance10 < 5 then
                DrawText3Ds(-619.2, 5498.16, 51.31, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree10 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree10 = tree10 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance11 < 5 then
                DrawText3Ds(-626.06, 5474.72, 53.29, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree11 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree11 = tree11 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance12 < 5 then
                DrawText3Ds(-629.45, 5470.82, 53.68, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree12 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree12 = tree12 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance13 < 5 then
                DrawText3Ds(-630.74, 5465.85, 53.67, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree13 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree13 = tree13 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance14 < 5 then
                DrawText3Ds(-556.55, 5512.26, 59.65, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree14 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree14 = tree14 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

            if distance15 < 5 then
                DrawText3Ds(-573.06, 5509.99, 55.54, "[E] Start Chopping")
                if IsControlJustPressed(0, 38) then if tree15 == 0 then
                    chopProcess()
                    PrepareAnim()
                    tree15 = tree15 + 1
                else
                    QBCore.Functions.Notify('You have already Chopped this spot.', 'error', 3500)

                end
                end
            end

        end

        if not inRange then
            Wait(2000)
        end
        Wait(3)
    end
end)