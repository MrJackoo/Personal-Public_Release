local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rebel-promocodes:client:openpromocodecreator', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Promo Code Creator",
        submitText = "Create",
        inputs = {
            {
                text = "Item Type",
                name = "itemtype", 
                type = "radio",
                options = { 
                    { value = "vehicle", text = "Vehicle" }, 
                    { value = "item", text = "Item" }, 
                    { value = "money", text = "Money" }  
                }
            },
            {
                text = "Item",
                name = "item", 
                type = "text", 
                isRequired = true 
            },
            {
                text = "Amount",
                name = "itemamount",
                type = "number", 
                isRequired = true
            },
            {
                text = "Uses",
                name = "itemuses",
                type = "number", 
                isRequired = true
            }
        }
    })

    if dialog ~= nil then
        TriggerServerEvent("rebel-promocodes:server:createpromocode", dialog)
    end
end)

RegisterNetEvent('rebel-promocodes:client:opengarageselector', function(result, args)
	

print(result)

    local dialog = exports['qb-input']:ShowInput({
        header = "Where do you want to store your "..QBCore.Shared.Vehicles[result.item]['name'],
        submitText = "Continue",
        inputs = {
            {
                text = "Select Garage", -- text you want to be displayed as a input header
                name = "selectedgarage", -- name of the input should be unique otherwise it might override
                type = "select", -- type of the input - Select is useful for 3+ amount of "or" options e.g; someselect = none OR other OR other2 OR other3...etc
                options = { -- Select drop down options, the first option will by default be selected
                    { value = 'pillboxgarage', text = "Pillbox" }, -- Options MUST include a value and a text option
                    { value = 'pillboxlowergarage', text = "Pillbox Lower"}, -- Options MUST include a value and a text option
                    { value = 'mirrorpark', text = "Mirror Park" }, -- Options MUST include a value and a text option
                    { value = 'motelgarage', text = "Motel" }, -- Options MUST include a value and a text option
                    { value = 'sapcounsel', text = "SAP Counsel" }, -- Options MUST include a value and a text option
                    { value = 'spanishave', text = "Spanis Avenue" }, -- Options MUST include a value and a text option
                    { value = 'caears24', text = "Caears" }, -- Options MUST include a value and a text option
                    { value = 'caears242', text = "Caears 2" }, -- Options MUST include a value and a text option
                    { value = 'lagunapi', text = "Laguna"}, -- Options MUST include a value and a text option
                    { value = 'airportp', text = "Airport" }, -- Options MUST include a value and a text option
                    { value = 'beachp', text = "Beach" }, -- Options MUST include a value and a text option
                    { value = 'themotorhotel', text = "Motor Hotel" }, -- Options MUST include a value and a text option
                    { value = 'liqourparking', text = "Liquor Parking" }, -- Options MUST include a value and a text option
                    { value = 'haanparking', text = "Haan" }, -- Options MUST include a value and a text option
                    { value = 'legionsquare', text = "Legion Square" }, -- Options MUST include a value and a text option
                    { value = 'apartments', text = "Apartments" }, -- Options MUST include a value and a text option
                    { value = 'cityhall', text = "Cityhall" }, -- Options MUST include a value and a text option
                },
            }
        }
    })

	local args = {
		selectedgarage = dialog,
		result = result,
		args = args
	}

    print(selectedgarage)
    print(result)
    print(args)
    print(dialog)
    print(value)

    if dialog ~= nil then
        TriggerServerEvent("rebel-promocodes:server:redeemvehicle", args)
    end
end)