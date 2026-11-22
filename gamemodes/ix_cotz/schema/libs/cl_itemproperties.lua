ix.itemProperties = ix.itemProperties or {}

local PROPERTY_COLOR = Color(200, 205, 185)
local PROTECTION_VALUE_GAP = 4
local ARMOR_ICONS = "vgui/ui/stalker/armorupgrades_grey/"
local WEAPON_ICONS = "vgui/ui/stalker/weaponupgrades_grey/"
local MISC_ICONS = "vgui/ui/stalker/misc_grey/"
-- Tints fitted from the full-colour upgrade icons, so family icons match their originals.
local ARMOR_COLOR = Color(92, 161, 197)
local WEAPON_COLOR = Color(95, 201, 193)
local HEALTH_COLOR = Color(220, 85, 95)
local BLOOD_COLOR = Color(215, 70, 70)
local RADIATION_COLOR = Color(215, 225, 60)
local PSYCHIC_COLOR = Color(225, 105, 190)
local STAMINA_COLOR = Color(110, 200, 120)
local REPAIR_ICON = "icon16/stalker_grey/repair.png"

-- This library loads before the schema's ix.util.GetMaterial override, so Helix's version would create these
-- with point sampling. The 19px icons are drawn at text height, where point sampling drops their frame edges.
local function icon(path, color, variants)
	return {material = Material(path, "smooth mips"), color = color, variants = variants}
end

-- Greyscale property icons keyed by row ID or a row's icon key, tinted per reading. Rows without an entry keep
-- the bullet. Variants recolour one icon by a row's variant, such as the weapon's fastest fire mode.
local ICONS = {
	weight = icon(WEAPON_ICONS .. "weight.png", WEAPON_COLOR),
	carry = icon(ARMOR_ICONS .. "carryweightinc.png", ARMOR_COLOR),
	nutrition = icon(ARMOR_ICONS .. "hunger.png", WEAPON_COLOR),
	hydration = icon(ARMOR_ICONS .. "bleeding.png", Color(95, 165, 235)),
	alcohol = icon(ARMOR_ICONS .. "bottlefeather.png", WEAPON_COLOR),
	clotting = icon(ARMOR_ICONS .. "bleeding.png", BLOOD_COLOR),
	clottingDuration = icon(MISC_ICONS .. "time.png", PROPERTY_COLOR),
	application = icon(MISC_ICONS .. "time.png", PROPERTY_COLOR),
	cooldown = icon(MISC_ICONS .. "time.png", PROPERTY_COLOR),
	healing = icon(ARMOR_ICONS .. "hpregen.png", HEALTH_COLOR),
	cartridge = icon(WEAPON_ICONS .. "impact.png", WEAPON_COLOR),
	magazine = icon(WEAPON_ICONS .. "ammocap.png", WEAPON_COLOR),
	fireRate = icon(WEAPON_ICONS .. "firerate.png", WEAPON_COLOR, {
		auto = Color(225, 85, 65),
		burst = Color(240, 145, 55),
		semi = Color(235, 205, 85),
		pump = Color(140, 200, 95),
		["break"] = Color(95, 190, 175),
		bolt = Color(110, 160, 235),
	}),
	cleanliness = icon(WEAPON_ICONS .. "rechamber.png", WEAPON_COLOR),
	durability = icon(REPAIR_ICON, WEAPON_COLOR),
	sharpnessCondition = icon(REPAIR_ICON, WEAPON_COLOR),
	sharpness = icon(REPAIR_ICON, WEAPON_COLOR),
	sharpnessLimit = icon(REPAIR_ICON, WEAPON_COLOR),
	installedAttachments = icon(WEAPON_ICONS .. "genericmod.png", WEAPON_COLOR),
	attachments = icon(WEAPON_ICONS .. "genericmod.png", WEAPON_COLOR),
	filter = icon(MISC_ICONS .. "gasmask.png", ARMOR_COLOR),

	["protection/ballistics"] = icon(ARMOR_ICONS .. "armor.png", Color(180, 185, 195)),
	["protection/rupture"] = icon(ARMOR_ICONS .. "bleeding2.png", BLOOD_COLOR),
	["protection/thermal"] = icon(ARMOR_ICONS .. "thermprot.png", Color(240, 130, 50)),
	["protection/electrical"] = icon(ARMOR_ICONS .. "elect.png", Color(120, 190, 255)),
	["protection/chemical"] = icon(ARMOR_ICONS .. "chemprot.png", Color(145, 210, 75)),
	["protection/gravitational"] = icon(ARMOR_ICONS .. "impact.png", Color(160, 140, 230)),
	["protection/psychic"] = icon(ARMOR_ICONS .. "psiprot.png", PSYCHIC_COLOR),
	["protection/radiation"] = icon(ARMOR_ICONS .. "radprot.png", RADIATION_COLOR),

	["effect/healing"] = icon(ARMOR_ICONS .. "hpregen.png", HEALTH_COLOR),
	["effect/stamina"] = icon(ARMOR_ICONS .. "stamina.png", STAMINA_COLOR),
	["effect/radiationRemoval"] = icon(ARMOR_ICONS .. "radprot.png", RADIATION_COLOR),
	["effect/radiationExposure"] = icon(ARMOR_ICONS .. "rad.png", RADIATION_COLOR),
	["effect/psychicRecovery"] = icon(ARMOR_ICONS .. "psiprot.png", PSYCHIC_COLOR),
	["effect/psychicDamage"] = icon(ARMOR_ICONS .. "psi.png", PSYCHIC_COLOR),
	["effect/movement"] = icon(ARMOR_ICONS .. "runspeed.png", STAMINA_COLOR),
	["effect/movementImpairment"] = icon(ARMOR_ICONS .. "runspeed.png", BLOOD_COLOR),
}

-- Returns {material, color, variants} for a property icon key, or nil when the reading uses a bullet.
function ix.itemProperties.GetIcon(iconKey)
	return ICONS[iconKey]
end

-- iconKey defaults to the row ID; variant selects an alternative tint from the icon's variants.
function ix.itemProperties.AddRow(tooltip, id, text, iconKey, variant)
	local rowID = "cotz/property/" .. id
	local definition = ICONS[iconKey or id]
	if not definition then
		return ix.util.PropertyDesc(tooltip, text, PROPERTY_COLOR, rowID)
	end

	local color = definition.variants and definition.variants[variant] or definition.color

	return ix.util.PropertyDesc2(tooltip, text, color, definition.material, rowID)
end

-- Protection values keep the legacy colour scale: red for none through blue for full resistance.
function ix.itemProperties.AddProtectionRow(tooltip, protection)
	local row = ix.itemProperties.AddRow(tooltip, protection.id, protection.label)
	if not row.protectionValue then
		row.protectionValue = row:Add("DLabel")
		row.protectionValue:SetFont("ixSmallFont")
	end

	local valueLabel = row.protectionValue
	valueLabel:SetText(protection.valueText)
	valueLabel:SetTextColor(ix.util.GetColorFromValue(protection.value, 0, 1))
	valueLabel:SizeToContents()
	valueLabel:MoveRightOf(row.propertyLabel, PROTECTION_VALUE_GAP)
	row:SetWide(row:GetWide() + PROTECTION_VALUE_GAP + valueLabel:GetWide())
	tooltip:SizeToContents()

	return row
end

function ix.itemProperties.PopulateProtection(tooltip, item)
	if item.entity then return end

	local rows = ix.itemProperties.GetProtection(item)
	if #rows == 0 then return end

	for _, row in ipairs(rows) do ix.itemProperties.AddProtectionRow(tooltip, row) end
end

function ix.itemProperties.Populate(tooltip, item)
	if tooltip.cotzPropertiesPopulated then return end
	tooltip.cotzPropertiesPopulated = true
	if item.entity then
		local weight = item.GetWeight and item:GetWeight()
		if weight then
			local text = "Weight: " .. ix.weight.WeightString(weight, ix.option.Get("imperial", false))
			ix.itemProperties.AddRow(tooltip, "weight", text)
		end

		return
	end
	for _, row in ipairs(ix.itemProperties.GetRows(item)) do
		ix.itemProperties.AddRow(tooltip, row.id, row.text, row.icon, row.variant)
	end
	ix.itemProperties.PopulateProtection(tooltip, item)
end
