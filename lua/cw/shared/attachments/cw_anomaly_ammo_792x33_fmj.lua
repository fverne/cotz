-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_792x33_fmj"

att.displayName = "Ammunition 7,92x57 mm Mauser"

att.displayNameShort = "Ammunition 7,92x57 mm Mauser"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = ""
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_792x33_fmj")

	att.description = {{t = "The 7.92x57 Mauser cartridge was adopted in the first half of the last century by the German Empire and then by the Third Reich. It was one of the most popular cartridges in the period of the two world wars. However, nowadays the cartridge is primarily used for hunting and sporting purposes.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_792x33_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_792x33_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
