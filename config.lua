Config = {}
-- Edit this config for your server


-- Scripts (Set to false to disable) --
Config.deleteveh = true -- Delete vehicle command (/dv)
Config.antiswear = true -- Kicks a player when sending specific messages (You can change these messages below)
Config.rpcommands = true -- /twt, /dispatch, /darkweb, /news, /do, /ooc, /me, /show id commands with discord logging
Config.handsup = true -- Press x to put your hands up
Config.watermark = true -- Watermark for your server with customizable text
Config.drag = true -- /drag command (Drags the closest player)
Config.crouch = true -- Pressing ctrl makes you crouch
Config.tazereffect = true -- Gives you an effect when you get tazed
Config.noreticle = true -- Disables the reticle when aiming
Config.damageragdoll = true -- Ragdoll when shot
Config.fingerpoint = true -- Press b to point
Config.serverlistuptime = true -- Adds a server convar with the server uptime
Config.nogrip = true -- When jumping and running, there is an 90% chance of falling (Customizable)
Config.antiaircontrol = true -- Disable air control with vehicles
Config.pvp = true -- Enable pvp
Config.afkkick = false -- Kick players for being AFK
Config.delallveh = true -- Delete all vehicles on the map
Config.neverwanted = true -- Disable wanted level and emergency services
Config.removeparkedvehicles = true -- Removes all parked vehicles
Config.automessages = false -- Sends the configurable messages to the player, every x minutes.

-- Customize the Antiswear script here --

Config.kickplayer = true -- Kick the player if they say a word listed below?
Config.kickmessage = 'You have been automatically kicked for swearing.' -- Kick message
Config.wordlist = {
    "example",
    "example2"
}



-- Customize the Watermark script here --

Config.servername = "~p~Test ~w~Roleplay" -- Watermark text

-- The x and y offset (starting at the top left corner) --
Config.offsetX = 0.005
Config.offsetY = 0.001
Config.alpha = 255 -- Text transparency
Config.scale = 0.5 -- Text scale, NOTE: Number needs to be a float (so instead of 1 do 1.0)
Config.font = 4 -- Text Font, 0 - 5 possible




-- Customize the RPCommands script here --

-- Note: These commands will not work if rpcommands is set to false.
-- Enable or disable commands
-- Set to false to disable
Config.twitter = true -- /twt command?
Config.dispatch = true -- /dispatch command?
Config.darkweb = true -- /darkweb command?
Config.news = true -- /news command?
Config.doo = true -- /do command?
Config.ooc = true -- /ooc command?
Config.me = true -- /me command?
Config.showid = true -- /showid command?
Config.missingargs = '^1Please provide a message.' -- Send this message when a player didn't provide a message
-- [!] CHANGE THE DISCORD WEBHOOK IN SERVER.LUA AT THE TOP
-- [!] CHANGE THE DISCORD WEBHOOK IN SERVER.LUA AT THE TOP
-- [!] CHANGE THE DISCORD WEBHOOK IN SERVER.LUA AT THE TOP
-- [!] CHANGE THE DISCORD WEBHOOK IN SERVER.LUA AT THE TOP



-- Customize the NoGrip script here --

Config.ragdoll_chance = 0.8 -- Edit this decimal value for chance of falling (e.g. 80% = 0.8    75% = 0.75    32% = 0.32)




-- Customize the AFK Kick script here --

Config.secondsuntilkick = 600 -- AFK Kick Time Limit (in seconds)
Config.kickwarning = true -- Warn players if 3/4 of the Time Limit ran up
-- Edit Warning message before getting kicked in client.lua line 611
Config.afkkickmessage = "You were kicked for being AFK for too long."




-- Customize the delallveh script here --

Config.delay = 15 -- Delay before actually deleting all vehicles in seconds
Config.delaymessage = "^1SYSTEM^0: ^7All unoccupied vehicles will be deleted in ".. Config.delay .. " seconds" -- Message before deleting all vehicles
Config.deletemessage = "^1SYSTEM^0: ^7All unoccupied vehicles have been deleted by a staff member to reduce the amount of server lag and texture loss."
Config.commandname = "delallveh" -- This is the command that you will type into chat to execute the script.
Config.restrictcommand = true
-- Setting this to false will allow anyone in the server to use the command. 
-- If you set it to true you will need to add a ace perm to allow people to use it.
-- Such as add_ace [GROUP] command.[commandName] allow






-- Customize the Auto Messages script here --

Config.mdelay = 10 -- Delay in minutes between messages
Config.prefix = '^1SYSTEM^0: ' -- Prefix appears in front of each message.
Config.messages = { -- Messages to be sent (You can add unlimited messages)
    '^0This is a ^2test message',
	'^0This is a ^3test message',
	'^0This is a ^4test message'
}
