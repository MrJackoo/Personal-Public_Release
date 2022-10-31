-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local processingMaterial = false
local mine = 0
local mine2 = 0
local mine3 = 0
local mine4 = 0
local mine5 = 0
local mine6 = 0
local mine7 = 0
local mine8 = 0
local mine9 = 0
local mine10 = 0
local mine11 = 0
local mine12 = 0
local mine13 = 0
local mine14 = 0
local mine15 = 0
local mine16 = 0
local mine17 = 0
local mine18 = 0
local mine19 = 0

-- Functions
function DrawText3Ds (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function loadModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
        RequestModel(model)
    end
    return model
end

function MineProcess()
    local Ped = PlayerPedId()
	local coord = GetEntityCoords(Ped)
    local model = loadModel(`prop_tool_pickaxe`)
    local axe = CreateObject(model, GetEntityCoords(Ped), true, false, false)
    AttachEntityToEntity(axe, Ped, GetPedBoneIndex(Ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

    QBCore.Functions.Progressbar('mine_rocks', 'Mining Rocks..', 4000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "melee@hatchet@streamed_core",
        anim = "plyr_rear_takedown_b",
        flags = 16,
    }, {}, {}, function() -- Done

        TriggerServerEvent('qb-mining:server:mine')
        StopAnimTask(Ped, "melee@hatchet@streamed_core", "startmine", 1.0)
        DeleteObject(axe)
        ClearPedTasks(Ped)
        DeleteObject(axe)
        
    end, function() -- Cancel
        StopAnimTask(Ped, "melee@hatchet@streamed_core", "startmine", 1.0)
        ClearPedTasks(Ped)
        DeleteObject(axe)
        QBCore.Functions.Notify('Process Canceled', 'error')
    end)
end

-- Events

-- Rock Washing
RegisterNetEvent('qb-mining:client:inputRocks', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Process Rocks',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'rocks',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.rocks then return end
        TriggerServerEvent('qb-mining:server:processRocks', dialog.rocks)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processRocks', function(rocksNumber)
    local finaltime = tonumber(rocksNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('washing_rocks', 'Washing Rocks ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:washRocks', rocksNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Hardened Steel
RegisterNetEvent('qb-mining:client:inputSteel', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Harden Steel',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'steel',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.steel then return end
        TriggerServerEvent('qb-mining:server:processSteel', dialog.steel)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processSteel', function(steelNumber)
    local finaltime = tonumber(steelNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('hardening_materials', 'Hardening Steel ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Steel', steelNumber)
        ClearPedTasks(PlayerPedId())
        local processingMateriall = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Reinforced Aluminium
RegisterNetEvent('qb-mining:client:inputAluminium', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Reinforce Aluminium',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'aluminium',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.aluminium then return end
        TriggerServerEvent('qb-mining:server:processAluminium', dialog.aluminium)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processAluminium', function(aluminiumNumber)
    local finaltime = tonumber(aluminiumNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('processing_materials', 'Reinforcing Aluminium ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Aluminium', aluminiumNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Reinforced Metal
RegisterNetEvent('qb-mining:client:inputMetal', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Reinforce Metal',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'metal',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.metal then return end
        TriggerServerEvent('qb-mining:server:processMetal', dialog.metal)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processMetal', function(metalNumber)
    local finaltime = tonumber(metalNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('reinforcing_materials', 'Reinforcing Metal ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Metal', metalNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Refined Copper
RegisterNetEvent('qb-mining:client:inputCopper', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine Copper',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'copper',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.copper then return end
        TriggerServerEvent('qb-mining:server:processCopper', dialog.copper)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processCopper', function(copperNumber)
    local finaltime = tonumber(copperNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('refining_materials', 'Refining Copper ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Copper', copperNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Refined lead
RegisterNetEvent('qb-mining:client:inputLead', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine Lead',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'lead',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.lead then return end
        TriggerServerEvent('qb-mining:server:processLead', dialog.lead)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processLead', function(leadNumber)
    local finaltime = tonumber(leadNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('refining_materials', 'Refining Lead ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Lead', leadNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Refined Zinc
RegisterNetEvent('qb-mining:client:inputZinc', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine Zinc',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'zinc',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.zinc then return end
        TriggerServerEvent('qb-mining:server:processZinc', dialog.zinc)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processZinc', function(zincNumber)
    local finaltime = tonumber(zincNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('refining_materials', 'Refining Zinc ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Zinc', zincNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Aluminium
RegisterNetEvent('qb-mining:client:inputWGAluminium', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'WG Aluminium',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgaluminium',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgaluminium then return end
        TriggerServerEvent('qb-mining:server:processWGAluminium', dialog.wgaluminium)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGAluminium', function(wgaluminiumNumber)
    local finaltime = tonumber(wgaluminiumNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('processing_materials', 'Refining WG Aluminium ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGAluminium', wgaluminiumNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Brass
RegisterNetEvent('qb-mining:client:inputWGBrass', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'WG Brass',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgbrass',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgbrass then return end
        TriggerServerEvent('qb-mining:server:processWGBrass', dialog.wgbrass)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGBrass', function(wgbrassNumber)
    local finaltime = tonumber(wgbrassNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('processing_materials', 'Refining WG Brass ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGBrass', wgbrassNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Metal
RegisterNetEvent('qb-mining:client:inputWGMetal', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine WG Metal',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgmetal',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgmetal then return end
        TriggerServerEvent('qb-mining:server:processWGMetal', dialog.wgmetal)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGMetal', function(wgmetalNumber)
    local finaltime = tonumber(wgmetalNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('reinforcing_materials', 'Refining WG Metal ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGMetal', wgmetalNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade lead
RegisterNetEvent('qb-mining:client:inputWGLead', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine WG Lead',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wglead',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wglead then return end
        TriggerServerEvent('qb-mining:server:processWGLead', dialog.wglead)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGLead', function(wgleadNumber)
    local finaltime = tonumber(wgleadNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('refining_materials', 'Refining Lead ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGLead', wgleadNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Rubber
RegisterNetEvent('qb-mining:client:inputWGPlastic', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'WG Plastic',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgplastic',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgplastic then return end
        TriggerServerEvent('qb-mining:server:processWGPlastic', dialog.wgplastic)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGPlastic', function(wgplasticNumber)
    local finaltime = tonumber(wgplasticNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('processing_materials', 'Refining WG Plastic ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGPlastic', wgplasticNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Rubber
RegisterNetEvent('qb-mining:client:inputWGRubber', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'WG Rubber',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgrubber',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgrubber then return end
        TriggerServerEvent('qb-mining:server:processWGRubber', dialog.wgrubber)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGRubber', function(wgrubberNumber)
    local finaltime = tonumber(wgrubberNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('processing_materials', 'Refining WG Rubber ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGRubber', wgrubberNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Steel
RegisterNetEvent('qb-mining:client:inputWGSteel', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine WG Steel',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgsteel',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgsteel then return end
        TriggerServerEvent('qb-mining:server:processWGSteel', dialog.wgsteel)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGSteel', function(wgsteelNumber)
    local finaltime = tonumber(wgsteelNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('refine_wgmaterials', 'Refining WG Steel ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGSteel', wgsteelNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Wood
RegisterNetEvent('qb-mining:client:inputWGWood', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine Wood',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgwood',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgwood then return end
        TriggerServerEvent('qb-mining:server:processWGWood', dialog.wgwood)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGWood', function(wgwoodNumber)
    local finaltime = tonumber(wgwoodNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('refining_materials', 'Refining WG Wood ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGWood', wgwoodNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Weapons Grade Zinc
RegisterNetEvent('qb-mining:client:inputWGZinc', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Refine Zinc',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'wgzinc',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.wgzinc then return end
        TriggerServerEvent('qb-mining:server:processWGZinc', dialog.wgzinc)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processWGZinc', function(wgzincNumber)
    local finaltime = tonumber(wgzincNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('refining_materials', 'Refining WG Zinc ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:WGZinc', wgzincNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Carbonate Ore
RegisterNetEvent('qb-mining:client:inputCarbonate', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Process Carbonate Ore',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'carbonate',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.carbonate then return end
        TriggerServerEvent('qb-mining:server:processCarbonate', dialog.carbonate)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processCarbonate', function(carbonateNumber)
    local finaltime = tonumber(carbonateNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('processing_ore', 'Processing Carbonate Ore ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:CarbonateOre', carbonateNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Oxide
RegisterNetEvent('qb-mining:client:inputOxide', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Process Oxide',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'oxide',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.oxide then return end
        TriggerServerEvent('qb-mining:server:processOxide', dialog.oxide)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processOxide', function(oxideNumber)
    local finaltime = tonumber(oxideNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('process_oxide', 'Processing Oxides ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Oxide', oxideNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Sulphide
RegisterNetEvent('qb-mining:client:inputSulphide', function()
    if processingMaterial == false then
        local dialog = exports['qb-input']:ShowInput({
            header = 'Process Sulphide',
            submitText = 'Submit',
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = 'sulphide',
                    text = 'Enter Number to Process'
                }
            }
        })
    if dialog then
        if not dialog.sulphide then return end
        TriggerServerEvent('qb-mining:server:processSulphide', dialog.sulphide)
        else
            QBCore.Functions.Notify('You are already doing something!', 'error')
        end
    end
end)

RegisterNetEvent('qb-mining:client:processSulphide', function(sulphideNumber)
    local finaltime = tonumber(sulphideNumber * 3000)
    local processTime = finaltime / 1000
    local processingMaterial = true
    QBCore.Functions.Progressbar('process_sulphide', 'Processing Sulphide ('..processTime..' seconds)', finaltime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function() -- done
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        TriggerServerEvent('qb-mining:server:Sulphide', sulphideNumber)
        ClearPedTasks(PlayerPedId())
        local processingMaterial = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 1.0)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('Process Canceled', 'error')
        local processingMaterial = false
    end)
end)

-- Wash Menu
RegisterNetEvent('qb-mining:washMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = 'Stoner Cement Works',
            txt = 'Rock Washing'
        },
        {
            header = 'Wash Your Rocks',
            txt = 'Remember and have enough space',
            params = {
                event = 'qb-mining:client:inputRocks',
            }
        },
    })
end)

-- Refining Menus
RegisterNetEvent('qb-mining:FoundryMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = 'Foundry',
            txt = 'Material Processing'
        },
        -- {
        --     header = 'Refine Materials',
        --     txt = 'Standard Grade',
        --     params = {
        --         event = 'qb-mining:standardGradeMenu',
        --     }
        -- },
        -- {
        --     header = 'Refine Materials',
        --     txt = 'Weapons Grade',
        --     params = {
        --         event = 'qb-mining:weaponsGradeMenu',
        --     }
        -- },
        {
            header = 'Process Materials',
            txt = 'Other Materials',
            params = {
                event = 'qb-mining:otherProcessMenu',
            }
        },
    })
end)

-- RegisterNetEvent('qb-mining:standardGradeMenu', function()
--     exports['qb-menu']:openMenu({
--         {
--             isMenuHeader = true,
--             header = 'Standard/ Materials',
--             txt = 'Refine, Harden & Reinforce'
--         },
--         {
--             header = 'Hardened Steel',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputSteel',
--             }
--         },
--         {
--             header = 'Reinforced Aluminium',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputAluminium',
--             }
--         },
--         {
--             header = 'Reinforced Metal',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputMetal',
--             }
--         },
--         {
--             header = 'Refined Copper',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputCopper',
--             }
--         },
--         {
--             header = 'Refined Lead',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputLead',
--             }
--         },
--         {
--             header = 'Refined Zinc',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputZinc',
--             }
--         },
--         {
--             header = 'Back',
--             txt = '',
--             params = {
--                 event = 'qb-mining:FoundryMenu',
--             }
--         },
--     })
-- end)

-- RegisterNetEvent('qb-mining:weaponsGradeMenu', function()
--     exports['qb-menu']:openMenu({
--         {
--             isMenuHeader = true,
--             header = 'Weapons Grade Refining',
--             txt = ''
--         },
--         {
--             header = 'Refine Weapons Grade Aluminium',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGAluminium',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Brass',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGBrass',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Lead',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGLead',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Metal',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGMetal',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Plastic',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGPlastic',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Rubber',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGRubber',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Steel',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGSteel',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Wood',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGWood',
--             }
--         },
--         {
--             header = 'Refine Weapons Grade Zinc',
--             txt = '',
--             params = {
--                 event = 'qb-mining:client:inputWGZinc',
--             }
--         },
--         {
--             header = 'Back',
--             txt = '',
--             params = {
--                 event = 'qb-mining:FoundryMenu',
--             }
--         },
--     })
-- end)

RegisterNetEvent('qb-mining:otherProcessMenu', function()
    exports['qb-menu']:openMenu({
        {
            isMenuHeader = true,
            header = 'Process Other Materials',
            txt = ''
        },
        {
            header = 'Process Carbonate Ore',
            txt = '',
            params = {
                event = 'qb-mining:client:inputCarbonate',
            }
        },
        {
            header = 'Process Charcoal',
            txt = '',
            params = {
                event = 'qb-lumber:client:inputCharcoal',
            }
        },
        {
            header = 'Process Oxides',
            txt = '',
            params = {
                event = 'qb-mining:client:inputOxide',
            }
        },
        {
            header = 'Process Sulphide Ore',
            txt = '',
            params = {
                event = 'qb-mining:client:inputSulphide',
            }
        },
        {
            header = 'Back',
            txt = '',
            params = {
                event = 'qb-mining:FoundryMenu',
            }
        },
    })
end)

-- Threads
CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        local dist = #(GetEntityCoords(ped)-vector3(286.98, 2844.12, 44.7))
        if dist <= 2.5 then
            wait = 5
            inZone = true
            if IsControlJustReleased(0, 38) then
                exports['qb-core']:KeyPressed()
                TriggerEvent('qb-mining:washMenu')
            end
        else
            wait = 1000
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Wash Rocks', 'left')
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
        local dist = #(GetEntityCoords(ped)-vector3(1112.97, -2004.5, 35.44))
        if dist <= 2.5 then
            wait = 5
            inZone  = true
            if IsControlJustReleased(0, 38) then
                exports['qb-core']:KeyPressed()
                TriggerEvent('qb-mining:FoundryMenu')
            end
        else
            wait = 1000
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['qb-core']:DrawText('[E] Access Foundry', 'left')
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
        Wait(120000)
        if mine > 0 then 
            mine = 0
        end

        if mine2 > 0 then 
            mine2 = 0
        end

        if mine3 > 0 then 
            mine3 = 0
        end

        if mine4 > 0 then 
            mine4 = 0
        end

        if mine5 > 0 then 
            mine5 = 0
        end

        if mine6 > 0 then 
            mine6 = 0
        end

        if mine7 > 0 then 
            mine7 = 0
        end

        if mine8 > 0 then 
            mine8 = 0
        end

        if mine9 > 0 then 
            mine9 = 0
        end

        if mine10 > 0 then 
            mine10 = 0
        end

        if mine11 > 0 then 
            mine11 = 0
        end

        if mine12 > 0 then 
            mine12 = 0
        end

        if mine13 > 0 then 
            mine13 = 0
        end

        if mine14 > 0 then 
            mine14 = 0
        end

        if mine15 > 0 then 
            mine15 = 0
        end

        if mine16 > 0 then 
            mine16 = 0
        end

        if mine17 > 0 then 
            mine17 = 0
        end

        if mine18 > 0 then 
            mine18 = 0
        end

        if mine19 > 0 then 
            mine19 = 0
        end

    end
end)

CreateThread(function()
    for k, mining in pairs(Config.Locations['Mining']) do
        local blip = AddBlipForCoord(mining.coords.x, mining.coords.y, mining.coords.z)
        SetBlipSprite(blip, 78)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(mining.label)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance1 = #(PlayerPos - Config.Locations['MiningLocation'][1].coords)
        local distance2 = #(PlayerPos - Config.Locations['MiningLocation'][2].coords)
        local distance3 = #(PlayerPos - Config.Locations['MiningLocation'][3].coords)
        local distance4 = #(PlayerPos - Config.Locations['MiningLocation'][4].coords)
        local distance5 = #(PlayerPos - Config.Locations['MiningLocation'][5].coords)
        local distance6 = #(PlayerPos - Config.Locations['MiningLocation'][6].coords)
        local distance7 = #(PlayerPos - Config.Locations['MiningLocation'][7].coords)
        local distance8 = #(PlayerPos - Config.Locations['MiningLocation'][8].coords)
        local distance9 = #(PlayerPos - Config.Locations['MiningLocation'][9].coords)
        local distance10 = #(PlayerPos - Config.Locations['MiningLocation'][10].coords)
        local distance11 = #(PlayerPos - Config.Locations['MiningLocation'][11].coords)
        local distance12 = #(PlayerPos - Config.Locations['MiningLocation'][12].coords)
        local distance13 = #(PlayerPos - Config.Locations['MiningLocation'][13].coords)
        local distance14 = #(PlayerPos - Config.Locations['MiningLocation'][14].coords)
        local distance15 = #(PlayerPos - Config.Locations['MiningLocation'][15].coords)
        local distance16 = #(PlayerPos - Config.Locations['MiningLocation'][16].coords)
        local distance17 = #(PlayerPos - Config.Locations['MiningLocation'][17].coords)
        local distance18 = #(PlayerPos - Config.Locations['MiningLocation'][18].coords)
        local distance19 = #(PlayerPos - Config.Locations['MiningLocation'][19].coords)
        
        if distance3 < 200 then
            inRange = true

            if distance1 < 2 then
                DrawText3Ds(-593.24, 2073.54, 131.47, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine == 0 then
                    MineProcess()
                    mine = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    
                end
                end
            end

            if distance2 < 2 then
                DrawText3Ds(-584.21, 2044.16, 129.37, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine2 == 0 then
                    MineProcess()
                    mine2 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance3 < 2 then
                DrawText3Ds(-573.01, 2023.55, 127.84, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine3 == 0 then
                    MineProcess()
                    mine3 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)   
                    end
                end
            end

            if distance4 < 2 then
                DrawText3Ds(-554.7, 1999.83, 127.28, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine4 == 0 then
                    MineProcess()
                    mine4 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance5 < 2 then
                DrawText3Ds(-532.17, 1979.33, 127.13, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine5 == 0 then
                    MineProcess()
                    mine5 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance6 < 2 then
                DrawText3Ds(-503.45, 1980.85, 125.98, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine6 == 0 then
                    MineProcess()
                    mine6 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance7 < 2 then
                DrawText3Ds(-481.47, 1985.8, 124.26, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine7 == 0 then
                    MineProcess()
                    mine7 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance8 < 2 then
                DrawText3Ds(-457.65, 2003.75, 123.49, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine8 == 0 then
                    MineProcess()
                    mine8 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance9 < 2 then
                DrawText3Ds(-449.73, 2031.08, 123.48, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine9 == 0 then
                    MineProcess()
                    mine9 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance10 < 2 then
                DrawText3Ds(-460.73, 2051.16, 122.32, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine10 == 0 then
                    MineProcess()
                    mine10 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance11 < 2 then
                DrawText3Ds(-432.78, 2061.11, 121.28, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine11 == 0 then
                    MineProcess()
                    mine11 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance12 < 2 then
                DrawText3Ds(-469.55, 2081.08, 120.36, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine12 == 0 then
                    MineProcess()
                    mine12 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance13 < 2 then
                DrawText3Ds(-541.48, 1972.54, 126.99, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine13 == 0 then
                    MineProcess()
                    mine13 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance14 < 2 then
                DrawText3Ds(-540.77, 1950.24, 126.35, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine14 == 0 then
                    MineProcess()
                    mine14 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance15 < 2 then
                DrawText3Ds(-536.4, 1927.93, 124.78, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine15 == 0 then
                    MineProcess()
                    mine15 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance16 < 2 then
                DrawText3Ds(-537.62, 1907.22, 123.21, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine16 == 0 then
                    MineProcess()
                    mine16 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance17 < 2 then
                DrawText3Ds(-514.85, 1893.01, 122.12, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine17 == 0 then
                    MineProcess()
                    mine17 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance18 < 2 then
                DrawText3Ds(-491.7, 1895.59, 120.28, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine18 == 0 then
                    MineProcess()
                    mine18 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
                    end
                end
            end

            if distance19 < 2 then
                DrawText3Ds(-555.91, 1889.7, 122.99, '[E] Start Mining')
                if IsControlJustPressed(0, 38) then if mine19 == 0 then
                    MineProcess()
                    mine19 = 1
                else 
                    QBCore.Functions.Notify('You have already Mined this spot.', 'error', 3500)
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