local origInflictor, origAttacker

//-----------------------------------------------------------------------------
// remove this madness VV
//-----------------------------------------------------------------------------

local isProjectile = {
	-- cw_kk_ins2_projectile_at4 = true, // these no longer use env_explosion
	-- cw_kk_ins2_projectile_m6a1 = true,
	-- cw_kk_ins2_projectile_pf60 = true,
	-- cw_kk_ins2_projectile_rpg = true,
	-- cw_kk_ins2_projectile_rpg_2 = true,
	cw_kk_css_projectile_m72 = true,
}

local function takeDmg(ent, d)
	origInflictor = d:GetInflictor()

	if IsValid(origInflictor) then
		if origInflictor:GetClass() == "env_explosion" then
			if IsValid(origInflictor.CW_KK_INS2_inflictor) then
				d:SetInflictor(origInflictor.CW_KK_INS2_inflictor)
			end
		end
	end

	origAttacker = d:GetAttacker()

	if IsValid(origAttacker) then
		if isProjectile[origAttacker:GetClass()] then
			if IsValid(origAttacker:GetOwner()) then
				d:SetAttacker(origAttacker:GetOwner())
				d:SetInflictor(origAttacker)
			end
		end
	end
end

hook.Add("EntityTakeDamage", "CW_KK_INS2_RPGS", takeDmg)

//-----------------------------------------------------------------------------
// remove this madness ^^
//-----------------------------------------------------------------------------

local choppa = {
	npc_helicopter = true,
	npc_combinedropship = true,
	npc_combinegunship = true,
}

local rackit = {
	cw_kk_ins2_projectile_at4 = 1,
	cw_kk_ins2_projectile_m6a1 = 2,
	cw_kk_ins2_projectile_pf60 = 3,
	cw_kk_ins2_projectile_piat = 2,
	cw_kk_ins2_projectile_rpg = 1,
	cw_kk_ins2_projectile_shrek = 2,
}

local hitChoppas = {}

local isProjectile = {
	cw_kk_ins2_projectile_anm14 = true,
	cw_kk_ins2_projectile_at4 = true,
	cw_kk_ins2_projectile_c4 = true,
	cw_kk_ins2_projectile_flare = true,
	cw_kk_ins2_projectile_frag = true,
	cw_kk_ins2_projectile_ied = true,
	cw_kk_ins2_projectile_m6a1 = true,
	cw_kk_ins2_projectile_m10 = true,
	cw_kk_ins2_projectile_m18 = true,
	cw_kk_ins2_projectile_m84 = true,
	cw_kk_ins2_projectile_molotov = true,
	cw_kk_ins2_projectile_molotov_doi = true,
	cw_kk_ins2_projectile_n69 = true,
	cw_kk_ins2_projectile_n76 = true,
	cw_kk_ins2_projectile_n77 = true,
	cw_kk_ins2_projectile_pf60 = true,
	cw_kk_ins2_projectile_piat = true,
	cw_kk_ins2_projectile_rpg = true,
	cw_kk_ins2_projectile_shrek = true,
	cw_kk_ins2_projectile_ww2_c4_de = true,
	cw_kk_ins2_projectile_ww2_c4_us = true,

	cw_40mm_explosive = true,
	cw_40mm_smoke = true,
}

local function takeDmg(ent, d)
	local origAttacker = d:GetAttacker()
	local origInflictor = d:GetInflictor()

	if !IsValid(origAttacker) or !IsValid(origInflictor) then
		return
	end

	local newAttacker = origInflictor._kkFixAttacker
	local newInflictor = origInflictor._kkFixInflictor

	if origInflictor:GetClass() == "entityflame" then
		newAttacker = ent.kkDOIFTAttacker or newAttacker
		newInflictor = ent.kkDOIFTInflictor or newInflictor
	end

	if isProjectile[origAttacker:GetClass()] then
		CustomizableWeaponry_KK.ins2._physDamageIcon =
			IsValid(CustomizableWeaponry_KK.ins2._physDamageIcon) and
			CustomizableWeaponry_KK.ins2._physDamageIcon or
			ents.Create("cw_kk_ins2_damage_phys")

		local physDamageIconEnt =
			IsValid(CustomizableWeaponry_KK.ins2._physDamageIcon) and
			CustomizableWeaponry_KK.ins2._physDamageIcon

		newAttacker = origAttacker.Owner or newAttacker
		newInflictor = physDamageIconEnt or newInflictor
	end

	d:SetAttacker(
		IsValid(newAttacker) and
		newAttacker or
		d:GetAttacker()
	)

	d:SetInflictor(
		IsValid(newInflictor) and
		newInflictor or
		d:GetInflictor()
	)

	local a, i, v = d:GetAttacker(), d:GetInflictor(), ent // util.BlastDMG would first have to pass choppas to this hook MWUHAHAHAHAHAHAHAHAHAHAAAAAAAAA

	if !IsValid(a) then return end
	if !IsValid(i) then return end
	if !IsValid(v) then return end

	if choppa[v:GetClass()] and rackit[i:GetClass()] then
		hitChoppas[v] = (hitChoppas[v] or 0) + 1

		if hitChoppas[v] >= rackit[i:GetClass()] then
			timer.Simple(1, function()
				if IsValid(v) then
					v:Fire("selfDestruct")
				end
			end)
		end
	end
end

hook.Add("EntityTakeDamage", "CW_KK_INS2_OTHER", takeDmg)
