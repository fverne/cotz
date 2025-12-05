local PLUGIN = PLUGIN
PLUGIN.name = "Arena"
PLUGIN.author = "cyanide"
PLUGIN.description = "Arena/Duelling system."

ix.config.Add("arenaEnabled", true, "If true, th arena system will be enabled.", nil, {
	category = "Arena"
})

PLUGIN.Arenas = {
	["rp_marsh_cs"] = {
		["swampsarena"] = {
			["active"] = false,
			["duration"] = 180,
			["announcer"] = Vector(-13379, -1855, 650),
			["players"] = {
				[1] = {
					["player"] = nil,
					["pos"] = Vector(-13367, -2665, 350),
					["ang"] = Angle(0, 90, 0),
				},
				[2] = {
					["player"] = nil,
					["pos"] = Vector(-13381, -1075, 350),
					["ang"] = Angle(0, -90, 0),
				},
			},
			["spectators"] = {},
			["dupes"] = {"swampsarena1"},
			["selected_dupe"] = 1,
			["ents"] = {
				[1] = {
					["class"] = "soundscape", -- 1st, 2nd, and 3rd indexes are reserved to function as a soundscape!
					["pos"] = Vector(-13039, -2284, 511),
					["ang"] = Angle(0, 0, 0),
					["model"] = "models/hunter/blocks/cube025x025x025.mdl",
					["soundscape"] = "cotz/arena/crowd_1.ogg",
					["duration"] = 13,
				},
				[2] = {
					["class"] = "soundscape",
					["pos"] = Vector(-13092, -1873, 575),
					["ang"] = Angle(0, 0, 0),
					["model"] = "models/hunter/blocks/cube025x025x025.mdl",
					["soundscape"] = "cotz/arena/crowd_2.ogg",
					["duration"] = 11,
				},
				[3] = {
					["class"] = "soundscape",
					["pos"] = Vector(-13058, -1486, 503),
					["ang"] = Angle(0, 0, 0),
					["model"] = "models/hunter/blocks/cube025x025x025.mdl",
					["soundscape"] = "cotz/arena/crowd_3.ogg",
					["duration"] = 8,
				},
				[4] = {
					["class"] = "base_anim",
					["pos"] = Vector(-13015, -1420, 550),
					["ang"] = Angle(0, -180, 0),
					["model"] = "models/monsters/duble.mdl",
					["sequence"] = "pose_standing_02"
				},
				[5] = {
					["class"] = "base_anim",
					["pos"] = Vector(-13015, -1650, 550),
					["ang"] = Angle(0, -180, 0),
					["model"] = "models/bandit/borov.mdl",
					["sequence"] = "bandit2_idle1"
				},
				[6] = {
					["class"] = "base_anim",
					["pos"] = Vector(-13015, -1750, 550),
					["ang"] = Angle(0, -180, 0),
					["model"] = "models/killer/gasmask.mdl",
					["sequence"] = "idle_suitcase"
				},
				[7] = {
					["class"] = "base_anim",
					["pos"] = Vector(-13015, -1925, 550),
					["ang"] = Angle(0, -180, 0),
					["model"] = "models/nasca/stalker/male_berill1.mdl",
					["sequence"] = "idle_all_scared"
				},
				[8] = {
					["class"] = "base_anim",
					["pos"] = Vector(-13015, -2090, 550),
					["ang"] = Angle(0, -180, 0),
					["model"] = "models/nasca/stalker/male_expedition.mdl",
					["sequence"] = "pose_standing_01"
				},
				[9] = {
					["class"] = "base_anim",
					["pos"] = Vector(-13015, -2265, 550),
					["ang"] = Angle(0, -180, 0),
					["model"] = "models/nasca/stalker/male_sunset_free.mdl",
					["sequence"] = "idle_all_angry"
				},
			} -- i could have just done this via advdupe lib but ah well
		}
	}
}

PLUGIN.Cutscenes = PLUGIN.Cutscenes or {}
PLUGIN.AnnouncerStation = nil

PLUGIN.Cutscenes.storedCallbacks = {
	["arenaintro"] = {
		["1"] = function()
			EmitSound("cotz/arena/crowd_wave_1.ogg", Vector(-13075, -2038, 611))
			EmitSound("cotz/arena/crowd_wave_2.ogg", Vector(-13086, -2304, 606))
			EmitSound("cotz/arena/crowd_wave_3.ogg", Vector(-13110, -1577, 590))

			sound.PlayFile("sound/cotz/arena/mega_arena_new_fight.ogg", "mono", function(station, errCode, errStr)
				if IsValid(station) then
					PLUGIN.AnnouncerStation = station
					PLUGIN.AnnouncerStation:Play()
				end
			end)
		end,
		["20"] = function()
			EmitSound("cotz/arena/crowd_1.ogg", Vector(-13075, -2038, 611))
		end,
		["40"] = function()
			EmitSound("cotz/arena/crowd_wave_1.ogg", Vector(-13075, -2038, 611))
			EmitSound("cotz/arena/crowd_wave_2.ogg", Vector(-13086, -2304, 606))
			EmitSound("cotz/arena/crowd_wave_3.ogg", Vector(-13110, -1577, 590))
			EmitSound("cotz/arena/crowd_2.ogg", Vector(-13075, -2038, 611))
		end,
		["60"] = function()
			EmitSound("cotz/arena/crowd_wave_1.ogg", Vector(-13075, -2038, 611))
			EmitSound("cotz/arena/crowd_wave_2.ogg", Vector(-13086, -2304, 606))
			EmitSound("cotz/arena/crowd_wave_3.ogg", Vector(-13110, -1577, 590))
		end,
		["70"] = function()
			EmitSound("cotz/arena/crowd_3.ogg", Vector(-13075, -2038, 611))
		end,
	},
	["arenaplayerone"] = {
		["1"] = function()
			if IsValid(PLUGIN.AnnouncerStation) then
				PLUGIN.AnnouncerStation:Stop()
				PLUGIN.AnnouncerStation = nil
			end

			LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 1)
		end,
		["13"] = function()
			surface.PlaySound("player/footsteps/concrete1.wav")
		end,
		["24"] = function()
			surface.PlaySound("player/footsteps/concrete2.wav")
		end,
		["42"] = function()
			surface.PlaySound("player/footsteps/concrete3.wav")
		end,
		["58"] = function()
			surface.PlaySound("player/footsteps/concrete2.wav")

			sound.PlayFile("sound/cotz/arena/mega_arena_start.ogg", "3d", function(station, errCode, errStr)
				if IsValid(station) then
					PLUGIN.AnnouncerStation = station
					PLUGIN.AnnouncerStation:Play()
					PLUGIN.AnnouncerStation:SetPos(PLUGIN.Arenas["rp_marsh_cs"]["swampsarena"]["announcer"])
					PLUGIN.AnnouncerStation:SetVolume(15)
				end
			end)
		end,
		["75"] = function()
			surface.PlaySound("player/footsteps/concrete1.wav")
		end,
		["88"] = function()
			surface.PlaySound("player/footsteps/concrete1.wav")
		end,
		["99"] = function()
			local wepTbl = ix.plugin.Get("wepselect"):GetWeaponTable(LocalPlayer():GetWeapons())
			local wepSelect = wepTbl[1] or wepTbl[2] or wepTbl[3]

			if wepSelect then
				input.SelectWeapon(wepSelect)
			end
		end,
	},
	["arenaplayertwo"] = {
		["13"] = function()
			surface.PlaySound("player/footsteps/concrete1.wav")
		end,
		["24"] = function()
			surface.PlaySound("player/footsteps/concrete2.wav")
		end,
		["42"] = function()
			surface.PlaySound("player/footsteps/concrete3.wav")
		end,
		["58"] = function()
			surface.PlaySound("player/footsteps/concrete2.wav")

			sound.PlayFile("sound/cotz/arena/mega_arena_start.ogg", "3d", function(station, errCode, errStr)
				if IsValid(station) then
					PLUGIN.AnnouncerStation = station
					PLUGIN.AnnouncerStation:Play()
					PLUGIN.AnnouncerStation:SetPos(PLUGIN.Arenas["rp_marsh_cs"]["swampsarena"]["announcer"])
					PLUGIN.AnnouncerStation:SetVolume(15)
				end
			end)
		end,
		["75"] = function()
			surface.PlaySound("player/footsteps/concrete1.wav")
		end,
		["88"] = function()
			surface.PlaySound("player/footsteps/concrete1.wav")
		end,
		["99"] = function()
			local wepTbl = ix.plugin.Get("wepselect"):GetWeaponTable(LocalPlayer():GetWeapons())
			local wepSelect = wepTbl[1] or wepTbl[2] or wepTbl[3]

			if wepSelect then
				input.SelectWeapon(wepSelect)
			end
		end,
	}
}

PLUGIN.Cutscenes.params = {
	["arenaintro"] = {
		no_headbob = true,
		drawplayer = true
	},
	["arenaplayerone"] = {
		updatepos = true,
		no_fade = true,
	},
	["arenaplayertwo"] = {
		updatepos = true,
		no_fade = true,
	}
}

local playerMeta = FindMetaTable("Player")

function playerMeta:GetCameraAttach()
	return self.Attached
end

local nerfPellets = {
	[".45 ACP -41-"] = true,
	["12 Gauge"] = true,
	["12 Gauge -DT-"] = true,
	["12 Gauge -MG-"] = true,
	["12 Gauge -SG-"] = true,
	["12 Gauge -TR-"] = true
}

function PLUGIN:EntityTakeDamage(target, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not (target:IsPlayer() and attacker:IsPlayer() and (target ~= attacker)) then return end
	if not (target:GetLocalVar("inArena", false) and attacker:GetLocalVar("inArena", false)) then return end
	local damage = dmginfo:GetDamage()
	local perRes = 1 - target:GetNWFloat("ixperbulletres")
	local flatRes = target:GetNWInt("ixflatbulletres")
	local weapon = attacker:GetActiveWeapon()
	local ammoName = game.GetAmmoName(weapon:GetPrimaryAmmoType())

	if nerfPellets[ammoName] then
		damage = damage * 0.5
	end

	if dmginfo:IsDamageType(DMG_BULLET) then
		damage = damage * math.pow(1 - perRes, 3)
		damage = damage - flatRes * 6
	elseif dmginfo:IsDamageType(DMG_AIRBOAT) then
		damage = damage * math.pow(1 - perRes, 3)
		damage = damage - flatRes * 2
	end

	damage = math.max(damage, 2)

	if IsValid(ix.temp.Corpses[target]) then
		damage = 0
	end

	dmginfo:SetDamage(damage)
end

-- same damage for all of the body
local hitgroupScales = {
	[HITGROUP_HEAD] = 0.5,
	[HITGROUP_CHEST] = 1,
	[HITGROUP_STOMACH] = 1,
	[HITGROUP_LEFTARM] = 4,
	[HITGROUP_RIGHTARM] = 4,
	[HITGROUP_LEFTLEG] = 4,
	[HITGROUP_RIGHTLEG] = 4,
	[HITGROUP_GEAR] = 1
}

function PLUGIN:ScalePlayerDamage(ply, hitgroup, dmginfo)
	if hitgroupScales[hitgroup] then
		dmginfo:ScaleDamage(hitgroupScales[hitgroup])
	else
		dmginfo:ScaleDamage(1)
	end
end

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")