ITEM.name = "Elastic Bandage"
ITEM.description = "A bandage for wounds."
ITEM.longdesc = "A normal elastic bandage used to stop bleeding and prevent infection of wounds. For regular bleeding, carefully apply the bandage to the wound. For arterial bleeding, urgently tie the bandage around the affected area."
ITEM.model = "models/lostsignalproject/items/medical/bandage.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.restore = 9
ITEM.restoreduration = 6
ITEM.applicationTime = 2
ITEM.quantity = 3
ITEM.bleedRestore = 50

ITEM.sound = "stalkersound/inv_bandage_2p9.mp3"
ITEM.price = 210
ITEM.weight = 0.010

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 2.5,
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
