-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_46x30_fmj"

att.displayName = "Ammunition 4.6x30 mm FMJ"

att.displayNameShort = "Ammunition 4.6x30 mm FMJ"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = ""
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_46x30_fmj")

	att.description = {{t = "4.6x30mm all-metal bullet cartridge, primarily used by the Heckler & Koch MP7 submachine gun. Designed to minimize weight and recoil during firing, while retaining the ability to penetrate body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_46x30_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_46x30_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
