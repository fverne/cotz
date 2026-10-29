ITEM.name = "Desktop Processor"
ITEM.description = "A desktop processor with a square metal lid."
ITEM.longdesc = "A desktop processor with a square metal lid and a green board visible around the edges. The"
	.. " printing on top remains readable beneath a dull film of handling marks. Such a small,"
	.. " unassuming piece of hardware to have once sat at the centre of somebody's entire working"
	.. " day."

ITEM.model = "models/cotz/eft/barter/electr_cpu.mdl"

ITEM.price = 4500
ITEM.width = 1
ITEM.height = 1
ITEM.flatweight = 0
ITEM.weight = 0.06

ITEM.quantity = 6
ITEM.quantdesc = "A stack containing %d desktop processors."

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 100.05897),
	ang = Angle(90, 180, 0),
	fov = 1.33045,
}

local COMBINE_INTERVAL = 0.2
local nextCombineTimes = setmetatable({}, {__mode = "k"})

local function validQuantity(item)
	local quantity = item:GetData("quantity", item.quantity)

	return isnumber(quantity) and quantity >= 1 and quantity <= item.quantity and quantity % 1 == 0
end

local function getCombineTarget(item, data)
	if not istable(data) or not isnumber(data[1]) or not IsValid(item.player) or IsValid(item.entity) then
		return
	end
	local character = item.player:GetCharacter()
	local inventory = character and character:GetInventory()
	local target = ix.item.instances[data[1]]
	if not inventory or not target or target == item or target.uniqueID ~= item.uniqueID then
		return
	end
	if inventory:GetItemByID(item.id) ~= item or inventory:GetItemByID(target.id) ~= target then
		return
	end
	if IsValid(target.entity) or not validQuantity(item) or not validQuantity(target) then
		return
	end
	if target:GetData("quantity", target.quantity) >= target.quantity then
		return
	end

	return target
end

function ITEM:GetPrice()
	return self.price * self:GetData("quantity", self.quantity)
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		return getCombineTarget(item, data) ~= nil
	end,
	OnRun = function(item, data)
		local target = getCombineTarget(item, data)
		local client = item.player
		if not target or (nextCombineTimes[client] or 0) > CurTime() then
			return false
		end
		nextCombineTimes[client] = CurTime() + COMBINE_INTERVAL
		local sourceQuantity = item:GetData("quantity", item.quantity)
		local targetQuantity = target:GetData("quantity", target.quantity)
		local transferred = math.min(sourceQuantity, target.quantity - targetQuantity)
		-- Consume first so a repeated request cannot reuse a fully merged source before Helix removes it.
		item:SetData("quantity", sourceQuantity - transferred)
		target:SetData("quantity", targetQuantity + transferred)
		client:EmitSound("stalkersound/inv_properties.mp3", 75)

		return transferred == sourceQuantity
	end,
}

function ITEM:OnInstanced()
	if self:GetData("quantity") == nil then
		self:SetData("quantity", math.random(1, 2))
	end
end
