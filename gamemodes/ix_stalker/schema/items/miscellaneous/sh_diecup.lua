ITEM.name = "Cup of dice"
ITEM.description = "A cup of dice"
ITEM.model = "models/kek1ch/jar.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = "15"
--ITEM.busflag = "MERCH3"
ITEM.busflag = {"hardware1_1"}
ITEM.maxDie = 6

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("diecount")) then
			draw.SimpleText("d:"..item:GetData("diecount", 1), "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end
	end
end

ITEM.functions.Roll = {
	icon = "icon16/stalker/dice.png",
	sound = "stalkersound/inv_slot.mp3",
	OnRun = function(item)
		local client = item.player
		local resultsum = 0
		local resultstr = ""
		for i = 1, item:GetData("diecount", 1) do
			local randommeme = math.random(1,6)
			resultsum = resultsum+randommeme
			resultstr = resultstr.." "..randommeme
			if i ~= item:GetData("diecount", 1) then
				if i == (item:GetData("diecount", 1) - 1) then
					resultstr = resultstr.." and a"
				else
					resultstr = resultstr..","
				end
			end
		end
		
		if item:GetData("diecount", 1) > 1 then
			resultstr = resultstr.." for a total of "..resultsum
		end
		
		ix.chat.Send(client, "iteminternal", "rolls the dice and gets a"..resultstr.."." , false)
		return false
	end,
}

ITEM.functions.Amount = {
	icon = "icon16/coins.png",
	sound = "physics/body/body_medium_impact_soft1.wav",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
        local tempName
		for i=1,item.maxDie do
			if i == 1 then
					tempName = i.." die"
			else
					tempName = i.." dice"
			end
			table.insert(targets, {
				name = tempName,
				data = {i} ,
			})
		end

		return targets
	end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity))
	end,
	OnRun = function(item, data)
		if !data[1] then
			return false
		end

		item:SetData("diecount", data[1])

		return false
	end,
}

function ITEM:GetDescription()
	local quant = self:GetData("quantity", 1)
	local str = self.longdesc

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end

	if (self.entity) then
		return self.description
	else
        return (str)
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

function ITEM:OnInstanced(invID, x, y)
	if !self:GetData("diecount") then
		self:SetData("diecount", 1)
	end
end