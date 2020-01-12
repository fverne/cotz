ITEM.name = "Expert Tools"
ITEM.description = "Used by technicians to do expert work on equipment."
ITEM.longdesc = "A professional set of high quality tools for fine-tuning equipment. Contains drill bit set, precision tweezers, soldiering iron, 4 mm Screwdriver bits and a multimeter. With enough knowledge and experience, this kit can be used for the creation of advanced equipment."
ITEM.model = "models/kek1ch/box_toolkit_3.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.category = "Technician"
ITEM.price = "25000"
--ITEM.busflag = "MERCH3"
ITEM.busflag = {"technician1_1_1"}
ITEM.noDeathDrop = true
ITEM.maxStack = 100
ITEM.isTool = true
ITEM.toolMult = 1
ITEM.compMultiplier = 1.25
ITEM.repairAmount = 25
ITEM.sound = "stalkersound/inv_repair_kit_use_fast.mp3"
ITEM.weight = 12

function ITEM:GetDescription()
	local quant = self:GetData("quantity", 1)
	local str = self.description.." \n\n"..self.longdesc

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end

	if (self.entity) then
		return self.description.."\n \nThis tool has "..math.Round(quant).."/100 durability."
	else
        return (str.."\n \nThis tool has "..math.Round(quant).."/100 durability.")
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
		draw.SimpleText(math.Round(item:GetData("quantity", 1)).."/"..item.maxStack, "DermaDefault", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
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
					if v.isWeapon and v:GetData("durability", 0) < 10000 then
						local curPrice = v:GetData("RealPrice")
						if !curPrice then
							curPrice = v.price
						end
						
						local lincost = ((v:GetData("durability",10000) / 1000)-10)
						local cost = math.Round(((curPrice / 50) * (lincost * lincost))/2)
						
						local maxcost = (curPrice * 1.05)
						
						if cost > maxcost then
							cost = maxcost
						end
						
						local compcost = math.Round(((100 - math.Round((v:GetData("durability",10000)/100),0))*(1-(client:GetCharacter():GetPerk("weapontechnician", 0)/20))),0)
						
						table.insert(targets, {
							name = L("Repair "..v.name.." | Costs: "..compcost.." components, "..cost.."Rubles"),
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
		if (item.player:GetCharacter():GetPerk("weapontechnician", 0) > 0) then 
			return (!IsValid(item.entity)) and item.player:GetFlags("2")
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		
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
			local compcount = 0
			local bigstack
			local itemquan = 0
			local bigstackquan
			local items = client:GetChar():GetInv():GetItems()
			for k,v in pairs(items) do
				if v:GetName() == "Components" then
					itemquan = v:GetData("quantity",1)
					compcount = compcount + itemquan
					if bigstack == nil then
						bigstack = v
					elseif bigstack:GetData("quantity",1) < itemquan then
						bigstack = v
					end
				end
			end
			
			if not bigstack then
				client:Notify("No Components")
				return false
			end
			
			bigstackquan = bigstack:GetData("quantity",1)
			
			local lincost = math.Round((target:GetData("durability") / 1000) - 10)
        
			local curPrice = target:GetData("RealPrice")
			if !curPrice then
				curPrice = target.price
			end
				
			local lincost = ((v:GetData("durability",10000) / 1000)-10)
			local cost = math.Round(((curPrice / 50) * (lincost * lincost))/2)
			local maxcost = (curPrice * 1.05)

			if cost > maxcost then
				cost = maxcost
			end

			local compcost = math.Round(((100 - math.Round((target:GetData("durability",10000)/100),0))*(1-(client:GetCharacter():GetPerk("weapontechnician", 0)/20))),0)

			if compcost > compcount then
				client:Notify("Not enough components")
				return false
			end
			
			
			if (client:GetChar():HasMoney(cost) == true) then
				client:GetChar():TakeMoney(cost)
				if bigstackquan > compcost then
					bigstack:SetData("quantity", (bigstackquan - compcost))
				elseif bigstackquan == compcost then
					bigstack:Remove()
				else
					local costtracker = compcost - bigstackquan
					bigstack:Remove()
					for k,v in pairs(items) do
						if v:GetName() == "Components" then
							local compquan = v:GetData("quantity",1)
							if compquan > costtracker then
								v:SetData("quantity", (compquan - costtracker))
								break
							elseif compquan == costtracker then
								v:Remove()
								break
							else
								costtracker = costtracker - compquan
								v:Remove()
							end
						end
					end
				end
				target:SetData("durability", 10000)
				client:EmitSound(item.sound or "items/battery_pickup.wav")
				ix.chat.Send(client, "iteminternal", "uses their "..item.name.." to repair a "..target.name..".", false)
			else
				client:Notify("Could not afford repairs")
				return false
			end
				
			if item:GetData("quantity",100) > 1 then
				item:SetData("quantity", item:GetData("quantity",100) - 1)
				return false
			else
				return true
			end
		else
			client:Notify("Unequip first!")
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
					
						local curPrice = v:GetData("RealPrice")
						if !curPrice then
							curPrice = v.price
						end
						
						local lincost = ((v:GetData("durability",100) / 10)-10)
						local cost = math.Round(((curPrice / 50) * (lincost * lincost))/2)
						local maxcost = (curPrice * 1.05)
						
						if cost > maxcost then
							cost = maxcost
						end
						
						local compcost = math.Round(((100 - math.Round(v:GetData("durability",100),0))*(1-(client:GetCharacter():GetPerk("armortechnician", 0)/20))),0)
						
						table.insert(targets, {
							name = L("Repair "..v.name.." | Costs: "..compcost.." components, "..cost.."Rubles"),
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
		if (item.player:GetCharacter():GetPerk("armortechnician", 0) > 0) then 
			return (!IsValid(item.entity)) and item.player:GetFlags("2")
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		
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
			local compcount = 0
			local bigstack
			local itemquan = 0
			local bigstackquan
			local items = client:GetChar():GetInv():GetItems()
			for k,v in pairs(items) do
				if v:GetName() == "Components" then
					itemquan = v:GetData("quantity",1)
					compcount = compcount + itemquan
					if bigstack == nil then
						bigstack = v
					elseif bigstack:GetData("quantity",1) < itemquan then
						bigstack = v
					end
				end
			end
			
			if not bigstack then
				client:Notify("No Components")
				return false
			end
			
			bigstackquan = bigstack:GetData("quantity",1)
        
			local curPrice = target:GetData("RealPrice")
			if !curPrice then
				curPrice = target.price
			end
				
			local lincost = ((v:GetData("durability",10000) / 1000)-10)
			local cost = math.Round(((curPrice / 50) * (lincost * lincost))/2)
			local maxcost = (curPrice * 1.05)
			
			if cost > maxcost then
				cost = maxcost
			end
				
			local compcost = math.Round(((100 - math.Round(target:GetData("durability",100),0))*(1-(client:GetCharacter():GetPerk("armortechnician", 0)/20))),0)
			
			if compcost > compcount then
				client:Notify("Not enough components")
				return false
			end
				
			if (client:GetChar():HasMoney(cost) == true) then
				client:GetChar():TakeMoney(cost)
				if bigstackquan > compcost then
					bigstack:SetData("quantity", (bigstackquan - compcost))
				elseif bigstackquan == compcost then
					bigstack:Remove()
				else
					local costtracker = compcost - bigstackquan
					bigstack:Remove()
					for k,v in pairs(items) do
						if v:GetName() == "Components" then
							local compquan = v:GetData("quantity",1)
							if compquan > costtracker then
								v:SetData("quantity", (compquan - costtracker))
								break
							elseif compquan == costtracker then
								v:Remove()
								break
							else
								costtracker = costtracker - compquan
								v:Remove()
							end
						end
					end
				end
				target:SetData("durability", 100)
				client:EmitSound(item.sound or "items/battery_pickup.wav")
				ix.chat.Send(client, "iteminternal", "uses their "..item.name.." to repair a "..target.name..".", false)
			else
				client:Notify("Could not afford repairs")
				return false
			end
				
			if item:GetData("quantity",100) > 1 then
				item:SetData("quantity", item:GetData("quantity",100) - 1)
				return false
			else
				return true
			end
		else
			client:Notify("Unequip first!")
			return false	
		end
	end,
}