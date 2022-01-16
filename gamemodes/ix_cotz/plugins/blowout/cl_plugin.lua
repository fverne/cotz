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
do
for i=1, #SoundNames do	--Registering custom sound scripts - probably the best way of playing multiple world-sounds on the client...
	sound.Add( {
		name = SoundNames[i],
		channel = CHAN_STATIC,
		level = 0,
		sound = SoundPaths[i]
	} )
end

for k,v in pairs(SoundPaths) do
	util.PrecacheSound(v)
end
end

-- ALL CLIENTSIDE
ix.blowout = ix.blowout or {}
ix.blowout.Flash = 0
ix.blowout.StartTime = 0
ix.blowout.Duration = 0
ix.blowout.BlowoutPhase = 0
ix.blowout.LastContrast = 0
ix.blowout.BlowoutSounds = {}
ix.blowout.BlowoutSounds[1] = ""
ix.blowout.BlowoutSounds[2] = "blowout_announce2"
ix.blowout.BlowoutSounds[3] = "blowout_prehit"
ix.blowout.BlowoutSounds[4] = "blowout_ambient1"
ix.blowout.BlowoutSounds[5] = "blowout_ambient2"
ix.blowout.BlowoutSounds[6] = "blowout_ambient3"
ix.blowout.BlowoutSounds[7] = "blowout_ambient4"
ix.blowout.BlowoutSounds[8] = "blowout_ambient5"
ix.blowout.BlowoutSounds[9] = "blowout_start"
ix.blowout.BlowoutSounds[10] = "blowout_buildup"
ix.blowout.BlowoutSounds[11] = "blowout_hit1"
ix.blowout.BlowoutSounds[12] = "blowout_hit2"
ix.blowout.BlowoutSounds[13] = "blowout_hit3"
ix.blowout.BlowoutSounds[14] = "blowout_end"
ix.blowout.BlowoutSounds[15] = ""
ix.blowout.BlowoutSounds[16] = ""

net.Receive("BlowoutPlaySound", function()
	local sndtoplay = net.ReadUInt(8)

	local File = ix.blowout.BlowoutSounds[sndtoplay] or ""	--Play the sound
	if (File != "") then
		LocalPlayer():EmitSound(File, 500, 100)
	end

	if sndtoplay >= 11 and sndtoplay <= 13 then
		ix.blowout.Flash = CurTime()
	end
end)

net.Receive("BlowoutChangePhase", function()
	local phasechange = net.ReadUInt(8)
	local duration    = net.ReadFloat()

	ix.blowout.BlowoutPhase = phasechange
	ix.blowout.StartTime = CurTime()
	ix.blowout.Duration = duration

	if phasechange == 5 then
		ix.blowout.StartTime = duration -- ???????? for what purpose
		ix.blowout.Duration = math.max(ix.blowout.StartTime - CurTime(), 0.01)
	end
end)


local function BlowoutPostProcess()
	if ix.blowout.BlowoutPhase <= 0 then return end
	local CTm = CurTime()
	local tab = {}

	if ix.blowout.BlowoutPhase == 1 then
		local Var = math.min((CTm - ix.blowout.StartTime) / ix.blowout.Duration, 1)

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -Var * 0.1
		tab[ "$pp_colour_contrast" ] = 1 - Var * 0.2
		tab[ "$pp_colour_colour" ] = 1 - Var * 0.5
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0

	elseif ix.blowout.BlowoutPhase == 2 then --Flashing right before hit, old phase 3
		local Var = math.min((CTm - ix.blowout.StartTime) / 15,1)
		local Var2 = Var ^ 2
		local FlashVar = math.max(1.5 - (CTm - ix.blowout.Flash),0) / 3

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
	elseif ix.blowout.BlowoutPhase == 3 then -- Knockout once the blowout hits, old phase 6
		local Var = math.min((CTm - ix.blowout.StartTime) / 1.8,1)
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

	elseif ix.blowout.BlowoutPhase == 4 then -- Waking up after blowout, old phase 7
		local Var = math.min((CTm - ix.blowout.StartTime) / ix.blowout.Duration,1)
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
	elseif ix.blowout.BlowoutPhase == 5 then -- Clearing up after blowout, old phase 2
		local Var = math.max( math.min((ix.blowout.StartTime - CTm) / ix.blowout.Duration, 1), 0)

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -Var * 0.1
		tab[ "$pp_colour_contrast" ] = 1 - Var * 0.2
		tab[ "$pp_colour_colour" ] = 1 - Var * 0.5
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
	end

    DrawColorModify( tab )
end

hook.Add("RenderScreenspaceEffects", "BlowoutPostProcess", BlowoutPostProcess)
