ITEM.name = "Ammo Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.ammo = "pistol" -- type of the ammo
ITEM.ammoAmount = 30 -- amount of the ammo
ITEM.isAmmo = true
ITEM.loadSize = {1,5,15, ITEM.ammoAmount}
ITEM.description = "A box with %s rounds of ammunition."
ITEM.category = "Ammunition"
ITEM.busflag = {"dev"}

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount)
	local ammodesc = Format(self.description, quant)
	local str = ""
	if self.longdesc then
		str = (self.longdesc or "")
	end

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end

	if (self.entity) then
		return (ammodesc)
	else
        return (str.."\n \nThis box contains "..quant.." rounds.")
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

function ITEM:OnInstanced(invID, x, y)
	
	if !self:GetData("quantity") then
		self:SetData("quantity", self.ammoAmount)
	end
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
		draw.SimpleText(
			item:GetData("quantity", item.ammoAmount).."/"..item.ammoAmount, "DermaDefault", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end
end

ITEM.functions.use = {
    name = "Load",
    tip = "useTip",
    icon = "icon16/stalker/load.png",
    isMulti = true,
    OnCanRun = function(item)				
		return (!IsValid(item.entity))
	end,
	multiOptions = function(item, client)
		local targets = {}
        local quantity = item:GetData("quantity", item.ammoAmount)
		
        for i=1,#item.loadSize do
			if quantity >= item.loadSize[i] then
				table.insert(targets, {
					name = item.loadSize[i].." rounds",
					data = {item.loadSize[i]},
				})
			end
		end
		table.insert(targets, {
			name = quantity.." rounds",
			data = {quantity},
		})
        return targets
	end,
    OnRun = function(item, data)
		if !data[1] then
			return false
		end

		local quantity = item:GetData("quantity", item.ammoAmount)
		item.player:GiveAmmo(data[1], item.ammo, true)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		
		quantity = quantity - data[1]

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		return true
	end,
}

ITEM.functions.split = {
    name = "Split",
    tip = "useTip",
    icon = "icon16/stalker/split.png",
    isMulti = true,
    multiOptions = function(item, client)
		local targets = {}
        local quantity = item:GetData("quantity", item.ammoAmount)
		
        for i=1,#item.loadSize-1 do
			if quantity > item.loadSize[i] then
				table.insert(targets, {
					name = item.loadSize[i],
					data = {item.loadSize[i]},
				})
			end
		end
        return targets
	end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity))
	end,
    OnRun = function(item, data)
		if data[1] then
			local quantity = item:GetData("quantity", item.ammoAmount)
			local client = item.player
			
			client:GetCharacter():GetInventory():Add(item.uniqueID, 1, {["quantity"] = data[1]})
			
			quantity = quantity - data[1]

			item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
			
			item:SetData("quantity", quantity)
			
		end
		return false
	end,
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end

		local targetItem = ix.item.instances[data[1]]

		if targetItem.ammo == item.ammo then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetAmmoDiff = targetItem.ammoAmount - targetItem:GetData("quantity", targetItem.ammoAmount)
		local localQuant = item:GetData("quantity", item.ammoAmount)
		local targetQuant = targetItem:GetData("quantity", targetItem.ammoAmount)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetAmmoDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetAmmoDiff)
			targetItem:SetData("quantity", targetItem.ammoAmount)
			return false
		end
	end,
}

-- Called after the item is registered into the item tables.
function ITEM:OnRegistered()
	if (ix.ammo) then
		ix.ammo.Register(self.ammo)
	end
end
