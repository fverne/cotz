AddCSLuaFile()

local models = {
	["models/weapons/upgrades/a_optic_aimpoint.mdl"] = "models/weapons/upgrades/a_optic_aimp2x.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_l.mdl"] = "models/weapons/upgrades/a_optic_aimp2x_l.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_m.mdl"] = "models/weapons/upgrades/a_optic_aimp2x_m.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_l.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_l_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_m.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_m_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_xl.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l_2x.mdl",
	["primaryModel"] = "magnifModel",
}

local wmodels = {
	["models/weapons/upgrades/a_optic_aimpoint.mdl"] = "models/weapons/upgrades/w_magaim.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_l.mdl"] = "models/weapons/upgrades/w_magaim.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_m.mdl"] = "models/weapons/upgrades/w_magaim.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_l.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_m.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_xl.mdl"] = "magnifModel",
	["primaryModel"] = "magnifModel",
}

local att = {}
att.name = "kk_ins2_magnifier"
att.displayNameShort = "2x Zoom"
att.displayName = "2x Magnifier Scope"
att.aimPos = {"KKINS2MagnifierPos", "KKINS2MagnifierAng"}
att.isSecondarySight = true
att.AimViewModelFOV = 25

att.statModifiers = {
	// OverallMouseSensMult = -0.07
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides 2x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
	}

	-- local simpleTextureDefault = surface.GetTextureID("models/weapons/optics/4x_reticule")
	-- local simpleTextureXPS = surface.GetTextureID("models/weapons/attachments/cw_kk_ins2_cstm_eotechxps/4x_reticule")

	local simpleTextureDefault = surface.GetTextureID("models/weapons/optics/aimpoint_reticule_holo")
	local simpleTextureXPS = surface.GetTextureID("models/weapons/optics/eotech_reticule_holo")

	local simpleTextures = {
		["_default"] = {tex = simpleTextureDefault, offset = {0, 1}, size = {64, 64}},
		["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl"] = {tex = simpleTextureXPS, offset = {0, 1}, size = {128, 128}},
		["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l.mdl"] = {tex = simpleTextureXPS, offset = {0, 1}, size = {128, 128}},
		["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m.mdl"] = {tex = simpleTextureXPS, offset = {0, 1}, size = {128, 128}},
	}

	att.zoomTextures = {
		{tex = simpleTextureDefault, offset = {0, 1}, size = {128, 128}},
		{tex = surface.GetTextureID("models/weapons/attachments/cw_kk_ins2_shared/fake"), offset = {0, 1}},
	}

	att._rtFov = 18

	att.zoomDesired = 2

	function att:INS2_DrawRenderTarget()
		if not self.ActiveAttachments[att.name] then return end
		local currentPrimarySight = self:getPrimarySight()

		local rc
		if currentPrimarySight then
			rc = self:getSightColor(currentPrimarySight)
		else
			rc = {r = 0, g = 0, b = 0, a = 0}
		end

		local scopeEnt = self.AttachmentModelsVM[att.name].ent
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		local isAiming = self:isAiming()

		if self._KK_INS2_magnifierLastPrimary != currentPrimarySight then
			local velement = self.AttachmentModelsVM[currentPrimarySight]

			self:setElementActive(currentPrimarySight, false)
			magnifierModel = models[velement.model]
			scopeEnt:SetModel(magnifierModel)

			local rem = self.AttachmentModelsVM[att.name].stencilEnt
			self.AttachmentModelsVM[att.name].stencilEnt = nil
			SafeRemoveEntity(rem)

			for i,mat in pairs(scopeEnt:GetMaterials()) do
				if CustomizableWeaponry_KK.ins2.nodrawMat[mat] then
					scopeEnt:SetSubMaterial(i - 1, CustomizableWeaponry_KK.ins2.nodrawMatPath)
				else
					scopeEnt:SetSubMaterial(i - 1)
				end
			end

			att.zoomTextures[1] = simpleTextures[velement.model] or simpleTextures["_default"]
			self.ZoomTextures = att.zoomTextures
		end
		self._KK_INS2_magnifierLastPrimary = currentPrimarySight

		// magnifier velement stuff
		if isAiming then
			scopeEnt:SetSequence("4x_zoom")
		else
			scopeEnt:SetSequence("4x_idle")
		end

		CustomizableWeaponry_KK.ins2.rtSight:renderTarget(self, att)
	end

	function att:elementRender()
		CustomizableWeaponry_KK.ins2.rtSight:stencil(self, att)
	end
end

function att:attachFunc()
	if CLIENT then
		if not self._KK_INS2_RTF_original then
			self._KK_INS2_RTF_original = self.RenderTargetFunc or function() end
		end

		self.RenderTargetFunc = function()
			self:_KK_INS2_RTF_original()
			att.INS2_DrawRenderTarget(self)
		end

		local currentPrimarySight = self:getPrimarySight()

		if currentPrimarySight and self.AttachmentModelsVM and self.AttachmentModelsVM[att.name] and self.AttachmentModelsVM[att.name].ent then
			magnifierModel = models[self.AttachmentModelsVM[currentPrimarySight].model]
			if magnifierModel then
				self.AttachmentModelsVM[att.name].ent:SetModel(magnifierModel)

				local rem = self.AttachmentModelsVM[att.name].stencilEnt
				self.AttachmentModelsVM[att.name].stencilEnt = nil
				SafeRemoveEntity(rem)

				if self.AttachmentModelsVM[currentPrimarySight] then
					self:setElementActive(currentPrimarySight, false)
				end
			end
		end
	end

	self.SimpleTelescopicsFOV = 70
	self.BlurOnAim = true
end

function att:detachFunc()
	if CLIENT then
		self.RenderTargetFunc = self._KK_INS2_RTF_original

		local currentPrimarySight = self:getPrimarySight()

		if currentPrimarySight and self.AttachmentModelsVM and self.AttachmentModelsVM[currentPrimarySight] then
			self:setElementActive(currentPrimarySight, true)
		end
	end

	self.SimpleTelescopicsFOV = nil
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)
