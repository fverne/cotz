-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_556x45_fmj"

att.displayName = "Ammunition 5,56x45 mm FMJ"

att.displayNameShort = "Ammunition 5,56x45 mm FMJ"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "5.56x45MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_556x45_fmj")

	att.description = {{t = "Standard NATO military cartridge, known as the M193, 5.56x45mm caliber steel-core round. It was developed for target practice in bursts. Based on hunting cartridges. Well known for use by the U.S. Army during the Vietnam War. Although it has low penetration, it provides excellent tissue damage.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_556x45_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_556x45_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
