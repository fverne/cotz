ix.itemProperties = ix.itemProperties or {}

local PROPERTY_COLOR = Color(200, 205, 185)
local PROTECTION_VALUE_GAP = 4
local LEGACY_ICONS = {
	weight = ix.util.GetMaterial("vgui/ui/stalker/weaponupgrades/weight.png"),
	carry = ix.util.GetMaterial("vgui/ui/stalker/armorupgrades/carryweightinc.png"),
}

function ix.itemProperties.AddRow(tooltip, id, text)
	local rowID = "cotz/property/" .. id
	local row
	if LEGACY_ICONS[id] then
		row = ix.util.PropertyDesc2(tooltip, text, color_white, LEGACY_ICONS[id], rowID)
	else
		row = ix.util.PropertyDesc(tooltip, text, PROPERTY_COLOR, rowID)
	end

	return row
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
		ix.itemProperties.AddRow(tooltip, row.id, row.text)
	end
	ix.itemProperties.PopulateProtection(tooltip, item)
end
