if SERVER then return end		--GET OUT OF HERE IVAN




local SoundNames = {
	"blowout_announce1",
	"blowout_announce2",
	"blowout_prehit",
	"blowout_ambient1",
	"blowout_ambient2",
	"blowout_ambient3",
	"blowout_ambient4",
	"blowout_ambient5",
	"blowout_start",
	"blowout_buildup",
	"blowout_hit1",
	"blowout_hit2",
	"blowout_hit3",
	"blowout_end",
	"blowout_posthit"
}

local SoundPaths = {
	"hgn/stalker/blowout/barman2.mp3",
	"blowout/announce2.wav",
	"stalkersound/blowout_siren.wav",
	"blowout/ambient1.wav",
	"blowout/ambient2.wav",
	"blowout/ambient3.wav",
	"blowout/ambient4.wav",
	"blowout/ambient5.wav",
	"blowout/start.wav",
	"blowout/buildup.wav",
	"blowout/hit1.wav",
	"blowout/hit2.wav",
	"blowout/hit3.wav",
	"blowout/end.wav",
	"hgn/stalker/blowout/barman3.mp3"
}

for i=1, #SoundNames do	--Registering custom sound scripts - probably the best way of playing multiple world-sounds on the client...
	sound.Add( {
		name = SoundNames[i],
		channel = CHAN_STATIC,
		level = 0,
		sound = SoundPaths[i]
	} )
end

local BlowoutSounds = {}	--Assigning our sounds to the umsg chars
	BlowoutSounds[1] = "blowout_announce1"
	BlowoutSounds[2] = "blowout_announce2"
	BlowoutSounds[3] = "blowout_prehit"
	BlowoutSounds[10] = "blowout_ambient1"
	BlowoutSounds[11] = "blowout_ambient2"
	BlowoutSounds[12] = "blowout_ambient3"
	BlowoutSounds[13] = "blowout_ambient4"
	BlowoutSounds[14] = "blowout_ambient5"
	BlowoutSounds[20] = "blowout_start"
	BlowoutSounds[30] = "blowout_buildup"
	BlowoutSounds[31] = "blowout_hit1"
	BlowoutSounds[32] = "blowout_hit2"
	BlowoutSounds[33] = "blowout_hit3"
	BlowoutSounds[40] = "blowout_end"
	BlowoutSounds[50] = "blowout_posthit"
	BlowoutSounds[51] = "blowout_posthit"





for k,v in pairs(SoundPaths) do
	util.PrecacheSound(v)
end

local IsKnockedOut = false
local Flash = 0
local StartTime = 0
local Duration = 0
local BlowoutPhase = 0
local OverrideEyeAng = false
local LastEyePitch = 0
local LastEyeZ = 0
local LastContrast = 0
local LastPos = Vector()
local LastAng = Angle()
local DSP = 0
local AltDSP = {}
	AltDSP[0] = 0
	AltDSP[31] = 31
	AltDSP[32] = 33
	AltDSP[33] = 32
	AltDSP[35] = 36
	AltDSP[36] = 35
local FemaleModels = {}
	FemaleModels["models/player/mossman.mdl"] = true
	FemaleModels["models/player/mossman_arctic.mdl"] = true
	FemaleModels["models/player/alyx.mdl"] = true
	FemaleModels["models/player/chell.mdl"] = true
	FemaleModels["models/player/p2_chell.mdl"] = true





local function ChangeDSP( NewDSP, Repeat )
/*	DSP = AltDSP[NewDSP]

	LocalPlayer():SetDSP( DSP, false )

	if Repeat then
		timer.Create( "BlowoutDSP", 0.5, 1, function() ChangeDSP( DSP, true ) end )
	else
		timer.Remove( "BlowoutDSP" )
	end*/
end





local function DoPanicSound()
	local Model = string.lower(LocalPlayer():GetModel())

	if FemaleModels[Model] or string.find(Model, "female") then
		LocalPlayer():EmitSound( "blowout/panic_f.wav", 100, 100 )
	else
		LocalPlayer():EmitSound( "blowout/panic_m.wav", 100, 100 )
	end
end





local function ReadBlowoutData( Data )
	local Var = Data:ReadChar()
	local Short = Data:ReadShort() or 0

	if Var < 100 then	--It's a sound file
		if Var == 20 then	--Blowout is starting (this involves both a sound and post process effects)
			StartTime = CurTime() - Short
			Flash = StartTime
			BlowoutPhase = 3
		elseif Var >= 31 and Var <= 33 then
			Flash = CurTime()
		elseif Var == 50 then		--Waking up, ragdolled
			StartTime = CurTime()
			BlowoutPhase = 5
			ChangeDSP(32, false)
		elseif Var == 51 then		--Waking up, not ragdolled
			StartTime = CurTime()
			BlowoutPhase = 7
			Duration = 3.5
			ChangeDSP(31, false)
			timer.Simple(1.5, function() DoPanicSound() end )
		end

		local File = BlowoutSounds[Var] or ""	--Play the sound
		if File != "" and Short == 0 then
			LocalPlayer():EmitSound(File, 500, 100)
		end

	else		--It's a post process effect
		if Var == 100 then		--Reset the PostProcess effects
			IsKnockedOut = false
			OverrideEyeAng = false
			Flash = 0
			StartTime = 0
			BlowoutPhase = 0
			ChangeDSP(0, false)
		elseif Var == 101 then		--Blowout announced, start fading colours out
			StartTime = Data:ReadLong()
			BlowoutPhase = 1
			Duration = Short
		elseif Var == 102 then		--Getting knocked out, ragdolled
			IsKnockedOut = true
			chat.Close()
			StartTime = CurTime()
			BlowoutPhase = 4
			timer.Simple(0.5, function() ChangeDSP(32, true) end )
/*		elseif Var == 103 then		--Getting knocked out, not ragdolled
			IsKnockedOut = true
			OverrideEyeAng = true
			chat.Close()
			StartTime = CurTime()
			BlowoutPhase = 6
			LastEyePitch = LocalPlayer():EyeAngles().p
			LastEyeZ = LocalPlayer():GetShootPos().z - LocalPlayer():GetPos().z
			timer.Simple(0.5, function() ChangeDSP(35, true) end ) */
		elseif Var == 104 then		--Finish waking up, unragdolled
			IsKnockedOut = false
			OverrideEyeAng = false
			ChangeDSP(0, false)
		elseif Var == 110 then		--Post-blowout PostProcess, colours fade back in
			IsKnockedOut = false
			OverrideEyeAng = false
			StartTime = Data:ReadLong()
			Duration = math.max(StartTime - CurTime(), 0.01)
			BlowoutPhase = 2
			ChangeDSP(0, false)
		elseif Var == 120 then		--An E2 got disabled, play a sound and emit sparks from it
			local Ent = Entity(Short)
			if !IsValid(Ent) then return end

			local Pos = Ent:GetPos()
			local effect = EffectData()
			effect:SetStart( Pos )
			effect:SetOrigin( Pos )
			effect:SetMagnitude( 3 )
			effect:SetScale( 1 )
			effect:SetNormal( Ent:GetUp() )
			util.Effect( "sparks", effect )

			Ent:EmitSound( "ambient/energy/spark"..math.random(3,6)..".wav", 100, 100 )
		end	
	end
end





local function BlowoutCalcView( ply, origin, angles, fov )
	if BlowoutPhase < 3 and !OverrideEyeAng then return end

	local view = {}
	view.fov = fov

	if OverrideEyeAng then
		local TimeDiff = CurTime() - StartTime
		local Prog = 0

		--Calculate the camera animations
		if BlowoutPhase == 6 then 
			local AnimDuration = 1.3
			Prog = -math.cos(math.min(TimeDiff / AnimDuration,1) * math.pi) / 2 + 0.5
			local Prog2 = Prog ^ 2

			angles.pitch = LastEyePitch * (1 - Prog) + 75 * Prog
			angles.roll = Prog * 45
			LastAng = Angle(angles.pitch, angles.yaw, angles.roll)

			if LocalPlayer():InVehicle() then
				view.origin = origin
			else				
				view.origin = LocalPlayer():GetPos() + Vector(0,0,LastEyeZ * (1 - Prog2) + 30 * Prog2)
			end
			LastPos = view.origin
		elseif BlowoutPhase == 7 then
			Prog = 0.5 + math.cos(math.min(TimeDiff / Duration,1) * math.pi) / 2

			angles = LerpAngle(Prog, angles, LastAng)

			if LocalPlayer():InVehicle() then
				view.origin = origin
			else				
				view.origin = LerpVector(Prog, origin, LastPos)
			end
		end

		--Add some randomness
		angles.yaw = angles.yaw + TimedCos(0.66,-2,2,0) * Prog
		angles.pitch = angles.pitch + TimedCos(0.42,-3,3,0) * Prog
		view.origin = view.origin + (Vector(TimedCos(0.78,-1,1,0), TimedCos(0.62,-1,1,0), 0) + VectorRand() / 2) * Prog

	else
		local Ragdoll = ply:GetNWEntity( "BlowoutRag" )
		if !IsValid(Ragdoll) then return end

		local Head = Ragdoll:GetPhysicsObjectNum( 10 )	--Usually the head 
		if !IsValid(Head) then return end

		view.origin = util.LocalToWorld(Ragdoll, Vector(2,-3,0), 10)

		angles = Head:GetAngles()
		angles:RotateAroundAxis( angles:Forward(), -90)
		angles:RotateAroundAxis( angles:Right(), -90)
	end

	view.angles = angles

	return view
end





local function BlowoutPostProcess()
	if BlowoutPhase <= 0 then return end
	local CTm = CurTime()
	local tab = {}

	if BlowoutPhase <= 2 then
		local Var = 0
		if BlowoutPhase == 1 then Var = math.min((CTm - StartTime) / Duration, 1)
		else Var = math.max( math.min((StartTime - CTm) / Duration, 1), 0) end

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -Var * 0.1
		tab[ "$pp_colour_contrast" ] = 1 - Var * 0.1
		tab[ "$pp_colour_colour" ] = 1 - Var * 0.5
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0

	elseif BlowoutPhase == 3 then
		local Var = math.min((CTm - StartTime) / 15,1)
		local Var2 = Var ^ 2
		local FlashVar = math.max(1.5 - (CTm - Flash),0) / 3

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = -Var * 0.15
		tab[ "$pp_colour_addb" ] = -Var * 0.25
		tab[ "$pp_colour_brightness" ] = -0.15 - Var * 0.15 + FlashVar
		tab[ "$pp_colour_contrast" ] = 1.5 + Var2 * 2
		tab[ "$pp_colour_colour" ] = 0.3 - Var * 0.3
		tab[ "$pp_colour_mulr" ] = Var * 0.4
		tab[ "$pp_colour_mulg" ] = Var * 0.3
		tab[ "$pp_colour_mulb" ] = 0

		DrawBloom( 1 - Var / 1.5, 1 - Var / 1.5, 10, 10, 3, 1, 1, 1, 1)

	elseif BlowoutPhase == 4 then
		local Var = math.min(CTm - StartTime,1)

		tab[ "$pp_colour_addr" ] = 255
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = 2
		tab[ "$pp_colour_contrast" ] = 1 - Var
		tab[ "$pp_colour_colour" ] = 1
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0

	elseif BlowoutPhase == 5 then
		local Var = math.min((CTm - StartTime) / 6,1) ^ 2

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -0.1
		tab[ "$pp_colour_contrast" ] = Var * 0.9
		tab[ "$pp_colour_colour" ] = 0.5
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0

	elseif BlowoutPhase == 6 then
		local Var = math.min((CTm - StartTime) / 1.8,1)
		local Var2 = math.sin(Var * math.pi / 2)

		tab[ "$pp_colour_addr" ] = 0.5
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = 0.4 - Var * 0.5
		tab[ "$pp_colour_contrast" ] = 2.1 - Var2 * 2 - TimedCos(0.55,0,0.3,0)
		tab[ "$pp_colour_colour" ] = 1 - Var * 0.8
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0

	elseif BlowoutPhase == 7 then
		local Var = math.min((CTm - StartTime) / Duration,1)
		local Var2 = math.sin(Var * math.pi / 2)

		tab[ "$pp_colour_addr" ] = (1 - Var) ^ 2 * 0.5
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -0.1
		tab[ "$pp_colour_contrast" ] = 0.1 + 0.8 * Var - TimedCos(0.55,0,0.3,0) * (1 - Var ^ 2)
		tab[ "$pp_colour_colour" ] = 0.2 + Var * 0.3
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
	end

    DrawColorModify( tab )
end





local function BlowoutChat( isTeam )
	if IsKnockedOut then
		chat.Close()
		return true
	end
end





local function BlowoutVoiceChat( ply )
	if IsKnockedOut then
		return false
		
	end
end





local function BlowoutBindPress( ply, bind, pressed )
	if !IsKnockedOut then return end

	if bind == "invprev" or bind == "invnext" or string.sub(bind,1,4) == "slot" then
		return true
	end
end





print("[Blowout] Clientside file loaded!")

usermessage.Hook("BlowoutVar", ReadBlowoutData)

hook.Add("CalcView", "BlowoutFirstPersonView", BlowoutCalcView)
hook.Add("RenderScreenspaceEffects", "BlowoutDrawPP", BlowoutPostProcess)
hook.Add("StartChat", "BlowoutPreventChat", BlowoutChat)
hook.Add("PlayerStartVoice", "BlowoutPreventVoiceChat", BlowoutVoiceChat)
hook.Add("PlayerBindPress", "BlowoutBindPress", BlowoutBindPress)