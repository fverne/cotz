ITEM.name = "Cleaning kit"
ITEM.description = "A rusty and very old cleaning kit for male grooming."
ITEM.longdesc = "This rusty and old cleaning kit is used by stalkers to clean their faces after long days, as beard and other growth can get in the way of your focus and general wellbeing. The cleaning kit does however have a secondary use, as a pseudo-tool, and is used by many stalkers if they dont have anything better."
ITEM.model = "models/lostsignalproject/items/misc/ckit.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.flag = "A"

ITEM.weight = 1.1
ITEM.quantity = 15

ITEM.price = 900

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 5),
	ang = Angle(0, -0, 0),
	fov = 2,
}

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("quantity")) then
        self:SetData("quantity", self.quantity)
    end
end