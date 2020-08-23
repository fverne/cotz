ITEM.name = "Compression Bandage"
ITEM.description = "A small bandage for wounds."
ITEM.longdesc = "A more advanced bandage, used for serious bleeding in combat situations. It is easy and quick to apply, but you do pay for the convenience."
ITEM.model = "models/lostsignalproject/items/medical/army_bandage.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.restore = 16
ITEM.quantity = 4 -- Total of 64 health recovered over 25s

ITEM.sound = "stalkersound/inv_bandage_2p9.mp3"
ITEM.price = 140
ITEM.weight = 0.015

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 2.5,
}

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)

		ix.chat.Send(item.player, "iteminternal", "unwraps and ties a "..item.name.." to their wound.", false)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Wrapping Bandages", 4, function(player) 
			player:AddBuff("buff_slowheal", 5, { amount = item.restore/5 })
			--player:HealBleeding(90)
		end)

		local quantity = item:GetData("quantity", item.quantity)
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