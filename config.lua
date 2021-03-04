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
Config.disablecombatroll = true -- Disables players from using the combat roll action while aiming.
Config.fingerpoint = true -- Press b to point
Config.serverlistuptime = true -- Adds a server convar with the server uptime
Config.nogrip = true -- When jumping and running, there is an 90% chance of falling (Customizable)
Config.antiaircontrol = true -- Disable air control with vehicles
Config.pvp = true -- Enable pvp

-- Customize the Antiswear script here --
Config.kickplayer = true -- Kick the player if they say a word listed below?
Config.kickmessage = 'You have been automatically kicked for swearing.' -- Kick message
Config.wordlist = {
    "test",
    "test2"
}



-- Customize the Watermark script here --

-- Watermark text
Config.servername = "~p~Test Roleplay"

-- The x and y offset (starting at the top left corner) --
-- Default: 0.005, 0.001
Config.offsetX = 0.005
Config.offsetY = 0.001

-- Text transparency --
-- Default: 255
Config.alpha = 255

-- Text scale
-- NOTE: Number needs to be a float (so instead of 1 do 1.0)
Config.scale = 0.5

-- Text Font --
-- 0 - 5 possible
Config.font = 4




-- Customize the RPCommands script here --

-- Note: These commands will not work if rpcommands is set to false.
-- Enable or disable commands
-- Set to false to disable
Config.twitter = true
Config.dispatch = true
Config.darkweb = true
Config.news = true
Config.doo = true
Config.ooc = true
Config.me = true
Config.showid = true

Config.missingargs = '^1Please provide a message.'

-- Change this webhook to where you want the command logging to be
Config.rpcommandswebhook = ''





-- NoGrip Script --

Config.ragdoll_chance = 0.8 -- edit this decimal value for chance of falling (e.g. 80% = 0.8    75% = 0.75    32% = 0.32)










-- Set to false to disable version checker
Config.versionchecker = true

Config.versionCheck = "1.0.0"