ITEM.name = "Scientific Syrette Kit"
ITEM.description = "A small cardboard box with medical supplies inside, made for the zone."
ITEM.longdesc = "A box of syrettes designed specifically for the harsh environments and dangers one might face in the exclusion zone.\nThe syrettes contain a solution that will both suppress pain, help the body stop possible bleeding, and attempt to purge radiation from the body as well."
ITEM.model = "models/lostsignalproject/items/medical/medkit_science.mdl"

ITEM.sound = "stalkersound/inv_bandage.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1800

ITEM.quantity = 2
ITEM.restore  = 80
item.radrem   = 35

ITEM.weight = 0.025
ITEM.flatweight = 0.045

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_slowheal", 20, { amount = item.restore/40 })
		item.player:AddBuff("buff_radiationremoval", 10, { amount = item.radrem/20 })
		--item.player:AddBuff("buff_bleedheal", 5, { amount = 40/10 })
		ix.chat.Send(item.player, "iteminternal", "opens the "..item.name.." and injects himself with a syrette.", false)

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
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
*/