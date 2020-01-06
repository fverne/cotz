
local SP = game.SinglePlayer()

//-----------------------------------------------------------------------------
// updateReloadTimes now only updates vars used by StatDisplay
// called from
// - SWEP:Initialize()
// - CL SWEP:Think()
//-----------------------------------------------------------------------------

local prefix, suffix

function SWEP:updateReloadTimes()
	prefix = self:getForegripMode()
	suffix = self._KK_INS2_customReloadSuffix

	self.ReloadTime, self.ReloadHalt = self:getAnimTimes(prefix .. "reload" .. suffix)
	self.ReloadTime_Empty, self.ReloadHalt_Empty = self:getAnimTimes(prefix .. "reload_empty" .. suffix)

	// we ll just check for both mag-fed and internal-mag setups coz
	// revolvers and ww2 rifles use both, why add extra checks, right?
	self.ReloadStartTime, self.ReloadStartTime = self:getAnimTimes(prefix .. "reload_start")
	self.InsertShellTime, self.InsertShellTime = self:getAnimTimes(prefix .. "insert")

	local _, finishEmpty = self:getAnimTimes(prefix .. "reload_end_empty")
	local _, startEmpty = self:getAnimTimes(prefix .. "reload_start_empty")

	if !finishEmpty or !startEmpty then
		return
	end

	// this should make stat display count full shotgun reload time correctly for ins2 sgs
	self.ReloadFinishWait = finishEmpty + startEmpty - self.ReloadStartTime
end

//-----------------------------------------------------------------------------
// getAnimTimes replaced old updateReloadTimes logic
//-----------------------------------------------------------------------------

local seqName, seqTable

function SWEP:getAnimTimes(animName)
	if not animName then
		return
	end

	if not self.ReloadTimes then
		return
	end

	seqName = self.Animations[animName]

	if not seqName then
		return
	end

	if istable(seqName) then
		seqName = seqName[1]
	end

	seqTable = self.ReloadTimes[seqName]

	if not seqTable then
		return
	end

	return seqTable[1], seqTable[2], seqTable[3], seqTable[4], seqTable[5], seqTable[6], seqTable[7], seqTable[8]
end

//-----------------------------------------------------------------------------
// updateHands checks cw_kk_ins2_rig convar for changes and updates hands model
//-----------------------------------------------------------------------------

if CLIENT then
	local cvRigModel = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_rig"]
	local cvRigSkin = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_rigskin"]
	local currentRigs = {}

	function SWEP:updateHands()
		local set = cvRigModel:GetInt()
		if set != currentRigs[self] then
			if IsValid(self.CW_KK_HANDS) then
				local tab = CustomizableWeaponry_KK.ins2.hands:_get(set)
				self.CW_KK_HANDS:SetModel(tab[1])
				self.UseGMHands = tab.mergeGMHands
			end
		end
		currentRigs[self] = set

		self.CW_KK_HANDS:SetSkin(cvRigSkin:GetInt())
	end
end

if CLIENT then
	function SWEP:getRigSkinMax()
		return IsValid(self.CW_KK_HANDS) and self.CW_KK_HANDS:SkinCount() - 1 or 0
	end
end

//-----------------------------------------------------------------------------
// updateBelt on first call
// - checks CW_VM for bodygroups called "belt", "clip" and "shells"
// - replaces itself with blank function or belt bodygroup handler
// - shells bodygroup is handled using sound table callbacks
//-----------------------------------------------------------------------------

if CLIENT then
	local function blank() end

	function SWEP:updateBelt()
		local vm = self.CW_VM

		for _, name in pairs({"bELt", "CliP"}) do
			local id = vm:FindBodygroupByName(name)

			if id < 0 then
				self.updateBelt = blank
			else
				self._beltBGID = id
				self._beltBGMax = vm:GetBodygroupCount(id) - 1
				self.updateBelt = CustomizableWeaponry_KK.ins2.bulletBgs.think
				break
			end
		end

		for _, name in pairs({"shELls"}) do
			local id = vm:FindBodygroupByName(name)

			if id > -1 then
				self._shellsBGID = id
				self._shellsBGMax = vm:GetBodygroupCount(id) - 1

				break
			end
		end
	end
end

//-----------------------------------------------------------------------------
// updateOtherParts is called from SWEP:Think, clientside only
//-----------------------------------------------------------------------------

if CLIENT then
	function SWEP:updateOtherParts()
		// whatever u want
	end
end

//-----------------------------------------------------------------------------
// updateStandardParts is called from post(attach|detach) callback, clientside
//-----------------------------------------------------------------------------

if CLIENT then
	function SWEP:updateStandardParts()
		// whatever u want
	end
end

//-----------------------------------------------------------------------------
// hasInstalledRTScope returns true if weapon has attached scope that uses
// render targets
//-----------------------------------------------------------------------------

function SWEP:hasInstalledRTScope()
	return
		self.ActiveAttachments.kk_ins2_magnifier or
		self.ActiveAttachments.kk_ins2_elcan or
		self.ActiveAttachments.kk_ins2_po4 or
		self.ActiveAttachments.kk_ins2_scope_m40 or
		self.ActiveAttachments.kk_ins2_scope_mosin or

		self.ActiveAttachments.kk_ins2_cstm_susat or
		self.ActiveAttachments.kk_ins2_cstm_acog or
		self.ActiveAttachments.kk_ins2_cstm_pgo7 or

		self.ActiveAttachments.kk_ins2_scope_enfield or
		self.ActiveAttachments.kk_ins2_scope_k98 or
		self.ActiveAttachments.kk_ins2_scope_m73 or
		self.ActiveAttachments.kk_ins2_scope_zf4
end

//-----------------------------------------------------------------------------
// hasInstalledStencilSight returns true if weapon has attached sight that uses
// stencils
//-----------------------------------------------------------------------------

function SWEP:hasInstalledStencilSight()
	return
		self.ActiveAttachments.kk_ins2_aimpoint or
		self.ActiveAttachments.kk_ins2_eotech or
		self.ActiveAttachments.kk_ins2_kobra or

		self.ActiveAttachments.kk_ins2_cstm_cmore or
		self.ActiveAttachments.kk_ins2_cstm_sureshot or
		self.ActiveAttachments.kk_ins2_cstm_barska or
		self.ActiveAttachments.kk_ins2_cstm_microt1 or
		self.ActiveAttachments.kk_ins2_cstm_eotechxps or
		self.ActiveAttachments.kk_ins2_cstm_compm4s
end

//-----------------------------------------------------------------------------
// hasInstalledGL returns true if weapon has attached grenade launcher
//-----------------------------------------------------------------------------

function SWEP:hasInstalledGL()
	return self._currentGrenadeLauncher != nil
end

//-----------------------------------------------------------------------------
// getForegripMode returns active anim prefix
//-----------------------------------------------------------------------------

function SWEP:getForegripMode()
	if self.ActiveAttachments.kk_ins2_vertgrip then
		return "foregrip_"
	elseif self.dt.BipodDeployed then
		return "bipod_"
	elseif self:hasInstalledGL() then
		if self.dt.INS2GLActive then
			return "gl_on_"
		else
			return "gl_off_"
		end
	end

	return "base_"
end

//-----------------------------------------------------------------------------
// getPrimarySight returns att.name of active primary sight (if any)
//-----------------------------------------------------------------------------

function SWEP:getPrimarySight()
	return self._currentPrimarySight and self._currentPrimarySight.name
end

//-----------------------------------------------------------------------------
// getSecondarySight returns att.name of active secondary sight (magnifier)
//-----------------------------------------------------------------------------

function SWEP:getSecondarySight()
	return self._currentSecondarySight and self._currentSecondarySight.name
end

//-----------------------------------------------------------------------------
// getGLAttName returns att.name of active grenade launcher attachment (if any)
//-----------------------------------------------------------------------------

function SWEP:getGLAttName()
	return (self._currentGrenadeLauncher and self._currentGrenadeLauncher.displayNameShort) or "No grenade launcher attached."
end

//-----------------------------------------------------------------------------
// canAimGL is called from adjustViewmodelPosition to allow/prevent use of
// wep.M203Pos and wep.M203Ang aim-positions
//-----------------------------------------------------------------------------

if CLIENT then
	function SWEP:canAimGL()
		return true
	end
end

//-----------------------------------------------------------------------------
// stripperClipsEnabled
//-----------------------------------------------------------------------------

function SWEP:stripperClipsEnabled()
	return self.ActiveAttachments.kk_ins2_ww2_stripper
end

//-----------------------------------------------------------------------------
// canDoStripperClipReload
//-----------------------------------------------------------------------------

function SWEP:canDoStripperClipReload(ammo, mag)
	return self:stripperClipsEnabled()
		and ammo >= self.stripperCapacity
		and (self.Primary.ClipSize + 1 - mag) >= self.stripperCapacity
end

//-----------------------------------------------------------------------------
// getStripperClipAnimation
//-----------------------------------------------------------------------------

function SWEP:getStripperClipAnimation(ammo, mag)
	local suffix = ""

	if mag < 1 then
		suffix = "_empty"
	end

	local clipDiff = math.floor(math.Clamp(self.Primary.ClipSize + 1 - mag, 0, self.Primary.ClipSize) / self.stripperCapacity)
	local clipIn = 1

	for i = 1, clipDiff - 1 do
		if (ammo - self.stripperCapacity >= clipIn * self.stripperCapacity) then
			clipIn = clipIn + 1
		end
	end

	return "reload_stripper_" .. tostring(clipIn) .. suffix
end

//-----------------------------------------------------------------------------
// IndividualReloadCheck to allow individual weapons to prevent reloads
//-----------------------------------------------------------------------------

function SWEP:IndividualReloadCheck()
	return true
end
