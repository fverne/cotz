
local SP = game.SinglePlayer()

//-----------------------------------------------------------------------------
// Initialize extra links(shells, muzzles) and generate tweak data(anim callbacks)
//-----------------------------------------------------------------------------

//yea im layzeeee
local copyPaste = {
	["KKINS2CSTMCMore"] = "KKINS2Aimpoint",
	["KKINS2CSTMBarska"] = "KKINS2EoTech",
	["KKINS2CSTMMicroT1"] = "KKINS2Aimpoint",
	["KKINS2CSTMEoTechXPS"] = "KKINS2EoTech",
	["KKINS2CSTMCompM4S"] = "KKINS2Aimpoint",
	["KKINS2CSTMACOG"] = "KKINS2Elcan",
}
local copyPasteSx = {
	"Pos", "Ang"
}

CustomizableWeaponry.callbacks:addNew("initialize", "KK_INS2_BASE", function(wep)
	-- wep:SetNWVarProxy("Potato", print)

	if CLIENT then
		-- wep.ReticleInactivityPostFire = wep.ReticleInactivityPostFire or wep.FireDelay

		// moved shell table getters here so they dont have to be called every createShell time
		if wep.Shell then
			wep._shellTable1 = CustomizableWeaponry.shells:getShell(wep.Shell)
		end

		if wep.Shell2 then
			wep._shellTable2 = CustomizableWeaponry.shells:getShell(wep.Shell2)
		end

		// fastest way to setup sights from Workshop sight contract
		for k, v in pairs(copyPaste) do
			for _, x in pairs(copyPasteSx) do
				if not wep[k .. x] then
					wep[k .. x] = wep[v .. x]
				end
			end
		end

		// reducing lookup calls
		if wep.MuzzleAttachmentName then
			wep.MuzzleAttachment = wep.CW_VM:LookupAttachment(wep.MuzzleAttachmentName)
		end
		if wep.ShellViewAttachmentName then
			wep.ShellViewAttachmentID = wep.CW_VM:LookupAttachment(wep.ShellViewAttachmentName)
		end
		if wep.Shell2ViewAttachmentName then
			wep.Shell2ViewAttachmentID = wep.CW_VM:LookupAttachment(wep.Shell2ViewAttachmentName)
		end

		// sth sth darqside
		wep._deployedShells = {}

		// setup anim callbacks for inactivity anims
		if wep.setupReticleInactivityCallbacks then
			wep:setupReticleInactivityCallbacks() // sh_anims.lua
		end

		// setup loops in crawl anims soundtables
		if wep.setupSoundTableLoops then
			wep:setupSoundTableLoops() // sh_anims.lua
		end

		// just so it doesnt iterate over ents.GetAll()
		CustomizableWeaponry_KK.ins2.welementThink:_addWeapon(wep)

		// doi viewbob
		wep._vmCamAttach = wep.CW_VM:LookupAttachment("camera")
	end

	// Ive never really used ammo crate before so here s quickfix for explosives
	if wep.KKINS2RCE or wep.KKINS2Nade then
		wep.Primary.ClipSize_Orig = 1
	end

	if wep.MuzzleEffect then
		PrecacheParticleSystem(wep.MuzzleEffect)
	end

	if wep.MuzzleEffectSupp then
		PrecacheParticleSystem(wep.MuzzleEffectSupp)
	end

	if wep.MuzzleEffectWorld then
		PrecacheParticleSystem(wep.MuzzleEffectWorld)
	end
end)

//-----------------------------------------------------------------------------
// Attach/Detach callbacks for sights and standard parts (elements)
//-----------------------------------------------------------------------------

local CW2_ATTS = CustomizableWeaponry.registeredAttachmentsSKey

local function sharedAttachDetach(wep, att)
	local prim, sec = wep:getPrimarySight(), wep:getSecondarySight()

	if CLIENT then
		// magnifier scope
		if sec then
			local a = CW2_ATTS[sec]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		elseif prim then
			local a = CW2_ATTS[prim]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		else
			wep.AimPos = wep.IronsightPos
			wep.AimAng = wep.IronsightAng
			wep.AimViewModelFOV = wep.AimViewModelFOV_Orig
		end

		// shared standard parts
		wep:setElementActive("kk_ins2_optic_iron", prim == nil)
		wep:setElementActive("kk_ins2_optic_rail", prim != nil)

		// individual standard parts
		wep:updateStandardParts()
	end
end

local att

CustomizableWeaponry.callbacks:addNew("postAttachAttachment", "KK_INS2_BASE", function(wep, catId, attId)
	if !wep.KKINS2Wep then return end

	att = CW2_ATTS[wep.Attachments[catId].atts[attId]]

	if att.isSight then
		wep._currentPrimarySight = att
	end

	if att.isSecondarySight then
		wep._currentSecondarySight = att
	end

	if att.isGrenadeLauncher and att.name != "kk_ins2_gp25_ammo" then
		wep._currentGrenadeLauncher = att
	end

	if CLIENT then
		if att.KK_INS2_playIdle then
			-- if wep.dt.State == CW_CUSTOMIZE then
			if wep._KK_INS2_PickedUp then
				wep:idleAnimFunc()
			else
				wep:pickupAnimFunc()
			end
		end

		wep:setElementActive(att.name, true)
		wep:setElementActive(att.name .. "_rail", true)
	end

	if CLIENT then
		if att.SelectIconOverride then
			if not wep.SelectIcon_Orig then
				wep.SelectIcon_Orig = wep.SelectIcon
			end

			wep.SelectIcon = att.SelectIconOverride
		end
	end

	if SERVER then
		wep:_KK_INS2_NWAttach(att)
	end

	sharedAttachDetach(wep, att)
end)

CustomizableWeaponry.callbacks:addNew("postDetachAttachment", "KK_INS2_BASE", function(wep, attTable, CWMenuCategory)
	if !wep.KKINS2Wep then return end

	att = attTable

	if att.isSight then
		wep._currentPrimarySight = nil
	end

	if att.isSecondarySight then
		wep._currentSecondarySight = nil
	end

	if att.isGrenadeLauncher then
		wep._currentGrenadeLauncher = nil
	end

	if CLIENT then
		if att.KK_INS2_playIdle then
			wep:idleAnimFunc()
		end

		wep:setElementActive(att.name, false)
		wep:setElementActive(att.name .. "_rail", false)
	end

	if CLIENT then
		if att.SelectIconOverride then
			wep.SelectIcon = wep.SelectIcon_Orig
		end
	end

	if SERVER then
		wep:_KK_INS2_NWDetach(att)
	end

	sharedAttachDetach(wep, att)
end)

//-----------------------------------------------------------------------------
// custom Action states
//-----------------------------------------------------------------------------

if CLIENT then
	local kkAction = {
		[CW_KK_ACTION] = true,
		[CW_KK_QNADE] = true,
		[CW_KK_QKNIFE] = true,
	}

	local v0 = Vector()

	CustomizableWeaponry.callbacks:addNew("adjustViewmodelPosition", "KK_INS2_BASE", function(wep, TargetPos, TargetAng)
		if !wep.KKINS2Wep then return end

		if kkAction[wep.dt.State] and not wep.KKINS2Potato then
			return wep.SwimPos, wep.SwimAng
		end

		// no CustomizePos during crawling
		// also SprintViewSimulation?
		if wep.dt.State != CW_ACTION and wep:IsOwnerCrawling() then
			-- TargetPos, TargetAng = Vector(wep.AlternativePos), Vector(wep.AlternativeAng)

			-- // 2do: edit to add SprintViewSim to crawling

			-- local verticalOffset = EyeAngles().p * 0.4 * 1
			-- TargetAng.x = TargetAng.x - math.Clamp(verticalOffset, -70, 70) * -1.5
			-- TargetAng.y = TargetAng.y - verticalOffset * 0.5 * 0
			-- TargetAng.z = TargetAng.z - verticalOffset * 0.2 * 0
			-- TargetPos.z = TargetPos.z + math.Clamp(verticalOffset * 0.2, -10, 3)

			-- return TargetPos, TargetAng
			-- return wep.AlternativePos, wep.AlternativeAng
		end

		// pure holster animation when holstering, no swimpos
		if wep.dt.State == CW_HOLSTER_START or wep.dt.State == CW_HOLSTER_END then
			return wep.AlternativePos, wep.AlternativeAng
		end

		// grenade launcher have sights so lets use it for all nade types
		if wep.dt.INS2GLActive and wep:isAiming() then
			if wep:canAimGL() then
				return wep.M203Pos, wep.M203Ang
			else
				return v0, v0
			end
		end
	end)
end

//-----------------------------------------------------------------------------
// Hints for plant-able-s
//-----------------------------------------------------------------------------

if CLIENT then
	local White, Black = Color(255, 255, 255, 255), Color(0, 0, 0, 255)
	local cwhud24 = "CW_HUD24"

	local td = {}

	CustomizableWeaponry.callbacks:addNew("suppressHUDElements", "KK_INS2_BASE_PLANTABLES", function(wep)
		td.filter = wep.Owner
		td.start = wep.Owner:EyePos()
		td.endpos = td.start + wep.Owner:EyeAngles():Forward() * 95

		local tr = util.TraceLine(td)

		local x, y = ScrW() / 2, ScrH() / 2 + 40

		if tr.Hit and IsValid(tr.Entity) and tr.Entity.KKIN2RCEprojetile then
			draw.ShadowText("[	]", cwhud24, ScrW() / 2, ScrH() / 2, White, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			local ent = tr.Entity

			if IsValid(ent.dt.Detonator) and ent.dt.Detonator.Owner == wep.Owner then
				draw.ShadowText("[USE KEY - PICK UP]", cwhud24, x , y, White, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				y = y + 30
			end
		end

		if not (wep.KKINS2RCE or (wep.KKINS2Nade and wep.canPlant)) then
			return
		end

		if (wep.Owner:GetAmmoCount(wep.Primary.Ammo) < 1) then
			if wep:Clip1() > 0 then
				draw.ShadowText("[PRIMARY - DETONATE]", cwhud24, x, y, White, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			return
		end

		local nw, tr = wep:isNearWall()

		if not nw then
			return
		end

		draw.ShadowText("[	]", cwhud24, ScrW() / 2, ScrH() / 2, White, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.ShadowText("[PRIMARY - PLANT]", cwhud24, x, y, White, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		return
	end)

	hook.Add("FindUseEntity", "findmesomeentity", print)

end

//-----------------------------------------------------------------------------
// WElements for cw_dropped_weapon
//-----------------------------------------------------------------------------

CustomizableWeaponry_KK.ins2.welementDrop = CustomizableWeaponry_KK.ins2.welementDrop or {}
CustomizableWeaponry_KK.ins2.welementDrop.nwstring = "CW_KK_INS2_wepDrop"
function CustomizableWeaponry_KK.ins2.welementDrop:IsValid() return true end

local uintSize = 16

if SERVER then
	util.AddNetworkString(CustomizableWeaponry_KK.ins2.welementDrop.nwstring)

	function CustomizableWeaponry_KK.ins2.welementDrop:send(wep, drop)
		local class = wep:GetClass()
		local ActiveWElements = wep.ActiveWElements
		local dropId = drop:EntIndex()

		net.Start(self.nwstring)
		net.WriteString(class)
		net.WriteUInt(dropId, uintSize)
		net.WriteUInt(wep:Clip1(), uintSize)

		net.WriteTable(ActiveWElements or {})
		net.Broadcast()
	end

	CustomizableWeaponry.callbacks:addNew("droppedWeapon", "KK_INS2_BASE", function(...)
		CustomizableWeaponry_KK.ins2.welementDrop:send(...)
	end)
end

if CLIENT then
	function CustomizableWeaponry_KK.ins2.welementDrop:receive(len, ply)
		local wep = net.ReadString()
		local drop = net.ReadInt(uintSize)
		local clip = net.ReadInt(uintSize)
		local usedWEs = net.ReadTable()

		self.data[drop] = {
			wep = wep,
			clip = clip,
			usedWEs = usedWEs,
			timeout = CurTime() + 20 // still doesnt save you from horrors of Dedicated Server
		}
	end

	net.Receive(CustomizableWeaponry_KK.ins2.welementDrop.nwstring, function(...)
		CustomizableWeaponry_KK.ins2.welementDrop:receive(...)
	end)
end

if CLIENT then
	CustomizableWeaponry_KK.ins2.welementDrop.data = CustomizableWeaponry_KK.ins2.welementDrop.data or {}
	-- CustomizableWeaponry_KK.ins2.welementDrop.used = CustomizableWeaponry_KK.ins2.welementDrop.used or {}

	local function copyTable(tab)
		if not tab then
			return
		end

		local out = {}

		for k,v in pairs(tab) do
			out[k] = v
		end

		return out
	end

	local basebase, base

	function CustomizableWeaponry_KK.ins2.welementDrop:Think()
		basebase = basebase or weapons.GetStored("cw_base")
		base = base or weapons.GetStored("cw_kk_ins2_base_main")

		if not basebase or not base then
			return
		end

		for dropId,dropData in pairs(self.data) do
			local drop = ents.GetByIndex(dropId)

			if !IsValid(drop) then
				continue
			end

			if dropData.remove or dropData.timeout < CurTime() then
				-- self.used[dropId] = self.data[dropId]
				self.data[dropId] = nil
				return
			end

			if not dropData._modelsDone then
				drop.AttachmentModelsWM = {}

				local storedWEs = weapons.GetStored(dropData.wep).AttachmentModelsWM or {}

				for k,v in pairs(storedWEs) do
					if (dropData.usedWEs[k] == true) or (dropData.usedWEs[k] == nil and v.active) then
						drop.AttachmentModelsWM[k] = copyTable(v)
						drop.AttachmentModelsWM[k].active = true
					end
				end

				drop.createManagedCModel = basebase.createManagedCModel
				base.setupAttachmentWModels(drop)

				local drawAtts = base.drawAttachmentsWorld
				local drawRest = drop.Draw

				local overrideVM = false
				for _,e in pairs(drop.AttachmentModelsWM) do
					overrideVM = overrideVM or (e.active and e.hideVM)

					if overrideVM then
						drop:SetMaterial(CustomizableWeaponry_KK.ins2.nodrawMatPath)
						break
					end
				end

				function drop:Draw()
					drawAtts(self, self)
					drawRest(self)
				end

				dropData._modelsDone = true
			end

			if not dropData._wrapperDone then
				local dropAttsReceived = drop:getAttachments()

				if not dropAttsReceived then
					continue
				end

				local welementThinkWrapper = {
					WMEnt = drop,
					ActiveAttachments = {},
					AttachmentModelsWM = drop.AttachmentModelsWM,
					dt = drop.dt,
					IsValid = function() return IsValid(drop) end,
					GetClass = function() return drop:GetWepClass() end,
					Clip1 = function() return dropData.clip end,
					isWrapper = true,
				}

				for _,k in pairs(drop:getAttachments()) do
					welementThinkWrapper.ActiveAttachments[k] = true
				end

				CustomizableWeaponry_KK.ins2.welementThink:_addWeapon(welementThinkWrapper)

				dropData._wrapperDone = true
			end

			if dropData._modelsDone and dropData._wrapperDone then
				dropData.remove = true
			end
		end
	end

	hook.Add("Think", CustomizableWeaponry_KK.ins2.welementDrop, CustomizableWeaponry_KK.ins2.welementDrop.Think)
end

//-----------------------------------------------------------------------------
// Prone Mod recoil mod
//-----------------------------------------------------------------------------

-- CustomizableWeaponry.callbacks:addNew("calculateRecoil", "KK_INS2_BASE", function(wep, mod)
	-- if !wep.KKINS2Wep then return end

	-- return wep:IsOwnerProne() and mod * 0.6 or mod
-- end)

-- if CLIENT then
	-- CustomizableWeaponry.callbacks:addNew("disableInteractionMenu", "KK_INS2_BASE", function(wep, mod)
		-- if !wep.KKINS2Wep then return end

		-- return wep:IsOwnerCrawling()
	-- end)
-- end
