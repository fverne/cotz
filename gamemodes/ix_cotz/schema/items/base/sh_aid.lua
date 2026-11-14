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
	local description = self:GetData("description", self.description)
	if self.entity or not self.longdesc or self.longdesc == "" then return description end

	return description .. "\n\n" .. self.longdesc
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

local BANDAGE_RANGE = 96

local function canTreatTarget(client, target, character)
	if not IsValid(target) or not target:IsPlayer() or not target:Alive() then return false end
	if target:GetCharacter() ~= character then return false end
	if client == target then return true end
	if client:GetPos():DistToSqr(target:GetPos()) > BANDAGE_RANGE * BANDAGE_RANGE then return false end

	local trace = util.TraceLine({
		start = client:GetShootPos(),
		endpos = target:WorldSpaceCenter(),
		filter = client,
	})

	return trace.Entity == target
end

function ITEM:StartBandageTreatment(target)
	if not self:CanUseBandage() then return false end

	local client = self.player
	target = target or client
	local character = client:GetCharacter()
	local targetCharacter = IsValid(target) and target:IsPlayer() and target:GetCharacter()
	if not targetCharacter or not canTreatTarget(client, target, targetCharacter) then return false end

	local total, duration, healing = self.bleedRestore, self.restoreduration, self.restore
	local token = {}
	client.cotzBandageAction = token
	local started = ix.util.PlayerPerformItemAction(client, self, "Wrapping Bandages", self.applicationTime, function(player)
		if not IsValid(player) or not player:Alive() or player:GetCharacter() ~= character then return end
		if player.cotzBandageAction ~= token then return end

		player.cotzBandageAction = nil
		if not canTreatTarget(player, target, targetCharacter) then return end

		target:SetHealth(math.min(target:Health() + healing, target:GetMaxHealth()))
		ix.plugin.Get("buffs"):StartBandageClotting(target, total, duration)
	end)
	if started == false then
		client.cotzBandageAction = nil

		return false
	end

	return true
end
