ITEM.base = "base_weapons"
ITEM.name = "Loan Camera"
ITEM.description = "A camera lent for a photography assignment."
ITEM.longdesc = "The camera records the subjects visible through its viewfinder. It remains with the photographer until the assignment has been settled."

ITEM.model = "models/weapons/infra/w_camera.mdl"
ITEM.class = "ix_camera"

ITEM.price = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.75

ITEM.weaponCategory = "jobcamera"
ITEM.isFieldCargo = true
ITEM.noDrop = true
ITEM.DropOnDeath = false
ITEM.canAttach = false
ITEM.canRepair = false

function ITEM:CanTransfer(oldInventory, inventory)
	local character = SERVER and ix.char.loaded[self:GetData("fieldOwner")]
		or CLIENT and LocalPlayer():GetCharacter()
	if not character or character:GetID() ~= self:GetData("fieldOwner")
		or not inventory or inventory:GetID() ~= character:GetInventory():GetID() then return false end
end
