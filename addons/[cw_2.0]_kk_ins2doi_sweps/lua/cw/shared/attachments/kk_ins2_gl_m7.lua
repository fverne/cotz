local att = {}
att.name = "kk_ins2_gl_m7"
att.displayNameShort = "GL"
att.displayName = "M7 Grenade Launcher"
att.isGrenadeLauncher = true
att.ww2GrenadeLauncher = true
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
		[1] = {t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE},
	}

	local nadeTypes = CustomizableWeaponry.grenadeTypes.registered

	-- function att:elementRender()
	-- end
end

local function resetGL(self)
	-- if CLIENT then
		-- self.CW_VM:SetModel(self.ViewModel)
		-- self._vmCamAttach = self.CW_VM:LookupAttachment("camera")
		-- self:buildBoneTable()
	-- end

	if self.M203Chamber then
		if SERVER then
			self.Owner:GiveAmmo(1, "40MM", true)
		end
		self.M203Chamber = false
	end

	self.dt.INS2GLActive = false
end

function att:attachFunc()
	-- if CLIENT then
		-- self.ViewModel = "models/weapons/v_cw_kk_doi_enfield.mdl"
	-- end

	resetGL(self)
end

function att:detachFunc()
	-- if CLIENT then
		-- self.ViewModel = "models/weapons/v_springfield.mdl"
	-- end

	resetGL(self)
end

CustomizableWeaponry:registerAttachment(att)
