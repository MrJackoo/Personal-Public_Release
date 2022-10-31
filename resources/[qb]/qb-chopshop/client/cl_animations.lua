RegisterNetEvent('qb-chopshop:wheelanimation')
AddEventHandler('qb-chopshop:wheelanimation', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
	QBCore.Functions.Progressbar("wheel", Config.Locale["Wheel"], 7000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(7500)
	local ped = PlayerPedId()    
	RequestAnimDict("anim@heists@box_carry@")
	Wait(100)
    wheelprop = CreateObject(GetHashKey("imp_prop_impexp_tyre_01b"), 0, 0, 0, true, true, true)        
	AttachEntityToEntity(wheelprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.05, 0.2, 0.35, -145.0, 100.0, 0.0, true, true, false, true, 1, true)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 2500, 51, 0, false, false, false)
	Wait(2500)
	DetachEntity(wheelprop, 1, true)
	DeleteEntity(wheelprop)
	DeleteObject(wheelprop)
end)

RegisterNetEvent('qb-chopshop:dooranimation')
AddEventHandler('qb-chopshop:dooranimation', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
	QBCore.Functions.Progressbar("Door1", Config.Locale["Door1"], (4000), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(4500)
	TriggerEvent('animations:client:EmoteCommandStart', {"pull"})
	QBCore.Functions.Progressbar("Door2", Config.Locale["Door2"], (4000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(4500)
	local ped = PlayerPedId()    
	RequestAnimDict("anim@heists@box_carry@")
	Wait(100)
	doorprop = CreateObject(GetHashKey("imp_prop_impexp_car_door_04a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(doorprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.16, -0.05, 0.5, -135.0, 180.0, 0.0, true, true, false, true, 1, true)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 2000, 51, 0, false, false, false)
	Wait(2000)
	DetachEntity(doorprop, 1, true)
	DeleteEntity(doorprop)
	DeleteObject(doorprop)
end)

RegisterNetEvent('qb-chopshop:trunkanimation')
AddEventHandler('qb-chopshop:trunkanimation', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
	QBCore.Functions.Progressbar("Trunk1", Config.Locale["searching"], (4000), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(4500)
	TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
	QBCore.Functions.Progressbar("Hood1", Config.Locale["Door1"], (4000), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(4500)
	TriggerEvent('animations:client:EmoteCommandStart', {"pull"})
	QBCore.Functions.Progressbar("Hood2", Config.Locale["Door2"], (4000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(4500)
end)

RegisterNetEvent('qb-chopshop:hoodanimation')
AddEventHandler('qb-chopshop:hoodanimation', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
	QBCore.Functions.Progressbar("Hood1", Config.Locale["Door1"], (4000), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(4500)
	TriggerEvent('animations:client:EmoteCommandStart', {"pull"})
	QBCore.Functions.Progressbar("Hood2", Config.Locale["Door2"], (4000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(4500)
	local ped = PlayerPedId()    
	RequestAnimDict("anim@heists@box_carry@")
	Wait(100)
	trunkprop = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(trunkprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.58, 0.35, 0.24, -120.0, 115.0, 0.0, true, true, false, true, 1, true)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 2000, 51, 0, false, false, false)
	Wait(2000)
	DetachEntity(trunkprop, 1, true)
	DeleteEntity(trunkprop)
	DeleteObject(trunkprop)
end)

RegisterNetEvent('qb-chopshop:wheelchopanim')
AddEventHandler('qb-chopshop:wheelchopanim', function()

	if not isdoingsomething then
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				QBCore.Functions.Progressbar('wheel', 'Chopping Wheel', math.random(4000,8000), false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},{
					animDict = "missmechanic",
					anim = "work2_base",
					flags = 1,
				},
				{}, -- prop1
				{}, -- prop2
				function() -- done
					TriggerServerEvent('qb-chopshop:server:chopwheel')
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
				end,
				function() -- Cancel
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify('Process Canceled', 'error')
					isdoingsomething = false
				end)			
			else
				QBCore.Functions.Notify('You Dont have anything to chop', 'error')
				isdoingsomething = false
			end
		end, 'carpart_wheel')
	else
		QBCore.Functions.Notify("Looks Like you are already doing something", "error")
	end
end)

RegisterNetEvent('qb-chopshop:doorchopanim')
AddEventHandler('qb-chopshop:doorchopanim', function()
	if not isdoingsomething then
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				QBCore.Functions.Progressbar('door', 'Chopping Door', math.random(4000,8000), false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},{
					animDict = "missmechanic",
					anim = "work2_base",
					flags = 1,
				},
				{}, -- prop1
				{}, -- prop2
				function() -- done
					TriggerServerEvent('qb-chopshop:server:chopdoor')
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
				end,
				function() -- Cancel
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify('Process Canceled', 'error')
					isdoingsomething = false
				end)			
			else
				QBCore.Functions.Notify('You Dont have anything to chop', 'error')
				isdoingsomething = false
			end
		end, 'carpart_door')
	else
		QBCore.Functions.Notify("Looks Like you are already doing something", "error")
	end
end)

RegisterNetEvent('qb-chopshop:hoodchopanim')
AddEventHandler('qb-chopshop:hoodchopanim', function()
	if not isdoingsomething then
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				QBCore.Functions.Progressbar('hood', 'Chopping Hood', math.random(4000,8000), false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},{
					animDict = "missmechanic",
					anim = "work2_base",
					flags = 1,
				},
				{}, -- prop1
				{}, -- prop2
				function() -- done
					TriggerServerEvent('qb-chopshop:server:chophood')
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
				end,
				function() -- Cancel
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify('Process Canceled', 'error')
					isdoingsomething = false
				end)			
			else
				QBCore.Functions.Notify('You Dont have anything to chop', 'error')
				isdoingsomething = false
			end
		end, 'carpart_hood')
	else
		QBCore.Functions.Notify("Looks Like you are already doing something", "error")
	end

end)

RegisterNetEvent('qb-chopshop:trunkchopanim')
AddEventHandler('qb-chopshop:trunkchopanim', function()
	if not isdoingsomething then
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				isdoingsomething = true
				QBCore.Functions.Progressbar('trunk', 'Chopping Trunk', math.random(4000,8000), false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},{
					animDict = "missmechanic",
					anim = "work2_base",
					flags = 1,
				},
				{}, -- prop1
				{}, -- prop2
				function() -- done
					TriggerServerEvent('qb-chopshop:server:choptrunk')
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
					isdoingsomething = false
				end,
				function() -- Cancel
					StopAnimTask(PlayerPedId(), "missmechanic", "work2_base", 1.0)
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify('Process Canceled', 'error')
					isdoingsomething = false
				end)			
			else
				QBCore.Functions.Notify('You Dont have anything to chop', 'error')
				isdoingsomething = false
			end
		end, 'carpart_trunk')
	else
		QBCore.Functions.Notify("Looks Like you are already doing something", "error")
	end
end)