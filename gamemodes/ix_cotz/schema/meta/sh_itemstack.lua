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

--- Returns the stack this stack can merge into, or nil. Both stacks must share one accessible inventory,
-- which can be the character's own inventory or an open container such as a stash.
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
	local inventory = ix.item.inventories[self.invID]
	if not inventory or self.invID == 0 or target.invID ~= self.invID or not inventory:OnCheckAccess(self.player) then
		return
	end
	if inventory:GetItemByID(self.id) ~= self or inventory:GetItemByID(target.id) ~= target then
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

--- Moves as many units as fit into the target. Returns true when the source is empty and should be removed.
-- @realm server
function ix.meta.item:CombineStack(target)
	local client = self.player
	if not target or (nextStackCombineTimes[client] or 0) > CurTime() then
		return false
	end
	nextStackCombineTimes[client] = CurTime() + STACK_COMBINE_INTERVAL
	local sourceQuantity = self:GetStackQuantity()
	local targetQuantity = target:GetStackQuantity()
	local transferred = math.min(sourceQuantity, target:GetStackCapacity() - targetQuantity)
	-- Consume first so a repeated request cannot reuse a fully merged source before Helix removes it.
	self:SetData("quantity", sourceQuantity - transferred)
	target:SetData("quantity", targetQuantity + transferred)
	client:EmitSound("stalkersound/inv_properties.mp3", 75)

	return transferred == sourceQuantity
end
