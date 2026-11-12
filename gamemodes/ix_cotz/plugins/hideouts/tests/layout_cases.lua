local function home(squad)
	FeatureReset()
	PLUGIN.personalContacts.testmap = PLUGIN.personalContacts.rp_marsh_cs
	ix.progression = {IsCompleted = function(character, id) return (character.completed or {})[id] == true end}
	ix.currency = {Get = function(amount) return amount .. " roubles" end}
	local owner = FeatureClient(1, 100000)
	local instance, record = FeatureHome(owner, squad)
	record.furnishingLevel = 1
	PLUGIN.state.templates.room.containers = {
		locker = {recipe = "gear", pos = Vector(40, 40, 20), angles = Angle(0, 90, 0)},
	}
	local slot = PLUGIN:GetContainer(record, "locker")
	slot.tier, slot.width, slot.height, slot.inventoryID = 1, 6, 6, 80
	ix.inventory.Create(6, 6, 80)
	local entity = PLUGIN:CreateUtility(instance, "ix_hideout_storage", Vector(40, 40, 20), "locker.mdl")
	entity.IsPlayerHolding = function(self) return self.cotzContainerHeld ~= nil end
	entity.ixHideoutSlot = "locker"
	instance.containers.locker = entity
	PLUGIN:RememberContainerPosition(instance, "locker", entity)

	return owner, instance, record, slot, entity
end

local function furnishing(client, instance)
	local entity = NewEntity(nil, instance.origin + Vector(100, 100, 20))
	entity:SetModel("chair.mdl")
	PLUGIN:PlayerSpawnedProp(client, entity:GetModel(), entity)

	return entity
end

Test("gear recipes accept suits, headgear and carrying gear without accepting unrelated items or nested storage", function()
	local owner, instance, record = home()
	assert(PLUGIN:ValidateMarkerSettings("container", "locker", "gear"))
	for _, field in ipairs({"isBodyArmor", "isHelmet", "isGasmask", "isBackpack", "isExoskeleton"}) do
		local item = {[field] = true, GetData = function() end}
		assert(PLUGIN:ContainerAccepts(record, "locker", item), field)
	end
	assert(PLUGIN:ContainerAccepts(record, "locker", {base = "base_gear", GetData = function() end}))
	assert(not PLUGIN:ContainerAccepts(record, "locker", {isWeapon = true, GetData = function() end}))
	assert(not PLUGIN:ContainerAccepts(record, "locker", {isBodyArmor = true, isBag = true, GetData = function() end}))
	assert(not PLUGIN:ContainerAccepts(record, "locker", {isBackpack = true, GetData = function() return 4 end}))
end)

Test("personal gear locker purchases use existing milestone gates and retain slot inventory identity", function()
	local owner, instance, record, slot = home()
	assert(PLUGIN:PreparePersonalStorage(instance))
	local offer = PLUGIN:BuildPersonalOffer(owner, record, "container", "locker")
	assert(offer and not offer.allowed and offer.level == 2)
	owner:GetCharacter().completed = {["cotz/town/ballast/v3/hideout/02"] = true}
	offer = PLUGIN:BuildPersonalOffer(owner, record, "container", "locker")
	assert(offer.allowed and offer.width >= slot.width and offer.height >= slot.height)
	local target = NewEntity(nil, owner:GetPos())
	target.GetClass = function() return "ix_vendor_adv" end
	target.GetDisplayName = function() return "'Ballast'" end
	local entity = instance.containers.locker
	entity:SetPos(instance.origin + Vector(70, 40, 20))
	PLUGIN:AuditContainers(instance)
	assert(PLUGIN:PurchasePersonalOffer(owner, target, offer))
	assert(slot.inventoryID == 80 and slot.tier == 2 and owner:GetCharacter():GetMoney() == 100000 - offer.price)
	assert(entity:GetPos().x == instance.origin.x + 70 and slot.transform.pos.x == 70)
end)

Test("only the placing character can remove a furnishing before and after restoration", function()
	local owner, instance, record = home(true)
	local officer = FeatureClient(2)
	ix.squad.list.squad1.members[2] = 1
	PLUGIN.members[officer] = record.id
	officer.position = instance.origin
	local prop = furnishing(officer, instance)
	assert(prop.cotzPlacedBy == 2 and prop:GetNetVar("hideoutPlacedBy") == 2)
	assert(PLUGIN:CanProperty(officer, "remover", prop) == true)
	assert(PLUGIN:CanProperty(owner, "remover", prop) == false)
	constraint = {GetAllConstrainedEntities = function() return {prop} end}
	assert(PLUGIN:CanTool(officer, {Entity = prop}, "remover") == nil)
	local saved = PLUGIN:SerializeProp(prop, instance.origin)
	local restored = NewEntity(nil, instance.origin)
	PLUGIN:ApplyPropData(restored, saved, instance.origin)
	instance.props[restored] = true
	PLUGIN:TagEntity(instance, restored)
	assert(PLUGIN:CanProperty(officer, "remover", restored) == true)
	assert(PLUGIN:CanProperty(owner, "remover", restored) == false)
	local shell = NewEntity(nil, instance.origin)
	PLUGIN:TagEntity(instance, shell)
	constraint.GetAllConstrainedEntities = function() return {prop, shell} end
	assert(PLUGIN:CanTool(officer, {Entity = prop}, "remover") == false)
	assert(PLUGIN:CanProperty(officer, "remover", shell) == false)
	assert(PLUGIN:CanProperty(officer, "remover", instance.containers.locker) == false)
end)

Test("legacy personal props keep owner removal while unknown legacy squad props remain protected", function()
	local owner, instance, record = home()
	local prop = NewEntity(nil, instance.origin)
	instance.props[prop] = true
	PLUGIN:TagEntity(instance, prop)
	assert(PLUGIN:CanProperty(owner, "remover", prop) == true)
	record.ownerType, record.owner, record.squadID = "squad", nil, "squad1"
	ix.squad.list.squad1 = {members = {[1] = 2}, leaderID = 1}
	local unknown = NewEntity(nil, instance.origin)
	instance.props[unknown] = true
	PLUGIN:TagEntity(instance, unknown)
	assert(PLUGIN:CanProperty(owner, "remover", unknown) == false)
end)

Test("container movement honors building permissions, guest restrictions and per-slot squad ranks", function()
	local owner, instance, record, slot, entity = home(true)
	local officer = FeatureClient(2)
	ix.squad.list.squad1.members[2] = 1
	PLUGIN.members[officer] = record.id
	officer.position = instance.origin
	assert(PLUGIN:GetHideoutEntityPermission(officer, entity) == true)
	slot.minimumRank = 2
	assert(PLUGIN:GetHideoutEntityPermission(officer, entity) == false)
	assert(PLUGIN:GetHideoutEntityPermission(owner, entity) == true)
	assert(PLUGIN:CanTool(owner, {Entity = entity}, "remover") == false)
	assert(PLUGIN:CanPlayerHoldObject(owner, entity) == false)
	local guest = FeatureClient(3)
	record.access = "public"
	PLUGIN.members[guest] = record.id
	guest.position = instance.origin
	assert(PLUGIN:GetHideoutEntityPermission(guest, entity) == false)
	instance.saving = true
	assert(PLUGIN:GetHideoutEntityPermission(owner, entity) == false)
end)

Test("moving containers closes access until dropped and rejects movement outside the allocated interior", function()
	local owner, instance, record, slot, entity = home()
	assert(PLUGIN:PhysgunPickup(owner, entity) == nil)
	assert(not entity.cotzContainerHeld)
	PLUGIN:OnPhysgunPickup(owner, entity)
	assert(entity.cotzContainerHeld == owner and not PLUGIN:IsNearUtility(owner, entity))
	entity:SetPos(instance.origin + Vector(60, 40, 20))
	entity:SetAngles(Angle(0, 45, 0))
	PLUGIN:PhysgunDrop(owner, entity)
	assert(not entity.cotzContainerHeld and PLUGIN:IsNearUtility(owner, entity))
	assert(slot.transform.pos.x == 60 and slot.transform.angles.y == 45)
	entity:SetPos(Vector(2000, 2000, 2000))
	PLUGIN:AuditContainers(instance)
	assert(entity:GetPos().x == instance.origin.x + 60 and slot.transform.pos.x == 60)
end)

Test("container positions survive checkpoints and cold restoration at a different instance origin", function()
	local owner, instance, record, slot, entity = home()
	entity:SetPos(instance.origin + Vector(70, 40, 20))
	entity:SetAngles(Angle(0, 135, 0))
	PLUGIN:SaveInstance(instance, function(ok) assert(ok) end)
	assert(slot.transform.pos.x == 70)
	PLUGIN:LoadData()
	record = PLUGIN:GetHideout("1")
	instance.origin = Vector(200, 400, 0)
	instance.template = nil
	instance.state = "loading"
	PLUGIN:RestoreStorage(instance, function(ok) assert(ok) end)
	local restored = instance.containers.locker
	assert(restored:GetPos().x == 270 and restored:GetPos().y == 440 and restored:GetAngles().y == 135)
	assert(record.containers.locker.inventoryID == 80)
end)

Test("layout reset preserves inventories, upgrades, loose items, shell, vendor and other characters' props", function()
	local owner, instance, record, slot, entity = home(true)
	local officer = FeatureClient(2)
	ix.squad.list.squad1.members[2] = 1
	PLUGIN.members[officer] = record.id
	officer.position = instance.origin
	local own = furnishing(owner, instance)
	local other = furnishing(officer, instance)
	local floor = NewEntity(NewItem(), instance.origin)
	instance.items[floor.ixItemID] = floor
	instance.vendor = NewEntity(nil, instance.origin)
	local shell = NewEntity(nil, instance.origin)
	instance.shell.wall = shell
	entity:SetPos(instance.origin + Vector(70, 40, 20))
	PLUGIN:AuditContainers(instance)
	slot.public, slot.minimumRank = true, 1
	assert(PLUGIN:ResetHideoutLayout(owner, record))
	assert(not IsValid(own) and IsValid(other) and IsValid(floor) and IsValid(shell) and IsValid(instance.vendor))
	assert(entity:GetPos().x == instance.origin.x + 40 and entity:GetAngles().y == 90)
	assert(slot.transform == nil and slot.inventoryID == 80 and slot.tier == 1 and slot.public and slot.minimumRank == 1)
	assert(#record.furnishings == 1 and record.furnishings[1].placedBy == 2)
	assert(not PLUGIN:ResetHideoutLayout(owner, record))
end)

Test("failed reset persistence leaves live props, positions and saved configuration unchanged", function()
	local owner, instance, record, slot, entity = home()
	local prop = furnishing(owner, instance)
	entity:SetPos(instance.origin + Vector(70, 40, 20))
	PLUGIN:AuditContainers(instance)
	local transform, furnishings = slot.transform, record.furnishings
	local persist = PLUGIN.Persist
	PLUGIN.Persist = function() return false end
	local ok = PLUGIN:ResetHideoutLayout(owner, record)
	PLUGIN.Persist = persist
	assert(not ok and IsValid(prop) and entity:GetPos().x == instance.origin.x + 70)
	assert(slot.transform == transform and record.furnishings == furnishings)
end)

Test("unloaded layout reset persists own prop removal and container defaults without loading inventories", function()
	local owner, instance, record, slot = home()
	record.furnishings = {{placedBy = 1}, {placedBy = 2}, {model = "legacy personal prop"}}
	slot.transform = {pos = Vector(70, 40, 20), angles = Angle()}
	PLUGIN.instances[record.id], PLUGIN.members[owner] = nil, nil
	owner.position = PLUGIN.state.entrances.gate.outside
	assert(PLUGIN:ResetHideoutLayout(owner, record))
	assert(#record.furnishings == 1 and record.furnishings[1].placedBy == 2 and not slot.transform)
	PLUGIN:LoadData()
	record = PLUGIN:GetHideout("1")
	assert(#record.furnishings == 1 and record.containers.locker.inventoryID == 80)
end)

Test("reset requests enforce location, busy state, active character and management scope", function()
	local owner, instance, record, slot, entity = home()
	local prop = furnishing(owner, instance)
	owner.cotzHideoutMenu = {character = owner:GetCharacter(), scope = "container", slot = "locker", ids = {["1"] = true}}
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 15, "", 0))
	instance.exit = NewEntity(nil, instance.origin)
	owner.cotzHideoutMenu.scope = "exit"
	instance.operations = 1
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 15, "", 0) and IsValid(prop))
	instance.operations = 0
	Advance(6)
	entity.cotzContainerHeld = owner
	assert(not PLUGIN:ResetHideoutLayout(owner, record) and IsValid(prop))
	entity.cotzContainerHeld = nil
	Advance(6)
	owner.position = Vector(5000, 5000, 0)
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 15, "", 0))
	owner.position = instance.origin
	local guest = FeatureClient(2)
	owner.character = guest:GetCharacter()
	assert(not PLUGIN:HandleManagementAction(owner, record.id, 15, "", 0))
	owner.character = ix.char.loaded[1]
	assert(PLUGIN:HandleManagementAction(owner, record.id, 15, "", 0) and not IsValid(prop))
end)

Test("officer layout reset retains leader-only container positions", function()
	local owner, instance, record, slot, entity = home(true)
	local officer = FeatureClient(2)
	ix.squad.list.squad1.members[2] = 1
	PLUGIN.members[officer] = record.id
	officer.position = instance.origin
	slot.minimumRank = 2
	entity:SetPos(instance.origin + Vector(70, 40, 20))
	PLUGIN:AuditContainers(instance)
	assert(PLUGIN:ResetHideoutLayout(officer, record))
	assert(entity:GetPos().x == instance.origin.x + 70 and slot.transform.pos.x == 70)
end)
