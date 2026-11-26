-- Shared stack-merge helpers for quantity items. These add no item action: an item only combines when its
-- own definition or base declares ITEM.functions.combine and calls them, so use-count items stay separate.

local STACK_COMBINE_INTERVAL = 0.2
local nextStackCombineTimes = setmetatable({}, {__mode = "k"})

--- Returns the most units one stack of this item can hold.
-- @realm shared
function ix.meta.item:GetStackCapacity()
	return self.maxStack or self.quantity
end

--- Returns the units currently in this stack.
-- @realm shared
function ix.meta.item:GetStackQuantity()
	return self:GetData("quantity", self.quantity)
end

--- Returns whether this stack may merge into the target stack. Families override this for their own rules.
-- @realm shared
function ix.meta.item:CanStackWith(target)
	return target.uniqueID == self.uniqueID
end

local function isValidStackQuantity(item)
	local quantity = item:GetStackQuantity()
	local capacity = item:GetStackCapacity()

	return isnumber(quantity) and isnumber(capacity) and quantity >= 1 and quantity <= capacity and quantity % 1 == 0
end

local function isAccessibleStack(item, client)
	local inventory = ix.item.inventories[item.invID]

	return inventory ~= nil and item.invID ~= 0 and inventory:OnCheckAccess(client)
		and inventory:GetItemByID(item.id) == item
end

--- Returns the stack this stack can merge into, or nil. Each stack must sit in an inventory the player can
-- access, such as the character's own inventory or an open container like a stash; they may differ.
-- @realm shared
function ix.meta.item:GetStackCombineTarget(data)
	if not istable(data) or not isnumber(data[1]) then
		return
	end
	if not IsValid(self.player) or not self.player:GetCharacter() or IsValid(self.entity) then
		return
	end
	local target = ix.item.instances[data[1]]
	if not target or target == self or IsValid(target.entity) or not self:CanStackWith(target) then
		return
	end
	if not isAccessibleStack(self, self.player) or not isAccessibleStack(target, self.player) then
		return
	end
	if not isValidStackQuantity(self) or not isValidStackQuantity(target) then
		return
	end
	if target:GetStackQuantity() >= target:GetStackCapacity() then
		return
	end

	return target
end

-- Quantity-scaled item weight changes without a transfer event, so refresh the owning character's carry.
local function updateOwnerWeight(inventory)
	local character = inventory.owner and ix.char.loaded[inventory.owner]
	if character and character.UpdateWeight then
		character:UpdateWeight()
	end
end

--- Moves as many units as fit into the target. Returns true when the source is empty and should be removed.
-- @realm server
function ix.meta.item:CombineStack(target)
	local client = self.player
	if not target or (nextStackCombineTimes[client] or 0) > CurTime() then
		return false
	end
	nextStackCombineTimes[client] = CurTime() + STACK_COMBINE_INTERVAL
	local sourceInventory = ix.item.inventories[self.invID]
	local targetInventory = ix.item.inventories[target.invID]
	local bCrossInventory = sourceInventory ~= targetInventory
	-- Units leaving an inventory follow the same rules as moving the stack itself, including the carry limit.
	if bCrossInventory and hook.Run("CanTransferItem", self, sourceInventory, targetInventory) == false then
		return false
	end
	local sourceQuantity = self:GetStackQuantity()
	local targetQuantity = target:GetStackQuantity()
	local transferred = math.min(sourceQuantity, target:GetStackCapacity() - targetQuantity)
	-- Consume first so a repeated request cannot reuse a fully merged source before Helix removes it.
	self:SetData("quantity", sourceQuantity - transferred)
	target:SetData("quantity", targetQuantity + transferred)
	client:EmitSound("stalkersound/inv_properties.mp3", 75)
	if bCrossInventory then
		updateOwnerWeight(sourceInventory)
		updateOwnerWeight(targetInventory)
	end

	return transferred == sourceQuantity
end
