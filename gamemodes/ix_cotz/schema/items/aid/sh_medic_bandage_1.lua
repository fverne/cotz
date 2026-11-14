ITEM.name = "Gauze Bandage"
ITEM.description = "A bandage for wounds."
ITEM.longdesc = "A simple roll of gauze, which in a pinch can be used to apply pressure if bound tightly around a wound. It is not very effective, however it will work in a pinch."
ITEM.model = "models/kek1ch/dev_bandage.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.restore = 6
ITEM.restoreduration = 6
ITEM.applicationTime = 2
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
		if not item:StartBandageTreatment(target) then
			item.player:Notify("Look at a living player within reach.")

			return false
		end

		ix.chat.Send(item.player, "iteminternal", "applies a " .. item.name .. " to the patient's wound.", false)
		quantity = quantity - 1
		if quantity >= 1 then
			item:SetData("quantity", quantity)

			return false
		end

		return true
	end,
	OnCanRun = function(item)
		return item:CanUseBandage()
	end
}
