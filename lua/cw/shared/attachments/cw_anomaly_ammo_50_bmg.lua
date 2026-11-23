-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_50_bmg"

att.displayName = "Ammunition .50 BMG"

att.displayNameShort = "Ammunition .50 BMG"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = ""
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_50_bmg")

	att.description = {{t = ".50 BMG (12,7x99 mm) - is a large-caliber cartridge developed in the 1920s Browning M1921 (M2HB) large-caliber machine gun. During World War II the cartridge was in the supply of all Allied countries and was used primarily in aircraft machine guns. As part of the ammunition for Lend-Lease armored vehicles and aircraft, the cartridge was also supplied to the USSR. After World War II, the .50 BMG cartridge was distributed all over the world.(except for the Warsaw Pact countries) as the standard NATO large-caliber ammunition for infantry machine guns. and today is produced by more than 30 manufacturers to U.S. standards. The cartridge also has various modifications: conventional M2, armor-piercing M2, armor-piercing incendiary M8, M1 incendiary, M1 tracer. Cartridges used for long bursts of fire, are contained in cartridge belts.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_50_bmg", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_50_bmg", false)

end

CustomizableWeaponry:registerAttachment(att)
