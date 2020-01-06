if not CustomizableWeaponry then return end
AddCSLuaFile()

SWEP.KKINS2Melee = true

if CLIENT then
	SWEP.SprintAnimSpeed = 1.2
	SWEP.ViewModelMovementScale_sprint = 0.5
	SWEP.ViewModelMovementScale_base = 0.6
	SWEP.DisableSprintViewSimulation = true

	SWEP.IconLetter = "j"

	SWEP.HUD_3D2DBone = 32
end

SWEP.Attachments = {}

SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.Author			= "Knife Kitty"
SWEP.Contact		= "http://steamcommunity.com/profiles/76561198012236670/"
SWEP.Purpose		= "detaching shared functions"
SWEP.Instructions	= "dont spawn this directly"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.AimingEnabled = false
SWEP.CanCustomize = false
SWEP.HolsterUnderwater = false
SWEP.HolsterOnLadder = false
SWEP.AccuracyEnabled = false
SWEP.AddSafeMode = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001
SWEP.Recoil = 3

SWEP.FireDelay = 0.6
SWEP.ReticleInactivityPostFire = 0.6

SWEP.FirstDeployTime = 0.6
SWEP.DeployTime = 0.6
SWEP.HolsterTime = 0.4

SWEP.SpeedDec = 0
SWEP.WeaponLength = 0

SWEP.AttackSound = ""
SWEP.HitFleshSound = "CW_KK_INS2_KNIFE"
SWEP.HitWorldSound = "CW_KK_INS2_KNIFE"

SWEP.DamageBase = 25
SWEP.DamageRand = 10
SWEP.DamageOutputDelay = 0.2
SWEP.DamageType = DMG_SLASH

//-----------------------------------------------------------------------------
// getMuzzlePosition edited to use bone matrices
//-----------------------------------------------------------------------------

if CLIENT then
	local m
	local muz = {}

	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		else
			m = self.CW_VM:GetBoneMatrix(self.HUD_3D2DBone)
		end

		muz.Pos = m:GetTranslation()
		muz.Ang = m:GetAngles()
		return muz
	end
end

//-----------------------------------------------------------------------------
// delayed aim vector trace and tr.ent:TakeDamageInfo
//-----------------------------------------------------------------------------

local CT

function SWEP:PrimaryAttack()
	if self:IsOwnerCrawling() then
		return
	end

	CT = CurTime()

	if self.meleeAttackDelay and self.meleeAttackDelay > CT then
		return
	end

	// ignore near-wall
	for i = 1, 2 do
		if not self:canFireWeapon(i) then
			return
		end
	end

	if self.InactiveWeaponStates[self.dt.State] then
		return
	end

	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry_KK.ins2.quickGrenade:canThrow(self) then
			CustomizableWeaponry_KK.ins2.quickGrenade:throw(self)
			return
		end
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if IsFirstTimePredicted() then
		self:sendWeaponAnim("base_fire",1,0)

		self:EmitSound(self.AttackSound)

		self.meleeAttackDelay = CT + self.FireDelay
		-- self:SetNextPrimaryFire(CT + self.FireDelay)

		if CLIENT then
			if self.ReticleInactivityPostFire then
				self.reticleInactivity = UnPredictedCurTime() + self.ReticleInactivityPostFire
			end
		end

		CustomizableWeaponry.actionSequence.new(self, self.DamageOutputDelay, nil, function()
			local start = self.Owner:GetShootPos()

			local tr = util.TraceLine({
				start = start,
				endpos = start + self.Owner:GetAimVector() * 60,
				filter = self.Owner
			})

			if tr.Hit then
				local ent = tr.Entity

				if IsValid(ent) then
					if SERVER then
						local d = DamageInfo()

						d:SetAttacker(self.Owner)
						d:SetInflictor(self)

						d:SetDamage(math.random(self.DamageRand) + self.DamageBase)

						local dir = self.Owner:GetAimVector() - start
						-- d:SetDamageForce((tr.HitPos + dir) * 200)
						d:SetDamageType(self.DamageType)
						d:SetDamagePosition(tr.HitPos)
						d:SetReportedPosition(start)

						ent:TakeDamageInfo(d)
					end

					-- if tr.MatType == MAT_METAL or tr.MatType == MAT_CONCRETE then
						-- local ed = EffectData()
						-- local dir = start - tr.HitPos
						-- ed:SetOrigin(tr.HitPos + (dir))
						-- util.Effect("StunstickImpact", ed)
					-- end

					if (ent.IsNPC and ent:IsNPC()) or (ent.IsPlayer and ent:IsPlayer()) then
						self:EmitSound(self.HitFleshSound)
					else
						self:EmitSound(self.HitWorldSound)
					end
				else
					self:EmitSound(self.HitWorldSound)
				end

				self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			else
				self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			end
		end)
	end
end

//-----------------------------------------------------------------------------
// stab (slower,stronger) attack someday, maybe?
//-----------------------------------------------------------------------------

function SWEP:SecondaryAttack() end

//-----------------------------------------------------------------------------
// nothing to reload
//-----------------------------------------------------------------------------

function SWEP:Reload() end

//-----------------------------------------------------------------------------
// nothing to update
//-----------------------------------------------------------------------------

function SWEP:updateReloadTimes() end
