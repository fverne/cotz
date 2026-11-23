-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_57x28_ss190"

att.displayName = "Ammunition 5.7x28 mm SS190"

att.displayNameShort = "Ammunition 5.7x28 mm SS190"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "5.7x28MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_57x28_ss190")

	att.description = {{t = "Ammunition 5.7x28 (SS190) designed by the Belgian company Fabrique Nationale specifically for the FN P90 submachine gun in the mid-1980s. This cartridge was later used in the Five SeveN pistol. The cartridge has more penetrating power than other pistol cartridges. The bullet has a muzzle velocity of up to 716 m/s and is capable of penetrating body armor. The stopping powerof the bullet is three times higher than that of the 9x19mm cartridge.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_57x28_ss190", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_57x28_ss190", false)

end

CustomizableWeaponry:registerAttachment(att)
