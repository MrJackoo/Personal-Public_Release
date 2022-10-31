local QBCore = exports['qb-core']:GetCoreObject()
local isSelling = false
isillegalSelling = false

function BoatMenuLaPuerta()
    exports['qb-menu']:openMenu({
        {
            header = "La Puerta Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: £"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 1
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuPaletoCove()
    exports['qb-menu']:openMenu({
        {
            header = "Paleto Cove Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: £"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 2
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuElGordo()
    exports['qb-menu']:openMenu({
        {
            header = "El Gordo Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: £"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 3
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 


function BoatMenuActDam()
    exports['qb-menu']:openMenu({
        {
            header = "Act Dam Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: £"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 4
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuAlamoSea()
    exports['qb-menu']:openMenu({
        {
            header = "Alamo Sea Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: £"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 5
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 
--============================================================== ReturnMenus

function ReturnBoatLaPuerta()
    exports['qb-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get £"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 1
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatPaletoCove()
    exports['qb-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get £"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 2
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatElGordo()
    exports['qb-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get £"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 3
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatActDam()
    exports['qb-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get £"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 4
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatAlamoSea()
    exports['qb-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get £"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 5
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

--============================================================== Sell/Gear Menus

RegisterNetEvent('doj:client:SellLegalFish')
AddEventHandler('doj:client:SellLegalFish', function()
    isSelling = false
    exports['qb-menu']:openMenu({
		{
            header = "Pearl's Seafood Restaurant",
            isMenuHeader = true
        },
        {
            header = "Sell Mackerel",
            txt = "Current Price: £"..Config.mackerelPrice.." each",
            params = {
                event = "jacko_fishing:client:inputfish",
                args = 1
            }
        },
        {
            header = "Sell Cod",
            txt = "Current Price: £"..Config.codfishPrice.." each",
            params = {
                event = "jacko_fishing:client:inputfish",
				args = 2
            }
        },
		{
            header = "Sell Bass",
            txt = "Current Price: £"..Config.bassPrice.." each",
            params = {
                event = "jacko_fishing:client:inputfish",
				args = 3 
            }
        },
        {
            header = "Sell Flounder",
            txt = "Current Price: £"..Config.flounderPrice.." each",
            params = {
                event = "jacko_fishing:client:inputfish",
				args = 4
            }
        },
		{
            header = "Sell Stingray",
            txt = "Current Price: £"..Config.stingrayPrice.." each",
            params = {
                event = "jacko_fishing:client:inputfish",
				args = 5
            }
        },		
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('jacko_fishing:client:inputfish', function(args)
    if isSelling == false then
        local type = nil
        if args == 1 then
            type = "mackerel"
        elseif args == 2 then
            type = "cod"
        elseif args == 3 then
            type = "bass"
        elseif args == 4 then
            type = "flounder"
        elseif args == 5 then
            type = "stingray"
        end

        local dialog = exports['qb-input']:ShowInput({
            header = 'Sell Fish',
            submitText = "Submit",
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = type,
                    text = 'Enter Number to Sell'
                }
            }
        })

    if dialog then
        if not (dialog.mackerel or dialog.cod or dialog.bass or dialog.flounder or dialog.stingray) then
            return
        end
        if dialog.mackerel then
            TriggerServerEvent('fishing:server:SellLegalFish', 1, dialog.mackerel)
            isSelling = true
        elseif dialog.cod then
            TriggerServerEvent('fishing:server:SellLegalFish', 2, dialog.cod)
            isSelling = true
        elseif dialog.bass then
            TriggerServerEvent('fishing:server:SellLegalFish', 3, dialog.bass)
            isSelling = true
        elseif dialog.flounder then
            TriggerServerEvent('fishing:server:SellLegalFish', 4, dialog.flounder)
            isSelling = true
        elseif dialog.stingray then
            TriggerServerEvent('fishing:server:SellLegalFish', 5, dialog.stingray)
            isSelling = true
        else
            QBCore.Functions.Notify("You are already doing something!", "error")
        end
    else
        QBCore.Functions.Notify("You are already doing something!", "error")
    end
    end
end)



-- RegisterNetEvent('jacko_fishing:openshop')
-- AddEventHandler('jacko_fishing:openshop', function(shop, itemData, amount)
--     local ShopItems = {}
--     ShopItems.label = Config.Shop["label"]
--     ShopItems.items = Config.fishingShopItem
--     ShopItems.slots = 30
--     TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_" .. Config.Shop["name"], ShopItems)
-- end)


RegisterNetEvent('doj:client:SellillegalFish')
AddEventHandler('doj:client:SellillegalFish', function() 
    isillegalSelling = false
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
			local charinfo = QBCore.Functions.GetPlayerData().charinfo
			QBCore.Functions.Notify('Welcome, '..charinfo.firstname..' '..charinfo.lastname)
			exports['qb-menu']:openMenu({
				{
					header = "Pearl's Seafood Restaurant",
					isMenuHeader = true
				},
				{
					header = "Sell Dolphin",
					txt = "Current Price: £"..Config.dolphinPrice.." each",
					params = {
						event = "jacko_fishing:client:inputillegalfish",
						args = 1
					}
				},
				{
					header = "Sell Tiger Shark",
					txt = "Current Price: £"..Config.sharktigerPrice.." each",
					params = {
						event = "jacko_fishing:client:inputillegalfish",
						args = 2
					}
				},
				{
					header = "Sell Hammerhead Shark",
					txt = "Current Price: £"..Config.sharkhammerPrice.." each",
					params = {
						event = "jacko_fishing:client:inputillegalfish",
						args = 3
					}
				},
				{
					header = "Sell Orca",
					txt = "Current Price: £"..Config.killerwhalePrice.." each",
					params = {
						event = "jacko_fishing:client:inputillegalfish",
						args = 4
					}
				},
				{
					header = "Close",
					txt = "",
					params = {
						event = "qb-menu:closeMenu"
					}
				},
			})
		else
			QBCore.Functions.Notify('You cannot sell to us at the moment, sorry for the inconvenience', 'error', 3500)
		end
	end, "pearlscard")
end)

RegisterNetEvent('jacko_fishing:client:inputillegalfish', function(args)
    if isillegalSelling == false then
        local type = nil
        if args == 1 then
            type = "dolphin"
        elseif args == 2 then
            type = "tiger"
        elseif args == 3 then
            type = "hammerhead"
        elseif args == 4 then
            type = "killerwhale"
        end

        local dialog = exports['qb-input']:ShowInput({
            header = 'Sell Illegal Fish',
            submitText = "Submit",
            inputs = {
                {
                    type = 'number', -- number doesn't accept decimals??
                    isRequired = true,
                    name = type,
                    text = 'Enter Number to Sell'
                }
            }
        })

    if dialog then
        if not (dialog.dolphin or dialog.tiger or dialog.hammerhead or dialog.killerwhale) then
            return
        end
        if dialog.dolphin then
            TriggerServerEvent('fishing:server:SellillegalFish', 1, dialog.dolphin)
            isillegalSelling = true
        elseif dialog.tiger then
            TriggerServerEvent('fishing:server:SellillegalFish', 2, dialog.tiger)
            isillegalSelling = true
        elseif dialog.hammerhead then
            TriggerServerEvent('fishing:server:SellillegalFish', 3, dialog.hammerhead)
            isillegalSelling = true
        elseif dialog.killerwhale then
            TriggerServerEvent('fishing:server:SellillegalFish', 4, dialog.killerwhale)
            isillegalSelling = true
        else
            QBCore.Functions.Notify("You are already doing something!", "error")
        end
    else
        QBCore.Functions.Notify("You are already doing something!", "error")
    end
    end
end)