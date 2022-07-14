ITEM.name = "Components"
ITEM.category = "Technician"
ITEM.model = "models/lostsignalproject/items/quest/condensers.mdl"
ITEM.description = "Components used for crafting various items."
ITEM.longdesc = "This box contains components salvaged from various items within the zone. They can be used by technicians to craft and repair various items."
ITEM.flag = "A"
ITEM.price = 1
ITEM.quantity = 5000
ITEM.splitSize = {1,5,10,25,100,1000}
ITEM.noBusiness = true

function ITEM:GetDescription()
	local quant = math.Round(self:GetData("quantity", 1), 0)
	local str = self.description.."\n \nThis box contains "..quant.." components."

	return str
end

function ITEM:GetDescription()
	local quant = self:GetData("quantity", 1)
	local str = ""
	if self.longdesc then
		str = (self.longdesc or "")
	end

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end

	if (self.entity) then
		return self.description.."\n \nThis box has "..math.Round(quant).."/"..self.quantity.." components."
	else
        return (str.."\n \nThis box has "..math.Round(quant).."/"..self.quantity.." components.")
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
		draw.SimpleText(math.Round(item:GetData("quantity", 1), 0).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)	
		if !data then
			return false
		end	

		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueID == item.uniqueID then
			return true
		else
			return false

		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetQuantDiff = targetItem.quantity - targetItem:GetData("quantity", 1)
		local localQuant = item:GetData("quantity", 1)
		local targetQuant = targetItem:GetData("quantity", 1)

		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

		if targetQuantDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetQuantDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}

ITEM.functions.use = {
    name = "Split",
    tip = "useTip",
    icon = "icon16/stalker/split.png",
    isMulti = true,
    multiOptions = function(item, client)
		local targets = {}
        local quantity = item:GetData("quantity", 1)
		
        for i=1,#item.splitSize do
			if quantity > item.splitSize[i] then
				table.insert(targets, {
					name = item.splitSize[i],
					data = {item.splitSize[i]},
				})
			end
		end
        return targets
	end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end,
    OnRun = function(item, data)
		if data[1] then
			local quantity = item:GetData("quantity", 1)
			local client = item.player
			
			client:GetCharacter():GetInventory():Add("component", 1, {["quantity"] = data[1]})
			
			item.player:EmitSound("items/ammo_pickup.wav", 110)
			
			quantity = quantity - data[1]
			
			item:SetData("quantity", quantity)
			
		end
		return false
	end,
}