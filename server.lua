-- RPCommands Discord Webhook
rpcommandswebhook = 'WEBHOOK_HERE' -- Change this webhook to where you want the RPCommands logging to be


---------------------------------------------


-- Antiswear
if Config.antiswear then
AddEventHandler('chatMessage', function(source, n, message)
      for k,n in pairs(Config.wordlist) do
        if string.match(message:lower(),n:lower()) then
        CancelEvent()
        if Config.kickplayer then
        DropPlayer(source, Config.kickmessage)
        end
      end
    end
end)
end
----------------------------------------------------------------------------------------------
-- Drag script
if Config.drag then
RegisterServerEvent("RPCore:drag")
AddEventHandler("RPCore:drag", function(Target)
	local Source = source
	TriggerClientEvent("RPCore", Target, Source)
end)
end
------------------------------------------------------------------------
-- Server Uptime Convar
if Config.serverlistuptime then
Citizen.CreateThread(function()
	local uptimeMinute, uptimeHour, uptime = 0, 0, ''

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		uptimeMinute = uptimeMinute + 1

		if uptimeMinute == 60 then
			uptimeMinute = 0
			uptimeHour = uptimeHour + 1
		end

		uptime = string.format("%02dh %02dm", uptimeHour, uptimeMinute)
		SetConvarServerInfo('Uptime', uptime)


		TriggerClientEvent('uptime:tick', -1, uptime)
		TriggerEvent('uptime:tick', uptime)
	end
end)
end
------------------------------------------------------------------------------
-- RPCommands script

-- Twitter Command
if Config.rpcommands then
if Config.twitter then
    RegisterCommand("twt", function(source, args, raw)
            if #args <= 0 then
            TriggerClientEvent('chatMessage', source, Config.missingargs)
            else
            local message = table.concat(args, " ")
            local steam = GetPlayerName(source)
            args = table.concat(args, ' ')
            TriggerClientEvent('chatMessage', -1, "TWITTER | ".. GetPlayerName(source) .."", { 30, 144, 255 }, message)
            PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = "**TWITTER:** ".. message .."", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
        end
    end)
    end
end
    
    -- Dispatch Command
    if Config.rpcommands then
    if Config.dispatch then
    RegisterCommand("dispatch", function(source, args, raw)
            if #args <= 0 then
            TriggerClientEvent('chatMessage', source, Config.missingargs)
            else
            local message = table.concat(args, " ")
            TriggerClientEvent('chatMessage', -1, "Dispatch | ".. GetPlayerName(source) .."", { 30, 144, 255 }, message)
            PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = "**DISPATCH:** ".. message .."", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
        end
    end)
    end
end
    
    -- Darkweb Command
    if Config.rpcommands then
    if Config.darkweb then
    RegisterCommand("darkweb", function(source, args, raw)
            if #args <= 0 then
            TriggerClientEvent('chatMessage', source, Config.missingargs)
            else
            local message = table.concat(args, " ")
            local steam = GetPlayerName(source)
            args = table.concat(args, ' ')
            TriggerClientEvent('chatMessage', -1, "Dark Web", { 33, 33, 38 }, message)
            PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = "**DARKWEB:** ".. message .."", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
        end
    end)
    end
end
    
    -- News Command
    if Config.rpcommands then
    if Config.news then
    RegisterCommand("news", function(source, args, raw)
            if #args <= 0 then
            TriggerClientEvent('chatMessage', source, Config.missingargs)
            else
            local message = table.concat(args, " ")
            local steam = GetPlayerName(source)
            args = table.concat(args, ' ')
            TriggerClientEvent('chatMessage', -1, "NEWS | ".. GetPlayerName(source) .."", { 194, 255, 51 }, message)
            PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = "**NEWS:** ".. message .."", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
        end
    end)
    end
end
    -- Do Command
    if Config.rpcommands then
    if Config.doo then
    RegisterCommand("do", function(source, args, raw)
            if #args <= 0 then
            TriggerClientEvent('chatMessage', source, Config.missingargs)
            else
            local message = table.concat(args, " ")
            TriggerClientEvent('chatMessage', -1, "Do | ".. GetPlayerName(source) .."", { 51, 153, 255 }, message)
            PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = "**DO:** ".. message .."", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
        end
    end)
    end
end
    
    -- OOC Command
    if Config.rpcommands then
    if Config.ooc then
    RegisterCommand("ooc", function(source, args, raw)
            if #args <= 0 then
            TriggerClientEvent('chatMessage', source, Config.missingargs)
            else
            local message = table.concat(args, " ")
            local steam = GetPlayerName(source)
            args = table.concat(args, ' ')
            TriggerClientEvent('chatMessage', -1, "OOC | ".. GetPlayerName(source) .."", { 128, 128, 128 }, message)
            PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = "**OOC:** ".. message .."", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
        end
    end)
    end
end
    -- Me Command
    if Config.rpcommands then
    if Config.me then
    RegisterCommand("me", function(source, args, raw)
            if #args <= 0 then
            TriggerClientEvent('chatMessage', source, Config.missingargs)
            else
            local message = table.concat(args, " ")
            local steam = GetPlayerName(source)
            args = table.concat(args, ' ')
            TriggerClientEvent('chatMessage', -1, "Me | ".. GetPlayerName(source) .."", { 255, 0, 0 }, message)
            PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = "**ME:** ".. message .."", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
        end
    end)
    end
end
    
    -- ShowID Command
    if Config.rpcommands then
    if Config.showid then
    RegisterCommand("showid", function(source, color, msg)
        cm = stringsplit(msg, " ")
            CancelEvent()
            if tablelength(cm) == 3 then
                local firstname = tostring(cm[2])
                local lastname = tostring(cm[3])
                local steam = GetPlayerName(source)
                TriggerClientEvent("RPCore:sendMessageShowID", -1, source, firstname, lastname)
                PerformHttpRequest(rpcommandswebhook, function(err, text, headers) end, 'POST', json.encode({username = steam, content = '**ShowID** | **First Name:** ' .. firstname .. ' **Last Name:** ' .. lastname .. '', avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
                
            else
                TriggerClientEvent('chatMessage', source, "Use the following format:", {255, 0, 0}, "/showid [First Name] [Last Name]")
            end
        end)
    end
end
    
    
      
    function stringsplit(inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
        end
        return t
    end
    
    
    
    function tablelength(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    end
--------------------------------------------------------------------------------------------------------------
-- AFK Kick Script --
if Config.afkkick then
RegisterServerEvent("RPCore:afkkick")
AddEventHandler("RPCore:afkkick", function()
	DropPlayer(source, Config.afkkickmessage)
end)
end
------------------------------------------------------------------------------
-- Delallveh Script --
if Config.delallveh then
RegisterCommand(Config.commandname, function(source, args, rawCommand) 
	TriggerClientEvent("RPCore:delallveh", -1) 
end, Config.restrictcommand)
end
-------------------------------------------------










































local branding = 
[[ 
  //
  ||     _____  _____   _____               
  ||    |  __ \|  __ \ / ____|              
  ||    | |__) | |__) | |     ___  _ __ ___ 
  ||    |  _  /|  ___/| |    / _ \| '__/ _ \
  ||    | | \ \| |    | |___| (_) | | |  __/
  ||    |_|  \_\_|     \_____\___/|_|  \___|
  ||             Made by Swqpping
  ||
  ||
  \\
  ]]

versionChecker = true -- Set to false to disable version checker


-- Don't touch
resourcename = "RPCore"
version = "1.0.2"
rawVersionLink = "https://raw.githubusercontent.com/Swqppingg/RPCore/main/version.txt"

-- Check for version updates.
if versionChecker then
print(branding)
PerformHttpRequest(rawVersionLink, function(errorCode, result, headers)
    if (string.find(tostring(result), version) == nil) then
        print("\n\r[".. GetCurrentResourceName() .."] ^1WARNING: Your version of ".. resourcename .." is not up to date. Please make sure to update whenever possible.\n\r")
    else
        print("\n\r[".. GetCurrentResourceName() .."] ^2You are running the latest version of ".. resourcename ..".\n\r")
    end
end, "GET", "", "")
end
