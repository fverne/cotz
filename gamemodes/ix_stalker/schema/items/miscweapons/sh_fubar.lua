ITEM.name = "FUBar"
ITEM.description = "A Functional Utility Bar for heavy demolition work."
ITEM.model = "models/weapons/tfa_nmrih/w_me_fubar.mdl"
ITEM.class = "tfa_nmrih_fubar"
ITEM.weaponCategory = "primary"
ITEM.price = 900
ITEM.busflag = {"melee1"}
ITEM.height = 1
ITEM.width = 4
ITEM.category = "Melee"
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false
ITEM.weight = 10
ITEM.iconCam = {
	pos = Vector(-4, 30, 4),
	ang = Angle(0, 270, 90),
	fov = 70
}
ITEM.modifier = 20
ITEM.isPLWeapon = true
ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(0.719, 93.188, -174.281),
						["Position"] = Vector(-6.38, -10.539, 6.522),
						["Model"] = "models/weapons/tfa_nmrih/w_me_fubar.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7778884673",
						["Bone"] = "chest",
						["Name"] = "fubar",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1288870522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_fubar@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2777776348",
		["EditorExpand"] = true,
	},
},
}
function ITEM:OnInstanced(invID, x, y)
	if !self:GetData("durability") then
		self:SetData("durability", 10000)
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		//Equipsquare
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 255)
			--surface.DrawRect(w - 14, h - 14, 8, 8)
		else
			surface.SetDrawColor(255, 110, 110, 255)
		end

		surface.SetMaterial(item.equipIcon)
		surface.DrawTexturedRect(w-23,h-23,19,19)

		//Durability bar
		if item:GetData("durability") then
			local dura = item:GetData("durability",10000)
			if (item:GetOwner():GetWeapon( item.class )) and (item:GetData("equip")) then
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 7, h - 15, 41, 9 )
				if (dura > 0) then
					surface.SetDrawColor(110, 255, 110, 100)
					surface.DrawRect(8, h - 14, (dura/10000) * 40, 8)
				else
					surface.SetDrawColor(255, 110, 110, 100)
					surface.DrawRect(8, h - 14, 40, 8)
				end
			else
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 7, h - 15, 41, 9 )
				if (dura > 0) then
					surface.SetDrawColor(110, 255, 110, 100)
					surface.DrawRect(8, h - 14, (dura/10000) * 40, 8)
				else
					surface.SetDrawColor(255, 110, 110, 100)
					surface.DrawRect(8, h - 14, 40, 8)
				end
			end
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		if (self:GetData("equip")) then
			local name = tooltip:GetRow("name")
			name:SetBackgroundColor(derma.GetColor("Success", tooltip))
		end
	end
end