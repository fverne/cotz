ITEM.name = "Kit"
ITEM.description= "Default kit."
ITEM.model = "models/props_junk/garbage_bag001a.mdl"
ITEM.category = "Kits"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.itemsForcedDrop = {}
ITEM.items = {}

ITEM.weight = 0

--[[ Example format
ITEM.items = {
	{
		{9, "reward_ammo_low"}, -- { <likelihood of spawning> , <item pool to spawn> }
		{1,  "reward_ammo_high"},
	},
	{
		{9, "reward_aid_low"},
		{1,  "reward_aid_high"},
	}
}
]]--

function ITEM:GetDescription()
	if ix.taskRewards and ix.taskRewards.IsTaskKit(self.uniqueID) then
		return self.description .. "\nRedeem at an NPC's task supplies menu for visible contents. No upgrade fee."
	end
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

function ITEM:PopulateTooltip(tooltip)
    if !self.entity then
        local description = ix.taskRewards and ix.taskRewards.IsTaskKit(self.uniqueID)
			and "Redeem for visible supplies at an NPC" or "Openable, contains items"
		ix.util.PropertyDesc(tooltip, description, Color(64, 224, 208))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

ITEM.functions.Open = {
    icon = "icon16/stalker/unlock.png",
    sound = "stalkersound/inv_ruck.mp3",
    OnRun = function(item)
		if ix.taskRewards and ix.taskRewards.IsTaskKit(item.uniqueID) then
			item.player:Notify("Redeem this kit through an NPC's task supplies menu. Contents are shown before exchange.")

			return false
		end
        local position = item.player:GetItemDropPos()
        local client = item.player

		for k, itemlist in pairs(item.items) do
			local totalweight = 0

    		for _,tableentry in pairs(itemlist) do
      			totalweight = totalweight + tableentry[1]
    		end

  			local roll = math.random(1, totalweight)
  			local grouptospawn

  			for _,tableentry in pairs(itemlist) do
    			roll = roll - tableentry[1]
    			if (roll <= 0) then
      				grouptospawn = tableentry[2]
      				break
    			end
  			end

  			local droppedItem = ix.util.GetRandomItemFromPool(grouptospawn)
			timer.Simple(k/10, function()
				if (IsValid(client) and client:GetCharacter() and !client:GetCharacter():GetInventory():Add(droppedItem[1], 1, droppedItem[2] or {})) then
					ix.item.Spawn(droppedItem[1], position, nil, AngleRand(), droppedItem[2] or {})
				end
			end)
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
	if ix.taskRewards and ix.taskRewards.IsTaskKit(item.uniqueID) then return end
	ix.chat.Send(item.player, "iteminternal", "opens the "..item.name..".", false)
end)