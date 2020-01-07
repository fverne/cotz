if CLIENT then return end	--GET OUT OF HERE STALKER!

AddCSLuaFile( "autorun/client/blowout_cl.lua" )
include( "autorun/client/blowout_cl.lua" )
resource.AddWorkshop( 230520180 )


local BlowoutEnabled = CreateConVar( "blowout_enabled", 0, { FCVAR_ARCHIVE }, "Enables / disables the Blowout addon. Value can be 0 (= off) or 1 (= on).")
local BlowoutInterval = CreateConVar( "blowout_interval", 36000, { FCVAR_ARCHIVE }, "The time in seconds between two blowouts (from the previous blowout's damage phase to the next one's announcement).")
local AnnounceDuration = CreateConVar( "blowout_announcing_duration", 70, { FCVAR_ARCHIVE }, "The delay in seconds until a blowout sequence starts, after it's been announced.")
local DamageDuration = CreateConVar( "blowout_damage_duration", 0, { FCVAR_ARCHIVE }, "The duration in seconds, after a blowout has hit, during which Wiremod E2s cannot be used.")

local CTm = CurTime()
local AnnounceTime = CTm + math.random((math.max(BlowoutInterval:GetInt(), 10))*0.5, (math.max(BlowoutInterval:GetInt(), 10))*1.5)
local BlowoutHitTime = 0
local BlowoutStep = 0
local DamageTime = 0
local NextSound = 0
local NextAmbientSound = 0
local NextAction = 0
local NextThink = 0
local BlowoutLastEnabled = false
local BlowoutStarted = false
local BlowoutHasHit = false
local BadMoveTypes = {}
	BadMoveTypes[0] = true
	BadMoveTypes[5] = true
	BadMoveTypes[8] = true
	BadMoveTypes[10] = true





local function BlowoutSound( Type )
	local ID = 0

	if Type == "announce1" then ID = 1
	elseif Type == "announce2" then ID = 2
	elseif Type == "prehit" then ID = 3
	elseif Type == "ambient" then ID = math.random(10,14)
	elseif Type == "start" then ID = 20
	elseif Type == "hit" then ID = math.random(31,33)
	elseif Type == "buildup" then ID = 30
	elseif Type == "end" then ID = 40
	end

	for k, v in pairs(player.GetAll()) do
		umsg.Start("BlowoutVar", v)
		umsg.Char(ID)
		umsg.End()
	end
end





local function BlowoutIsSafe( Pos )
	local tracedata_up = {}
	tracedata_up.start = Pos
	tracedata_up.endpos = Pos + Vector(0,0,999999)
	tracedata_up.mask = MASK_SOLID_BRUSHONLY + MASK_WATER 
	local trace_up = util.TraceLine(tracedata_up)	--Can the entity see the sky?
    
	if trace_up.HitSky then
		local Pos_up = trace_up.HitPos
		local tracedata_down = {}
		tracedata_down.start = Pos_up
		tracedata_down.endpos = Pos
		tracedata_down.mask = MASK_SOLID_BRUSHONLY + MASK_WATER 
		local trace_down = util.TraceLine(tracedata_down)	--Can the sky see the entity? (excludes entities that are below displacements or inside brushes)
		
		if !trace_down.Hit then
			return false
		end
		
		return true
	end

	return true
end





local function BlowoutUnragdoll( ply )
	if ply.IsSafe != false then return end

	ply:UnSpectate()
//	ply:Spawn()
	ply:UnLock()
	ply:SetNWEntity( "BlowoutRag", nil )

	local Ragdoll = ply.BlowoutRagdoll
	if !IsValid(Ragdoll) then return end

	local Weps = ply.Weps or {}
	local Ammo = ply.Ammo or {}
	local PlyHealth = ply.LastHealth or 0
	local PlyArmour = ply.LastArmour or 0

	if PlyHealth > 0 then timer.Simple(0.1, function() ply:SetHealth(PlyHealth) end ) end
	if PlyArmour > 0 then timer.Simple(0.1, function() ply:SetArmor(PlyArmour) end ) end

	if table.Count(Weps) then
		ply:StripWeapons()

		for k, v in pairs(Weps) do
			ply:Give(k)				--Give all weapons back
		end

		for k, v in pairs(ply:GetWeapons()) do
			v:SetClip1( Weps[v:GetClass()] )	--Reset the current clip of each weapon
		end

		if (ply.LastWep or "") != "" then ply:SelectWeapon(ply.LastWep) end
	end

	if table.Count(Ammo) then
		for k, v in pairs(Ammo) do
			ply:SetAmmo(v, k)			--Reset the total ammo count
		end
	end

	ply.Weps = {}
	ply.Ammo = {}
	ply.LastWep = nil
	ply.LastHealth = 0
	ply.LastArmour = 0

	ply:SetPos( Ragdoll:GetPos() )
	Ragdoll:Remove()
end





local function BlowoutReset( Plys, NPCs, E2s )
	if Plys > 0 then	--Reset the players' post processes
		for k, v in pairs(player.GetAll()) do
			umsg.Start("BlowoutVar", v)
			umsg.Char( 100 )
			umsg.End()

			--v:ChatPrint("The blowout sequence is over.")
			BlowoutUnragdoll( v )

			if v.IsSafe then
				v:Freeze( false )
			end
			v:SetNoTarget( false )
			v.IsSafe = nil
		end
	end

	if NPCs > 0 then	--Reset the NPCs
		local NPCs = ents.FindByClass( "npc_*" )
		for k, v in pairs(NPCs) do
			v:SetKeyValue( "sleepstate", "0" )
		end
	end

	if E2s > 0 then		--Reset the E2s
		timer.Remove( "BlowoutDisableE2s" )

		local E2s = ents.FindByClass( "gmod_wire_expression2" )
		for k, v in pairs(E2s) do
			v.ExcludedFromBlowout = nil
			if v.DisabledByBlowout == true then
				v.DisabledByBlowout = nil
				v.error = false
			end
		end
	end
end





local function BlowoutDisableE2s()
	if CurTime() > DamageTime or BlowoutHasHit == false or BlowoutEnabled:GetInt() <= 0 then return end

	local Plys = player.GetAll()
	for k, v in pairs( ents.FindByClass("gmod_wire_expression2") ) do
		if !IsValid(v) then continue end
		if v.ExcludedFromBlowout == true or v.error == true then continue end

		local ID = v:EntIndex()
		for k2, ply in pairs(Plys) do
			umsg.Start("BlowoutVar", ply)
			umsg.Char( 120 )
			umsg.Short( ID )
			umsg.End()
		end

		v.DisabledByBlowout = true
		v.error = true
	end

	timer.Create( "BlowoutDisableE2s", 1, 1, function() BlowoutDisableE2s() end )
end

local function CleanAnomalies()
	for k, v in pairs( ents.GetAll() ) do
		if (string.sub(v:GetClass(), 1, 5) == "anom_") then
			v:Remove()
		end
	end
end

local function BlowoutThink(ply)
	local CTm = CurTime()
	if CTm < NextThink then return end

	if BlowoutEnabled:GetInt() <= 0 then
		if BlowoutLastEnabled == true then
			BlowoutStep = 0
			BlowoutStarted = false
			BlowoutHasHit = false

			BlowoutReset(1,1,1)

			print("[Blowout] Addon has been disabled. ("..math.Round(CTm)..")")
			BlowoutLastEnabled = false
		end

		NextThink = CTm + 1
		return
	elseif BlowoutLastEnabled == false then
		local Next = math.max(BlowoutInterval:GetInt(), 60)
		AnnounceTime = CTm + Next

		print("[Blowout] Addon is now enabled, next blowout warning in "..math.Round(Next).." seconds. ("..math.Round(CTm)..")")
		BlowoutLastEnabled = true
	end



	if BlowoutHasHit then		--If the blowout has already hit
		NextThink = CTm + 1

		if CTm > NextAction then
			if BlowoutStep == 0 then	--Let the players enjoy the weather for a while
				BlowoutStep = 1
				NextAction = CTm + 6
			elseif BlowoutStep == 1 then	--Wake the safe players up
				BlowoutStep = 2
				NextAction = CTm + 4

				for k, v in pairs(player.GetAll()) do
					if v.IsSafe == true then
						umsg.Start("BlowoutVar", v)
						umsg.Char( 51 )
						umsg.End()
					end
				end
			elseif BlowoutStep == 2 then	--Reset the safe players
				BlowoutReset(0,1,0)
				BlowoutStep = 3
				NextAction = CTm + 2

				for k, v in pairs(player.GetAll()) do
					if v.IsSafe == true then
						v:Freeze( false )
						v:SetNoTarget( false )
						v.IsSafe = nil
						v:SelectWeapon(v.LastWep)
						v:StripWeapon("weapon_blowout_unarmed")

						umsg.Start("BlowoutVar", v)
						umsg.Char( 104 )
						umsg.End()
					end
				end
			elseif BlowoutStep == 3 then	--Wake the exposed players up
				BlowoutStep = 4
				NextAction = CTm + 8

				for k, v in pairs(player.GetAll()) do
					if v.IsSafe == false then
						umsg.Start("BlowoutVar", v)
						umsg.Char( 50 )
						umsg.End()
					end
				end
			elseif BlowoutStep == 4 then	--Make sure everyone is up by now and reactivate NPCs
				BlowoutStep = 5

				for k, v in pairs(player.GetAll()) do
					BlowoutUnragdoll( v )
					v:SetNoTarget( false )
					v.IsSafe = nil
					umsg.Start("BlowoutVar", v)
					umsg.Char( 110 )
					umsg.Short( 0 )
					umsg.Long( math.Round(DamageTime) )
					umsg.End()
				end
			elseif CTm > DamageTime then
				BlowoutReset(1,0,1)
				BlowoutStep = 0
				BlowoutStarted = false
				BlowoutHasHit = false
				BlowoutHitTime = 0
				NextAmbientSound = 0

				local Next = math.max(BlowoutInterval:GetInt(), 60)
				AnnounceTime = CTm + Next
				print("[Blowout] The blowout sequence has ended! Next blowout starts in "..math.Round(Next).." seconds. ("..math.Round(CTm)..")")
			end
		end

	elseif BlowoutStarted then		--If the blowout has been triggered (warm-up phase completed)
		NextThink = CTm + 0.25

		local TimeBeforeHit = BlowoutHitTime - CTm
		if TimeBeforeHit <= 0 then	--Knock the players out
			BlowoutStep = 0
			NextAction = CTm + 1
			local Time = 21 + math.max(DamageDuration:GetInt(), 1)
			DamageTime = CTm + Time
			BlowoutHasHit = true
			CleanAnomalies()
			ix.plugin.list["anomalycontroller"]:spawnAnomalies()
			print("The blowout has hit! Exposed E2s are disabled for "..Time.." seconds. ("..math.Round(CTm)..")")

			for k, v in pairs(player.GetAll()) do

                if !BadMoveTypes[v:GetMoveType()] and v:Health() > 0 then
					if IsValid(v:GetActiveWeapon()) then v.LastWep = v:GetActiveWeapon():GetClass() end

					v:SetNoTarget( true )	--Make the AI ignore players at this point
					umsg.Start("BlowoutVar", v)

					local Pos = v:GetShootPos()	--Check if the player is a safe spot
					v.IsSafe = BlowoutIsSafe(Pos)

					if v.IsSafe then	--Player is safe
//						v:Freeze( true )
//						v:Give("weapon_blowout_unarmed")
//						v:SelectWeapon("weapon_blowout_unarmed")
//						umsg.Char( 103 )

					else	--Player is not safe
						if v:InVehicle() then v:ExitVehicle() end

/*						local Ragdoll = ents.Create( "prop_ragdoll" )
						Ragdoll:SetModel( v:GetModel() )
						Ragdoll:SetPos( v:GetPos() )
						Ragdoll:SetAngles( Angle(0,v:GetAngles().y,0) )
						Ragdoll:Spawn()*/

						local PlySpeed = v:GetVelocity()
						local Mul = 100
						local AngVel = Vector(math.Rand(-Mul,Mul), math.Rand(-Mul,Mul), math.Rand(-Mul,Mul))
/*						local Count = Ragdoll:GetPhysicsObjectCount()
						for i = 1, Count do
							local Bone = Ragdoll:GetPhysicsObjectNum( i )
							if IsValid(Bone) then
								local Mass = Bone:GetMass()
								Bone:SetVelocity( PlySpeed )
								Bone:AddAngleVelocity( AngVel * Mass )
							end
						end*/

						local Weps = {}
						local Ammo = {}

						for wepID, wep in pairs(v:GetWeapons()) do
							Weps[wep:GetClass()] = wep:Clip1()

							local Type1 = wep:GetPrimaryAmmoType()
							if Type1 != "" then Ammo[Type1] = v:GetAmmoCount(Type1) end

							local Type2 = wep:GetSecondaryAmmoType()
							if Type2 != "" then Ammo[Type2] = v:GetAmmoCount(Type2) end
						end

						v.Weps = Weps
						v.Ammo = Ammo

						v:StripWeapons()
						v:SpectateEntity( Ragdoll )
						v:Spectate( 5 )
						v:SetNWEntity( "BlowoutRag", Ragdoll )
						v.BlowoutRagdoll = Ragdoll
						v:Lock()

						v.LastHealth = v:Kill()
						v.LastArmour = v:Armor()
						umsg.Char( 102 )
					end

					umsg.End()
				end
			end
			
			local NPCs = ents.FindByClass( "npc_*" )
			for k, v in pairs(NPCs) do	--Kill a set list of NPCs for further immersion
				if IsValid(v) then
					local Class = v:GetClass()

					if Class == "npc_combinegunship" or Class == "npc_turret_floor" then
						v:Fire( "selfdestruct", "", math.Rand(0,2) )
					elseif Class == "npc_rollermine" then
						v:Fire( "interactivepowerdown", "", math.Rand(0,2) )
					elseif Class == "npc_combinedropship" or Class == "npc_turret_ceiling" or Class == "npc_combine_camera" then
						v:Remove()
					else
						local Pos = v:GetPos()	--Check if the NPC is a safe spot
						if BlowoutIsSafe(Pos) then
							v:SetKeyValue( "sleepstate", "3" )	--Dirty way of telling the AI to stop whatever it's doing (also, ai_disabled would print a message in chat)
						else
							v:Fire( "sethealth", "0", math.Rand(0,2) )
						end
					end
				end
			end

			local E2s = ents.FindByClass( "gmod_wire_expression2" )		--Disable all exposed E2s (EMP, anyone?)
			for k, v in pairs(E2s) do
				local Pos = v:GetPos()	--Check if the E2 is a safe spot
				if BlowoutIsSafe(Pos) then
					v.ExcludedFromBlowout = true
				else
					v.DisabledByBlowout = true
					v.error = true
				end
			end
			timer.Simple( 1, function() BlowoutDisableE2s() end )

		elseif TimeBeforeHit <= 0.75 then	--Play the final blowout sound before knocking everyone out
			if BlowoutStep == 1 then
				BlowoutStep = 2
				BlowoutSound( "end" )
			end
		elseif TimeBeforeHit < 16 then		--Play the background sound
			if BlowoutStep == 0 then
				BlowoutStep = 1
				BlowoutSound( "buildup" )
			end
		end

		if CTm > NextSound then		--Play the thunder sounds
			NextSound = CTm + math.Rand(0.75,4)
			BlowoutSound( "hit" )

			local e=ents.Create("env_shake")	--Shake the world a little
			e:SetKeyValue( "amplitude", "3")
			e:SetKeyValue("frequency","100.0")
			e:SetKeyValue("duration","10")
			e:SetKeyValue("spawnflags", "5")
			e:Fire("startshake")
		end

	elseif CTm > AnnounceTime then		--If a blowout has been announced
		NextThink = CTm + 1
		local Duration = math.max(AnnounceDuration:GetInt(), 15)
		local TimeBeforeStart = AnnounceTime - CTm + Duration

		if TimeBeforeStart < 10 then	--Prevent any further announcing sounds from playing
			if TimeBeforeStart < 6 and BlowoutStep < 3 then	--Play the prehit sound
				BlowoutStep = 3
				BlowoutSound( "prehit" )
			elseif TimeBeforeStart <= 0 then	--Start the blowout
				BlowoutStarted = true
				NextSound = CTm + math.Rand(2,3.5)
				BlowoutHitTime = CTm + 18		--This is when the blowout hits
				BlowoutStep = 0
				BlowoutSound( "start" )
				print("[Blowout] The blowout sequence has begun! ("..math.Round(CTm)..")")

				local e=ents.Create("env_shake")	--Shake the world a little
				e:SetKeyValue( "amplitude", "1")
				e:SetKeyValue("frequency","100.0")
				e:SetKeyValue("duration","10")
				e:SetKeyValue("spawnflags", "5")
				e:Fire("startshake")
			end

		elseif CTm > NextSound then
			if BlowoutStep == 0 then	--Initialise the announcing phase
				BlowoutStep = 1
				BlowoutHit = 0
				StartTime = CTm + Duration + 1
				print("[Blowout] Announcing a blowout! Starting in "..Duration.." seconds. ("..math.Round(CTm)..")")

				local NewCTm = math.Round(CTm)
				for k, v in pairs(player.GetAll()) do
					umsg.Start("BlowoutVar", v)
					umsg.Char( 101 )
					umsg.Short( Duration + 1)
					umsg.Long( NewCTm )
					umsg.End()
				end
			elseif BlowoutStep == 1 then
				BlowoutStep = 2
				BlowoutSound( "announce1" )
				NextSound = CTm + math.random(11,14)
			else
				BlowoutStep = 1
				BlowoutSound( "announce2" )
				NextSound = CTm + math.random(60,90)
			end
		end

		if NextAmbientSound == 0 then
			NextAmbientSound = CTm + 5
		elseif CTm > NextAmbientSound then
			NextAmbientSound = CTm + math.random(15,20)
			BlowoutSound( "ambient" )
		end
	end
end





local function BlowoutCanSuicide( ply )
	if (BlowoutHasHit and BlowoutStep < 5) or ply.IsSafe != nil then return false end
end





local function BlowoutPlayerDamage( ent, dmginfo )
	if !IsValid(ent) or !ent:IsPlayer() then return end

	if ent.IsSafe != nil then
		dmginfo:ScaleDamage( 0 )
	end
end





local function BlowoutPlayerSpawn( ply )
	if BlowoutEnabled:GetInt() <= 0 then return end

	local CTm = CurTime()
	local Diff = CTm - AnnounceTime

	if Diff > 0 and CTm < BlowoutHitTime then
		ply:UnLock()

		umsg.Start("BlowoutVar", v)

/*		if BlowoutHasHit == true then
			ply:Lock()

			if BlowoutStep < 4 then		--Players are knocked out
				umsg.Char( 102 )
			elseif BlowoutStep == 4	then	--Players are waking up
				umsg.Char( 103 )
			end
		elseif BlowoutStarted then	--Blowout has started
			umsg.Char( 20 )
			umsg.Short( math.Round(CTm - BlowoutHitTime + 18) )
		else					--Blowout is announced
			umsg.Char( 101 )
			umsg.Short( math.Round(math.max(AnnounceDuration:GetInt(), 15) + 1) )
			umsg.Long( math.Round(CTm - Diff))
		end*/

		umsg.End()
	end
end





local function BlowoutTriggerInstant( ply, cmd, args )
	if IsValid(ply) and !ply:IsAdmin() then
		ply:ChatPrint("Not an admin.")
		return
	end


	if BlowoutEnabled:GetInt() <= 0 then
		if IsValid(ply) then
			ply:ChatPrint("Blowout addon is currently disabled, use 'blowout_enabled' to enable it first.")
		else
			print("[Blowout] Addon is currently disabled, use 'blowout_enabled' to enable it first.")
		end
		return
	end


	if CurTime() > AnnounceTime or BlowoutStarted then
		if IsValid(ply) then
			--ply:ChatPrint("A blowout sequence is still active! Wait for it to finish first.")
		else
			print("[Blowout] A blowout sequence is still active! Wait for it to finish first.")	
		end
		return
	end


	if IsValid(ply) then
		--ply:ChatPrint("You triggered an instant blowout sequence!")
	else
		print("[Blowout] Starting blowout sequence!")	
	end

	AnnounceTime = CurTime() - math.max(AnnounceDuration:GetInt(), 15) + 7
end





local function BlowoutTriggerDelayed( ply, cmd, args )
	if IsValid(ply) and !ply:IsAdmin() then
		ply:ChatPrint("Not an admin.")
		return
	end

	if BlowoutEnabled:GetInt() <= 0 then
		if IsValid(ply) then
			ply:ChatPrint("Blowout addon is currently disabled, use 'blowout_enabled' to enable it first.")
		else
			print("[Blowout] Addon is currently disabled, use 'blowout_enabled' to enable it first.")	
		end
		return
	end


	if CurTime() > AnnounceTime or BlowoutStarted then
		if IsValid(ply) then
			--ply:ChatPrint("A blowout sequence is still active! Wait for it to finish first.")
		else
			print("[Blowout] A blowout sequence is still active! Wait for it to finish first.")	
		end
		return
	end

	if IsValid(ply) then
		--ply:ChatPrint("You triggered a delayed blowout sequence!")
	end

	AnnounceTime = CurTime()
end





local function BlowoutNPCSpawned( ent )
	
	if !IsValid(ent) or !ent:IsNPC() then return end

	if BlowoutHasHit == true and BlowoutStep <= 2 then
		ent:Remove()
	end

end




concommand.Add("blowout_trigger_delayed", BlowoutTriggerDelayed)
concommand.Add("blowout_trigger_instant", BlowoutTriggerInstant)

BlowoutReset(1,1,1)
print("[Blowout] Serverside file loaded! ("..math.Round(CTm)..")")

hook.Add("Think", "BlowoutThink", BlowoutThink)
hook.Add("CanPlayerSuicide", "BlowoutCanSuicide", BlowoutCanSuicide)
hook.Add("PlayerSpawn", "BlowoutPlayerSpawn", BlowoutPlayerSpawn)
hook.Add("PlayerInitialSpawn", "BlowoutPlayerSpawn", BlowoutPlayerSpawn)
hook.Add("OnEntityCreated", "BlowoutDisableAI", BlowoutNPCSpawned)
hook.Add("EntityTakeDamage", "BlowoutPlayerDamage", BlowoutPlayerDamage)