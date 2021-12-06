ITEM.name = "Trading Ledger"
ITEM.description = "A noteblock with scribbles covering transactions."
ITEM.longdesc = "The noteblock has many of its pages filled with scribblings, most unreadable. The pages contain mostly documentation of tradings done, including various income registrations along the pages."
ITEM.model = "models/lostsignalproject/items/quest/notes_writing_book_1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 730

ITEM.flatweight = 0.550

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-1, 0, 200),
	ang = Angle(90, 180, 0),
	fov = 5,
}


if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end