
local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.quickKnife = CustomizableWeaponry_KK.ins2.quickKnife or {}
function CustomizableWeaponry_KK.ins2.quickKnife:IsValid() return true end

CustomizableWeaponry_KK.ins2.quickKnife.models = {}

CustomizableWeaponry_KK.ins2.quickKnife.models.gurkha = {
	vm = "models/weapons/v_gurkha.mdl",
	a_attack = "hitcenter3"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.bayonet = {
	vm = "models/weapons/v_marinebayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ninjato = {
	vm = "models/weapons/v_cw_kk_ins2_ninjato.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ww2de = {
	vm = "models/weapons/cw_kk_doi/v_k98kbayonet.mdl",
	a_attack = "slash_1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us = {
	vm = "models/weapons/cw_kk_doi/v_garand_bayonet.mdl",
	a_attack = "slash_1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ww2gb = {
	vm = "models/weapons/cw_kk_doi/v_enfield_bayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.b2kus = {
	vm = "models/weapons/cw_kk_doi/v_marinebayonet.mdl",
	a_attack = "slash_1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.b2keh = {
	vm = "models/weapons/v_nam_akbayonet.mdl",
	a_attack = "hitcenter3"
}

function CustomizableWeaponry_KK.ins2.quickKnife:canAttack(wep)
	self.restrictedStates = self.restrictedStates or {
		-- [CW_ACTION] = true, // it should work underwater and on ladders
		[CW_CUSTOMIZE] = true,
		[CW_KK_ACTION] = true,
		[CW_KK_QNADE] = true, // since we re ignoring CW_ACTION
		-- [CW_KK_QKNIFE] = true, // we re using wep.meleeAttackDelay
	}

	-- if CustomizableWeaponry.quickGrenade.restrictedStates[wep.dt.State] then
		-- return false
	-- end

	if wep.meleeAttackDelay and wep.meleeAttackDelay > CurTime() then
		return
	end

	if self.restrictedStates[wep.dt.State] then
		return false
	end

	if wep.Owner:InVehicle() and not wep.Owner:GetAllowWeaponsInVehicle() then
		return false
	end

	if wep.dt.PinPulled then
		return false
	end

	if wep.dt.BipodDeployed then
		return false
	end

	if wep.HolsterDelay then
		return false
	end

	return true
end

CustomizableWeaponry_KK.ins2.quickKnife.categories = {}

CustomizableWeaponry_KK.ins2.quickKnife.categories.knife = {
	td = {mins = Vector(-6, -6, -6), maxs = Vector(6, 6, 6)},
	range = 75,
	dmgBase = 30,
	dmgAddRnd = 10,
	dmgTime = 0.37,
	npcForceMult = 2000,
	doVPunch = true,
	hitFleshSound = "CW_KK_INS2_KNIFE",
	hitWorldSound = "CW_KK_INS2_KNIFE",
}

CustomizableWeaponry_KK.ins2.quickKnife.categories.bayonet = {
	td = {mins = Vector(-5, -5, -5), maxs = Vector(5, 5, 5)},
	range = 100,
	dmgBase = 55,
	dmgAddRnd = 10,
	dmgTime = 0,
	npcForceMult = 1500,
	hitFleshSound = "CW_KK_INS2_DOI_BAYONET_HITPLY",
	hitWorldSound = "CW_KK_INS2_DOI_BAYONET_HITWORLD",
}

CustomizableWeaponry_KK.ins2.quickKnife.categories.bash = {
	td = {mins = Vector(-7, -7, -7), maxs = Vector(7, 7, 7)},
	range = 60,
	dmgBase = 20,
	dmgAddRnd = 10,
	dmgTime = 0,
	npcForceMult = 2000,
	hitFleshSound = "CW_KK_INS2_DOI_MELEE_HITPLY",
	hitWorldSound = "CW_KK_INS2_DOI_MELEE_HITWORLD",
}

if SERVER then
	local punch = Angle(0, 0, 0)

	function CustomizableWeaponry_KK.ins2.quickKnife:_createDamage(wep, category)
		// Ill just count on wep and wep.Owner being Valid here

		local setup = category and self.categories[category]

		if not setup then
			print("[CustomizableWeaponry_KK.ins2.quickKnife:_createDamage]: invalid category")
			return
		end

		local td = setup.td
		local tr, ang

		CustomizableWeaponry.actionSequence.new(wep, setup.dmgTime, nil, function()
			td.start = wep.Owner:GetShootPos()
			td.endpos = td.start + wep.Owner:GetAimVector() * setup.range
			td.filter = wep.Owner

			tr = util.TraceHull(td)

			if tr.Hit then
				local ent = tr.Entity

				if IsValid(ent) then
					local d = DamageInfo()

					if !IsValid(self._inflictor) then
						self._inflictor = ents.Create("cw_kk_ins2_damage_melee")
					end

					d:SetAttacker(wep.Owner)
					d:SetInflictor(
						IsValid(self._inflictor) and
						self._inflictor or
						wep
					)

					d:SetDamage(setup.dmgBase + math.random(setup.dmgAddRnd))
					d:SetDamageForce(wep.Owner:GetAimVector() * setup.npcForceMult * 2)
					d:SetDamageType(DMG_SLASH)
					d:SetDamagePosition(tr.HitPos)
					d:SetReportedPosition(td.start)

					ent:TakeDamageInfo(d)

					if ent:IsNPC() then
						ang = wep.Owner:GetAngles()
						ang.p = 0
						ent:SetVelocity(ang:Forward() * setup.npcForceMult)
					end

					if string.find(ent:GetClass(), "breakable") then
						ent:Fire("Break")
					end

					if ent:IsNPC() or ent:IsPlayer() then
						wep.Owner:EmitSound(setup.hitFleshSound)
					else
						wep.Owner:EmitSound(setup.hitWorldSound)
					end
				else
					wep.Owner:EmitSound(setup.hitWorldSound)
				end

				punch.p = math.Rand(-5, -4)
				punch.y = math.Rand(-2, 2)
				punch.r = math.Rand(-1, 1)
			else
				punch.p = math.Rand(-5, -4)
				punch.y = math.Rand(-2, 2)
				punch.r = math.Rand(-1, 1)
			end

			if setup.doVPunch then
				wep.Owner:ViewPunch(punch)
			end
		end)
	end
end

function CustomizableWeaponry_KK.ins2.quickKnife:attack(wep)
	local CT = CurTime()

	// reset reload delays to interrupt reload (if any)
	wep.ReloadDelay = nil
	wep.ReloadWait = CT
	wep.ShotgunReloadState = 0
	if wep.dt.AT4ReloadEnd then
		wep.dt.AT4ReloadEnd = 0
	end

	// reset VM anim
	if CLIENT then
		wep:idleAnimFunc()
	end

	// tell client to do stuff since we are triggered using SV concommand, not PrimaryAttack
	if SERVER then
		SendUserMessage("CW_KK_INS2_QUICKKNIFE", wep.Owner)
	end

	local category

	if wep.ActiveAttachments.kk_ins2_ww2_knife or wep.ActiveAttachments.kk_ins2_ww2_knife_fat then
		if CLIENT then
			wep:bayonetAnimFunc()
		end

		wep:setGlobalDelay(0.8)
		wep:SetNextPrimaryFire(CT + 0.8)
		wep.meleeAttackDelay = CT + 0.8

		category = "bayonet"
	elseif wep.Animations[wep:getForegripMode() .. "melee"] then
		local prefix = wep:getForegripMode()
		local suffix = ""

		if wep.dt.INS2GLActive then
			if !wep.M203Chamber and wep.KK_INS2_EmptyIdleGL then
				suffix = "_empty" .. wep._KK_INS2_customEmptySuffix
			end
		else
			if wep:Clip1() == 0 and wep.KK_INS2_EmptyIdle then
				suffix = "_empty" .. wep._KK_INS2_customEmptySuffix
			end
		end

		local anim = prefix .. "melee" .. suffix

		if CLIENT then
			wep:sendWeaponAnim(anim, 1, 0)
		end

		local time, halt = wep:getAnimTimes(anim)

		halt = 3 * halt / 5

		CustomizableWeaponry_KK.ins2.quickKnife.categories.bash.dmgTime = time

		wep:setGlobalDelay(halt)
		wep:SetNextPrimaryFire(CT + halt)
		wep.meleeAttackDelay = CT + halt

		category = "bash"
	else
		wep:setGlobalDelay(1.2)
		wep:SetNextPrimaryFire(CT + 1.2)
		wep.meleeAttackDelay = CT + 1.2

		if wep.KKINS2Potato then
			wep.dt.State = CW_ACTION

			wep.Animations["_melee_a"] = wep.CW_KK_KNIFE_TWEAK.a_attack
			wep.Animations["_melee_h"] = "holster"

			CustomizableWeaponry.actionSequence.new(wep, 0.1, nil, function()
				wep.dt.State = CW_KK_QKNIFE

				if CLIENT then
					wep.knifeTime = CurTime() + 1
					wep.CW_VM:SetModel(wep.CW_KK_KNIFE_TWEAK.vm)
					wep:EmitSound("weapons/knife/knife_deploy1.wav")
					wep:playAnim("_melee_a", 0, 0.1)
				end
			end)

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 0.3, nil, function()
					wep:playAnim("_melee_a", 1, 0.1)
				end)
			end

			CustomizableWeaponry.actionSequence.new(wep, 0.9, nil, function()
				wep.dt.State = CW_ACTION

				if CLIENT then
					wep:playAnim("_melee_h", 2, 0)
				end
			end)

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 1, nil, function()
					wep.CW_VM:SetModel(wep.ViewModel)
					wep:idleAnimFunc()
					-- wep.reticleInactivity = 0
					-- wep:idleAnimFunc()
				end)
			end

			CustomizableWeaponry.actionSequence.new(wep, 1.2, nil, function()
				-- wep.dt.State = CW_IDLE

				if CLIENT then
					wep.reticleInactivity = 0
				end
			end)
		else
			wep.dt.State = CW_KK_QKNIFE

			if wep:filterPrediction() then
				wep:EmitSound("CW_HOLSTER")
			end

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 0.1, nil, function()
					wep:EmitSound("weapons/knife/knife_deploy1.wav")
				end)

				CustomizableWeaponry.actionSequence.new(wep, 0.1, nil, function()
					wep.GrenadePos.z = -15
					wep.knifeTime = CurTime() + 1

					wep.CW_KK_HANDS:SetParent(wep.CW_KK_KNIFE)

					wep:playAnim(wep.CW_KK_KNIFE_TWEAK.a_attack, 0, 0.1, wep.CW_KK_KNIFE)
				end)

				CustomizableWeaponry.actionSequence.new(wep, 0.3, nil, function()
					wep:playAnim(wep.CW_KK_KNIFE_TWEAK.a_attack, 1, 0.1, wep.CW_KK_KNIFE)
				end)

				CustomizableWeaponry.actionSequence.new(wep, 0.9, nil, function()
					wep:playAnim("holster", 2, 0, wep.CW_KK_KNIFE)
				end)

				CustomizableWeaponry.actionSequence.new(wep, 1, nil, function()
					wep.reticleInactivity = 0
					wep:idleAnimFunc()
				end)
			end
		end

		category = "knife"
	end

	if SERVER then
		net.Start("CW_KK_INS2_NWGQK")
		net.WriteEntity(wep.Owner)
		net.Broadcast()

		self:_createDamage(wep, category)
	end
end

if CLIENT then
	local ply, wep

	usermessage.Hook("CW_KK_INS2_QUICKKNIFE", function()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon then
			CustomizableWeaponry_KK.ins2.quickKnife:attack(wep)
		end
	end)
end

// concommand

if SERVER then
	local wep

	concommand.Add("cw_kk_melee", function(ply)
		if !IsValid(ply) then return end
		-- ply:ConCommand("_cw_kk_melee_cl")

		wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end

		if wep.CW_KK_MELEE then
			wep:CW_KK_MELEE()
		end
	end)
end

// gesture

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWGQK")
end

if CLIENT then
	local function receive()
		local ply = net.ReadEntity()

		if IsValid(ply) then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2, true)
		end
	end

	net.Receive("CW_KK_INS2_NWGQK", receive)
end
