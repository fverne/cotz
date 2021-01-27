ITEM.name = "Handdrawn Anomaly Map"
ITEM.description = "A hastily drawn, and soaked, anomaly map."
ITEM.longdesc = "This map describes the anomalies quite detailed of an anomaly field. It's quite useless, as anomalies move between emissions."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.180

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end