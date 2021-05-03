
local META = ix.meta.inventory or {}

function META:GetItemCountNonSpecific(onlyMain)
	local i = 0

	for _, v in pairs(self:GetItems(onlyMain)) do
		i = i + 1
	end

	return i
end