-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x54_7h1"

att.displayName = "Ammunition 7,62x54 mm 7N1"

att.displayNameShort = "Ammunition 7,62x54 mm 7N1"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x54MMR"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x54_7h1")

	att.description = {{t = "Specially developed modernized sniper cartridge 7.62x54 mm with armor-piercing SNB bullet. The bullet has a combined lead and hardened steel core U12A, capable of penetrating body armor and small obstacles. Compared to the standard cartridge of the same caliber, it has a lightened tail section, which provides greater accuracy and improved ballistic characteristics.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x54_7h1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x54_7h1", false)

end

CustomizableWeaponry:registerAttachment(att)
