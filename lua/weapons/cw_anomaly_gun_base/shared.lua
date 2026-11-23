AddCSLuaFile()
AddCSLuaFile("cl_draw.lua")

SWEP.Base = "cw_base"
SWEP.PrintName = "Anomaly CW2 firearm base"
SWEP.Spawnable = false
SWEP.Attachments = {}
SWEP.Sounds = {}
SWEP.AnomalyAttachmentOrder = {}
SWEP.AnomalySource = {Primary = {}, Secondary = {}}

local ANIMATION_KEYS = {shoot1 = "fire", shoot1_last = "fire_dry"}

-- Source stats whose attachment changes apply to the COTZ-balanced native stats as ratios.
local SCALED_FIELDS = {
	Damage = "Damage",
	Spread = "HipSpread",
	IronAccuracy = "AimSpread",
}

local function getStateStat(state, path)
	local value = state

	for key in string.gmatch(path, "[^.]+") do
		if not istable(value) then return end
		value = value[key]
	end

	return value
end

local function getSourceRecoil(primary)
	return ((primary.KickUp or 0) + (primary.KickDown or 0)) * 0.5
end

-- Applies a source attachment change to a COTZ-balanced stat as a ratio of the source value.
local function scaleBySource(balanced, current, source)
	if not current or not source or source == 0 then return balanced end

	return balanced * current / source
end

local function applyChanges(state, target, changes, context)
	for key, value in pairs(changes) do
		if isfunction(value) then
			local previous = target[key]
			if previous == nil and (context == "Animations" or context == "IronAnimation"
				or context == "SprintAnimation") then previous = {} end
			target[key] = value(state, previous)
		elseif istable(value) and not isvector(value) and not isangle(value) then
			target[key] = target[key] or {}
			applyChanges(state, target[key], value, key)
		else
			target[key] = value
		end
	end
end

function SWEP:Initialize()
	self.Primary = table.Copy(self.Primary)
	self.Secondary = table.Copy(self.Secondary)
	self.Animations = table.Copy(self.Animations)
	self.Attachments = table.Copy(self.Attachments)
	self.ActiveAttachments = {}

	if SERVER and not self.ixItem then
		self:SetWeaponDurability(100)
		self:SetWeaponWear(100)
	end

	return baseclass.Get("cw_base").Initialize(self)
end

function SWEP:IndividualInitialize()
	-- SWEP fields carry the COTZ balance; source values only supply attachment ratios.
	self.AnomalyBalanced = {Recoil = self.Recoil_Orig, ClumpSpread = self.ClumpSpread_Orig}

	for _, nativeField in pairs(SCALED_FIELDS) do
		self.AnomalyBalanced[nativeField] = self[nativeField .. "_Orig"]
	end

	self.AnomalyBaselineAnimations = table.Copy(self.Animations)
	self.AnomalyAttachmentState = {}
	self:ApplyAnomalyAttachments()
end

function SWEP:ApplyAnomalyAttachments(changedID, enabled)
	self.AnomalyAttachmentState = self.AnomalyAttachmentState or {}

	if changedID then
		self.AnomalyAttachmentState[changedID] = enabled
	end

	local state = table.Copy(self.AnomalySource)
	state.GetStat = getStateStat
	state.GLDeployed = function() return self.AnomalyGLActive == true end
	state.CheckVMSequence = function(_, name) return self.AnomalySequences[name] ~= nil end
	state.Primary.ClumpSpread = self.AnomalyBalanced.ClumpSpread
	state.Animations = {}
	state.IronAnimation = {loop = {}, shoot = {}}
	state.SprintAnimation = {loop = {}}

	for key, sequence in pairs(self.AnomalyBaselineAnimations or self.Animations) do
		state.Animations[key] = {value = sequence}
	end

	self.AnomalyLauncher = nil

	for _, id in ipairs(self.AnomalyAttachmentOrder) do
		if self.AnomalyAttachmentState[id] then
			local attachment = CustomizableWeaponry:findAttachment(id)
			applyChanges(state, state, attachment.anomalyEffect)

			if attachment.anomalyLauncher.Ammo then
				self.AnomalyLauncher = attachment.anomalyLauncher
			end
		end
	end

	self.AnomalyState = state
	self.AnomalyGLActive = self.AnomalyLauncher ~= nil and self.AnomalyGLActive or false

	local source = self.AnomalySource.Primary

	for sourceField, nativeField in pairs(SCALED_FIELDS) do
		self[nativeField .. "_Orig"] = scaleBySource(self.AnomalyBalanced[nativeField],
			state.Primary[sourceField], source[sourceField])
	end

	self.Recoil_Orig = scaleBySource(self.AnomalyBalanced.Recoil, getSourceRecoil(state.Primary),
		getSourceRecoil(source))
	self.ClumpSpread_Orig = state.Primary.ClumpSpread
	self.Shots = state.Primary.NumShots or self.Shots_Orig or self.Shots
	self.FireSound = state.Primary.Sound or self.FireSound_Orig
	self.dt.Suppressed = state.Silenced or self.AnomalyInitialSilenced
	self.Primary.Ammo = state.Primary.Ammo
	self:setupBallisticsInformation()
	self:CalculateEffectiveRange()

	if CLIENT then
		self.AnomalySightPos = state.IronSightsPos or self.IronsightPos
		self.AnomalySightAng = state.IronSightsAng or self.IronsightAng
		local suffix = state.INS2_SightSuffix

		if suffix then
			self.AnomalySightPos = state["IronSightsPos_" .. suffix] or self.AnomalySightPos
			self.AnomalySightAng = state["IronSightsAng_" .. suffix] or self.AnomalySightAng
		end

		self:setupCurrentIronsights(self.AnomalySightPos, self.AnomalySightAng)
		local zoom = state.Secondary.ScopeZoom or self.AnomalyScopeZoom
		self.ZoomAmount = zoom and (90 - 90 / zoom) or (90 - (state.Secondary.IronFOV or 70))
		self.AnomalyScopeActive = zoom ~= nil
		self.MoveWepAwayWhenAiming = self.AnomalyScopeActive
		self:UpdateAnomalyMaterials()
		-- Attachment scopes draw the reticle of their own sight model; built-in scopes use ScopeReticule.
		local sightReticle = self.AnomalySightReticles and self.AnomalySightReticles[state.INS2_SightVElement]
		self.AnomalyScopeReticle = state.Secondary.ScopeZoom and sightReticle or self.AnomalyReticle
		self.AnomalyReticleMaterial = state.StencilSight_ReticleMaterial
			and Material(state.StencilSight_ReticleMaterial) or nil
	end

	for key, data in pairs(state.Animations) do
		if data.value and self.AnomalySequences[data.value] then
			self.Animations[ANIMATION_KEYS[key] or key] = data.value
		end
	end

	self.AnomalyActiveAimFire = state.IronAnimation.shoot.value or self.AnomalyAimFire
	self.AnomalyActiveLastFire = state.Animations.shoot1_last and state.Animations.shoot1_last.value
	for _, key in ipairs({"reload", "reload_empty"}) do
		local duration = self.AnomalySequences[self.Animations[key]]

		if duration then
			local suffix = key == "reload_empty" and "_Empty" or ""
			self["ReloadTime" .. suffix] = duration
			self["ReloadHalt" .. suffix] = duration
		end
	end

	if SERVER then
		local ids = {}
		for _, id in ipairs(self.AnomalyAttachmentOrder) do
			if self.AnomalyAttachmentState[id] then ids[#ids + 1] = id end
		end
		self:SetNWString("cotz/anomaly/attachments", table.concat(ids, ","))
	end

	self:recalculateStats()
end

-- An ammunition attachment must never relabel rounds already loaded in the weapon.
function SWEP:_attach(category, position, inherited)
	local group = self.Attachments[category]
	local id = group and group.atts[position]

	if id and string.find(id, "_ammo_", 1, true) and self:Clip1() > 0 then return false end

	return baseclass.Get("cw_base")._attach(self, category, position, inherited)
end

function SWEP:_detach(category, position, skipDependencyCheck)
	local group = self.Attachments[category]
	local id = group and group.atts[position]

	if id and string.find(id, "_ammo_", 1, true) and self:Clip1() > 0 then return false end

	local result = baseclass.Get("cw_base")._detach(self, category, position, skipDependencyCheck)
	self:ApplyAnomalyAttachments()

	return result
end

function SWEP:fireAnimFunc()
	local sequence = self.Animations.fire

	if self.dt.State == CW_AIMING then
		sequence = self.AnomalyActiveAimFire or sequence
	end

	if self:Clip1() <= self.AmmoPerShot and self.AnomalySequences.anm_shots_last then
		sequence = self.AnomalyActiveLastFire or "anm_shots_last"
	end

	self:sendWeaponAnim(sequence)
end

function SWEP.bulletCallback(player, trace, damage)
	baseclass.Get("cw_base").bulletCallback(player, trace, damage)
	local weapon = player:GetActiveWeapon()
	if not SERVER or not weapon.AnomalyTracer then return end
	local effect = EffectData()
	effect:SetEntity(weapon)
	effect:SetStart(trace.StartPos)
	effect:SetOrigin(trace.HitPos)
	util.Effect(weapon.AnomalyTracer, effect)
end

function SWEP:FireBullet(damage, cone, clumpSpread, bullets)
	if not self.AnomalyProjectile then
		return baseclass.Get("cw_base").FireBullet(self, damage, cone, clumpSpread, bullets)
	end

	if SERVER then
		local projectile = self:SpawnAnomalyProjectile(self.AnomalyProjectile, self.AnomalyProjectileVelocity)
		self.AnomalyProjectileFailed = not IsValid(projectile)
	end
end

function SWEP:SpawnAnomalyProjectile(class, velocity)
	local owner = self:GetOwner()
	local projectile = ents.Create("cw_" .. class)
	if not IsValid(projectile) then return end
	projectile:SetOwner(owner)
	projectile:SetPos(owner:GetShootPos() + owner:GetAimVector() * 16)
	projectile:SetAngles(owner:EyeAngles())
	projectile:Spawn()
	projectile:Activate()
	local physics = projectile:GetPhysicsObject()

	if IsValid(physics) then
		physics:SetVelocity(owner:GetAimVector() * velocity + owner:GetVelocity())
	end

	return projectile
end

function SWEP:Reload()
	if self.AnomalyAmmoUnavailable then return end
	if not self.AnomalyGLActive then return baseclass.Get("cw_base").Reload(self) end
	if self.AnomalyLauncherReloadAt or self:GetNWBool("cotz/anomaly/launcher-loaded", false) then return end
	local owner = self:GetOwner()
	if owner:GetAmmoCount(self.AnomalyLauncher.Ammo) < 1 then return end
	if not self:canFireWeapon(1) then return end
	self.AnomalyLauncherReloadAt = CurTime() + self.AnomalyLauncherReloadTime
	self.AnomalyReloadOwner = owner
	self.AnomalyReloadCharacter = owner.GetCharacter and owner:GetCharacter()
	self:sendWeaponAnim("anm_reload_g")
	self:SetNextPrimaryFire(self.AnomalyLauncherReloadAt)
	self:SetNextSecondaryFire(self.AnomalyLauncherReloadAt)
end

function SWEP:IndividualThink()
	if not self.AnomalyLauncherReloadAt or CurTime() < self.AnomalyLauncherReloadAt then return end
	self.AnomalyLauncherReloadAt = nil
	if not SERVER then return end
	local owner = self:GetOwner()
	if not IsValid(owner) or owner ~= self.AnomalyReloadOwner or owner:GetActiveWeapon() ~= self then return end
	if owner.GetCharacter and owner:GetCharacter() ~= self.AnomalyReloadCharacter then return end
	if not self.AnomalyLauncher then return end
	local ammo = self.AnomalyLauncher.Ammo

	if owner:GetAmmoCount(ammo) > 0 then
		owner:RemoveAmmo(1, ammo)
		self:SetNWBool("cotz/anomaly/launcher-loaded", true)
	end
end

function SWEP:SecondaryAttack()
	if not self.AnomalyLauncher or not self:GetOwner():KeyDown(IN_USE) then
		return baseclass.Get("cw_base").SecondaryAttack(self)
	end

	if CurTime() < self:GetNextSecondaryFire() or self.ReloadDelay or self.AnomalyLauncherReloadAt then return end
	self:SetNextSecondaryFire(CurTime() + 0.3)

	if IsFirstTimePredicted() then
		self.AnomalyGLActive = not self.AnomalyGLActive
		self:ApplyAnomalyAttachments()
	end
end

function SWEP:PrimaryAttack()
	if self.AnomalyAmmoUnavailable then return end
	if not self.AnomalyGLActive then
		local clip = self:Clip1()
		self.AnomalyProjectileFailed = false
		local result = baseclass.Get("cw_base").PrimaryAttack(self)

		if SERVER and self.AnomalyProjectileFailed then
			self:SetClip1(clip)
		end

		return result
	end

	if not self:canFireWeapon(1) or not self:canFireWeapon(2) or not self:canFireWeapon(3) then return end
	local owner = self:GetOwner()
	local launcher = self.AnomalyLauncher
	if not self:GetNWBool("cotz/anomaly/launcher-loaded", false) then return end
	self:SetNextPrimaryFire(CurTime() + self.FireDelay)

	if IsFirstTimePredicted() then
		self:sendWeaponAnim("anm_shots_g")
		self:EmitSound(self.AnomalySource.Primary.GLSound or "TFA_ANOMALY.GRENADE.LAUNCH")
	end

	if SERVER then
		local class = string.find(launcher.DefaultModel or "", "wpn_vog", 1, true)
			and "anomaly_rg6_rocket" or "anomaly_40mm_rocket"
		local projectile = self:SpawnAnomalyProjectile(class, launcher.Velocity)

		if IsValid(projectile) then
			self:SetNWBool("cotz/anomaly/launcher-loaded", false)
		end
	end
end

if CLIENT then
	include("cl_draw.lua")
end
