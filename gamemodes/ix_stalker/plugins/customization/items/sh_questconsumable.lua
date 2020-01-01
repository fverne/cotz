ITEM.name = "Quest Item"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A quest item."
ITEM.flag = "N"
ITEM.category = "Quest"
ITEM.OnGetDropModel = true

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
			local inventory = client:GetCharacter():GetInventory()
			
			if(!inventory:Add(item.uniqueID, 1, item.data)) then
				client:Notify("Inventory is full")
			end
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

function ITEM:GetDescription(partial)
	local desc = self.description
	
	local customData = self:GetData("custom", {})
	if(customData.desc) then
		desc = customData.desc
	end
		
	if(!partial) then
		if(customData.quality) then
			desc = desc .. "\nQuality: " ..customData.quality
		end
	end
	
	return desc
end

function ITEM:GetName()
	local name = self.name
	
	local customData = self:GetData("custom", {})
	if(customData.name) then
		name = customData.name
	end
	
	return name
end

function ITEM:OnGetDropModel()
	local model = self.model
	
	local customData = self:GetData("custom", {})
	if(customData.model) then
		model = customData.model
	end
	
	return Format(model)
end