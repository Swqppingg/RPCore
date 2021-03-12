


-- DeleteVehicle Command --
if Config.deleteveh then
RegisterCommand( "dv", function()
    TriggerEvent( "RPCore:deleteVehicle" )
end, false )
TriggerEvent( "chat:addSuggestion", "/dv", "Deletes the vehicle you're sat in, or standing next to." )

local distanceToCheck = 5.0
local numRetries = 5

RegisterNetEvent( "RPCore:deleteVehicle" )
AddEventHandler( "RPCore:deleteVehicle", function()
    local ped = PlayerPedId()

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                Notify( "You must be in the driver's seat!" )
            end 
        else
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( ped, pos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                Notify( "~y~You must be in or near a vehicle to delete it." )
            end 
        end 
    end 
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        Notify( "~r~Failed to delete vehicle, trying again..." )
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            if ( not DoesEntityExist( veh ) ) then 
                Notify( "~g~Vehicle deleted." )
            end 

            timeout = timeout + 1 
            Citizen.Wait( 500 )

            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                Notify( "~r~Failed to delete vehicle after " .. timeoutMax .. " retries." )
            end 
        end 
    else 
        Notify( "~g~Vehicle deleted." )
    end 
end 

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
end
------------------------------------------------------------------
-- Hands up script
if Config.handsup then
Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 323) then --Start holding X
            if not handsup then
                TaskPlayAnim(PlayerPedId(), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(PlayerPedId())
            end
        end
    end
end)
end
------------------------------------------------------------------
-- Watermark script

if Config.watermark then
Citizen.CreateThread(function()
	while true do
		Wait(1)
		SetTextColour(129, 45, 211, Config.alpha)
		SetTextFont(Config.font)
		SetTextScale(Config.scale, Config.scale)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(2, 2, 0, 0, 0)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(Config.servername)
		DrawText(Config.offsetX, Config.offsetY)
	end
end)
end
------------------------------------------------------------------
-- Drag script
if Config.drag then
local Drag = {
	Distance = 3,
	Dragging = false,
	Dragger = -1,
	Dragged = false,
}

function Drag:GetPlayers()
	local Players = {}
    
	for Index = 0, 255 do
		if NetworkIsPlayerActive(Index) then
			table.insert(Players, Index)
		end
	end

    return Players
end

function Drag:GetClosestPlayer()
    local Players = self:GetPlayers()
    local ClosestDistance = -1
    local ClosestPlayer = -1
    local PlayerPed = PlayerPedId()
    local PlayerPosition = GetEntityCoords(PlayerPed, false)
    
    for Index = 1, #Players do
    	local TargetPed = GetPlayerPed(Players[Index])
    	if PlayerPed ~= TargetPed then
    		local TargetCoords = GetEntityCoords(TargetPed, false)
    		local Distance = #(PlayerPosition - TargetCoords)

    		if ClosestDistance == -1 or ClosestDistance > Distance then
    			ClosestPlayer = Players[Index]
    			ClosestDistance = Distance
    		end
    	end
    end
    
    return ClosestPlayer, ClosestDistance
end

RegisterNetEvent("RPCore:drag")
AddEventHandler("RPCore:drag", function(Dragger)
	Drag.Dragging = not Drag.Dragging
	Drag.Dragger = Dragger
end)

RegisterCommand("drag", function(source, args, fullCommand)
	local Player, Distance = Drag:GetClosestPlayer()

	if Distance ~= -1 and Distance < Drag.Distance then
		TriggerServerEvent("RPCore:drag", GetPlayerServerId(Player))
	else
		TriggerEvent("chat:addMessage", {
			color = {255, 0, 0},
			multiline = true,
			args = {"Government", "Please get closer to the target!"},
		})
	end
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NetworkIsSessionStarted() then
			TriggerEvent("chat:addSuggestion", "/drag", "Drag the closest player")
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Drag.Dragging then
			local PlayerPed = PlayerPedId()

			Drag.Dragged = true
			AttachEntityToEntity(PlayerPed, GetPlayerPed(GetPlayerFromServerId(Drag.Dragger)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			if Drag.Dragged then
				local PlayerPed = PlayerPedId()

				if not IsPedInParachuteFreeFall(PlayerPed) then
					Drag.Dragged = false
					DetachEntity(PlayerPed, true, false)    
				end
			end
		end
	end
end)
end
------------------------------------------------------------------
-- Crouch script
if Config.crouch then
    local crouched = false
    
    Citizen.CreateThread( function()
        while true do 
            Citizen.Wait(1)
            local ped = PlayerPedId()
            if (DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped)) then 
                DisableControlAction( 0, 36, true )
                if ( not IsPauseMenuActive() ) then 
                    if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                        RequestAnimSet( "move_ped_crouched" )
                        while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                            Citizen.Wait( 100 )
                        end 
                        if ( crouched == true ) then 
                            ResetPedMovementClipset( ped, 0 )
                            crouched = false 
                        elseif ( crouched == false ) then
                            SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                            crouched = true 
                        end 
                    end
                end 
            end 
        end
    end)
    end
------------------------------------------------------------------
-- Tazer effect
    if Config.tazereffect then
local isTaz = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		ped = PlayerPedId()
		
		if IsPedBeingStunned(ped) then
			
			SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
			
		end
		
		if IsPedBeingStunned(ped) and not isTaz then
			
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			
		elseif not IsPedBeingStunned(ped) and isTaz then
			isTaz = false
			Wait(5000)
			
			SetTimecycleModifier("hud_def_desat_Trevor")
			
			Wait(10000)
			
      		SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
	end
end)
end
------------------------------------------------------------------
-- No reticle
    if Config.noreticle then
    local scopedWeapons = 
    {
        100416529,  -- WEAPON_SNIPERRIFLE
        205991906,  -- WEAPON_HEAVYSNIPER
        3342088282  -- WEAPON_MARKSMANRIFLE
    }
    
    function HashInTable( hash )
        for k, v in pairs( scopedWeapons ) do 
            if ( hash == v ) then 
                return true 
            end 
        end 
    
        return false 
    end 
    
    function ManageReticle()
        local ped = PlayerPedId()
    
        if ( DoesEntityExist(ped) and not IsEntityDead(ped)) then
            local _, hash = GetCurrentPedWeapon(ped, true)
    
            if ( GetFollowPedCamViewMode() ~= 4 and IsPlayerFreeAiming() and not HashInTable(hash)) then 
                HideHudComponentThisFrame(14)
            end 
        end 
    end 
    
    Citizen.CreateThread(function()
        while true do 
        
            HideHudComponentThisFrame(14)		
            Citizen.Wait(0)
    
        end 
    end)
    end
------------------------------------------------------------------
-- Damage ragdoll script
    
    if Config.damageragdoll then
    local BONES = {
        --[[Pelvis]][11816] = true,
        --[[SKEL_L_Thigh]][58271] = true,
        --[[SKEL_L_Calf]][63931] = true,
        --[[SKEL_L_Foot]][14201] = true,
        --[[SKEL_L_Toe0]][2108] = true,
        --[[IK_L_Foot]][65245] = true,
        --[[PH_L_Foot]][57717] = true,
        --[[MH_L_Knee]][46078] = true,
        --[[SKEL_R_Thigh]][51826] = true,
        --[[SKEL_R_Calf]][36864] = true,
        --[[SKEL_R_Foot]][52301] = true,
        --[[SKEL_R_Toe0]][20781] = true,
        --[[IK_R_Foot]][35502] = true,
        --[[PH_R_Foot]][24806] = true,
        --[[MH_R_Knee]][16335] = true,
        --[[RB_L_ThighRoll]][23639] = true,
        --[[RB_R_ThighRoll]][6442] = true,
    }
    
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local ped = PlayerPedId()
                if HasEntityBeenDamagedByAnyPed(ped) then
                        Disarm(ped)
                end
                ClearEntityLastDamageEntity(ped)
         end
    end)
    
    function Bool (num) return num == 1 or num == true end
    local function GetDisarmOffsetsForPed (ped)
        local v
    
        if IsPedWalking(ped) then v = { 0.6, 4.7, -0.1 }
        elseif IsPedSprinting(ped) then v = { 0.6, 5.7, -0.1 }
        elseif IsPedRunning(ped) then v = { 0.6, 4.7, -0.1 }
        else v = { 0.4, 4.7, -0.1 } end
    
        return v
    end
    function Disarm (ped)
        if IsEntityDead(ped) then return false end
    
        local boneCoords
        local hit, bone = GetPedLastDamageBone(ped)
    
        hit = Bool(hit)
    
        if hit then
            if BONES[bone] then
                
    
                boneCoords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, bone))
                SetPedToRagdoll(PlayerPedId(), 5000, 5000, 0, 0, 0, 0)
                
    
                return true
            end
        end
    
        return false
    end
    end
------------------------------------------------------------------
-- Disable combat roll script
    if Config.disablecombatroll then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            if IsControlPressed(0, 25)
            then DisableControlAction(0, 22, true)
            end
        end
    end)
------------------------------------------------------------------
-- Finger point script
    if Config.fingerpoint then
    local mp_pointing = false
    local keyPressed = false
    
    local function startPointing()
        local ped = PlayerPedId()
        RequestAnimDict("anim@mp_point")
        while not HasAnimDictLoaded("anim@mp_point") do
            Wait(0)
        end
        SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
        SetPedConfigFlag(ped, 36, 1)
        Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
        RemoveAnimDict("anim@mp_point")
    end
    
    local function stopPointing()
        local ped = PlayerPedId()
        Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
        if not IsPedInjured(ped) then
            ClearPedSecondaryTask(ped)
        end
        if not IsPedInAnyVehicle(ped, 1) then
            SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
        end
        SetPedConfigFlag(ped, 36, 0)
        ClearPedSecondaryTask(PlayerPedId())
    end
    
    local once = true
    local oldval = false
    local oldvalped = false
    
    Citizen.CreateThread(function()
        while true do
            Wait(0)
    
            if once then
                once = false
            end
    
            if not keyPressed then
                if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                    Wait(200)
                    if not IsControlPressed(0, 29) then
                        keyPressed = true
                        startPointing()
                        mp_pointing = true
                    else
                        keyPressed = true
                        while IsControlPressed(0, 29) do
                            Wait(50)
                        end
                    end
                elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                    keyPressed = true
                    mp_pointing = false
                    stopPointing()
                end
            end
    
            if keyPressed then
                if not IsControlPressed(0, 29) then
                    keyPressed = false
                end
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
                stopPointing()
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                if not IsPedOnFoot(PlayerPedId()) then
                    stopPointing()
                else
                    local ped = PlayerPedId()
                    local camPitch = GetGameplayCamRelativePitch()
                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end
                    camPitch = (camPitch + 70.0) / 112.0
    
                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)
                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end
                    camHeading = (camHeading + 180.0) / 360.0
    
                    local blocked = 0
                    local nn = 0
    
                    local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                    nn,blocked,coords,coords = GetRaycastResult(ray)
    
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
    
                end
            end
        end
    end)
end
end
------------------------------------------------------------------
-- ShowID Command
if Config.rpcommands then
    if Config.showid then
RegisterNetEvent('RPCore:sendMessageShowID')
AddEventHandler('RPCore:sendMessageShowID', function(id, name1, name2)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "^2ID ^0|", {0, 150, 200}, " ^2First Name: ^0" .. name1 .." ^0| ^2Last Name: ^0".. name2 .. " ")
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 1.5 then
    TriggerEvent('chatMessage', "^2ID ^0|", {0, 150, 200}, " ^2First Name: ^0" .. name1 .." ^0| ^2Last Name: ^0".. name2 .. " ")
  end
end)
end
end
-- Chat suggestions for RPCommands
if Config.rpcommands then
Citizen.CreateThread(function()
   TriggerEvent('chat:addSuggestion', '/twt', 'Tweet something')
   TriggerEvent('chat:addSuggestion', '/dispatch', 'Dispatch')
   TriggerEvent('chat:addSuggestion', '/darkweb', 'Send a message on the darkweb')
   TriggerEvent('chat:addSuggestion', '/news', 'News')
   TriggerEvent('chat:addSuggestion', '/do', 'Describe an action you are doing.')
   TriggerEvent('chat:addSuggestion', '/ooc', 'Out of Character chat')
   TriggerEvent('chat:addSuggestion', '/me', 'Player action')
   TriggerEvent('chat:addSuggestion', '/showid', 'Show your first name and last name')
end)
end
------------------------------------------------------------------
-- NoGrip Script
if Config.nogrip then
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			if chance_result < Config.ragdoll_chance then 
				Citizen.Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.00)
				SetPedToRagdoll(ped, 5000, 1, 2)
			else
				Citizen.Wait(2000)
			end
		end
	end
end)
end
------------------------------------------------------------------
-- Anti air control script
if Config.antiaircontrol then
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(veh) then
                DisableControlAction(0, 59)
                DisableControlAction(0, 60)
            end
        end
    end
end)
end
------------------------------------------------------------------
-- PVP Script
if Config.pvp then
AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)
end
------------------------------------------------------------------
-- AFK Kick Script
if Config.afkkick then
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = PlayerPedId()
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)
			if currentPos == prevPos then
				if time > 0 then
					if Config.kickwarning and time == math.ceil(Config.secondsuntilkick / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1You'll be kicked in " .. time .. " seconds for being AFK!")
					end
					time = time - 1
				else
					TriggerServerEvent("RPCore:afkkick")
				end
			else
				time = Config.secondsuntilkick
			end
			prevPos = currentPos
		end
	end
end)
end
------------------------------------------------------------------
-- Delallveh Script
if Config.delallveh then
local delay2 = Config.delay * 1000
RegisterNetEvent("RPCore:delallveh")
AddEventHandler("RPCore:delallveh", function ()
    TriggerEvent('chatMessage', Config.delaymessage)
    Wait(delay2)
    TriggerEvent('chatMessage', Config.deletemessage)
    local totalvehc = 0
    local notdelvehc = 0

    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then SetVehicleHasBeenOwnedByPlayer(vehicle, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then DeleteVehicle(vehicle) end
            if (DoesEntityExist(vehicle)) then notdelvehc = notdelvehc + 1 end
        end
        totalvehc = totalvehc + 1 
    end
end)
end
------------------------------------------------------------------
-- Never wanted script --
if Config.neverwanted then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            for i = 1, 12 do
                EnableDispatchService(i, false)
            end
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
            SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        end
    end)
------------------------------------------------------------------
-- Remove parked vehicles --
if Config.removeparkedvehicles then
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(20)

		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		local playerPed = PlayerPedId()
		local pos = GetEntityCoords(playerPed) 
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
		SetGarbageTrucks(0)
		SetRandomBoats(0)
	end
end)
end
end
------------------------------------------------------------------
-- Auto Messages Script --
if Config.automessages then
local timeout = Config.mdelay * 1000 * 60
Citizen.CreateThread(function()
        while true do
            function chat(i)
                TriggerEvent('chatMessage', '', {255,255,255}, Config.prefix .. Config.messages[i])
            end
            for i in pairs(Config.messages) do
                    chat(i)
                Citizen.Wait(timeout)
            end
            
            Citizen.Wait(50)
        end
    end)
end
--------------------------------------------------------------------------
