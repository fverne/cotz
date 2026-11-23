-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x54_7h14"

att.displayName = "Ammunition 7,62x54 mm 7N14"

att.displayNameShort = "Ammunition 7,62x54 mm 7N14"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x54MMR"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x54_7h14")

	att.description = {{t = "Specially developed modernized sniper cartridge 7.62x54 mm with armor-piercing bullet SNB. The bullet is equipped with a combined core of lead and hardened U12A steel, capable of penetrating body armor and small obstacles. Compared to a standard round of the same caliber, it has a lighter tail section, which provides greater accuracy and improved ballistic characteristics.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x54_7h14", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x54_7h14", false)

end

CustomizableWeaponry:registerAttachment(att)
