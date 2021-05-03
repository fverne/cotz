ITEM.name = "Shovel"
ITEM.description= "An old, rusty shovel."
ITEM.longdesc = "This very old field shovel has seen better days. The handle is rusted, and it's too light to fight with. This doesn't undermine it's ability as a tool, however, as it's very easy to hide your personal belongings in the zone, out of sight for other stalkers."
ITEM.model = "models/lostsignalproject/items/misc/shovel.mdl"
ITEM.width = 3
ITEM.height = 1
ITEM.flag = "A"

ITEM.weight = 2.600
ITEM.quantity = 40

ITEM.price = 3500

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-1, 0, 200),
	ang = Angle(90, 90, 0),
	fov = 11,
}

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("quantity")) then
        self:SetData("quantity", self.quantity)
    end
end