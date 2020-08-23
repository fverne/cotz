ITEM.name = "Cuban Cigar"
ITEM.description = "A single 'Cohiba' brand cuban cigar."
ITEM.longdesc = "This 'Cohiba' brand Cuban cigar is of high quality. It is not a very common thing in the zone, as most STALKERs simply do not have the money to spare to import them. Often enjoyed by some experienced STALKERs after they've scored big and can afford it. Apart from using it as a celebration, it can also be used to help calm ones nerves."
ITEM.model = "models/lostsignalproject/items/consumable/cigar.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 985

ITEM.quantity = 2
ITEM.hunger = 8
ITEM.psyheal = 8

ITEM.weight = 0.0015

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 1.7,
}

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Rare Item", Color(200, 200, 200))
			ix.util.PropertyDesc(tooltip, "Calms the Mind", Color(0, 255, 255))
			ix.util.PropertyDesc(tooltip, "Unhealthy", Color(255, 0, 0))
		end
	end
end

ITEM.functions.use = {
	name = "Smoke",
	icon = "icon16/stalker/smoke.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		local hunger = item.player:GetCharacter():GetData("hunger", 100)
		item.player:SetHunger(hunger + item.hunger)

		item.player:AddBuff("buff_psyheal", 15, { amount = item.psyheal/30 })

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "lights his "..item.name.." and inhales deeply.", false)

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end
		
		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueid == item.uniqueid then
			return true
		else
			return false

		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetQuantDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetQuantDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetQuantDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}