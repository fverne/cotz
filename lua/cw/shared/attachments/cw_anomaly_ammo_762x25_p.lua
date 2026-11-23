-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x25_p"

att.displayName = "Ammunition 7,62x25 mm P"

att.displayNameShort = "Ammunition 7,62x25 mm P"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x25MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x25_p")

	att.description = {{t = "Soviet 7.62 mm caliber pistol cartridge, now known as 7.62x25 mm Tokarev. The bullet has a lead core and a tompak-clad steel jacket. The bullet has a muzzle velocity of 420 meters per second, and the energy is 510 joules. In order to make a more reliable connection between the bullet and the cartridge case, which was made of brass, the bullet was fixed in the cartridge case by circular crimping of the cartridge case muzzle and subsequent lurching. In the warehouses of military of the Russian Armed Forces still have a very large number of these cartridges.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x25_p", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x25_p", false)

end

CustomizableWeaponry:registerAttachment(att)
