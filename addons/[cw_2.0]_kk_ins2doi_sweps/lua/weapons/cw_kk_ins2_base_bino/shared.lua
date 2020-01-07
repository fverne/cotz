if not CustomizableWeaponry then return end

AddCSLuaFile()

SWEP.Base = "cw_kk_ins2_base_main"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_DOI_P08_FIRE"
SWEP.Recoil = 0.77

SWEP.HipSpread = 0.034
SWEP.AimSpread = 0.012
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.22
SWEP.Shots = 1
SWEP.Damage = 24

SWEP.FirstDeployTime = 0.8
SWEP.DeployTime = 0.8

SWEP.AddSafeMode = false

if CLIENT then
	SWEP.StretchOverlayToScreen = true

	SWEP.MoveWepAwayWhenAiming = true
	SWEP.FadeDuringAiming = false
	SWEP.AdjustableZoom = true
	SWEP.SnapZoom = true
	SWEP.DelayedZoom = true

	SWEP.MinZoom = 60
	SWEP.ZoomAmount = 70
	SWEP.MaxZoom = 80

	SWEP.CustomizePos = Vector()
	SWEP.CustomizeAng = Vector()
end

function SWEP:Reload() end

function SWEP:updateReloadTimes() end

local td = {}

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry_KK.ins2.quickGrenade:canThrow(self) then
			CustomizableWeaponry_KK.ins2.quickGrenade:throw(self)
			return
		end
	end

	if not self:isAiming() then
		return
	end

	if self.Owner._kkNextAirStrike and self.Owner._kkNextAirStrike > CurTime() then
		return
	end

	if CLIENT then return end

	td.filter = self.Owner
	td.start = td.filter:GetShootPos()
	td.endpos = td.start + td.filter:GetAimVector() * 64000

	local tr = util.TraceLine(td)

	if tr.Hit then
		local ent = ents.Create("env_headcrabcanister")

		if !IsValid(ent) then
			return
		end

		self:EmitSound(self.FireSound)

		local CT = CurTime()

		// THX goes to http://steamcommunity.com/sharedfiles/filedetails/?id=104619813
		local ang = Angle(math.sin(CT) * 16 - 55, tr.HitNormal:Angle().y, 0)

		if (tr.HitNormal.z > 0.9999) then
			ang.y = self.Owner:GetAngles().y
		end

		ent:SetPos(tr.HitPos)
		ent:SetAngles(ang)
		ent:SetKeyValue("HeadcrabType", 0)
		ent:SetKeyValue("HeadcrabCount", 10)
		ent:SetKeyValue("FlightSpeed", 4000)
		ent:SetKeyValue("FlightTime", 5)
		ent:SetKeyValue("StartingHeight", 0)
		ent:SetKeyValue("Damage", 256)
		ent:SetKeyValue("DamageRadius", 1024)
		ent:SetKeyValue("SmokeLifetime", 30)
		ent:SetKeyValue("spawnflags", 0)

		ent:Spawn()
		ent:Activate()

		if self.ResponseSound then
			timer.Simple(5, function()
				if IsValid(self.Owner) then
					self.Owner:EmitSound(self.ResponseSound)
				end
			end)
		end

		timer.Simple(8, function()
			if IsValid(ent) then
				ent:Fire("FireCanister")
			end
		end)

		self.Owner._kkNextAirStrike = CT + 8
	end
end

function SWEP:IndividualThink()
	if CLIENT then
		self.CustomizationTab = 1
	end

	weapons.GetStored("cw_kk_ins2_base_main").IndividualThink(self)
end

if CLIENT then
	local att
	local muz = {}

	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			muz.Pos = self.WMEnt:GetPos()
			muz.Ang = EyeAngles()
			return muz
		end

		muz.Pos = self.Owner:EyePos()
		muz.Ang = self.Owner:EyeAngles()

		muz.Pos = muz.Pos + muz.Ang:Forward() * 20 + muz.Ang:Right() * 5 + muz.Ang:Up() * -2

		return muz
	end
end
