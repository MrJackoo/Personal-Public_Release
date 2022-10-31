local QBCore = exports['qb-core']:GetCoreObject()

function getPlayersIdentifier(id)
	if USING_QBUS == true then
		local identifier = GetPlayerIdentifiers(id)[2]
		local cutIdentifier = string.gsub(identifier, "license:", "")
		return cutIdentifier
	else
		local identifier = GetPlayerIdentifiers(id)[1]
		return identifier
	end
end




RegisterServerEvent('strin_jobform:sendWebhook')
AddEventHandler('strin_jobform:sendWebhook', function(data)
	local Player = QBCore.Functions.GetPlayer(source)
	local job = data.job


	if data.corruption == false then 
		corruption = "No" 
	elseif data.corruption == true then
		corruption = "Yes"
	end

	if data.meetage == false then 
		meetage = "No" 
	elseif data.meetage == true then
		meetage = "Yes"
	end

	if data.indiscord == false then 
		indiscord = "No" 
	elseif data.indiscord == true then
		indiscord = "Yes"
	end

	if data.discordid == nil then data.type = "" end
	if data.age == nil then data.type = "" end
	if data.joinreason == nil then data.type = "" end
	if data.qualities == nil then data.type = "" end
	if data.previous == nil then data.type = "" end
	if data.indiscord == nil then data.type = "" end
	if data.meetage == nil then data.type = "" end
	if data.extra == nil then data.type = "" end
	if data.label == nil then data.type = "" end
	if data.firstname == nil then data.type = "" end
	if data.lastname == nil then data.type = "" end
	if data.phone == nil then data.type = "" end


	local discordid = data.discordid
	local age = data.age
	local joinreason = data.joinreason
	local qualities = data.qualities
	local previous = data.previous
	local extra = data.extra
	local label = data.label
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local phone = Player.PlayerData.charinfo.phone
	local dob = Player.PlayerData.charinfo.birthdate
	local citizenid = Player.PlayerData.citizenid 
	local headers = {
		['Content-Type'] = 'application/json'

	}

	local policedata = {
		["embeds"] = {{
			['title'] = "New Police Application",
			['description'] = "A new application has been submitted please check below:",
			['color'] = "9812423",
			["footer"] = {
				["text"] = "Created by: Jacko#2098",
			},
			['thumbnail'] = {
				['url'] = "https://i.imgur.com/BG2Yczh.png"
			},
			["fields"] = {
				{
					['name'] = "First Name",
					['value'] = firstname,
					['inline'] = true
				},
				{
					['name'] = "Last Name",
					['value'] = lastname,
					['inline'] = true
				},
				{
					['name'] = "Age",
					['value'] = age,
					['inline'] = true
				},
				{
					['name'] = "Discord ID",
					['value'] = discordid,
					['inline'] = true
				},
				{
					['name'] = "Phone Number",
					['value'] = phone,
					['inline'] = true
				},
				{
					['name'] = "Why do you want to join?",
					['value'] = joinreason
				},
				{
					['name'] = "What qualities can you bring?",
					['value'] = qualities
				},
				{
					['name'] = "Do you have any previous experience?",
					['value'] = previous
				},
				{
					['name'] = "Are you in the discord?",
					['value'] = indiscord
				},
				{
					['name'] = "Do you understand you MUST meet the age requirement to join",
					['value'] = meetage
				},
				{
					['name'] = "Do you understand that you cannot be corrupt as police as this is a server rulebreak?",
					['value'] = corruption
				},
				{
					['name'] = "Do you have anything extra to say?",
					['value'] = extra
				}
			},
			["author"] = {
				['name'] = "Axiom Government"
			},
		}}
	}

	local nhsdata = {
		["embeds"] = {{
			['title'] = "New NHS Application",
			['description'] = "A new application has been submitted please check below:",
			['color'] = "1595419",
			["footer"] = {
				["text"] = "Created by: Jacko#2098",
			},
			['thumbnail'] = {
				['url'] = "https://i.imgur.com/BG2Yczh.png"
			},
			["fields"] = {
				{
					['name'] = "First Name",
					['value'] = firstname,
					['inline'] = true
				},
				{
					['name'] = "Last Name",
					['value'] = lastname,
					['inline'] = true
				},
				{
					['name'] = "Age",
					['value'] = age,
					['inline'] = true
				},
				{
					['name'] = "Discord ID",
					['value'] = discordid,
					['inline'] = true
				},
				{
					['name'] = "Phone Number",
					['value'] = phone,
					['inline'] = true
				},
				{
					['name'] = "Why do you want to join?",
					['value'] = joinreason
				},
				{
					['name'] = "What qualities can you bring?",
					['value'] = qualities
				},
				{
					['name'] = "Do you have any previous experience?",
					['value'] = previous
				},
				{
					['name'] = "Are you in the discord?",
					['value'] = indiscord
				},
				{
					['name'] = "Do you understand you MUST meet the age requirement to join",
					['value'] = meetage
				},
				{
					['name'] = "Do you have anything extra to say?",
					['value'] = extra
				}
			},
			["author"] = {
				['name'] = "Axiom Government"
			},
		}}
	}

	if job == "police" then
		PerformHttpRequest(WEBHOOKS[job], function(err, text, headers) end, 'POST', json.encode(policedata), headers)
	elseif job == "ambulance" then
		PerformHttpRequest(WEBHOOKS[job], function(err, text, headers) end, 'POST', json.encode(nhsdata), headers)
	end
end)

