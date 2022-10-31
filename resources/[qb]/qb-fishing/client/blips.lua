Citizen.CreateThread(function()

	-- for k, v in pairs(Config.FishingAreas) do
	-- 	blip = AddBlipForCoord(v.coords)
	-- 	SetBlipSprite(blip, 410)
	-- 	SetBlipDisplay(blip, 4)
	-- 	SetBlipScale(blip, 0.7)
	-- 	SetBlipColour(blip, 74)
	-- 	SetBlipAsShortRange(blip, true)
	-- 	BeginTextCommandSetBlipName("STRING")
	-- 	AddTextComponentSubstringPlayerName(v.label)
	-- 	EndTextCommandSetBlipName(blip)
	-- end

	PearlsSellsBlip = AddBlipForCoord(Config.PearlsSellsBlip)
	SetBlipSprite(PearlsSellsBlip, 68)
	SetBlipDisplay(PearlsSellsBlip, 4)
	SetBlipScale(PearlsSellsBlip, 0.7)
	SetBlipColour(PearlsSellsBlip, 74)
    SetBlipAsShortRange(PearlsSellsBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Fishmonger")
    EndTextCommandSetBlipName(PearlsSellsBlip)
end)