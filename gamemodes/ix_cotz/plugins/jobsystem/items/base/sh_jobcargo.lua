ITEM.name = "Field cargo"
ITEM.description = "Equipment bound to an active field assignment."
ITEM.isFieldCargo = true
ITEM.noDrop = true
ITEM.flag = "A"

-- The installed item transfer path also checks this after plugin hooks. Keep the
-- binding here because existing COTZ hooks may return true and stop hook dispatch.
function ITEM:CanTransfer(oldInventory, inventory)
	local character = SERVER and ix.char.loaded[self:GetData("fieldOwner")]
		or CLIENT and LocalPlayer():GetCharacter()
	-- Helix's client drag check passes nil for a move inside the same inventory.
	if CLIENT and not inventory and character and oldInventory
		and character:GetID() == self:GetData("fieldOwner")
		and oldInventory:GetID() == character:GetInventory():GetID() then return end
	if not character or character:GetID() ~= self:GetData("fieldOwner")
		or not inventory or inventory:GetID() ~= character:GetInventory():GetID() then return false end
end

function ITEM:GetWeight()
	return self.flatweight
end

function ITEM:GetName()
	return self:GetData("fieldName", self.name)
end

function ITEM:GetDescription()
	local recipient = self:GetData("fieldRecipient")
	local instruction = recipient and "\nDeliver this to " .. recipient .. "."
		or "\nReturn this to the contact who issued your assignment."

	local description = self:GetData("fieldDescription", self.description)
	if not self.entity and self.longdesc and self.longdesc ~= "" then
		description = description .. "\n\n" .. self.longdesc
	end

	return description .. instruction
end

local function cargoJob(item)
	local client = item.player
	local character = IsValid(client) and client:GetCharacter()
	if not character or IsValid(item.entity) or item.invID ~= character:GetInventory():GetID() then return end
	for npc, job in pairs(character:GetJobs()) do
		if ix.jobs.field.FindCargo(character, job) == item then return npc, job end
	end
end

ITEM.functions.Assignment = {
	name = "Show assignment",
	icon = "icon16/map.png",
	OnCanRun = function(item) return cargoJob(item) ~= nil end,
	OnRun = function(item)
		local npc = cargoJob(item)
		if npc then ix.jobs.field.Action(item.player, npc, "status") end

		return false
	end,
}

ITEM.functions.BuryParcel = {
	name = "Bury parcel with digging tool",
	icon = "icon16/arrow_down.png",
	OnCanRun = function(item)
		local _, job = cargoJob(item)

		return job ~= nil and job.fieldTask.kind == "deadDrop" and job.fieldTask.stage == "carrying"
	end,
	OnRun = function(item)
		local npc, job = cargoJob(item)
		if job and job.fieldTask.kind == "deadDrop" then ix.jobs.field.Action(item.player, npc, "deliver") end

		return false
	end,
}
