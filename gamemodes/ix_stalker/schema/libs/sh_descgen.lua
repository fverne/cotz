
-- Any files in the libs/ folder will be automatically included on the server and/or client, depending on the prefix of the
-- file. There are a few conventions you'll want to follow when creating a library.

-- Your library should reside in the "ix" table.
ix.util.text = ix.util.text or {}

-- Your library functions should reside in the table as regular function calls, not method calls (i.e use "." instead of ":") to
-- maintain consistency with the rest of Helix. What you shouldn't do: function ix.test:Add(one, two)
function ix.util.PropertyDesc(tooltip, text, color)
	if !tooltip:GetRow("propertyheader") then
		local descheader = tooltip:AddRow("propertyheader")
		descheader:SetText("\nPROPERTIES:")
		descheader:SizeToContents()
		descheader:SetContentAlignment(4)
	end

	local dot = tooltip:AddRow("propertyitem")
	dot:SetText("")

	local image = dot:Add("DLabel")
	image:SetText("•")
	image:SetContentAlignment(8)
	image:SetTextColor( color or Color( 255, 255, 255) )
	image:SetPos(8, 0)
	image:SetSize(dot:GetTall(), dot:GetTall())
	--image:SizeToContents()


	local desctext = dot:Add("DLabel")
	desctext:MoveRightOf(image)
	desctext:SetText("  "..text)
	desctext:SetTextColor(Color(255, 255, 255))
	desctext:SetFont("ixSmallFont")
	desctext:SizeToContents()
end

function ix.util.PropertyDesc2(tooltip, text, color, imagestring)
	if !tooltip:GetRow("propertyheader") then
		local descheader = tooltip:AddRow("propertyheader")
		descheader:SetText("\nPROPERTIES:")
		descheader:SizeToContents()
		descheader:SetContentAlignment(4)
	end

	local dot

	if !tooltip:GetRow("propertyitem") then
		dot = tooltip:AddRowAfter("propertyheader", "propertyitem")
		dot:SetText("")
	else
		dot = tooltip:AddRow("propertyitem")
		dot:SetText("")
	end

	

	local image = dot:Add("DImage")
	image:SetMaterial(imagestring)
	image:SetPos(8, 0)
	image:SetSize(dot:GetTall(), dot:GetTall())
	image:SizeToContents()

	local desctext = dot:Add("DLabel")
	desctext:MoveRightOf(image)
	desctext:SetText("  "..text)
	desctext:SetTextColor(Color(255, 255, 255))
	desctext:SetFont("ixSmallFont")
	desctext:SizeToContents()

	dot:SizeToContents()
end
