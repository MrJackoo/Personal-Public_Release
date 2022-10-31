local canBeTackled = true
local inTackleCooldown = false
TimerEnabled = false
local tacklekey = 38 -- ID for key control (https://docs.fivem.net/docs/game-references/controls/#controls)



CreateThread(function()
	while true do
		Wait(0)
        local ped = PlayerPedId()
		if IsPedJumping(ped) and IsControlJustReleased(0, tacklekey) then
			if IsPedInAnyVehicle(ped) then
				return
			else
                DisableControlAction(0, tacklekey, true)
				Tackle()
                RequestAnimDict("swimming@first_person@diving")
                while not HasAnimDictLoaded("swimming@first_person@diving") do
                    Wait(1)
                end
                if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
                    ClearPedTasksImmediately(ped)
                else
                    TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
                    Wait(250)
                    ClearPedTasksImmediately(ped)
                    SetPedToRagdoll(ped, 150, 150, 0, 0, 0, 0)
                end
			end
            Wait(5000)
            DisableControlAction(0, tacklekey, false)
		end
	end
end)





-- CreateThread(function()
--     while true do 
--         local ped = PlayerPedId()
--         if not IsPedInAnyVehicle(ped, false) and GetEntitySpeed(ped) > 2.5 then
--             if IsControlJustPressed(0, 19) and not spacePressed then
--                 -- print("tackling")
--                 Tackle()
--                 RequestAnimDict("swimming@first_person@diving")
--                 while not HasAnimDictLoaded("swimming@first_person@diving") do
--                     Wait(1)
--                 end
--                 if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
--                     ClearPedTasksImmediately(ped)
--                 else
--                     TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
--                     Wait(250)
--                     ClearPedTasksImmediately(ped)
--                     SetPedToRagdoll(ped, 150, 150, 0, 0, 0, 0)
--                 end
--             end
--         else
--             Wait(250)
--         end

--         Wait(1)
--     end
-- end)

RegisterNetEvent('tackle:client:GetTackled', function()
    if not canBeTackled or inTackleCooldown then
        return
    end

    SetPedToRagdoll(PlayerPedId(), math.random(3500,5000), math.random(3500,5000), 0, 0, 0, 0)
    TimerEnabled = true
    inTackleCooldown = true
    Wait(10000)
    TimerEnabled = false
    inTackleCooldown = false
end)

function Tackle()
    local closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
    if(distance ~= -1 and distance < 2) then
        TriggerServerEvent("tackle:server:TacklePlayer", GetPlayerServerId(closestPlayer))
        TackleAnim()
    end
end

function TackleAnim()
    local ped = PlayerPedId()
    if not QBCore.Functions.GetPlayerData().metadata["ishandcuffed"] or not QBCore.Functions.GetPlayerData().metadata["isziptied"] and not IsPedRagdoll(ped) then
        RequestAnimDict("swimming@first_person@diving")
        while not HasAnimDictLoaded("swimming@first_person@diving") do
            Wait(1)
        end
        if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedTasksImmediately(ped)
        else
            TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
            Wait(250)
            ClearPedTasksImmediately(ped)
            SetPedToRagdoll(ped, 150, 150, 0, 0, 0, 0)
        end
    end
end
