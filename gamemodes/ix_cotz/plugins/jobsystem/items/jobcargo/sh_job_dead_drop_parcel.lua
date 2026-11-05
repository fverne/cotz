ITEM.name = "Sealed Dead-Drop Parcel"
ITEM.description = "A sealed parcel entrusted to you for delivery to an assigned dead drop."
ITEM.longdesc = "The dead-drop parcel keeps its assigned cargo inside a sealed wrapping. Its plain exterior suits a delivery completed without meeting the receiving party. The package is the part of the exchange that travels; the agreed location supplies the rest of the instructions."
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
