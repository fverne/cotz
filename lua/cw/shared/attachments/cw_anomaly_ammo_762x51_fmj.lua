-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x51_fmj"

att.displayName = "Ammunition 7,62x51 mm NATO FMJ"

att.displayNameShort = "Ammunition 7,62x51 mm NATO FMJ"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x51MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x51_fmj")

	att.description = {{t = "The 7.62x51 NATO is the Army's version of the .308 cartridge, which was used by NATO forces as standard ammunition until 5.56 mm ammunition was introduced in the 1970s during the Vietnam War. This ammunition is now most commonly used by mercenaries around the world.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x51_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x51_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
