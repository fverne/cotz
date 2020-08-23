ITEM.name = "Army Syrette Kit"
ITEM.description = "A small cardboard box with medical supplies inside, intended for the army."
ITEM.longdesc = "Inside this paper shell is a couple of syrettes of army-grade strength.\nThese syrettes come at a premium, as the drugs contained within them are expensive and especially hard to procure in the exclusion zone."
ITEM.model = "models/lostsignalproject/items/medical/medkit_army.mdl"

ITEM.sound = "stalkersound/inv_bandage.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1220

ITEM.quantity = 2
ITEM.restore = 65

ITEM.weight = 0.025
ITEM.flatweight = 0.045

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(200, 0, 0),
	ang = Angle(180, -0, 180),
	fov = 2.1,
}

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		
		item.player:AddBuff("buff_slowheal", 20, { amount = item.restore/40 })
		
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