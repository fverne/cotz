ITEM.name = "Kit"
ITEM.description= "Default kit."
ITEM.model = "models/props_junk/garbage_bag001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Kits"
ITEM.itemsForcedDrop = {}
ITEM.items = {}
--[[ Example format
ITEM.items[1] = {
	dropAmount = 5, --How many times it will roll for drop
	dropRareChance = 40, --chances for the rarer drops
	dropVeryRareChance = 20,
	itemsCommon = {
		{"9x18"},
		{"9x19"},
		{"12gauge"},
	},
	itemsRare = {
		{"57x28"},
		{"380acp"},
		{"762x25"},
	},
	itemsVeryRare = {
		{"22lr"},
		{"mp5", {["durability"] = 30}}, --Data can also be passed
		{"45acp"},
	},
}
]]--

function ITEM:GetDescription()
	local quant = self:GetData("quantity", 1)
	local str = self.description
	if self.longdesc then
		str = str.."\n"..(self.longdesc or "").."\n\n"
	end

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

ITEM.functions.Open = {
    icon = "icon16/stalker/unlock.png",
    sound = "stalkersound/inv_ruck.mp3",
    OnRun = function(item)
        local position = item.player:GetItemDropPos()
        local client = item.player

		for k = 1, #item.items do
			for i = 1, item.items[k].dropAmount do
				local droppedItem
				local rchance
				local vrchance
				--Select item to be dropped
				local casinoVar = math.random(100) --SPIN THE WHEEL
				if item.items[k].dropVeryRareChance then
					vrchance = item.items[k].dropVeryRareChance*(1+(client:GetCharacter():GetAttribute("luck", 0)/2))
				else	
					vrchance = 0
				end
				if item.items[k].dropRareChance then
					rchance = item.items[k].dropRareChance*(1+(client:GetCharacter():GetAttribute("luck", 0)/2))
				else	
					rchance = 0
				end
				
				if casinoVar >= (100 - vrchance) then
					droppedItem = table.Random(item.items[k].itemsVeryRare)
				elseif casinoVar >= (100 - rchance) then
					droppedItem = table.Random(item.items[k].itemsRare)
				else
					droppedItem = table.Random(item.items[k].itemsCommon)
				end
				
				timer.Simple(i/10, function()
					if (IsValid(client) and client:GetCharacter() and !client:GetCharacter():GetInventory():Add(droppedItem[1], 1, droppedItem[2] or {})) then
						ix.item.Spawn(droppedItem[1], position, nil, AngleRand(), droppedItem[2] or {})
					end
				end)
			end
        end
		
		if #item.itemsForcedDrop >= 0 then
			for i = 1, #item.itemsForcedDrop do
				timer.Simple(i/10, function()
                if (IsValid(client) and client:GetCharacter() and !client:GetCharacter():GetInventory():Add(item.itemsForcedDrop[i][1], 1, item.itemsForcedDrop[i][2] or {})) then
                    ix.item.Spawn(item.itemsForcedDrop[i][1], position, nil, AngleRand(), item.itemsForcedDrop[i][2] or {})
                end
			end)
			end
		end
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity)
    end
}

ITEM:Hook("Open", function(item)
	ix.chat.Send(item.player, "iteminternal", "opens the "..item.name..".", false)
end)