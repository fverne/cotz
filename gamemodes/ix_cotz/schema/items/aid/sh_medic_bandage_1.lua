ITEM.name = "Gauze Bandage"
ITEM.description = "A bandage for wounds. Reduces bleeding severity by 20."
ITEM.longdesc = "A simple roll of gauze, which in a pinch can be used to apply pressure if bound tightly around a wound. It is not very effective, however it will work in a pinch."
ITEM.model = "models/kek1ch/dev_bandage.mdl"
ITEM.width = 1
ITEM.height = 1

-- ITEM.restore = 8
ITEM.restoreduration = 4
ITEM.quantity = 3
ITEM.bleedRestore = 20

ITEM.sound = "stalkersound/inv_bandage_2p9.mp3"
ITEM.price = 140
ITEM.weight = 0.008

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-1, 0, 200),
	ang = Angle(90, 0, -45),
	fov = 3,
}

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
	ix.util.PropertyDesc(tooltip, "Bleeding reduction: " .. self.bleedRestore, Color(220, 45, 45))
end

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		if not item:CanUseBandage() then return false end

		ix.chat.Send(item.player, "iteminternal", "unwraps and ties a "..item.name.." to their wound.", false)

		if not item:StartBandageTreatment() then return false end
		
		local quantity = item:GetData("quantity", item.quantity)
		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		return true
	end,
	OnCanRun = function(item)
		return item:CanUseBandage()
	end
}

ITEM.functions.usetarget = {
	name = "Heal Target",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		if not item:CanUseBandage() then return false end

		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
		local quantity = item:GetData("quantity", item.quantity)
		if IsValid(target) and target:IsPlayer() and target:Alive() and target:GetCharacter() then
			
			ix.chat.Send(item.player, "iteminternal", "unwraps a "..item.name.." and ties it to "..target:Name().."'s wound.", false)
			-- target:AddBuff("buff_slowheal", item.restoreduration, { amount = item.restore })
			local buffs = ix.plugin.Get("buffs")
			if buffs then
				buffs:HealBleeding(target, item.bleedRestore)
			end
			target:SetLocalVar("stm", math.min(target:GetLocalVar("stm", 100) + item.restore*item.restoreduration, 100))
			
			quantity = quantity - 1

			if (quantity >= 1) then
				item:SetData("quantity", quantity)
				return false
			end
		else
			item.player:Notify("Not looking at a player!")
			return false
		end

		return true
	end,
	OnCanRun = function(item)
		return item:CanUseBandage()
	end
}
