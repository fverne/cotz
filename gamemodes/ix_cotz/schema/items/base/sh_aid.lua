ITEM.name = "aid"
ITEM.description = "Helps your body survive in the zone - in one way or another."
ITEM.longdesc = "Supplies pass through many hands before reaching a camp treatment table. The original packaging"
	.. " is often the only record left of where they came from."
ITEM.category = "Aid"
ITEM.quantdesc = "This item has %d uses left."

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.quantity = 0
ITEM.restore = 0

ITEM.weight = 0
ITEM.flatweight = 0

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description)
	else
        return (self.description..quantdesc..invdesc)
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

function ITEM:PopulateTooltip(tooltip)
    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
end)

ITEM:Hook("usetarget", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
end)

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
end

function ITEM:GetPrice()
	return math.Round(self.price * self:GetData("quantity", self.quantity) / self.quantity)
end

function ITEM:CanUseBandage()
	local client = self.player
	if not IsValid(client) or not client:Alive() or IsValid(self.entity) then return false end

	local character = client:GetCharacter()
	if not character or self.invID ~= character:GetInventory():GetID() then return false end
	if client:GetNetVar("ix_noMenuAllowed", false) then return false end

	return self:GetData("quantity", self.quantity) >= 1
end

function ITEM:StartBandageTreatment()
	if not self:CanUseBandage() then return false end

	local client = self.player
	local character = client:GetCharacter()
	local restore, duration, bleedRestore = self.restore, self.restoreduration, self.bleedRestore
	local token = {}
	client.cotzBandageAction = token
	ix.util.PlayerPerformItemAction(client, self, "Wrapping Bandages", 2, function(player)
		if not IsValid(player) or not player:Alive() or player:GetCharacter() ~= character then return end
		if player.cotzBandageAction ~= token then return end

		player.cotzBandageAction = nil
		player:AddBuff("buff_bleedheal", duration, {amount = restore})
		local buffs = ix.plugin.Get("buffs")
		if buffs then
			buffs:HealBleeding(player, bleedRestore)
		end
	end)

	return true
end
