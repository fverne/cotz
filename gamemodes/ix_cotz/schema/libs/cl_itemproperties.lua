ix.itemProperties = ix.itemProperties or {}

local PROPERTY_COLOR = Color(200, 205, 185)

function ix.itemProperties.AddRow(tooltip, id, text)
	id = "cotz/property/" .. id
	local existing = tooltip:GetRow(id)
	if existing then
		existing:SetText("• " .. text)
		existing:SizeToContents()

		return existing
	end

	local header = tooltip:GetRow("propertyheader")
	if not header then
		header = tooltip:AddRow("propertyheader")
		header:SetText("\nPROPERTIES:")
		header:SizeToContents()
	end
	tooltip.cotzPropertyCount = (tooltip.cotzPropertyCount or 0) + 1
	local row = tooltip:AddRow(id)
	row:SetZPos(header:GetZPos() + 2 + tooltip.cotzPropertyCount)
	row:SetFont("ixSmallFont")
	row:SetTextColor(PROPERTY_COLOR)
	row:SetText("• " .. text)
	row:SizeToContents()

	return row
end

function ix.itemProperties.PopulateProtection(tooltip, item)
	local rows = ix.itemProperties.GetProtection(item)
	if #rows == 0 then return end

	ix.itemProperties.AddRow(tooltip, "protectionHeader", "Protection levels")
	for _, row in ipairs(rows) do ix.itemProperties.AddRow(tooltip, row.id, row.text) end
end

function ix.itemProperties.Populate(tooltip, item)
	if tooltip.cotzPropertiesPopulated then return end
	tooltip.cotzPropertiesPopulated = true
	for _, row in ipairs(ix.itemProperties.GetRows(item)) do
		ix.itemProperties.AddRow(tooltip, row.id, row.text)
	end
	ix.itemProperties.PopulateProtection(tooltip, item)
end
