-- Both vendor endpoints dispatch this hook before checking or updating the vendor's balance.
function PLUGIN:CanPlayerTradeWithVendor(client, vendor, itemID, selling)
	if vendor.money ~= nil then vendor:SetMoney() end
end

function PLUGIN:CanPlayerUseVendor(client, vendor)
	if vendor.money ~= nil then vendor:SetMoney() end
end
