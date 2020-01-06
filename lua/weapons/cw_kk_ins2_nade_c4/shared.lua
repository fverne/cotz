if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "C4 Explosive"
	SWEP.CSMuzzleFlashes = true
	SWEP.DrawAmmo = false

	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_c4_clicker")

	SWEP.AttachmentModelsVM = {
		-- ["element_name"] = {model = "models/weapons/stattrack.mdl", bone = "SECEXP", pos = Vector(-0.64, -0.969, 0.021), angle = Angle(90, 0, 0), size = Vector(0.5, 0.5, 0.5)}
	}

	SWEP.AttachmentModelsWM = {}

	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
	SWEP.HUD_MagText = "PLANTED: "

	SWEP.CustomizationMenuScale = 0.006
end

SWEP.Attachments = CustomizableWeaponry_KK.ins2.slowGrenadeMenu

SWEP.Animations = {
	pullpin = "base_pullback",
	throw = "base_throw",

	pull_short = "low_pullback",
	throw_short = "low_throw",

	plant = "base_plant",

	base_pickup = "base_draw",
	base_idle = "base_idle",
	base_draw = "base_draw",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_crawl = "base_crawl",

	det_boom = "det_detonate",
	det_draw = "det_draw",
	det_holster = "det_holster",
	det_idle = "det_idle",
	det_sprint = "det_sprint",
	det_crawl = "det_crawl",
}

SWEP.CanRestOnObjects = false

-- SWEP.SprintingEnabled = false
SWEP.AimingEnabled = false
SWEP.CanCustomize = true
SWEP.AccuracyEnabled = false

SWEP.SpeedDec = 5

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "slam"
SWEP.RunHoldType = "slam"
SWEP.FireModes = {"single"}
SWEP.Base = "cw_kk_ins2_base_nade"
SWEP.Category = "Ethereal Thrown"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_c4_sec.mdl"
SWEP.WorldModel		= "models/weapons/w_cw_kk_ins2_c4.mdl"

SWEP.WMPos = Vector(5.5, 3.295, -1.765)
SWEP.WMAng = Angle(-28.962, 165.365, 70)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.Ammo			= "C4"

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001

SWEP.SpeedDec = 0
SWEP.Recoil = 1

SWEP.WeaponLength = 40

SWEP.KKINS2RCE = true

SWEP.canCook = false
SWEP.mustCook = false
SWEP.canPlant = true

SWEP.projectileClass = "cw_kk_ins2_projectile_c4"

SWEP.fuseTime = 0
SWEP.timeToThrow = 0.4
SWEP.swapTime = 0.9
SWEP.maxVelDelay = 0.7

SWEP.timeToThrowShort = 0.4
SWEP.swapTimeShort = 0.9
SWEP.maxVelDelayShort = 0.7

SWEP.spawnTimePlant = 0.4
SWEP.swapTimePlant = 1

SWEP.spawnOffsetShort = Vector(0, 0, 0)

SWEP.velocityModForwardMinMaxShort = {0.5, 1.2}
SWEP.velocityModForwardMinMax = {0.5, 1.2}
SWEP.velocityModUpMinMaxShort = {0.6, 1.1}
SWEP.velocityModUpMinMax = {0.6, 1.1}

SWEP.reticleInactivityCallbacksRaw = {
	["det_boom"] = 0.1,
}

function SWEP:PrimaryAttack()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		self:_attack(1)
	else
		self:detonateLast()
	end
end

function SWEP:fuseProjectile(grenade, overrideTime)
	grenade:SetOwner(self.lastOwner)

	grenade:InitPhys()

	grenade:SetDetonator(self)
	self.PlantedCharges[grenade] = grenade
end

//-----------------------------------------------------------------------------
// old functions
//-----------------------------------------------------------------------------

if SERVER then
	function SWEP:EquipAmmo(ply)
		local owned = ply:GetWeapon(self:GetClass())
		local remove = self:Clip1()

		if IsValid(owned) then
			remove = table.Count(self.PlantedCharges)

			for k,v in pairs(self.PlantedCharges) do
				if IsValid(v) then
					v:SetDetonator(owned)
					owned.PlantedCharges[v] = v
				end
			end
		end

		if self._fresh then
			ply:GiveAmmo(1, self.Primary.Ammo)
		else
			ply:RemoveAmmo(remove, self.Primary.Ammo)
		end
	end

	function SWEP:equipFunc()
		local ply = self.Owner

		if self._fresh then
			self._fresh = false
			ply:GiveAmmo(1, self.Primary.Ammo)
		else
			ply:RemoveAmmo(0, self.Primary.Ammo)
		end
	end

	function SWEP:IndividualInitialize()
		self._fresh = true
		self.PlantedCharges = {}
	end

	function SWEP:OnDrop() end
end

function SWEP:ShouldDropOnDie()
	return true
end

local SP = game.SinglePlayer()

function SWEP:IndividualThink_INS2()
	if self.PlantedCharges then
		for k,v in pairs(self.PlantedCharges) do
			if !IsValid(v) then
				self.PlantedCharges[v] = nil
			end
		end

		self:SetClip1(table.Count(self.PlantedCharges))
	end
end

function SWEP:detonateC4()
	self:EmitSound("CW_KK_INS2_C4_TRIGGERSEC")

	if SERVER then
		for _,v in pairs(self.PlantedCharges) do
			v:Fuse()
		end
	end
end

function SWEP:canAnimate()
	if SP then
		return SERVER
	else
		return CLIENT and IsFirstTimePredicted()
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		if CLIENT then
			self.reticleInactivity = UnPredictedCurTime() + 2.5
		end

		if self:canAnimate() then
			self:holsterAnimFunc()
		end

		local oldMAD = self.meleeAttackDelay or 0

		CustomizableWeaponry.actionSequence.new(self, 0.4, nil, function()
			if math.abs((self.meleeAttackDelay or 0) - oldMAD) > 0.1 then return end

			if self:canAnimate() then
				self:sendWeaponAnim("det_draw", 1, 0)
			end
		end)

		CustomizableWeaponry.actionSequence.new(self, 0.7, nil, function()
			if math.abs((self.meleeAttackDelay or 0) - oldMAD) > 0.1 then return end

			if self:canAnimate() then
				self:sendWeaponAnim("det_boom", 1, 0)
			end
		end)

		CustomizableWeaponry.actionSequence.new(self, 1, nil, function()
			if math.abs((self.meleeAttackDelay or 0) - oldMAD) > 0.1 then return end

			self:detonateC4()
		end)

		CustomizableWeaponry.actionSequence.new(self, 1.7, nil, function()
			if math.abs((self.meleeAttackDelay or 0) - oldMAD) > 0.1 then return end

			if self:canAnimate() then
				self:drawAnimFunc()
			end
		end)

		local CT = CurTime()

		self:SetNextPrimaryFire(CT + 2)
		self:SetNextSecondaryFire(CT + 2)
	else
		self:detonateLast()
	end
end

function SWEP:detonateLast()
	if self:canAnimate() then
		self:sendWeaponAnim("det_boom", 1, 0)
	end

	local oldMAD = self.meleeAttackDelay or 0

	CustomizableWeaponry.actionSequence.new(self, 10/30, nil, function()
		if math.abs((self.meleeAttackDelay or 0) - oldMAD) > 0.1 then return end

		self:detonateC4()
	end)

	CustomizableWeaponry.actionSequence.new(self, 0.62, nil, function()
		if math.abs((self.meleeAttackDelay or 0) - oldMAD) > 0.1 then return end

		if self:canAnimate() then
			self:sendWeaponAnim("det_idle", 1, 0)
		end
	end)

	local CT = CurTime()

	self:SetNextPrimaryFire(CT + 1)
	self:SetNextSecondaryFire(CT + 1)
end

function SWEP:getForegripMode()
	if IsValid(self.Owner) and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		return "base_"
	end

	return "det_"
end

function SWEP:drawAnimFunc()
	local prefix = self:getForegripMode()

	self:sendWeaponAnim(prefix .. "draw", 1, 0)
end

function SWEP:idleAnimFunc()
	local prefix = self:getForegripMode()

	self:sendWeaponAnim(prefix .. "idle", 1, 0)
end

function SWEP:sprintAnimFunc()
	local prefix = self:getForegripMode()

	self:sendWeaponAnim(prefix .. "sprint", 1, 0)
end

function SWEP:proneAnimFunc()
	local prefix = self:getForegripMode()

	self:sendWeaponAnim(prefix .. "crawl", 1, 0)
end

if CLIENT then
	-- function SWEP:updateOtherParts()
		-- self.AttachmentModelsVM.element_name.ent._KKCSGONUM = 160224
		-- self.AttachmentModelsVM.element_name.active = CustomizableWeaponry_KK.HOME
	-- end

	local m, pos, ang, offset
	local muz = {}

	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		else
			if string.StartWith(self.Sequence, "det_") then
				m = self.CW_VM:GetBoneMatrix(62)
			else
				m = self.CW_VM:GetBoneMatrix(8)
			end
		end

		if self.CustomizeMenuAlpha > 0 then
			offset = self.HUD_3D2DOffsetMenu
		else
			offset = self.HUD_3D2DOffset
		end

		pos = m:GetTranslation()
		ang = EyeAngles()

		pos = pos + ang:Right() * offset.x
		pos = pos + ang:Up() * offset.y
		pos = pos + ang:Forward() * offset.z

		muz.Pos = pos
		muz.Ang = m:GetAngles()
		return muz
	end
end
