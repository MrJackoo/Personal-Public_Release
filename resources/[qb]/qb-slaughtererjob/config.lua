Config = {}


Config.ChickenItems = {
    ["packagedchicken"] = {
        ["price"] = 450
    },
}

Config.Chickenprice = 225

------------------CONFIG----------------------

Config.chickenstart = vector3(-68.425, 6248.42, 31.194)

Config.Slaughterloc = vector3(-96.007, 6206.92, 31.02)

Config.Slaughterloc2 = vector3(-100.64, 6202.30, 31.02)

Config.Packing1 = vector3(-103.99, 6206.31, 31.03)

Config.Packing2 = vector3(-101.56, 6208.51, 31.03)

Config.Packing3 = vector3(-99.53, 6210.47, 31.03)

Config.selling = vector3(-1177.17, -890.68, 13.79)


-- startX = -68.425  --miejsce lapania kurczakow
-- startY = 6248.42
-- startZ = 31.194
-- ---------------------------------------------
-- przetworniaX = -96.007   --punkt na przetwarzanie 1
-- przetworniaY = 6206.92
-- przetworniaZ = 31.02
-- ---
-- przetworniaX2 = -100.64   --punkt na przetwarzanie 2
-- przetworniaY2 = 6202.30
-- przetworniaZ2 = 31.02
-- ---
-- pakowanieX = -106.44    --punkt pakowania 1
-- pakowanieY = 6204.29
-- pakowanieZ = 31.02
-- ---
-- pakowanieX2 = -104.20   --punkt pakowania 2
-- pakowanieY2 = 6206.45
-- pakowanieZ2 = 31.02
-- ---
-- sellX = -1177.17    --punkt sprzedazy
-- sellY = -890.68
-- sellZ = 13.79




local blip = AddBlipForCoord(Config.Slaughterloc.x, Config.Slaughterloc.y, Config.Slaughterloc.z)
	SetBlipSprite (blip, 273)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, 46)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Slaughter House')
	EndTextCommandSetBlipName(blip)

local sellingblip = AddBlipForCoord(Config.selling.x, Config.selling.y, Config.selling.z)
	SetBlipSprite (sellingblip, 478)
	SetBlipDisplay(sellingblip, 4)
	SetBlipScale  (sellingblip, 0.6)
	SetBlipColour (sellingblip, 46)
	SetBlipAsShortRange(sellingblip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Chicken Dealer')
	EndTextCommandSetBlipName(sellingblip)


	

