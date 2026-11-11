ITEM.name = "Gasmask Filter"
ITEM.description = "A replacement gasmask cartridge."
ITEM.category = "Gasmask Filters"
ITEM.isGasmaskFilter = true

function ITEM:OnInstanced()
	if self:GetData("filterCondition") == nil then self:SetData("filterCondition", self.filterCondition) end
end

function ITEM:GetWeight()
	if self.cotzFilterReturning then return 0 end

	return self:GetData("weight", self.weight)
end

if CLIENT then
	function ITEM:PaintOver(item, width, height)
		ix.util.PaintGasmaskFilter(item, width, height)
	end

	function ITEM:PopulateTooltip(tooltip)
		ix.util.PopulateGasmaskFilterTooltip(tooltip, self)
	end
end
