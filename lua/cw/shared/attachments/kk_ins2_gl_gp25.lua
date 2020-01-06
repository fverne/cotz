local att = {}
att.name = "kk_ins2_gl_gp25"
att.displayNameShort = "GP35"
att.displayName = "GP35"
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
		[1] = {t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE},
		-- [2] = {t = "And other bullshit.", c = CustomizableWeaponry.textColors.POSITIVE}
	}

	local v0 = Vector(0.01, 0.01, 0.01)
	local v1 = Vector(1, 1, 1)

	local nadeTypes = CustomizableWeaponry.grenadeTypes.registered

	-- att.AttachmentModelsVM = {
		-- ["40mm_kk_1337"] = {model = "models/weapons/w_at4_projectile.mdl", bone = "GL_Round", pos = Vector(1.75,0,0), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85),
			-- active = function(self)
				-- local correctAmmo = nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_1337"
				-- local nadeVisible = self.AttachmentModelsVM.kk_ins2_gl_gp25.active and self.M203Chamber or (self.Sequence == self.Animations.gl_on_reload and self.CW_VM:GetCycle() > 0.2)
				-- return correctAmmo and nadeVisible
			-- end
		-- },
		-- ["40mm_kk_1338"] = {model = "models/weapons/w_cw_fraggrenade_thrown.mdl", bone = "GL_Round", pos = Vector(-0.267, 0.052, -0.015), angle = Angle(90, 0, 0), size = Vector(0.5, 0.5, 0.5),
			-- active = function(self)
				-- return nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_1338"
			-- end
		-- },
		-- ["40mm_kk_1339"] = {model = "models/weapons/w_magnade.mdl", bone = "GL_Round", pos = Vector(-1.18, 0, 0), angle = Angle(0, 90, 0), size = Vector(0.15, 0.15, 0.15),
			-- active = function(self)
				-- return nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_1339"
			-- end
		-- },
		-- ["40mm_kk_13399"] = { type = "Model", model = "models/effects/combineball.mdl", bone = "GL_Round", pos = Vector(-0.3, 0, 0), angle = Angle(), size = Vector(0.065, 0.065, 0.065),
			-- active = function(self)
				-- return nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_13399"
			-- end
		-- },
	-- }

	function att:elementRender()
		att.CW_VM = self.AttachmentModelsVM[att.name].ent

		if self.Grenade40MM > 2 then
			att.CW_VM:ManipulateBoneScale(att.CW_VM:LookupBone("GL_Round"), v0)
		else
			att.CW_VM:ManipulateBoneScale(att.CW_VM:LookupBone("GL_Round"), v1)
		end

		if self.Grenade40MM == 2 then
			att.CW_VM:SetSkin(1)
		else
			att.CW_VM:SetSkin(0)
		end
	end

	-- function att:IsValid() return true end
	-- function att:createManagedCModel(...)
		-- local ent = ClientsideModel(...)
		-- CustomizableWeaponry.cmodels:add(ent, self)
		-- return ent
	-- end

	-- function att:attachFunc()
		-- att.CW_VM = self.AttachmentModelsVM[att.name].ent
	-- end
end

function att:detachFunc()
	self.dt.INS2GLActive = false
end

CustomizableWeaponry:registerAttachment(att)
