ITEM.name = "Water Flask"
ITEM.description = "A reusable water flask."
ITEM.longdesc = "Reliable sealed container capable of holding a litre of water. Water inside can be boiled in a cooker and then further purified using a water filter."
ITEM.model = "models/illusion/eftcontainers/aquamari.mdl"

ITEM.width = 1
ITEM.height = 2
ITEM.flatweight = 0.2
ITEM.quantity = 0
ITEM.contains = 0
ITEM.weight = 0.5
ITEM.price = 400

ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(24.64, 219.98, 0),
	fov = 0.5
}

if (CLIENT) then
	local bar = Material("cotz/panels/hp1.png", "noclamp smooth")

	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", 0)
		local contains = item:GetData("contains", 0)
		surface.SetMaterial(bar)
		surface.SetDrawColor(Color(120, 120, 120, 255))
		surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)
		if (quantity>0) then
			if contains == 3 then
				color = Color(30, 240, 30, 255)
			elseif contains == 2 then
				color = Color (240, 240, 30, 255)
			else
				color = Color (240, 30, 30, 255)
			end
			surface.SetDrawColor(color)
			surface.DrawTexturedRectUV(5, h - 10, (quantity/2)*38, 4.6, 0, 0, (quantity/2)*0.2, 1)
		end
	end
end

function ITEM:PopulateTooltip(tooltip)
    ix.util.PropertyDesc(tooltip, "Water Container", Color(64, 224, 208))

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end


ITEM.functions.zFill = {
	name = "Fill",
    icon = "icon16/stalker/drink.png",
    sound = "stalkersound/inv_properties.mp3",
    OnRun = function(item)
        ix.chat.Send(item.player, "iteminternal", "Fills their "..item.name.." with dirty water.", false)
        ix.util.PlayerPerformBlackScreenAction(item.player, "Filling water flask...", 3, function(player)
        	item:SetData("contains", 1)
        	item:SetData("quantity", 2)
        end)
        print(item:GetData("contains"))
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and (item:GetData("quantity",item.quantity)<2 or item:GetData("contains",item.contains)==0) and item.player:WaterLevel()>0 and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}
ITEM.functions.zFilter ={
	name = "Filter",
    icon = "icon16/help.png",
    sound = "stalkersound/inv_eat_mutant_food.mp3",
    OnRun = function(item)
    	local found = false
 		for k,v in pairs(item.player:GetCharacter():GetInv():GetItems()) do
			if (v.name == "Water Filter") then
				found = true
				break
			end
		end
		if found then
	        ix.chat.Send(item.player, "iteminternal", "purifies their "..item.name..".", false)
	        ix.util.PlayerPerformBlackScreenAction(item.player, "Purifying water flask...", 8, function(player)
	        	item:SetData("contains", 3)
	        end)
	    else 
	    	item.player:Notify("No water filter.")
	    end
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("contains",item.contains)==2 and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}

ITEM.functions.zCook = {
	name = "Boil",
	tip = "useTip",
	icon = "icon16/stalker/attach.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()

		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for k, v in pairs(items) do
					if (v.cookertier  and v:GetData("fuel", 0) > 0) then
						table.insert(targets, {
							name = L(v.name),
							data = {v:GetID()},
						})
					end
				end
			end
		end

		return targets
		end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item:GetData("contains",item.contains)==1 and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		if (!targetItem) then return false end

		if ( targetItem.cookertier and targetItem:GetData("fuel", 0) > 0 ) then
			item.player:EmitSound("stalkersound/inv_cooking_cooker.ogg", 110)
        	ix.chat.Send(item.player, "iteminternal", "boils water for their "..item.name..".", false)
	        ix.util.PlayerPerformBlackScreenAction(item.player, "Boiling water...", 6, function(player)
				item:SetData("contains", 2)
				targetItem:SetData("fuel", targetItem:GetData("fuel", 1) - 1)
	        end)
		end
		return false
	end,
}

ITEM.functions.use = {
	name = "Drink",
    icon = "icon16/stalker/drink.png",
    sound = "stalkersound/inv_flask.mp3",
    OnRun = function(item)
        ix.chat.Send(item.player, "iteminternal", "drinks from their "..item.name, false)
        local contains = item:GetData("contains",item.contains)
        local thirst = item.player:GetCharacter():GetData("thirst", 100)
        if contains == 3 then
        	ix.util.PlayerPerformBlackScreenAction(item.player, "Drinking from water flask...", 5, function(player)
            	player:SetThirst(thirst + 15)
        	end)
        elseif contains == 2 then
        	ix.util.PlayerPerformBlackScreenAction(item.player, "Drinking from water flask...", 5, function(player)
            	player:SetThirst(thirst + 12)
            	player:AddBuff("debuff_radiation", 10, { amount = 0.2 })
        	end)
        else
        	ix.util.PlayerPerformBlackScreenAction(item.player, "Drinking from water flask...", 5, function(player)
	        	player:SetThirst(thirst + 8)
	        	player:AddBuff("debuff_radiation", 10, { amount = 0.5 })
	            player:AddBuff("debuff_psy", 10, { amount = 0.25 })
            end)
        end
        item:SetData("quantity", item:GetData("quantity", 1) - 1)
        if (item:GetData("quantity") == 0) then item:SetData("contains", 0) end
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("contains", item.contains)>0 and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}
