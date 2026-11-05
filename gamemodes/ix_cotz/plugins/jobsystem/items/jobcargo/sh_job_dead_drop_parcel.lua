ITEM.name = "Sealed Dead-Drop Parcel"
ITEM.description = "A sealed parcel entrusted to you for delivery to an assigned dead drop."
ITEM.longdesc = "The wrapping has been left undisturbed for the next pair of hands. Out here, a successful"
	.. " delivery often ends without either party learning the other's name."
ITEM.model = "models/props_c17/briefcase001a.mdl"

ITEM.price = 0
ITEM.width = 2
ITEM.height = 2
ITEM.flatweight = 5

function ITEM:GetDescription()
	local description = self:GetData("fieldDescription", self.description)
	if not self.entity then
		description = description .. "\n\n" .. self.longdesc
	end

	return description
		.. "\nUse Field work in your PDA task list to find the destination and deliver it."
end
