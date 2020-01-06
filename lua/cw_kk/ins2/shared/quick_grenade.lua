
local SP = game.SinglePlayer()
local MP = !SP

CustomizableWeaponry_KK.ins2.quickGrenade = CustomizableWeaponry_KK.ins2.quickGrenade or {}

if CLIENT then
	CustomizableWeaponry_KK.ins2.quickGrenade.cvarType = CreateClientConVar("_cw_kk_ins2_qnadetype", 1, false, true)
end

CustomizableWeaponry_KK.ins2.quickGrenade.models = {}

CustomizableWeaponry_KK.ins2.quickGrenade.models.m67 = {
	id = "m67",
	vm = "models/weapons/v_cw_kk_ins2_m67.mdl",
	wm = "models/weapons/w_cw_kk_ins2_m67.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.f1 = {
	id = "f1",
	vm = "models/weapons/v_f1.mdl",
	wm = "models/weapons/w_f1.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.m18 = {
	id = "m18",
	vm = "models/weapons/v_m18.mdl",
	wm = "models/weapons/w_m18.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.m84 = {
	id = "m84",
	vm = "models/weapons/v_m84.mdl",
	wm = "models/weapons/w_m84.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2us = {
	id = "ww2us",
	vm = "models/weapons/cw_kk_doi/v_mk2.mdl",
	wm = "models/weapons/w_mk2.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2de = {
	id = "ww2de",
	vm = "models/weapons/cw_kk_doi/v_stielhandgranate.mdl",
	wm = "models/weapons/w_stielhandgranate.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "bakethrow"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2gb = {
	id = "ww2gb",
	vm = "models/weapons/cw_kk_doi/v_mills.mdl",
	wm = "models/weapons/w_mills.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.n69 = {
	id = "n69",
	vm = "models/weapons/cw_kk_doi/v_no69.mdl",
	wm = "models/weapons/w_no69.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.n76 = {
	id = "n77",
	vm = "models/weapons/cw_kk_doi/v_no77.mdl",
	wm = "models/weapons/w_no77.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.n77 = {
	id = "n77",
	vm = "models/weapons/cw_kk_doi/v_no79.mdl",
	wm = "models/weapons/w_no77.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.anm14 = {
	id = "anm14",
	vm = "models/weapons/v_anm14.mdl",
	wm = "models/weapons/w_anm14.mdl",
	a_pinpull = "pullbackhighbake",
	a_throw = "bakethrow"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.m26 = {
	id = "m26",
	vm = "models/weapons/v_nam_m26.mdl",
	wm = "models/weapons/w_nam_m26.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.rgd5 = {
	id = "rgd5",
	vm = "models/weapons/v_nam_rgd5.mdl",
	wm = "models/weapons/w_nam_rgd5.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.types = {}

local function add(tab)
	table.insert(CustomizableWeaponry_KK.ins2.quickGrenade.types, tab)
end

add({text = "FRAG", ammo = "Frag Grenades", class = "cw_kk_ins2_projectile_frag"})
add({text = "FLASH", ammo = "Flash Grenades", class = "cw_kk_ins2_projectile_m84", default = "m84"})
add({text = "SMOKE", ammo = "Smoke Grenades", class = "cw_kk_ins2_projectile_m18", default = "m18"})
add({text = "FLAME", ammo = "Incendiary", class = "cw_kk_ins2_projectile_anm14", default = "anm14"})

if CustomizableWeaponry_KK.HOME then
	-- CustomizableWeaponry_KK.ins2.quickGrenade.models.roflkek = {
		-- vm = "models/weapons/cw_kk_doi/v_anm14.mdl",
		-- wm = "models/props_junk/flare.mdl",
		-- a_pinpull = "pullbackhighbake",
		-- a_throw = "bakethrow"
	-- }

	add({text = "BUG", /*ammo = "9x19MM", */class = "npc_grenade_bugbait", default = "n77"})
	-- add({text = "HL2", /*ammo = "Frag Grenades", */class = "npc_grenade_frag", default = "m18"})
	-- add({text = "EP1", /*ammo = "Frag Grenades", */class = "kk_flare", default = "roflkek"})
	-- add({text = "N69", ammo = "Frag Grenades", class = "cw_kk_ins2_projectile_n69", default = "n69"})
end

function CustomizableWeaponry_KK.ins2.quickGrenade:getAmmo(wep)
	local nadeType

	if SERVER then
		nadeType = wep.Owner:GetInfoNum("_cw_kk_ins2_qnadetype", 1)
	else
		nadeType = self.cvarType:GetInt() or 1
	end

	nadeType = math.Clamp(nadeType, 1, #self.types)

	return self.types[nadeType]
end

function CustomizableWeaponry_KK.ins2.quickGrenade:canThrow(wep)
	if not CustomizableWeaponry.quickGrenade.enabled then
		return false
	end

	if CustomizableWeaponry.quickGrenade.restrictedStates[wep.dt.State] then
		return false
	end

	if wep.dt.BipodDeployed then
		return false
	end

	if wep.HolsterDelay then
		return false
	end

	local ammo = self:getAmmo(wep).ammo
	if ammo and wep.Owner:GetAmmoCount(ammo) <= 0 then
		return false
	end

	return true
end

function CustomizableWeaponry_KK.ins2.quickGrenade:throw(wep, IFTP)
	local CT = CurTime()

	wep:setGlobalDelay(1.9)
	wep:SetNextPrimaryFire(CT + 1.9)

	if SERVER and SP then
		SendUserMessage("CW_KK_INS2_THROWGRENADE", wep.Owner)
	end

	wep.dt.State = CW_KK_QNADE

	IFTP = IFTP or IsFirstTimePredicted()

	if (MP and IFTP) or SP then
		if wep:filterPrediction() then
			wep:EmitSound("CW_HOLSTER")
		end

		CustomizableWeaponry.callbacks.processCategory(wep, "beginThrowGrenade")

		local curSetup = self:getAmmo(wep)

		local quickNadeTweak = curSetup.default and self.models[curSetup.default] or wep.CW_GREN_TWEAK
		local nadeAmmo = curSetup.ammo
		local entClass = curSetup.class

		if wep.KKINS2Potato then
			wep.dt.State = CW_ACTION

			wep.Animations["_grenade_pin"] = quickNadeTweak.a_pinpull
			wep.Animations["_grenade_throw"] = quickNadeTweak.a_throw

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 0.1, nil, function()
					wep.grenadeTime = CurTime() + 1.5
					wep.CW_VM:SetModel(quickNadeTweak.vm)
				end)
			end

			if SERVER then
				CustomizableWeaponry.actionSequence.new(wep, 0.3, nil, function()
					wep.dt.State = CW_KK_QNADE
					wep.canDropGrenade = true
				end)
			end

			if SERVER then
				CustomizableWeaponry.actionSequence.new(wep, 0.4, nil, function()
					net.Start("CW_KK_INS2_NWGQN")
					net.WriteEntity(wep.Owner)
					net.Broadcast()
				end)
			end

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 0.45, nil, function()
					wep:playAnim("_grenade_pin", 1, 0)
				end)
			end

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 0.7, nil, function()
					surface.PlaySound("weapons/pinpull.wav")
				end)
			end

			if SERVER then
				CustomizableWeaponry.actionSequence.new(wep, 0.9, nil, function()
					wep.liveGrenade = true
				end)
			end

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 1, nil, function()
					wep:playAnim("_grenade_throw", 1.1, 0)
				end)
			end

			if SERVER then
				CustomizableWeaponry.actionSequence.new(wep, 1.2, nil, function()
					// create and setup
					local nade = ents.Create(entClass)

					if IsValid(nade) then
						local pos = wep.Owner:GetShootPos()
						local eyeAng = wep.Owner:EyeAngles()
						local forward = eyeAng:Forward()

						nade.Model = quickNadeTweak.wm
						nade:SetModel(quickNadeTweak.wm)

						nade:SetPos(pos)
						nade:SetAngles(eyeAng)
						-- nade:SetOwner(wep.Owner)

						nade:Spawn()
						nade:Activate()

						nade:SetModel(quickNadeTweak.wm)

						// add velocity
						local velocity = CustomizableWeaponry.quickGrenade:getThrowVelocity(wep.Owner, throwVelocity, addVelocity)
						local phys = nade:GetPhysicsObject()

						if IsValid(phys) then
							phys:SetVelocity(velocity)
							phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
						else
							nade:SetVelocity(velocity)
						end

						// fuse
						if nade.Fuse then
							nade:Fuse(3)
						end

						nade:Fire("sETtIMER", 3)
					end

					CustomizableWeaponry.actionSequence.new(wep, 0, nil, function()
						hook.Call("GrenadeThrown", nil, wep, nade)
					end)

					// consume owners ammo
					local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage")

					if nadeAmmo and not suppressAmmoUsage then
						wep.Owner:RemoveAmmo(1, nadeAmmo)
					end

					// ease on martyrdom
					wep.liveGrenade = false
					wep.canDropGrenade = false
				end)
			end

			CustomizableWeaponry.actionSequence.new(wep, 1.3, nil, function()
				wep.dt.State = CW_ACTION
			end)

			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 1.4, nil, function()
					wep.CW_VM:SetModel(wep.ViewModel)
					wep:idleAnimFunc()
				end)
			end
		else
			if CLIENT then
				wep.CW_GREN:SetModel(quickNadeTweak.vm)

				CustomizableWeaponry.actionSequence.new(wep, 0.45, nil, function()
					wep.GrenadePos.z = -10
					wep.grenadeTime = CurTime() + 1.5

					wep.CW_KK_HANDS:SetParent(wep.CW_GREN)
					wep.CW_KK_HANDS:AddEffects(EF_BONEMERGE_FASTCULL)

					wep:playAnim(quickNadeTweak.a_pinpull, 1, 0, wep.CW_GREN)
				end)

				CustomizableWeaponry.actionSequence.new(wep, 0.7, nil, function()
					surface.PlaySound("weapons/pinpull.wav")
				end)

				CustomizableWeaponry.actionSequence.new(wep, 1, nil, function()
					wep:playAnim(quickNadeTweak.a_throw, 1.1, 0, wep.CW_GREN)
				end)
			end

			if SERVER then
				CustomizableWeaponry.actionSequence.new(wep, 0.3, nil, function()
					wep.canDropGrenade = true
				end)

				CustomizableWeaponry.actionSequence.new(wep, 0.4, nil, function()
					net.Start("CW_KK_INS2_NWGQN")
					net.WriteEntity(wep.Owner)
					net.Broadcast()
				end)

				CustomizableWeaponry.actionSequence.new(wep, 0.9, nil, function()
					wep.liveGrenade = true
				end)

				CustomizableWeaponry.actionSequence.new(wep, 1.2, nil, function()
					// create and setup
					local nade = ents.Create(entClass)

					if IsValid(nade) then
						local pos = wep.Owner:GetShootPos()
						local eyeAng = wep.Owner:EyeAngles()
						local forward = eyeAng:Forward()

						nade.Model = quickNadeTweak.wm
						nade:SetModel(quickNadeTweak.wm)

						nade:SetPos(pos)
						nade:SetAngles(eyeAng)
						nade:SetOwner(wep.Owner)

						nade:Spawn()
						nade:Activate()

						nade:SetModel(quickNadeTweak.wm)

						// add velocity
						local velocity = CustomizableWeaponry.quickGrenade:getThrowVelocity(wep.Owner, throwVelocity, addVelocity)
						local phys = nade:GetPhysicsObject()

						if IsValid(phys) then
							phys:SetVelocity(velocity)
							phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
						else
							nade:SetVelocity(velocity)
						end

						// fuse
						if nade.Fuse then
							nade:Fuse(3)
						end

						nade:Fire("sETtIMER", 3)
					end

					CustomizableWeaponry.actionSequence.new(wep, 0, nil, function()
						hook.Call("GrenadeThrown", nil, wep, nade)
					end)

					// consume owners ammo
					local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage")

					if nadeAmmo and not suppressAmmoUsage then
						wep.Owner:RemoveAmmo(1, nadeAmmo)
					end

					// ease on martyrdom
					wep.liveGrenade = false
					wep.canDropGrenade = false
				end)
			end
		end

		CustomizableWeaponry.actionSequence.new(wep, 2, nil, function()
			local delay = CustomizableWeaponry.quickGrenade.postGrenadeWeaponDelay
			wep:SetNextPrimaryFire(CT + delay)
			wep:SetNextSecondaryFire(CT + delay)
		end)
	end
end

if CLIENT then
	local ply, wep

	usermessage.Hook("CW_KK_INS2_THROWGRENADE", function()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon then
			CustomizableWeaponry_KK.ins2.quickGrenade:throw(wep)
		end
	end)
end

// concommand

if SERVER then
	local wep

	local function cw_kk_throwfrag(ply)
		if MP then return end
		if !IsValid(ply) then return end

		wep = ply:GetActiveWeapon()

		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end

		if CurTime() < wep:GetNextPrimaryFire() then return end
		if not wep:canFireWeapon(1) then return end

		if wep.KKINS2Wep then
			-- if wep.KKINS2Nade then
				-- wep:PrimaryAttack()
				-- return
			-- end

			if CustomizableWeaponry_KK.ins2.quickGrenade:canThrow(wep) then
				CustomizableWeaponry_KK.ins2.quickGrenade:throw(wep, true)
				SendUserMessage("CW_KK_INS2_THROWGRENADE", ply)
			end
		else
			-- if wep.Base == "cw_grenade_base" then
				-- wep:PrimaryAttack()
				-- return
			-- end

			if CustomizableWeaponry.quickGrenade.canThrow(wep) then
				CustomizableWeaponry.quickGrenade.throw(wep, true)
				SendUserMessage("CW20_THROWGRENADE", ply)
			end
		end
	end

	concommand.Add("cw_kk_throwfrag", cw_kk_throwfrag)
end

// concommand for cycling type

if CLIENT then
	local cats = CustomizableWeaponry_KK.ins2.quickGrenade.types
	local count = table.Count

	local function cw_kk_cyclefrag(ply)
		if !IsValid(ply) then return end

		local set = CustomizableWeaponry_KK.ins2.quickGrenade.cvarType:GetInt() + 1

		for _ = 1, (#cats - 1) do
			if set > #cats then
				set = 1
			end

			if cats[set].ammo and ply:GetAmmoCount(cats[set].ammo) < 1 then
				set = set + 1
			end
		end

		if set > #cats then
			set = 1
		end

		RunConsoleCommand("_cw_kk_ins2_qnadetype", set)
	end

	concommand.Add("cw_kk_ins2_cyclenadetype", cw_kk_cyclefrag)

	local function think()
		local cur = CustomizableWeaponry_KK.ins2.quickGrenade.cvarType:GetInt()

		if cats[cur] and cats[cur].ammo and LocalPlayer():GetAmmoCount(cats[cur].ammo) < 1 then
			RunConsoleCommand("cw_kk_ins2_cyclenadetype")
		end
	end

	hook.Add("Think", "CW_KK_INS2_QNADEAMMOWATCH", think)
end

// gesture

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWGQN")
end

if CLIENT then
	local function receive()
		local ply = net.ReadEntity()

		if IsValid(ply) then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)
		end
	end

	net.Receive("CW_KK_INS2_NWGQN", receive)
end
