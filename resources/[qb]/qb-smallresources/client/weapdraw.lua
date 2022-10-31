local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local PlayerJob = QBCore.Functions.GetPlayerData().job

playerloadedin = false


RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent("QBCore:Client:OnFlagUpdate")
AddEventHandler("QBCore:Client:OnFlagUpdate",function(flagtype)
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
	playerloadedin = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = nil
	playerloadedin = false
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
	  print("the resource: " .. resource .. " has been restarted")
	  playerloadedin = false
	  PlayerData = nil
	  PlayerJob = nil
	end
  end)
  
  AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		print("the resource: " .. resource .. " has been restarted")
		playerloadedin = true
		PlayerData = QBCore.Functions.GetPlayerData()
		PlayerJob = PlayerData.job
	end
  end)


local weapons = {
	'WEAPON_KNIFE',
	'WEAPON_NIGHTSTICK',
	'WEAPON_BREAD',
	'WEAPON_FLASHLIGHT',
	'WEAPON_HAMMER',
	'WEAPON_BAT',
	'WEAPON_GOLFCLUB',
	'WEAPON_CROWBAR',
	'WEAPON_BOTTLE',
	'WEAPON_DAGGER',
	'WEAPON_HATCHET',
	'WEAPON_MACHETE',
	'WEAPON_SWITCHBLADE',
	'WEAPON_BATTLEAXE',
	'WEAPON_POOLCUE',
	'WEAPON_WRENCH',
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
	'WEAPON_SNSPISTOL',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_MICROSMG',
	'WEAPON_SMG',
	'WEAPON_ASSAULTSMG',
	'WEAPON_MINISMG',
	'WEAPON_MACHINEPISTOL',
	'WEAPON_COMBATPDW',
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_SAWNOFFSHOTGUN',
	'WEAPON_ASSAULTSHOTGUN',
	'WEAPON_BULLPUPSHOTGUN',
	'WEAPON_HEAVYSHOTGUN',
	'WEAPON_ASSAULTRIFLE',
	'WEAPON_CARBINERIFLE',
	'WEAPON_ADVANCEDRIFLE',
	'WEAPON_SPECIALCARBINE',
	'WEAPON_BULLPUPRIFLE',
	'WEAPON_COMPACTRIFLE',
	'WEAPON_MG',
	'WEAPON_COMBATMG',
	'WEAPON_GUSENBERG',
	'WEAPON_SNIPERRIFLE',
	'WEAPON_HEAVYSNIPER',
	'WEAPON_MARKSMANRIFLE',
	'WEAPON_GRENADELAUNCHER',
	'WEAPON_RPG',
	'WEAPON_STINGER',
	'WEAPON_MINIGUN',
	'WEAPON_GRENADE',
	'WEAPON_STICKYBOMB',
	'WEAPON_SMOKEGRENADE',
	'WEAPON_BZGAS',
	'WEAPON_MOLOTOV',
	'WEAPON_DIGISCANNER',
	'WEAPON_FIREWORK',
	'WEAPON_MUSKET',
	'WEAPON_STUNGUN',
	'WEAPON_HOMINGLAUNCHER',
	'WEAPON_PROXMINE',
	'WEAPON_FLAREGUN',
	'WEAPON_MARKSMANPISTOL',
	'WEAPON_RAILGUN',
	'WEAPON_DBSHOTGUN',
	'WEAPON_AUTOSHOTGUN',
	'WEAPON_COMPACTLAUNCHER',
	'WEAPON_PIPEBOMB',
	'WEAPON_DOUBLEACTION',
}

-- Wheapons that require the Police holster animation
-- local holsterableWeapons = {
-- 	--'WEAPON_STUNGUN',
-- 	'WEAPON_PISTOL',
-- 	'WEAPON_PISTOL_MK2',
-- 	'WEAPON_COMBATPISTOL',
-- 	'WEAPON_APPISTOL',
-- 	'WEAPON_PISTOL50',
-- 	'WEAPON_REVOLVER',
-- 	'WEAPON_SNSPISTOL',
-- 	'WEAPON_HEAVYPISTOL',
-- 	'WEAPON_VINTAGEPISTOL'
-- }

local canFire = true
local currWeapon = `WEAPON_UNARMED`
local currentHolster = nil
local currentHolsterTexture = nil

local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function CheckWeapon(newWeap)
	for i = 1, #weapons do
		if joaat(weapons[i]) == newWeap then
			return true
		end
	end
	return false
end

RegisterNetEvent('weapons:ResetHolster', function()
	holstered = true
	canFire = true
	currWeapon = `WEAPON_UNARMED`
	currentHolster = nil
	currentHolsterTexture = nil
end)

CreateThread(function()
	local sleep
	while true do
		local ped = PlayerPedId()
		sleep = 250
		if playerloadedin then
			local PlayerJob = QBCore.Functions.GetPlayerData().job
			if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedFalling(ped) and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) then
				sleep = 0
				if currWeapon ~= GetSelectedPedWeapon(ped) then
					local pos = GetEntityCoords(ped, true)
					local rot = GetEntityHeading(ped)

					local newWeap = GetSelectedPedWeapon(ped)
					SetCurrentPedWeapon(ped, currWeapon, true)
					loadAnimDict("reaction@intimidation@1h")
					loadAnimDict("reaction@intimidation@cop@unarmed")
					loadAnimDict("rcmjosh4")
					loadAnimDict("weapons@pistol@")


					if CheckWeapon(newWeap) then
						if holstered then
							if PlayerJob.name == "police" then
								

								TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "intro", pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
								Wait(50)
								SetCurrentPedWeapon(ped, newWeap, true)
								ClearPedTasks(ped)

								currWeapon = newWeap
								holstered = false
								canFire = true
							else
								canFire = false
								TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
								Wait(1500)
								SetCurrentPedWeapon(ped, newWeap, true)
								currWeapon = newWeap
								Wait(1500)
								ClearPedTasks(ped)
								holstered = false
								canFire = true
							end
						elseif newWeap ~= currWeapon and CheckWeapon(currWeapon) then
							if PlayerJob.name == "police" then
								canFire = false

								TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "intro", pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
								Wait(50)
								SetCurrentPedWeapon(ped, newWeap, true)
								ClearPedTasks(ped)
								currWeapon = newWeap
								holstered = false
								canFire = true
							else
								canFire = false
								TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
								Wait(1600)
								SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
								TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
								Wait(1000)
								SetCurrentPedWeapon(ped, newWeap, true)
								currWeapon = newWeap
								Wait(1400)
								ClearPedTasks(ped)
								holstered = false
								canFire = true
							end
						else
							if PlayerJob.name == "police" then

								TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "intro", pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
								Wait(50)
								SetCurrentPedWeapon(ped, newWeap, true)
								ClearPedTasks(ped)

								currWeapon = newWeap
								holstered = false
								canFire = true
							else
								SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
								TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
								Wait(1000)
								SetCurrentPedWeapon(ped, newWeap, true)
								currWeapon = newWeap
								Wait(1400)
								ClearPedTasks(ped)
								holstered = false
								canFire = true
							end
						end
					else
						if not holstered and CheckWeapon(currWeapon) then
							if PlayerJob.name == "police" then
								canFire = false

								TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "intro", pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
								Wait(50)
								SetCurrentPedWeapon(ped, newWeap, true)
								ClearPedTasks(ped)

								holstered = true
								canFire = true
								currWeapon = newWeap
							else
								canFire = false
								TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
								Wait(1400)
								SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
								ClearPedTasks(ped)
								SetCurrentPedWeapon(ped, newWeap, true)
								holstered = true
								canFire = true
								currWeapon = newWeap
							end
						else
							SetCurrentPedWeapon(ped, newWeap, true)
							holstered = false
							canFire = true
							currWeapon = newWeap
						end
					end
				end
			end
		end
		Wait(sleep)
	end
end)

CreateThread(function()
	if GetResourceState('lj-inventory') == 'missing' then return end -- This part is only made to work with qb-inventory, other inventories might conflict
	local sleep
	while true do
		sleep = 250
		if not canFire then
			sleep = 0
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(PlayerId(), true)
		end
		Wait(sleep)
	end
end)