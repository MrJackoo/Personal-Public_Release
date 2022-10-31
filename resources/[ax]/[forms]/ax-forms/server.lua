local QBCore = exports['qb-core']:GetCoreObject()

-- Functions
function getPlayersIdentifier(id)
	if qbcore == true then
		local identifier = GetPlayerIdentifiers(id)[2]
		local cutIdentifier = string.gsub(identifier, "license:", "")
		return cutIdentifier
	else
		local identifier = GetPlayerIdentifiers(id)[1]
		return identifier
	end
end

local function GenerateMailId()
    return math.random(111111, 999999)
end

-- Commands
QBCore.Commands.Add("staffemail", "Send an Email to a Player", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('ax-forms:client:EmailPlayer', source)
end, 'senioradministrator')

QBCore.Commands.Add("courtemail", "Send a court Email to a Player", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('ax-forms:client:courtEmail', source)
end)

-- Events
RegisterNetEvent('ax-forms:server:EmailPlayer', function(cid, title, email)
	local src = sourcew
	local citizenid = cid
	local title = title
	local message = email

	local mailData = { 
		sender = 'Axiom RP Staff', 
		subject = title,
		message = email
	}
	
	TriggerEvent('ax-forms:sendMail', citizenid, mailData)
	TriggerClientEvent('QBCore:Notify', src, 'Email Sent to Player', 'success', 2000)
end)

RegisterNetEvent('ax-forms:server:courtEmail', function(cid, title, email)
	local src = sourcew
	local citizenid = cid
	local title = title
	local message = email

	local mailData = { 
		sender = 'Supreme Court', 
		subject = title,
		message = email
	}
	
	TriggerEvent('ax-forms:sendMail', citizenid, mailData)
	TriggerClientEvent('QBCore:Notify', src, 'Email Sent to Player', 'success', 2000)
end)

RegisterNetEvent('ax-forms:sendMail', function(citizenid, mailData)
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if Player then
        local src = Player.PlayerData.source
        if mailData.button == nil then
			MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0})
            TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
        end
        SetTimeout(500, function()
            local mails = MySQL.query.await('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', {Player.PlayerData.citizenid})
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
            TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
        end)
    else
        if mailData.button == nil then
			MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0})
        end
    end
end)

RegisterServerEvent('ax-forms:server:sendCompRequest', function(message, evidence, time, reason)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local phone = Player.PlayerData.charinfo.phone
	local citizenid = Player.PlayerData.citizenid 
	local date = os.date('%d-%m-%Y %H:%M:%S', os.time())

	local headers = {
		['Content-Type'] = 'application/json'
	}
	
	local data = {
		["username"] = 'Compensation Request',
		["embeds"] = {{
		  	["color"] = 3447003,
		  	['description'] = 
			  "**Citizen ID:** "..citizenid..
			  "**\nName:** "..firstname.. ' '..lastname..
			  '**\nPhone Number:** '..phone..
			  '\n **\nMessage:** \n'..message..
			  '\n \n **Evidence:** '..evidence..
			  '\n **Time:** '..time..
			  '\n **Reason:** '..reason,
				
		  	["footer"] = {
			  	["text"] = 'Submitted: '..date
		  	}
		}}
	}
	PerformHttpRequest(Config['Webhooks']['Comp_Request'], function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

RegisterServerEvent('ax-forms:server:submitWarrant', function(rank, auth, warrant, application)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local phone = Player.PlayerData.charinfo.phone
	local citizenid = Player.PlayerData.citizenid 
	local date = os.date('%d-%m-%Y %H:%M:%S', os.time())

	local headers = {
		['Content-Type'] = 'application/json'
	}
	
	local data = {
		["username"] = 'Warrant Application',
		["embeds"] = {{
		  	["color"] = 3447003,
		  	['description'] = 
			  "**Citizen ID:** "..citizenid..
			  "**\nSubmitting Officer:** "..rank.. ' '..firstname.. ' '..lastname..
			  "**\nAuthorizing Officer:** "..auth..
			  '**\nPhone Number:** '..phone..
			  '**\nWarrant Type:** '..warrant..
			  '**\nApplication Link:** '..application,
				
		  	["footer"] = {
			  	["text"] = 'Submitted: '..date
		  	}
		}}
	}
	PerformHttpRequest(Config['Webhooks']['Warrant_Request'], function(err, text, headers) end, 'POST', json.encode(data), headers)
end)