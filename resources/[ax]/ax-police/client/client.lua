local QBCore = exports['qb-core']:GetCoreObject()

--Custom Images
RegisterNetEvent("ax-police:server:CustomImages",function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Display Image',
        submitText = 'Submit',
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'image',
                text = 'Enter Image Link'
            }
        }
    })
    if dialog then
        if not dialog.image then return end
        if string.find(dialog.image, "streamable") then
            print("STREAMABLE BLOCKED")
            return QBCore.Functions.Notify("Images Only", "error")
        elseif string.find(dialog.image, "youtube") then
            print("YOUTUBE BLOCKED")
            return QBCore.Functions.Notify("Images Only", "error")
        elseif string.find(dialog.image, "giphy") then
            print("GIPHY BLOCKED")
            return QBCore.Functions.Notify("Images Only", "error")
        end 
        TriggerServerEvent('ax-police:CustomImages2:server', dialog.image)
    end
end)

Citizen.CreateThread(function()
    exports['qb-target']:AddCircleZone("PoliceTraining", vector3(441.17, -985.76, 34.97), 0.50, {
        name="PoliceTraining",
        debugPoly=false,
        useZ=true,
        }, {
            options = {
                {
                    type = "client",
                    event = "ax-police:client:CustomImages2",
                    icon = "fas fa-file-image",
                    label = "Display Image",
                    job = "police",
                },
            },
        distance = 2.0 
    })
end)

RegisterNetEvent("ax-police:client:Images",function(displayimage)
    local txd = CreateRuntimeTxd('duiTxd')
    --local duiObj = CreateDui(displayimage, 960, 540)
    local duiObj = CreateDui(''..displayimage..'', 960, 540)
    _G.duiObj = duiObj
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
    AddReplaceTexture('prop_planning_b1', 'prop_base_white_01b', 'duiTxd', 'duiTex')
end)

RegisterNetEvent("ax-police:client:CustomImages2",function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Display Image',
        submitText = 'Submit',
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'image',
                text = 'Enter Image Link'
            }
        }
    })
    if dialog then
        if not dialog.image then return end
        
        if string.find(dialog.image, "streamable") then
            print("STREAMABLE BLOCKED")
            return QBCore.Functions.Notify("Images Only", "error")
        elseif string.find(dialog.image, "youtube") then
            print("YOUTUBE BLOCKED")
            return QBCore.Functions.Notify("Images Only", "error")
        elseif string.find(dialog.image, "giphy") then
            print("GIPHY BLOCKED")
            return QBCore.Functions.Notify("Images Only", "error")
        end        

        TriggerServerEvent('ax-police:server:CustomImages2', dialog.image)
    end
end)

RegisterNetEvent("ax-police:client:Images2",function(displayimage)
    local txd = CreateRuntimeTxd('duiTxd2')
    local duiObj = CreateDui(''..displayimage..'', 760, 540)
    _G.duiObj = duiObj
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex2', dui)
    AddReplaceTexture('prop_planning_b1', 'prop_base_white_01b', 'duiTxd2', 'duiTex2')
end)

-- Meeting Notes
RegisterNetEvent("ax-police:client:MeetingSlides",function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Meeting Room',
        submitText = 'Submit',
        inputs = {
            {
                text = "Meeting Notes", -- text you want to be displayed as a input header
                name = "slidenumber", -- name of the input should be unique otherwise it might override
                type = "select", -- type of the input - Select is useful for 3+ amount of "or" options e.g; someselect = none OR other OR other2 OR other3...etc
                options = { -- Select drop down options, the first option will by default be selected
                    { value = "https://i.imgur.com/S9gJ7kO.png", text = "Main Slide" }, -- Options MUST include a value and a text option
                    { value = "https://imgur.com/0Hvvlah", text = "Bronze Command Points" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/RtfrIcr.png", text = "Promotions" }, -- Options MUST include a value and a text option
                    { value = "", text = "Questions/Suggestions" }, -- Options MUST include a value and a text option
                }
            }
        },
    })
    if dialog then
        if not dialog.slidenumber then return end
        TriggerServerEvent('ax-police:server:MeetingSlides', dialog.slidenumber)
    end
end)

RegisterNetEvent("ax-police:MeetingSlides",function(displayimage)
    local txd = CreateRuntimeTxd('duiTxd3')
    local duiObj = CreateDui(''..displayimage..'', 760, 540)
    _G.duiObj = duiObj
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex3', dui)
    AddReplaceTexture('prop_planning_b1', 'prop_base_white_01b', 'duiTxd3', 'duiTex3')
end)