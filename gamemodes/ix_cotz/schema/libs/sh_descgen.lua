
-- Any files in the libs/ folder will be automatically included on the server and/or client, depending on the prefix of the
-- file. There are a few conventions you'll want to follow when creating a library.

-- Your library should reside in the "ix" table.
ix.util.text = ix.util.text or {}

-- Your library functions should reside in the table as regular function calls, not method calls (i.e use "." instead of ":") to
-- maintain consistency with the rest of Helix. What you shouldn't do: function ix.test:Add(one, two)
-- Keep converted readings first even when item callbacks add legacy properties later.
function ix.util.OrderPropertyRows(tooltip, row, rowID)
	tooltip.cotzPropertyRows = tooltip.cotzPropertyRows or {}
	if not row.cotzPropertyOrder then
		row.cotzPropertyOrder = #tooltip.cotzPropertyRows + 1
		row.cotzPropertyPriority = type(rowID) == "string" and rowID:find("cotz/property/", 1, true) == 1 and 1 or 2
		if rowID == "cotz/property/weight" then row.cotzPropertyPriority = 3 end
		tooltip.cotzPropertyRows[#tooltip.cotzPropertyRows + 1] = row
	end
	table.sort(tooltip.cotzPropertyRows, function(a, b)
		if a.cotzPropertyPriority == b.cotzPropertyPriority then
			return a.cotzPropertyOrder < b.cotzPropertyOrder
		end

		return a.cotzPropertyPriority < b.cotzPropertyPriority
	end)
	local position = tooltip:GetRow("propertyheader"):GetZPos()
	for index, property in ipairs(tooltip.cotzPropertyRows) do property:SetZPos(position + index) end
end

function ix.util.SizePropertyRow(row, text)
	local marker = row.propertyBullet or row.propertyImage
	local label = row.propertyLabel
	local spacing = 15
	local labelWidth = math.max(1, (row.maxWidth or ScrW() * 0.2) - marker:GetWide() - spacing)
	local lines = ix.util.WrapText("  " .. text, labelWidth, "ixSmallFont")
	-- Explicit lines avoid measuring DLabel's cached automatic wrapping before its layout pass.
	label:SetWrap(false)
	label:SetText(table.concat(lines, "\n"))
	label:SizeToContents()
	row:SetWide(marker:GetWide() + label:GetWide() + spacing)
	row:SetTall(math.max(marker:GetTall(), label:GetTall()))
end

function ix.util.PropertyDesc(tooltip, text, color, rowID)
	-- Legacy callers passed unused materials here before semantic row IDs were introduced.
	if type(rowID) ~= "string" then rowID = nil end

	if not tooltip:GetRow("propertyheader") then
		local header = tooltip:AddRow("propertyheader")
		header:SetText("\nPROPERTIES:")
		header:SizeToContents()
		header:SetContentAlignment(4)
	end

	local row = rowID and tooltip:GetRow(rowID)
	if not row then
		row = tooltip:AddRowAfter("propertyheader", rowID or "propertyitem")
		row:SetText("")
		row.propertyBullet = row:Add("DLabel")
		row.propertyBullet:SetText("•")
		row.propertyBullet:SetContentAlignment(8)
		row.propertyBullet:SetPos(8, 0)
		row.propertyBullet:SetSize(row:GetTall(), row:GetTall())
		row.propertyLabel = row:Add("DLabel")
		row.propertyLabel:MoveRightOf(row.propertyBullet)
		row.propertyLabel:SetTextColor(color_white)
		row.propertyLabel:SetFont("ixSmallFont")
	end

	row.propertyBullet:SetTextColor(color or color_white)
	ix.util.SizePropertyRow(row, text)
	ix.util.OrderPropertyRows(tooltip, row, rowID)
	tooltip:SizeToContents()

	return row
end

function ix.util.PropertyDesc2(tooltip, text, imagecolor, imagestring, rowID)
	-- Material() in the final argument position can also return a numeric load time.
	if type(rowID) ~= "string" then rowID = nil end

	if not tooltip:GetRow("propertyheader") then
		local header = tooltip:AddRow("propertyheader")
		header:SetText("\nPROPERTIES:")
		header:SizeToContents()
		header:SetContentAlignment(4)
	end

	-- Optional semantic IDs let converted properties update a row without duplicating its children.
	local row = rowID and tooltip:GetRow(rowID)
	if not row then
		row = tooltip:AddRowAfter("propertyitem", rowID or "propertyitem2")
		row:SetText("")
		row.propertyImage = row:Add("DImage")
		row.propertyImage:SetPos(8, 0)
		row.propertyImage:SetSize(row:GetTall(), row:GetTall())
		row.propertyLabel = row:Add("DLabel")
		row.propertyLabel:MoveRightOf(row.propertyImage)
		row.propertyLabel:SetTextColor(color_white)
		row.propertyLabel:SetFont("ixSmallFont")
	end

	row.propertyImage:SetMaterial(imagestring)
	row.propertyImage:SetImageColor(imagecolor or color_white)
	ix.util.SizePropertyRow(row, text)
	ix.util.OrderPropertyRows(tooltip, row, rowID)
	tooltip:SizeToContents()

	return row
end

function ix.util.PropertyDesc3(tooltip, text, imagecolor, imagestring, zpos) -- property, with image and zpos
	if not tooltip:GetRow("propertyheader") then
		local descheader = tooltip:AddRow("propertyheader")
		descheader:SetText("\nPROPERTIES:")
		descheader:SizeToContents()
		descheader:SetContentAlignment(4)
	end

	local dot
	if not tooltip:GetRow("propertyitemheader") then
		dot = tooltip:AddRowAfter("propertyitem", "propertyitem2")
		dot:SetText("")
	else
		dot = tooltip:AddRowAfter("propertyitem", "propertyitem2")
		dot:SetText("")
	end

	local image = dot:Add("DImage")
	image:SetMaterial(imagestring)
	image:SetImageColor(imagecolor or Color(255, 255, 255))
	image:SetPos(8, 0)
	image:SetSize(dot:GetTall(), dot:GetTall())

	local desctext = dot:Add("DLabel")
	desctext:MoveRightOf(image)
	desctext:SetText("  "..text)
	desctext:SetTextColor(Color(255, 255, 255))
	desctext:SetFont("ixSmallFont")
	desctext:SizeToContents()

	ix.util.OrderPropertyRows(tooltip, dot)

	dot:SetWide(image:GetWide() + desctext:GetWide() + 15)

	tooltip:SizeToContents()
end

function ix.util.MarkedDeletionDesc(tooltip) -- property, with image and zpos
	local text = "Marked for deletion."
	local desctext = tooltip:AddRow("markeddeletion")
	desctext:SetText("\n"..text)
	desctext:SetTextColor(Color(255, 0, 0))
	desctext:SetFont("ixSmallFont")
	desctext:SizeToContents()
	desctext:SetZPos(10000)

	tooltip:SizeToContents()
	
end
