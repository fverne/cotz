
CustomizableWeaponry_KK.ins2.welementThink = CustomizableWeaponry_KK.ins2.welementThink or {}
CustomizableWeaponry_KK.ins2.welementThink.IsValid = function() return true end

function CustomizableWeaponry_KK.ins2.welementThink:_addWeapon(wep)
	self._cache = self._cache or {}

	table.insert(self._cache, wep)
end

function CustomizableWeaponry_KK.ins2.welementThink:_processWeapon(wep)
	if not IsValid(wep) then
		return false
	end

	if wep.AttachmentModelsWM then
		for k,v in pairs(wep.AttachmentModelsWM) do
			local f = self._funcs[k]
			if f and v.active then
				f(wep, v.ent)
			end
		end
	end

	local f = self._funcs[wep:GetClass()]
	if f then
		f(wep, wep.WMEnt)
	end

	return true
end

function CustomizableWeaponry_KK.ins2.welementThink:think()
	if not self._cache then return end

	for k,wep in pairs(self._cache) do
		self._cache[k] = self:_processWeapon(wep) and wep or nil
	end
end

hook.Add("Think", CustomizableWeaponry_KK.ins2.welementThink, CustomizableWeaponry_KK.ins2.welementThink.think)

CustomizableWeaponry_KK.ins2.welementThink.templates = {
	bipod = function(wep, welement)
		welement:SetSequence(wep.dt.BipodDeployed and 1 or 0)
	end,

	launcher = function(wep, welement)
		welement:SetBodygroup(1, (wep:Clip1() == 1) and 0 or 1)
	end,

	grenade = function(wep, welement)
		welement:SetBodygroup(1, wep.dt.PinPulled and 0 or 1)
	end,

	rcex = function(wep, welement)
		welement:SetBodygroup(1, IsValid(wep.Owner) and 0 or 1)
	end,
}

local pwn

CustomizableWeaponry_KK.ins2.welementThink.templates.grenadewtrail = function(wep, welement)
	welement:SetBodygroup(1, wep.dt.PinPulled and 0 or 1)

	pwn = wep.Owner

	if IsValid(pwn) and pwn == LocalPlayer() and not pwn:ShouldDrawLocalPlayer() then
		welement:StopParticles()
		welement.particlesStarted = false
		return
	end

	if wep.dt.PinPulled then
		if not welement.particlesStarted then
			ParticleEffectAttach(wep.projectileTrailParticles, PATTACH_POINT_FOLLOW, welement, 1)
			welement.particlesStarted = true
		end
	else
		welement:StopParticles()
		welement.particlesStarted = false
	end
end

function CustomizableWeaponry_KK.ins2.welementThink:add(id, func)
	if not id then return end

	func = self.templates[func] or func // if template exists, use it

	self._funcs = self._funcs or {}
	self._funcs[id] = func // if nil is passed, remove existing
end

CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_rpg", "launcher")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_piat", "launcher")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_tankfist", "launcher")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_tankshrek", "launcher")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_zooka", "launcher")

CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_anm14", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_f1", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_m18", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_m67", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_m84", "grenade")
-- CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_m24", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_mk2", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_n36", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_n39", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_n69", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_n76", "grenade")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_n77", "grenade")

CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_molotov", "grenadewtrail")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_c4_de", "grenadewtrail")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_nade_c4_us", "grenadewtrail")

CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_c4", "rcex")
CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_ied", "rcex")

CustomizableWeaponry_KK.ins2.welementThink:add("kk_ins2_bipod", "bipod")

local att = {}
CustomizableWeaponry_KK.ins2.welementThink:add("kk_ins2_lam", function(wep, welement)
	if IsValid(welement) then
		att.Pos = welement:GetPos()
		att.Ang = welement:GetAngles()
		-- CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"]._elementRender(wep, att)
	end
end)
