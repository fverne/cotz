local att = {}
att.name = "kk_ins2_fl_kombo"
att.displayName = "Flashlight + Laser Combo"
att.displayNameShort = "LAM+LEM"

att.statModifiers = {
	VelocitySensitivityMult = -0.2,
	// OverallMouseSensMult = -0.2,
	HipSpreadMult = -0.2,
	DrawSpeedMult = -0.1,
	MaxSpreadIncMult = -0.25
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "[impulse 100] cycles through modes.", c = CustomizableWeaponry.textColors.REGULAR},
		[2] = {t = "Uses LAM/LEM colors.", c = CustomizableWeaponry.textColors.REGULAR},
	}

	local rgb = {"r","g","b","a"}

	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end

		local laserAtts, lightAtts = {}, {}
		local mode = self:GetNWInt("INS2LAMMode")
		local element = self.AttachmentModelsVM[att.name]

		if element then
			if IsValid(element.ent) then
				table.insert(laserAtts, element.ent:GetAttachment(element.laserAtt or 1))
				table.insert(lightAtts, element.ent:GetAttachment(element.lightAtt or 2))
			end

			if element.models then
				for _,element in pairs(element.models) do
					if IsValid(element.ent) then
						table.insert(laserAtts, element.ent:GetAttachment(element.laserAtt or 1) or nil)
						table.insert(lightAtts, element.ent:GetAttachment(element.lightAtt or 2) or nil)
					end
				end
			end
		else
			element = self.AttachmentModelsVM["kk_ins2_lam"]
			if element != nil and IsValid(element.ent) then
				table.insert(laserAtts, element.ent:GetAttachment(element.laserAtt or 1))
			end

			element = self.AttachmentModelsVM["kk_ins2_flashlight"]
			if element != nil and IsValid(element.ent) then
				table.insert(lightAtts, element.ent:GetAttachment(element.lightAtt or 1))
			end
		end

		if (mode % 2) == 1 then
			for _,laserAtt in pairs(laserAtts) do
				self.lastLaserPos = nil // TODO: fix/forget/w/e
				CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"]._elementRender(self, laserAtt)
			end
		else
			self.lastLaserPos = nil
		end

		for _,lightAtt in pairs(lightAtts) do
			CustomizableWeaponry_KK.ins2.flashlight.v6.elementRender(self, lightAtt)
		end
	end

	// for V6 LEM, true - ON, false - OFF
	function att:getLEMState()
		-- return (self.dt.INS2LAMMode > 1)
		return (self:GetNWInt("INS2LAMMode") > 1)
	end
end

function att:attachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v6.attach(self, att)

	if CLIENT then
		if not self.AttachmentModelsVM[att.name] then
			self.AttachmentModelsVM["kk_ins2_flashlight"].active = true
			self.AttachmentModelsVM["kk_ins2_lam"].active = true
		end
	end
end

function att:detachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v6.detach(self, att)

	if CLIENT then
		if not self.AttachmentModelsVM[att.name] then
			self.AttachmentModelsVM["kk_ins2_flashlight"].active = false
			self.AttachmentModelsVM["kk_ins2_lam"].active = false
		end
	end
end

CustomizableWeaponry:registerAttachment(att)
