ITEM.name = "Wood-Fueled Cooker"
ITEM.description = "A low tier cooker."
ITEM.longdesc = "No longer description available."
ITEM.model = "models/lostsignalproject/items/misc/wood_stove.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.cookertier = "low"
ITEM.maxStack = 100
ITEM.busflag = {"dev"}

-- Inventory drawing
if (CLIENT) then
	local Texture2 = Material("cotz/panels/hp1.png", "noclamp smooth") 

	function ITEM:PaintOver(item, w, h)
		--Less mental way of doing the above:
		local quantity = 0

		if item:GetData("quantity") then --checks if we are in the business menu
			quantity = item:GetData("quantity", item.maxStack)
		end

		//durability
		surface.SetMaterial(Texture2)
		surface.SetDrawColor(Color(120, 120, 120, 255))
		surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)

		surface.SetMaterial(Texture2)
		if (quantity >= 80) then 
			surface.SetDrawColor(Color(120, 255, 120, 255))
		elseif (quantity >= 60) then 
			surface.SetDrawColor(Color(180, 255, 120, 255))
		elseif (quantity >= 40) then 
			surface.SetDrawColor(Color(255, 255, 120, 255))
		elseif (quantity >= 20) then 
			surface.SetDrawColor(Color(255, 180, 120, 255))
		elseif (quantity > 0) then 
			surface.SetDrawColor(Color(255, 120, 120, 255))	
		end
		surface.DrawTexturedRectUV(5, h - 10, math.Clamp(quantity/100, 0, 1)*38, 4.6, 0, 0, math.Clamp(quantity/100, 0, 1)*0.2, 1)

	end
end

