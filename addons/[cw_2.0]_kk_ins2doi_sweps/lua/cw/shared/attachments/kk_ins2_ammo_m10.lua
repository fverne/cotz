local att = {}
att.name = "kk_ins2_ammo_m10"
att.displayName = "M10A1 Smoke Rockets"
att.displayNameShort = "Smoke"
att.KK_INS2_playIdle = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Swaps HEAT rockets for white phosphorus smoke rockets.", c = CustomizableWeaponry.textColors.NETURAL}
	}
end

function att:attachFunc()
	self:unloadWeapon()

	self._KK_INS2_customPickupSuffix = "_mm"
	self._KK_INS2_customReloadSuffix = "_mm"

	self.Primary.Ammo = "M10A1 Rocket"
	self.projectileClass = "cw_kk_ins2_projectile_m10"
end

function att:detachFunc()
	self:unloadWeapon()

	self._KK_INS2_customPickupSuffix = ""
	self._KK_INS2_customReloadSuffix = ""

	self.Primary.Ammo = "M6A1 Rocket"
	self.projectileClass = "cw_kk_ins2_projectile_m6a1"
end

CustomizableWeaponry:registerAttachment(att)
