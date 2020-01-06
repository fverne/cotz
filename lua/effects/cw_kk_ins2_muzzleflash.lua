AddCSLuaFile()

function EFFECT:Init(fx)
	local wep = fx:GetEntity()

	if not IsValid(wep) then
		return
	end

	if not IsValid(wep.Owner) then
		return
	end

	if not wep.Owner:ShouldDrawLocalPlayer() and wep.Owner == LocalPlayer() then
		return
	end

	local ent = wep:getMuzzleModel()

	if not IsValid(ent) then
		return
	end

	-- particleEffect = wep:getFireParticles()
	local particleEffect = wep.dt.Suppressed and wep.MuzzleEffectSupp or (wep.MuzzleEffectWorld or wep.MuzzleEffect)

	local att = ent:GetAttachment(wep.WorldMuzzleAttachmentID)

	if particleEffect and att then
		ParticleEffectAttach(particleEffect, PATTACH_POINT_FOLLOW, ent, wep.WorldMuzzleAttachmentID)

		if not wep.dt.Suppressed then
			local dlight = DynamicLight(self:EntIndex())

			dlight.r = 255
			dlight.g = 218
			dlight.b = 74
			dlight.Brightness = 4
			dlight.Pos = att.Pos
			dlight.Size = 96
			dlight.Decay = 128
			dlight.DieTime = CurTime() + FrameTime()
		end
	end

	if wep.RearEffectw then	// RPGs
		local att = ent:GetAttachment(2)

		if att then
			-- ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, ent, 2)
			-- ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, ent, 2)
			ParticleEffectAttach(particleEffect, PATTACH_POINT_FOLLOW, ent, 2)

			local dlight = DynamicLight(self:EntIndex())

			dlight.r = 255
			dlight.g = 218
			dlight.b = 74
			dlight.Brightness = 4
			dlight.Pos = att.Pos
			dlight.Size = 128
			dlight.Decay = 128
			dlight.DieTime = CurTime() + FrameTime()
		end
	end

	if wep.NoShells then
		return
	end

	if wep.ShellDelay then
		timer.Simple(wep.ShellDelay, function()
			if IsValid(wep) then
				wep:shellEvent()
			end
		end)
	else
		wep:shellEvent()
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
