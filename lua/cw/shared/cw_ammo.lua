AddCSLuaFile()

CustomizableWeaponry.ammoTypes = CustomizableWeaponry.ammoTypes or {}

-- base ammo registration function
function CustomizableWeaponry:registerAmmo(name, text, bulletDiameter, caseLength, dmgtype_override)
	CustomizableWeaponry.ammoTypes[name] = {bulletDiameter = bulletDiameter, caseLength = caseLength}
	
	game.AddAmmoType({name = name,
	dmgtype = dmgtype_override or DMG_BULLET})
	
	if CLIENT then
		language.Add(name .. "_ammo", text)
	end
end

-- aliases
CustomizableWeaponry.registerAmmoType = CustomizableWeaponry.registerAmmo
CustomizableWeaponry.registerNewAmmo = CustomizableWeaponry.registerAmmo


--SPECIAL
CustomizableWeaponry:registerAmmo(".45 ACP -41-", ".410 Magnum Buck", 4, 8) -- Naughty

--Regular Ammo
CustomizableWeaponry:registerAmmo("7.62x25MM", "7.62x25MM Rounds", 7.62, 25)
CustomizableWeaponry:registerAmmo("7.62x39MM", "7.62x39MM Rounds", 7.62, 39)
CustomizableWeaponry:registerAmmo("7.62x51MM", "7.62x51MM Rounds", 7.62, 51)
CustomizableWeaponry:registerAmmo("7.62x54MMR", "7.62x54MMR Rounds", 7.62, 39)
CustomizableWeaponry:registerAmmo("7.62x54MM", "7.62x54MM Rounds", 7.62, 54)
CustomizableWeaponry:registerAmmo("5.45x39MM", "5.45x39MM Rounds", 5.45, 39)
CustomizableWeaponry:registerAmmo("5.56x45MM", "5.56x45MM Rounds", 5.56, 45)
CustomizableWeaponry:registerAmmo("5.7x28MM", "5.7x28MM Rounds", 5.7, 28)
CustomizableWeaponry:registerAmmo("14.5x114MM", "14.5x114MM Rounds", 14.5, 114)
CustomizableWeaponry:registerAmmo(".22LR", ".22LR Rounds", 5.7, 15.6)
CustomizableWeaponry:registerAmmo(".338 Lapua", ".338 Lapua", 8.58, 69.20)
CustomizableWeaponry:registerAmmo(".357 Magnum", ".357 Magnum Rounds", 9, 33.6)
CustomizableWeaponry:registerAmmo(".44 Magnum", ".44 Magnum Rounds", 10.9, 32.6)
CustomizableWeaponry:registerAmmo(".500 Magnum", ".500 Magnum Rounds", 12.7, 41.6)
CustomizableWeaponry:registerAmmo(".45 ACP", ".45 ACP Rounds", 11.5, 22.8)
CustomizableWeaponry:registerAmmo(".50 AE", ".50 AE Rounds", 12.7, 32.6)
CustomizableWeaponry:registerAmmo("9x18MM", "9x18MM Rounds", 9, 18)
CustomizableWeaponry:registerAmmo("9x19MM", "9x19MM Rounds", 9, 19)
CustomizableWeaponry:registerAmmo("9x21MM", "9x21MM Gyurza", 9, 21)
CustomizableWeaponry:registerAmmo("9x39MM", "9x39MM Rounds", 9, 39)
CustomizableWeaponry:registerAmmo("12 Gauge", "12 Gauge Shells", 5, 10)
CustomizableWeaponry:registerAmmo("40MM", "40MM Grenades", 0, 0)
CustomizableWeaponry:registerAmmo("Frag Grenades", "Frag Grenades", 0, 0)
CustomizableWeaponry:registerAmmo("Smoke Grenades", "Smoke Grenades", 0, 0)
CustomizableWeaponry:registerAmmo("Flash Grenades", "Flash Grenades", 0, 0)

--Shotgun Ammo Variants
CustomizableWeaponry:registerAmmo("12 Gauge -SG-", "12 Gauge Slug Shells", 5, 10)
CustomizableWeaponry:registerAmmo("12 Gauge -TR-", "12 Gauge Tri Rounds", 5, 10)
CustomizableWeaponry:registerAmmo("12 Gauge -DT-", "12 Gauge Dart Shells", 5, 10,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("12 Gauge -MG-", "12 Gauge Magnum Buckshot", 5, 10)

--Armor Piercing
CustomizableWeaponry:registerAmmo("7.62x25MM -AP-", "7.62x25MM Rounds - Armor Piercing", 7.62, 25,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("7.62x39MM -AP-", "7.62x39MM Rounds - Armor Piercing", 7.62, 39,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("7.62x51MM -AP-", "7.62x51MM Rounds - Armor Piercing", 7.62, 51,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("7.62x54MMR -AP-", "7.62x54MMR Rounds - Armor Piercing", 7.62, 39,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("7.62x54MM -AP-", "7.62x54MM Rounds - Armor Piercing", 7.62, 54,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("5.45x39MM -AP-", "5.45x39MM Rounds - Armor Piercing", 5.45, 39,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("5.56x45MM -AP-", "5.56x45MM Rounds - Armor Piercing", 5.56, 45,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("5.7x28MM -AP-", "5.7x28MM Rounds - Armor Piercing", 5.7, 28,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("14.5x114MM -AP-", "14.5x114MM Rounds - Armor Piercing", 14.5, 114,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo(".22LR -AP-", ".22LR Rounds - Armor Piercing", 5.7, 15.6,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo(".338 Lapua -AP-", ".338 Lapua - Armor Piercing", 8.58, 69.20,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo(".357 Magnum -AP-", ".357 Magnum Rounds - Armor Piercing", 9, 33.6,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo(".44 Magnum -AP-", ".44 Magnum Rounds - Armor Piercing", 10.9, 32.6,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo(".500 Magnum -AP-", ".500 Magnum Rounds - Armor Piercing", 12.7, 41.6,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo(".45 ACP -AP-", ".45 ACP Rounds - Armor Piercing", 11.5, 22.8,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo(".50 AE -AP-", ".50 AE Rounds - Armor Piercing", 12.7, 32.6,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("9x18MM -AP-", "9x18MM Rounds - Armor Piercing", 9, 18,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("9x19MM -AP-", "9x19MM Rounds - Armor Piercing", 9, 19,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("9x21MM -AP-", "9x21MM Gyurza - Armor Piercing", 9, 21,DMG_AIRBOAT)
CustomizableWeaponry:registerAmmo("9x39MM -AP-", "9x39MM Rounds - Armor Piercing", 9, 39,DMG_AIRBOAT)

--HOLLOWPOINT AMMO
CustomizableWeaponry:registerAmmo("7.62x25MM -HP-", "7.62x25MM Rounds - Hollow Point", 7.62, 25)
CustomizableWeaponry:registerAmmo("7.62x39MM -HP-", "7.62x39MM Rounds - Hollow Point", 7.62, 39)
CustomizableWeaponry:registerAmmo("7.62x51MM -HP-", "7.62x51MM Rounds - Hollow Point", 7.62, 51)
CustomizableWeaponry:registerAmmo("7.62x54MMR -HP-", "7.62x54MMR Rounds - Hollow Point", 7.62, 39)
CustomizableWeaponry:registerAmmo("7.62x54MM -HP-", "7.62x54MM Rounds - Hollow Point", 7.62, 54)
CustomizableWeaponry:registerAmmo("5.45x39MM -HP-", "5.45x39MM Rounds - Hollow Point", 5.45, 39)
CustomizableWeaponry:registerAmmo("5.56x45MM -HP-", "5.56x45MM Rounds - Hollow Point", 5.56, 45)
CustomizableWeaponry:registerAmmo("5.7x28MM -HP-", "5.7x28MM Rounds - Hollow Point", 5.7, 28)
CustomizableWeaponry:registerAmmo("14.5x114MM -HP-", "14.5x114MM Rounds - Hollow Point", 14.5, 114)
CustomizableWeaponry:registerAmmo(".22LR -HP-", ".22LR Rounds - Hollow Point", 5.7, 15.6)
CustomizableWeaponry:registerAmmo(".338 Lapua -HP-", ".338 Lapua Rounds - Hollow Point", 8.58, 69.20)
CustomizableWeaponry:registerAmmo(".357 Magnum -HP-", ".357 Magnum Rounds - Hollow Point", 9, 33.6)
CustomizableWeaponry:registerAmmo(".44 Magnum -HP-", ".44 Magnum Rounds - Hollow Point", 10.9, 32.6)
CustomizableWeaponry:registerAmmo(".500 Magnum -HP-", ".500 Magnum Rounds - Hollow Point", 12.7, 41.6)
CustomizableWeaponry:registerAmmo(".45 ACP -HP-", ".45 ACP Rounds - Hollow Point", 11.5, 22.8)
CustomizableWeaponry:registerAmmo(".50 AE -HP-", ".50 AE Rounds - Hollow Point", 12.7, 32.6)
CustomizableWeaponry:registerAmmo("9x18MM -HP-", "9x18MM Rounds - Hollow Point", 9, 18)
CustomizableWeaponry:registerAmmo("9x19MM -HP-", "9x19MM Rounds - Hollow Point", 9, 19)
CustomizableWeaponry:registerAmmo("9x21MM -HP-", "9x21MM Gyurza - Hollow Point", 9, 21)
CustomizableWeaponry:registerAmmo("9x39MM -HP-", "9x39MM Rounds - Hollow Point", 9, 39)