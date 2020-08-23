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
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description)
	else
        return (self.description..quantdesc..invdesc)
	end
end

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