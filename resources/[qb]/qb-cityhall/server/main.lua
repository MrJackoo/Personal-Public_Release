local QBCore = exports['qb-core']:GetCoreObject()

-- Functions
local function giveStarterItems()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    for _, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "Class C Driver License"
        end
        Player.Functions.AddItem(v.item, 1, nil, info)
    end
end

-- Events
RegisterServerEvent('qb-cityhall:server:getidentity', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local identity = Player.Functions.GetItemByName("id_card")
    local PlayerBank = Player.PlayerData.money.bank

    if identity ~= nil then
        TriggerClientEvent('QBCore:Notify', src, "You already have an ID Card", "primary", 5000)

    else
        local info = {}
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality

        if PlayerBank >= 50 then
            Player.Functions.RemoveMoney('bank', 50, 'Cityhall: Purchased ID')
            Player.Functions.AddItem("id_card", 1, false, info)
            TriggerClientEvent('QBCore:Notify', src, 'You paid £50 for an ID Card', "success", 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Money, The Cost Is £50', 'error')
        end
    end
end)

RegisterServerEvent('qb-cityhall:server:getdrivers', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local drivers = Player.Functions.GetItemByName("driver_license")
    local licenseTable = Player.PlayerData.metadata["licences"]
    local PlayerBank = Player.PlayerData.money.bank
    local info = {}

    if licenseTable.driver ~= true then
        TriggerClientEvent('QBCore:Notify', src, 'Your Drivers License has been revoked, vist Mission Row Police Station', "error", 5000)
    elseif drivers  ~= nil then
        TriggerClientEvent('QBCore:Notify', src, 'You already have a Driving License', "primary", 5000)
    else

    if PlayerBank >= 50 then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "Class C Driver License"

            Player.Functions.RemoveMoney('bank', 50, 'Cityhall: Purchased Driver License')
            Player.Functions.AddItem("driver_license", 1, false, info)
            TriggerClientEvent('QBCore:Notify', src, 'You paid £50 for a Drivers License', "success", 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Money, The Cost Is £50', "error", 5000)
        end
    end
end)

RegisterServerEvent('qb-cityhall:server:getweapon', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local weapon = Player.Functions.GetItemByName("weaponlicense")
    local PlayerBank = Player.PlayerData.money.bank
    local licenseTable = Player.PlayerData.metadata["licences"]
    local info = {}

    if licenseTable.weapon ~= true then
        TriggerClientEvent('QBCore:Notify', src, "You are not registered, Vist Mission Row Police Station", "error", 5000)
    elseif weapon ~= nil then
        TriggerClientEvent('QBCore:Notify', src, "You already have a Firearms Permit", "primary", 5000)
    else

    if PlayerBank >= 2500 then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.citizenid = Player.PlayerData.citizenid

            Player.Functions.RemoveMoney('bank', 2500, 'Cityhall: Purchased Weapon License')
            Player.Functions.AddItem("weaponlicense", 1, false, info)
            TriggerClientEvent('QBCore:Notify', src, 'You paid £2,500 for a Firearms Permit', "success", 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Money, The Cost Is £2,500', 'error')
        end
    end
end)

-- Job Events
RegisterServerEvent('qb-cityhall:server:getbusjob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["bus"]
    
    if Player.PlayerData.job.name == "bus" then
        TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
    else
        Player.Functions.SetJob("bus", 0)
        TriggerClientEvent('QBCore:Notify', src, 'Bus Driver: Check your map for directions')
        TriggerClientEvent('qb-cityhall:client:busway', src)
    end
end)

RegisterServerEvent('qb-cityhall:server:getgarbagejob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["garbage"]
    
    if Player.PlayerData.job.name == "garbage" then
        TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
    else
        Player.Functions.SetJob("garbage", 0)
        TriggerClientEvent('QBCore:Notify', src, 'Garbage Collector: Check your map for directions')
        TriggerClientEvent('qb-cityhall:client:garbageway', src)
    end
end)

RegisterServerEvent('qb-cityhall:server:getreporterjob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["reporter"]
    
    if Player.PlayerData.job.name == "reporter" then
        TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
    else
        Player.Functions.SetJob("reporter", 0)
        TriggerClientEvent('QBCore:Notify', src, 'You Are Now Employed as a Reporter')
    end
end)

RegisterServerEvent('qb-cityhall:server:getsecurityjob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["gruppesechs"]
    
    if Player.PlayerData.job.name == "gruppesechs" then
        TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
    else
        Player.Functions.SetJob("gruppesechs", 0)
        TriggerClientEvent('QBCore:Notify', src, 'You Are Now Employed as a Security Guard')
        TriggerClientEvent('qb-cityhall:client:securityway', src)
    end
end)

RegisterServerEvent('qb-cityhall:server:gettaxijob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["taxi"]
    
    if Player.PlayerData.job.name == "taxi" then
        TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
    else
        Player.Functions.SetJob("taxi", 0)
        TriggerClientEvent('QBCore:Notify', src, 'Taxi Driver: Check your map for directions')
        TriggerClientEvent('qb-cityhall:client:taxiway', src)
    end
end)


RegisterServerEvent('qb-cityhall:server:gettelcojob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["telco"]
    
    if Player.PlayerData.job.name == "telco" then
        TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
    else
        Player.Functions.SetJob("telco", 0)
        TriggerClientEvent('QBCore:Notify', src, 'Telecomms Engineer: Check your map for directions')
        TriggerClientEvent('qb-cityhall:client:telcoway', src)
    end
end)

RegisterServerEvent('qb-cityhall:server:gettowjob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["tow"]
    
    if Player.PlayerData.job.name == "tow" then
        TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
    else
        Player.Functions.SetJob("tow", 0)
        TriggerClientEvent('QBCore:Notify', src, 'Tow-Truck Driver: Check your map for directions')
        TriggerClientEvent('qb-cityhall:client:towway', src)
    end
end)

-- RegisterServerEvent('qb-cityhall:server:gettruckerjob', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local JobInfo = QBCore.Shared.Jobs["trucker"]
    
--     if Player.PlayerData.job.name == "trucker" then
--         TriggerClientEvent('QBCore:Notify', src, "You already have this job", "error", 5000)
--     else
--         Player.Functions.SetJob("trucker", 0)
--         TriggerClientEvent('QBCore:Notify', src, 'Delivery Driver: Check your map for directions')
--         TriggerClientEvent('qb-cityhall:client:truckerway', src)
--     end
-- end)

RegisterServerEvent('qb-cityhall:server:unemployed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs["unemployed"]
    
    if Player.PlayerData.job.name == "unemployed" then
        TriggerClientEvent('QBCore:Notify', src, "You are already unemployed", "error", 5000)
    else
        Player.Functions.SetJob("unemployed", 0)
        TriggerClientEvent('QBCore:Notify', src, 'You Are Now Unemployed')
    end
end)

RegisterNetEvent('qb-cityhall:server:sendDriverTest', function(instructors)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    for i = 1, #instructors do
        local citizenid = instructors[i]
        local SchoolPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
        if SchoolPlayer then
            TriggerClientEvent("qb-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
        else
            local mailData = {
                sender = "Township",
                subject = "Driving lessons request",
                message = "Hello,<br><br>We have just received a message that someone wants to take driving lessons.<br>If you are willing to teach, please contact them:<br>Name: <strong>".. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Phone Number: <strong>"..Player.PlayerData.charinfo.phone.."</strong><br><br>Kind regards,<br>Township Los Santos",
                button = {}
            }
            TriggerEvent("qb-phone:server:sendNewMailToOffline", citizenid, mailData)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, "An email has been sent to driving schools, and you will be contacted automatically", "success", 5000)
end)

RegisterNetEvent('qb-cityhall:server:getIDs', giveStarterItems)

-- Commands

QBCore.Commands.Add("drivinglicense", "Give a drivers license to someone", {{"id", "ID of a person"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if SearchedPlayer then
        if not SearchedPlayer.PlayerData.metadata["licences"]["driver"] then
            -- for i = 1, #Config.DrivingSchools do
            --     for id = 1, #Config.DrivingSchools[i].instructors do
            --         if Config.DrivingSchools[i].instructors[id] == Player.PlayerData.citizenid then
            --             SearchedPlayer.PlayerData.metadata["licences"]["driver"] = true
            --             SearchedPlayer.Functions.SetMetaData("licences", SearchedPlayer.PlayerData.metadata["licences"])
            --             TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have passed! Pick up your drivers license at the town hall", "success", 5000)
            --             TriggerClientEvent('QBCore:Notify', source, ("Player with ID %s has been granted access to a driving license"):format(SearchedPlayer.PlayerData.source), "success", 5000)
            --             break
            --         end
            --     end
            -- end

            -- New function without driving school
            SearchedPlayer.PlayerData.metadata["licences"]["driver"] = true
            SearchedPlayer.Functions.SetMetaData("licences", SearchedPlayer.PlayerData.metadata["licences"])
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have passed! Pick up your drivers license at the town hall", "success", 5000)
            TriggerClientEvent('QBCore:Notify', source, ("Player with ID %s has been granted access to a driving license"):format(SearchedPlayer.PlayerData.source), "success", 5000)
        else
            TriggerClientEvent('QBCore:Notify', source, "Can't give permission for a drivers license, this person already has permission", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
    end
end)
