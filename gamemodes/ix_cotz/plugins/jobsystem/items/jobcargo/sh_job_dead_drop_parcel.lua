ITEM.name = "Sealed Dead-Drop Parcel"
ITEM.description = "A sealed parcel entrusted to you for delivery to an assigned dead drop."
ITEM.model = "models/props_c17/briefcase001a.mdl"

ITEM.price = 0
ITEM.width = 2
ITEM.height = 2
ITEM.flatweight = 5

function ITEM:GetDescription()
	return self.description .. "\nUse Field work in your PDA task list to find the destination and deliver it."
end
