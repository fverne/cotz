ITEM.name = "Cutlery"
ITEM.description = "Broken cutlery."
ITEM.longdesc = "The cutlery you are holding is very much out of shape. The fork has parts of it missing and the knife has no handle. It's completely impossible to use this for eating. It can still be used for very basic tool usage, such as prying open areas to hide your stash."
ITEM.model = "models/lostsignalproject/items/misc/cutlery.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.flag = "A"

ITEM.weight = 0.550
ITEM.quantity = 5

ITEM.price = 200

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 180, 0),
	fov = 2.9411764705882,
}

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("quantity")) then
        self:SetData("quantity", self.quantity)
    end
end