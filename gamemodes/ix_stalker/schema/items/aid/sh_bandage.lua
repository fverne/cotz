ITEM.name = "Bandage"
ITEM.description = "A small bandage for wounds."
ITEM.longdesc = "A normal elastic bandage used to stop bleeding and prevent infection of wounds. For regular bleeding, carefully apply the bandage to the wound. For arterial bleeding, urgently tie the bandage around the affected area."
ITEM.model = "models/kek1ch/dev_bandage.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Aid"
ITEM.restore = 15
ITEM.sound = "stalkersound/inv_bandage_2p9.mp3"
ITEM.price = "25"
ITEM.busflag = {"medical"}
ITEM.weight = 0.05

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		item.player:AddBuff("buff_slowheal", 10, { amount = item.restore/5 })
		ix.chat.Send(item.player, "iteminternal", "unwraps and ties a "..item.name.." to their wound.", false)
		
		

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
/*
ITEM.functions.usetarget = {
	name = "Heal Target",
	icon = "icon16/stalker/heal.png",
	onRun = function(item)
		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
		local quantity = item:getData("quantity", item.quantity)
		if (IsValid(target) and target:IsPlayer()) then
			target:AddBuff("buff_slowheal", 5, { amount = item.restore*(1+(item.player:getChar():getAttrib("medical", 0)/50))/10 })
			nut.chat.send(item.player, "iteminternal", "opens a "..item.name.." and uses it on "..target:Name()..".", false)
			
			quantity = quantity - 1

			if (quantity >= 1) then
				item:setData("quantity", quantity)
				return false
			end
			
			
		else
			item.player:notify("Not looking at a player!")
			return false
		end

		return true
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}