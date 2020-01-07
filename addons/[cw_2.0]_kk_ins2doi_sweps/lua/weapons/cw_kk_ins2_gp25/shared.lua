if not CustomizableWeaponry then return end

AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "GP35"
	SWEP.CSMuzzleFlashes = true
	SWEP.DrawAmmo = false

	SWEP.ViewModelMovementScale = 1.15

	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/underbarrel_gp25_he")

	SWEP.MuzzleAttachmentName = "muzzle_gl"
	SWEP.NoShells = true

	SWEP.AttachmentModelsVM = {
		["kk_ins2_gl_gp25"] = {model = "models/weapons/upgrades/a_gl_gp25.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},

		["40mm_kk_1337"] = {model = "models/weapons/w_at4_projectile.mdl", bone = "GL_Round", pos = Vector(1.75,0,0), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85),
			-- active = function(self)
				-- local correctAmmo = CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM] and CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM].name == "40mm_kk_1337"
				-- local nadeVisible = (self:Clip1() > 0) or (self.Sequence == self.Animations.gl_on_reload and self.CW_VM:GetCycle() > 0.2)
				-- return correctAmmo and nadeVisible
			-- end
		},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_gl_gp25_merge"] = {model = "models/weapons/upgrades/w_gp25.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
	}

	SWEP.ForeGripOffsetCycle_Reload = 0
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0
	SWEP.ForeGripOffsetCycle_Draw = 0

	SWEP.ForegripOverridePos = {
		righthandfix = {
			["R Clavicle"] = {pos = Vector(9.68, 0, -0.046), angle = Angle()}
		}
	}

	SWEP.ForegripParent = "righthandfix"
	SWEP.ForegripOverride = true

	SWEP.IronsightPos = Vector(-0.539, -8, 1.0201)
	SWEP.IronsightAng = Vector(5.3932, 0.0032, 0)

	SWEP.AlternativePos = Vector(1, -8, 0)
	SWEP.AlternativeAng = Vector()

	SWEP.CustomizePos = Vector(1, -8, 0)
	SWEP.CustomizeAng = Vector()

	SWEP.SprintPos = Vector(1, -8, 0)
	SWEP.SprintAng = Vector()

	SWEP.HUD_MagText = "BARREL: "
	SWEP.CustomizationMenuScale = 0.01

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
end

SWEP.MuzzleEffect = "ins_weapon_m203"

SWEP.Chamberable = false
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {
	{header = "", offset = {0, -500}, atts = {"kk_ins2_gp25_ammo"}},
}

SWEP.Animations = {
	base_pickup = "gl_draw",
	base_draw = "gl_draw",
	base_fire = "gl_fire",
	base_fire_aim = {"gl_iron_fire","gl_iron_fire_a","gl_iron_fire_b","gl_iron_fire_c","gl_iron_fire_d","gl_iron_fire_e","gl_iron_fire_f"},
	base_fire_empty = "gl_dryfire",
	base_fire_empty_aim = "gl_iron_dryfire",
	base_reload = "gl_reload",
	base_reload_empty = "gl_reloadempty",
	base_idle = "gl_holster",
	base_holster = "gl_holster",
	base_sprint = "gl_sprint",
	base_safe = "gl_down",
	base_safe_aim = "gl_iron_down",

	gl_off_pickup = "gl_draw",
	gl_off_draw = "gl_draw",
	gl_off_fire = "gl_fire",
	gl_off_fire_aim = {"gl_iron_fire","gl_iron_fire_a","gl_iron_fire_b","gl_iron_fire_c","gl_iron_fire_d","gl_iron_fire_e","gl_iron_fire_f"},
	gl_off_fire_empty = "gl_dryfire",
	gl_off_fire_empty_aim = "gl_iron_dryfire",
	gl_off_reload = "gl_reload",
	gl_off_reload_empty = "gl_reloadempty",
	gl_off_idle = "gl_holster",
	gl_off_holster = "gl_holster",
	gl_off_sprint = "gl_sprint",
	gl_off_safe = "gl_down",
	gl_off_safe_aim = "gl_iron_down",

	gl_on_draw = "glsetup_draw",
	gl_on_fire = "glsetup_fire",
	gl_on_fire_aim = "glsetup_iron_fire",
	gl_on_fire_empty = "glsetup_dryfire",
	gl_on_fire_empty_aim = "glsetup_iron_dryfire",
	gl_on_reload = "glsetup_reload",
	gl_on_idle = "glsetup",
	gl_on_holster = "glsetup_holster",
	gl_on_sprint = "glsetup_sprint",
	gl_on_safe = "glsetup_down",
	gl_on_safe_aim = "glsetup_iron_down",

	gl_turn_on = "glsetup_in",
	gl_turn_off = "glsetup_out",
}

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	base_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	base_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_AK74_RATTLE"},
	},

	base_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_AK74_RATTLE"},
		{time = 96/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 102/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	foregrip_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
	},

	foregrip_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
		{time = 98/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	foergrip_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	foregrip_iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	gl_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	gl_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	gl_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	gl_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	gl_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	gl_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
	},

	gl_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
		{time = 98/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	gl_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	gl_iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	glsetup_in = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_SELECT"},
	},

	glsetup_out = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_DESELECT"},
	},

	glsetup_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_dryfire = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_EMPTY"},
	},

	glsetup_iron_dryfire = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_EMPTY"},
	},

	glsetup_reload = {
		{time = 0, sound = "CW_KK_INS2_GL_BEGINRELOAD"},
		{time = 40/30, sound = "CW_KK_INS2_GP30_INSERTGRENADE"},
		{time = 54/30, sound = "CW_KK_INS2_GP30_INSERTGRENADECLICK"},
	},
}

SWEP.SpeedDec = 5

SWEP.Slot = 5
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_ak74.mdl"
SWEP.WorldModel		= "models/weapons/w_ak74.mdl"

SWEP.WMPos = Vector(5.666, 0.66, -1.055)
SWEP.WMAng = Angle(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.AdminOnly		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "40MM"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_KK_INS2_GP30_FIRE"
SWEP.Recoil = 5

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 33

SWEP.FirstDeployTime = 0.5
SWEP.DeployTime = 0.6

SWEP.ReloadTimes = {
	gl_reload = {1.7, 2},
	gl_reloadempty = {1.7, 2},
}

if CLIENT then
	function SWEP:_drawViewModel()
		self.CW_VM:FrameAdvance(FrameTime())
		self.CW_VM:SetupBones()
		-- self.CW_VM:DrawModel()
		RunConsoleCommand("cw_alternative_vm_pos", 1)

		if CurTime() > self.grenadeTime and CurTime() > self.knifeTime then
			self.CW_KK_HANDS:SetPos(self.CW_VM:GetPos())

			self.CW_KK_HANDS:SetParent(self.CW_VM)
			self.CW_KK_HANDS:AddEffects(EF_BONEMERGE)
			self.CW_KK_HANDS:DrawModel()
		end

		self:drawAttachments()
		self:drawInteractionMenu()

		if self.reticleFunc then
			self.reticleFunc(self)
		end

		if GetConVarNumber("cw_customhud_ammo") >= 1 then
			self:draw3D2DHUD()
		end
	end
end

function SWEP:fireAnimFunc()
	if self:Clip1() == 0 then
		self:sendWeaponAnim("base_fire_empty",1,0)
	end
end

function SWEP:FireBullet(Damage, CurCone, ClumpSpread, Shots)
	if Shots == 1 then
		local target = CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM]

		if not target then
			CustomizableWeaponry.grenadeTypes.defaultFireFunc(self)
		else
			target.fireFunc(self)
		end

		CustomizableWeaponry.grenadeTypes.selectFireSound(self, target)
	else
		weapons.GetStored("cw_base").FireBullet(self, Damage, CurCone, ClumpSpread, Shots)
	end
end

function SWEP:reloadAnimFunc(lm)
	self.dt.AT4ReloadEnd = CurTime() + self.ReloadHalt

	self:sendWeaponAnim("gl_turn_on",1,0.08)

	CustomizableWeaponry.actionSequence.new(self, 0.15, nil, function()
		self:sendWeaponAnim("gl_on_reload",1,0.08)
	end)

	CustomizableWeaponry.actionSequence.new(self, 1.8, nil, function()
		self:sendWeaponAnim("gl_off_holster",-1,0)
	end)

	return 1.7, 2
end //*/

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Int", 1, "Shots")
	self:NetworkVar("Float", 0, "HolsterDelay")
	self:NetworkVar("Float", 1, "AT4ReloadEnd")
	self:NetworkVar("Bool", 0, "Suppressed")
	self:NetworkVar("Bool", 1, "Safe")
	self:NetworkVar("Bool", 2, "BipodDeployed")
	self:NetworkVar("Angle", 0, "ViewOffset")
end

function SWEP:getReloadProgress()
	local CT = CurTime()

	if self.dt.AT4ReloadEnd < CT then return end

	return math.Round((CT - self.dt.AT4ReloadEnd + self.ReloadHalt) * 100 / self.ReloadHalt)
end

function SWEP:unloadM203()
	self:unloadWeapon()
end

function SWEP:equipFunc()
	if SERVER then
		CustomizableWeaponry.giveAttachments(self.Owner, {"kk_ins2_gl_gp25", "kk_ins2_gp25_ammo"}, true)
	end
end
