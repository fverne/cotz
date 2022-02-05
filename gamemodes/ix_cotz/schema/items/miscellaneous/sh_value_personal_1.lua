ITEM.name = "Personal Belongings"
ITEM.description = "A small jar containing personal items."
ITEM.longdesc = "This jar contains various amounts of smaller items from outside the zone. The objects inside are various and in different conditions. It contains photographs of loved ones, cheap fake jewelry, drawings and other objects which aren't of a lot of commercial value - except for the person who knows it's true value: priceless."
ITEM.model = "models/lostsignalproject/items/misc/jar.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.price = 200

function ITEM:GetName()
	local name

	if(not self:GetOwner()) then return "Personal Belongings" end

	if self:GetData("charname", nil) then
		name = self:GetData("charname", "Anonymous").."'s "..self.name
	end

	return name
end

function ITEM:OnInstanced(invID, x, y)
	if self:GetOwner() then
		self:SetData("charname", self:GetOwner():GetName())
	end
end