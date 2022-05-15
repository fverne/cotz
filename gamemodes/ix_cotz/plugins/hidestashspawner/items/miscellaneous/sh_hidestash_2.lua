ITEM.name = "Lost Rookie PDA"
ITEM.model = "models/lostsignalproject/items/devices/pda.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "The PDA of a lost stalker. It looks new, and did probably belong to a rookie STALKER."
ITEM.price = 2500
ITEM.flag = "A"
ITEM.hidestashcategory = "tier2"
ITEM.moneyinterval = {200, 400}

function ITEM:GetDescription()
    if self:GetData("stashtext", nil) == nil then
        return self.description
    else
        if self:GetData("moneytaken", false) == true then
            return self.description .. "\n\n" .. self:GetData("stashtext", nil)
        else
            return self.description .. "\n\nThe pda has a note written on it. It reads:\n" .. self:GetData("stashtext", nil)
        end
    end
end

ITEM.functions.use = {
	name = "Check for information",
	icon = "icon16/stalker/unlock.png",
	OnRun = function(item)
		local loot = table.Random(ix.plugin.list["hidestashspawner"].StashItems[item.hidestashcategory])
		local spawnpoint = ix.plugin.list["hidestashspawner"]:GetPoint()
		local stashcontent = "CONTENT: "

		if !spawnpoint then
			item.player:Notify("No hidestash spawn points defined for this map, contact the developers.")
			print("a hidestash item was used, but there are no points on the map to spawn it in!")
			return false
		end

		local chance = math.random(1,2)
		if chance == 1 then
			ix.plugin.list["hidestash"]:SpawnStash(spawnpoint[1], { loot[1], loot[2], loot[3] })
			item:SetData("stashcoordinates", spawnpoint[1])
			item:SetData("stashtext", spawnpoint[2])
			item:SetData("map", game.GetMap())
			for i = 1, #loot[1] do
				stashcontent = stashcontent..", "..loot[i][1]
			end

			item.player:Notify( "You found the location of a stash!" )
			ix.log.Add(item.player, "command", "created a stash from "..item.name.." at x:"..spawnpoint[1].x.." y:"..spawnpoint[1].y.." z:"..spawnpoint[1].z.." with "..stashcontent)
		else
			local money = math.random(item.moneyinterval[1], item.moneyinterval[2])
			item.player:GetCharacter():GiveMoney(money)
			item.player:Notify( "You found "..money.." rubles and wired them to your account!" )
			item:SetData("stashtext", "There was some money on this PDA, but it's gone now.")
			item:SetData("moneytaken", true)
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (item:GetData("stashcoordinates", nil) == nil) and (item:GetData("moneytaken", nil) != true) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.stashpointer = {
	name = "Check stash coordinates",
	icon = "icon16/stalker/throw.png",
	OnRun = function(item)
		if game.GetMap() == item:GetData("map", "gm_construct") then
			item.player:Notify( "You take a close look at the stash coordinates..." )
			netstream.Start(item.player, "nut_DisplayStashSpawnPointsSingle", item:GetData("stashcoordinates", nil))
		else
			item.player:Notify("Stash is not on this map! It's at "..item:GetData("map", "gm_construct"))
		end
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (item:GetData("stashcoordinates", nil) != nil) and (item:GetData("moneytaken", nil) != true) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}
