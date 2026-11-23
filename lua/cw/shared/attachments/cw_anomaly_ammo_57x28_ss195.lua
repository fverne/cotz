-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_57x28_ss195"

att.displayName = "Ammunition 5.7x28 mm SS195LF/JHP"

att.displayNameShort = "Ammunition 5.7x28 mm SS195LF/JHP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "5.7x28MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_57x28_ss195")

	att.description = {{t = "5.7x28 mm a cartridge known as SS195LF, with an expansive bullet. has less penetration than SS190, but greater stopping power and killing power.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_57x28_ss195", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_57x28_ss195", false)

end

CustomizableWeaponry:registerAttachment(att)
