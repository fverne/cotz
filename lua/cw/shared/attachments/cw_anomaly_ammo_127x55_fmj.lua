-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_127x55_fmj"

att.displayName = "Ammunition 12,7x55 mm ST-130"

att.displayNameShort = "Ammunition 12,7x55 mm ST-130"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "12.7x55mm"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_127x55_fmj")

	att.description = {{t = "12,7x55 mm ST-130 - This is a Russian rifle ammunition with subsonic bullet velocity, developed at the TsKIB SOO for low-noise and flameless engagement of protected targets and manpower wearing heavy body armor at ranges up to 600 meters.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_127x55_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_127x55_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
