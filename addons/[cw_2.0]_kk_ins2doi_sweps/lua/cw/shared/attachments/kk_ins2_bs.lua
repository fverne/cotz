
CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_OTHER = "KK_BS"
CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_OTHER] = {
	[1] = {name = "kk_bs_wear",		display = "Wear",			color = Color(255,0,0,255)},
	[2] = {name = "kk_bs_sleew",	display = "Wear+Sleeve",	color = Color(0,255,0,255)},
	[3] = {name = "kk_bs_sleev",	display = "Sleeve",			color = Color(0,0,255,255)},
}

CustomizableWeaponry.colorableParts.colorText[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_OTHER] = " (HOLD - cycle styles)"
CustomizableWeaponry.colorableParts.defaultColors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_OTHER] = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_OTHER][1]

for k,v in pairs(CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_OTHER]) do
	v.color.kki = k
end

local att = {}

att.name = "kk_ins2_bs"
att.displayNameShort = "85"
att.displayName = "C05M371X"
att.isBG = true

att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_OTHER

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/kk_dogg")
	att.reticle = "cw2/reticles/aim_reticule"
	att.description = {
		[1] = {t = "Changes skin and/or adds camo sleeve.", c = CustomizableWeaponry.textColors.NEUTRAL},
		[2] = {t = "^^ Only where and when applicable.", c = CustomizableWeaponry.textColors.NEUTRAL},
	}

	function att:setSleeve(val)
		self:setElementActive("sleeve", val)
	end

	local lastStyle

	function att:elementRender()
		if not self.ActiveAttachments[att.name] then
			return
		end

		local style = self:getSightColor(att.name).kki

		if style == lastStyle then
			return
		end

		lastStyle = style

		if style == 1 then
			self:setSkin(1)
			att.setSleeve(self, false)
		elseif style == 2 then
			self:setSkin(1)
			att.setSleeve(self, true)
		elseif style == 3 then
			self:setSkin(0)
			att.setSleeve(self, true)
		end
	end

	function att:detachFunc()
		self:setSkin(0)
		att.setSleeve(self, false)
		lastStyle = nil
	end
end

CustomizableWeaponry:registerAttachment(att)
