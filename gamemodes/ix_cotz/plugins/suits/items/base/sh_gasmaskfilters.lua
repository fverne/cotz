ITEM.name = "Gasmask Filter"
ITEM.description = "A replacement gasmask cartridge."
ITEM.category = "Gasmask Filters"
ITEM.isGasmaskFilter = true

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		local targetID = istable(data) and data[1]
		if not isnumber(targetID) then return false end

		return ix.util.CanInstallGasmaskFilter(ix.item.instances[targetID], item, item.player)
	end,
	OnRun = function(item, data)
		local targetID = istable(data) and data[1]
		local target = isnumber(targetID) and ix.item.instances[targetID]
		if target then ix.util.InstallGasmaskFilter(target, item.player, {item.id}) end

		return false
	end,
}

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
