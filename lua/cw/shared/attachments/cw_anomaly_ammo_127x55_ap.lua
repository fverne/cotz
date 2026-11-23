-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_127x55_ap"

att.displayName = "Ammunition 12,7x55 mm ST-130 VPS"

att.displayNameShort = "Ammunition 12,7x55 mm ST-130 VPS"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "12.7x55mm"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_127x55_ap")

	att.description = {{t = "Large-caliber sniper cartridge SC-130 VPS (high penetration capability) is designed to hit by silent shot the enemy's manpower protected by heavy PPE (5-6 level of protection according to GOST R50744-95) at ranges up to 200 meters or located behind various barriers. GOST R50744-95) at ranges up to 200 meters or located behind various obstacles (car trim, door, glass, fence, etc.) at a range of up to 600 meters, as well as for the defeat of lightly armored and non-armored vehicles.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_127x55_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_127x55_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
