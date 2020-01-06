local att = {}
att.name = "kk_ins2_gl_m320"
att.displayNameShort = "M320"
att.displayName = "M320"
att.isGrenadeLauncher = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	DrawSpeedMult = -0.2,
	HolsterSpeedMult = -0.2,
	// OverallMouseSensMult = -0.2,
	RecoilMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE}
	}

	local down = Vector(0,0,10)

	function att:elementRender()
		if not self.AttachmentModelsVM then return end
		if not self.AttachmentModelsVM[att.name] then return end

		local ent = self.AttachmentModelsVM[att.name].ent

		if !IsValid(ent) then return end

		// grenade skin
		if self.Grenade40MM == 2 then
			ent:SetSkin(1)
		else
			ent:SetSkin(0)
		end
	end
end

-- function att:attachFunc()
-- end

function att:detachFunc()
	self.dt.INS2GLActive = false
end

CustomizableWeaponry:registerAttachment(att)
