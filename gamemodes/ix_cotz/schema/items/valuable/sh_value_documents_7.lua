ITEM.name = "Firearm Assembly Illustration"
ITEM.description = "A single page torn from a weapons manual."
ITEM.longdesc = "This single page shows the various elements of the assembly and disassembly of a weapon of soviet origin."
ITEM.model = "models/lostsignalproject/items/quest/notes_letter_2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 160

ITEM.flatweight = 0.100

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 19.607843399048),
	ang = Angle(90, 180, 0),
	fov = 57.058823529412,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end