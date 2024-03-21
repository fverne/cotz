ITEM.name = "Basic Tools"
ITEM.description = "Used by technicians to do basic work on equipment."
ITEM.longdesc = "A basic repair toolkit. Unlikely to be suitable for advanced maintenance, but they could be useful in the hands of a thrifty technician. Contains different types and sizes of pliers, screws, adhesives and assorted fasteners. With enough knowledge and experience, this kit can be used for the creation of basic equipment."
ITEM.model = "models/lostsignalproject/items/quest/toolkit_1.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.category = "Technician"
ITEM.price = "5000"
--ITEM.busflag = "MERCH3"
ITEM.busflag = {"technician1"}
ITEM.noDeathDrop = true
ITEM.quantity = 100
ITEM.isTool = true
ITEM.toolMult = 4
ITEM.compMultiplier = 1
ITEM.repairAmount = 25
ITEM.sound = "stalkersound/inv_repair_kit_use_fast.mp3"

function ITEM:GetDescription()
	local quant = self:GetData("quantity", 1)
	local str = self.longdesc

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end

	if (self.entity) then
		return self.description.."\n \nThis tool has "..math.Round(quant).."/100 durability."
	else
        return (str.."This tool has "..math.Round(quant).."/100 durability.")
	end
end

function ITEM:GetName()
	local name = self.name
	
	local customData = self:GetData("custom", {})
	if(customData.name) then
		name = customData.name
	end
	
	return name
end

ITEM.functions.Custom = {
	name = "Customize",
	tip = "Customize this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)		
		ix.plugin.list["customization"]:startCustom(item.player, item)
		
		return false
	end,
	
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

ITEM.functions.Inspect = {
    name = "Inspect",
    tip = "Inspect this item",
    icon = "icon16/picture.png",
    OnClick = function(item, test)
        local customData = item:GetData("custom", {})

        local frame = vgui.Create("DFrame")
        frame:SetSize(540, 680)
        frame:SetTitle(item.name)
        frame:MakePopup()
        frame:Center()

        frame.html = frame:Add("DHTML")
        frame.html:Dock(FILL)
        
        local imageCode = [[<img src = "]]..customData.img..[["/>]]
        
        frame.html:SetHTML([[<html><body style="background-color: #000000; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">]]..imageCode..[[</body></html>]])
    end,
    OnRun = function(item)
        return false
    end,
    OnCanRun = function(item)
        local customData = item:GetData("custom", {})
    
        if(!customData.img) then
            return false
        end
        
        if(item.entity) then
            return false
        end
        
        return true
    end
}

ITEM.functions.Clone = {
	name = "Clone",
	tip = "Clone this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player	
	
		client:requestQuery("Are you sure you want to clone this item?", "Clone", function(text)
			if text then
				local inventory = client:GetCharacter():GetInventory()
				
				if(!inventory:Add(item.uniqueID, 1, item.data)) then
					client:Notify("Inventory is full")
				end
			end
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(math.Round(item:GetData("quantity", 1)).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

function ITEM:OnInstanced(invID, x, y)
	if !self:GetData("quantity") then
		self:SetData("quantity", 100)
	end
end

/*
ITEM.functions.craftmenu = { -- sorry, for name order.
	name = "Open Crafting Menu",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)
		
		netstream.Start( item.player, "nut_CraftWindow", item.player)
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
*/

ITEM.functions._use = {
	name = "Disassemble",
	tip = "useTip",
	icon = "icon16/stalker/scrap.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()         
		
		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for k, v in pairs(items) do
					if (v.repairCost and v:GetData("equip") != true) then
						table.insert(targets, {
							name = L("Disassemble "..v.name.." | Yields "..math.Round((v.repairCost*2)*item.compMultiplier*(1+(client:GetCharacter():GetAttribute("technician", 0)/100)), 0).." components"),
							data = {v:GetID()},
						})
					else
						continue
					end
				end
			end
		end

		return targets
		end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and !(item:GetData("equip")) and item.player:GetFlags("T")
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		local cost = 0

		for k, invItem in pairs(items) do
			if (data[1]) then
				if (invItem:GetID() == data[1]) then
					target = invItem

					break
				end
			else
				client:Notify("No item selected.")
				return false
			end
		end

		cost = target.repairCost

		if math.sqrt( cost )/10 < item:GetData("quantity", 1) then
			client:GetChar():GetInventory():Add("component", 1, {["quantity"] = math.Round((cost*2)*item.compMultiplier*(1+(client:GetCharacter():GetAttribute("technician", 0)/100)), 0)})
			item:SetData("quantity", item:GetData("quantity", 1) - math.sqrt( cost ))
			target:Remove()
			item.player:EmitSound(item.sound or "items/battery_pickup.wav")
			ix.chat.Send(item.player, "iteminternal", "uses their "..item.name.." to disassemble their "..target.name.." into components.", false)
		else
			client:Notify("Not enough tool durability.")
		end

		return false
	end,
}

ITEM.functions.repairgun = {
	name = "Repair Gun",
	tip = "useTip",
	icon = "icon16/stalker/repair.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()
		
		
		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for k, v in pairs(items) do
					if v.isWeapon and v:GetData("durability", 0) < 100 then
						table.insert(targets, {
							name = L("Repair "..v.name.." with "..math.Round(v:GetData("durability",0), 2).." percent durability to "..math.Clamp(math.Round(v:GetData("durability",0), 2)+item.repairAmount*(1+(client:GetCharacter():GetAttribute("technician", 0)/100)), 0, 100).." percent durability | Costs "..math.Round(v.repairCost*(1-(client:GetCharacter():GetAttribute("technician", 0)/100))).." components."),
							data = {v:GetID()},
						})
					else
						continue
					end
				end
			end
		end

		return targets
		end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity)) and item.player:GetFlags("T")
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		local comp = client:GetCharacter():GetInventory():HasItem("component")
		
		for k, invItem in pairs(items) do
			if (data[1]) then
				if (invItem:GetID() == data[1]) then
					target = invItem

					break
				end
			else
				client:Notify("No weapon selected.")
				return false
			end
		end
		
		if target:GetData("equip") != true then
			if comp and (comp:GetData("quantity", 1)) >= target.repairCost then
				target:SetData("durability", math.Clamp(target:GetData("durability",100) + item.repairAmount*(1+(client:GetCharacter():GetAttribute("technician", 0)/100)), 0, 100))
				client:Notify(target.name.." successfully repaired.")
				comp:SetData("quantity", comp:GetData("quantity") - target.repairCost*(1-(client:GetCharacter():GetAttribute("technician", 0)/100)))
				item.player:EmitSound(item.sound or "items/battery_pickup.wav")
				ix.chat.Send(item.player, "iteminternal", "uses their "..item.name.." to repair their "..target.name..".", false)
				if item:GetData("quantity",100) > 1 then
					item:SetData("quantity", item:GetData("quantity",100) - 1)
					return false
				else
					return true
				end
			else
				client:Notify("Not enough components.")
				return false
			end
		else
			client:Notify("Unequip the weapon first!")
			return false	
		end
	end,
}

ITEM.functions.repairarmor = {
	name = "Repair Armor",
	tip = "useTip",
	icon = "icon16/stalker/repair.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()
		
		
		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for k, v in pairs(items) do
					if (v.isBodyArmor or v.isHelmet or v.isGasmask) and v:GetData("durability", 0) < 100 then
						table.insert(targets, {
							name = L("Repair "..v.name.." with "..math.Round(v:GetData("durability",0), 2).." percent durability to "..math.Clamp(math.Round(v:GetData("durability",0), 2)+item.repairAmount*(1+(client:GetCharacter():GetAttribute("technician", 0)/100)), 0, 100).." percent durability | Costs "..math.Round((v.price/100)*(1-(client:GetCharacter():GetAttribute("technician", 0)/100))).." components."),
							data = {v:GetID()},
						})
					else
						continue
					end
				end
			end
		end

		return targets
		end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity)) and item.player:GetFlags("T")
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		local comp = client:GetCharacter():GetInventory():HasItem("component")
		
		for k, invItem in pairs(items) do
			if (data[1]) then
				if (invItem:GetID() == data[1]) then
					target = invItem

					break
				end
			else
				client:Notify("No outfit selected.")
				return false
			end
		end
		
		if target:GetData("equip") != true then
			if comp and (comp:GetData("quantity", 1)) >= (target.price/100) then
				target:SetData("durability", math.Clamp(target:GetData("durability",100) + item.repairAmount*(1+(client:GetCharacter():GetAttribute("technician", 0)/100)), 0, 100))
				client:Notify(target.name.." successfully repaired.")
				comp:SetData("quantity", comp:GetData("quantity") - (target.price/100)*(1-(client:GetCharacter():GetAttribute("technician", 0)/100)))
				item.player:EmitSound(item.sound or "items/battery_pickup.wav")
				ix.chat.Send(item.player, "iteminternal", "uses their "..item.name.." to repair their "..target.name..".", false)
				if item:GetData("quantity",100) > 1 then
					item:SetData("quantity", item:GetData("quantity",100) - 1)
					return false
				else
					return true
				end
			else
				client:Notify("Not enough components.")
				return false
			end
		else
			client:Notify("Unequip the outfit first!")
			return false	
		end
	end,
}