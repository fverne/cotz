local originalFile, originalAdvDupe = file, AdvDupe2
local originalHash = util.SHA256
local originalPath = string.GetPathFromFilename
local files, failBackup
file = {
	Read = function(path) return files[path] end,
	Write = function(path, contents) if not failBackup then files[path] = contents end end,
	Exists = function(path) return files[path] ~= nil end,
	CreateDir = function() end,
}
string.GetPathFromFilename = function(path) return path:match("^(.*/)") end
util.SHA256 = function(value)
	local result = 0
	for index = 1, #value do result = (result * 31 + value:byte(index)) % 4294967296 end

	return string.format("%08x%08x", result, result)
end
AdvDupe2 = {DataFolder = "advdupe2"}

local function setup()
	FeatureReset()
	files, failBackup = {}, false
	files["advdupe2/STALKERDupes/old.txt"] = "old shell"
	files["advdupe2/STALKERDupes/new.txt"] = "new shell"
	local admin = FeatureClient(1)
	admin.IsAdmin = function() return true end
	admin.SteamID64 = function() return "123" end
	admin.PrintMessage = function(self, _, message) self.report = message end
	local pilot, record = FeatureHome(admin)
	PLUGIN.state.templates.old = {
		dupe = "old", mins = Vector(-256, -256, -16), maxs = Vector(256, 256, 256),
		containers = {general = {recipe = "general", pos = Vector(40, 0, 8)}},
	}
	PLUGIN.state.templates.new = table.Copy(PLUGIN.state.templates.old)
	PLUGIN.state.templates.new.dupe = "new"
	PLUGIN.state.templates.new.containers.general.pos = Vector(80, 0, 8)
	record.template = "new"
	record.personalLayout = table.Copy(PLUGIN.state.templates.new.containers)
	pilot.template = table.Copy(PLUGIN.state.templates.new)
	pilot.migrationDupeHash = PLUGIN:GetMigrationDupeHash(PLUGIN.state.templates.new)
	local source = table.Copy(record)
	source.id, source.template, source.owner, source.location = "2", "old", 22, "village"
	source.personalLayout = table.Copy(PLUGIN.state.templates.old.containers)
	source.starterSlot, source.personalVersion = "general", 1
	source.floorLevel, source.furnishingLevel, source.cassetteLevel = 2, 1, 1
	source.shell = {stale = false}
	source.seeds = {earned = {initialized = true}}
	source.furnishings = {{class = "prop_physics", pos = Vector(20, 0, 0), angles = Angle(), model = "chair.mdl"}}
	source.cassetteTransform = {pos = Vector(12, 0, 0)}
	source.containers = {general = {
		recipe = "general", tier = 5, inventoryID = 800, width = 8, height = 8,
		public = true, guests = {["42"] = true}, transform = {pos = Vector(50, 0, 8)},
	}}
	PLUGIN.state.hideouts["2"] = source
	PLUGIN.state.locations = {village = {template = "old", entrance = "gate", name = "Village room"}}
	local squad = table.Copy(source)
	squad.id, squad.ownerType = "3", "squad"
	PLUGIN.state.hideouts["3"] = squad
	ix.inventory.Create(8, 8, 800)
	sql.Query("INSERT INTO ix_items (item_id, inventory_id, unique_id, data) VALUES (900, 800, 'test', '{}')")

	return admin, pilot, source
end

local function preview(admin)
	local ok, message = PLUGIN:PreviewTemplateMigration(admin, "old", "1")
	assert(ok, message)

	return admin.cotzHideoutMigration.plan.token
end

local function apply(admin, token)
	PLUGIN.instances, PLUGIN.members = {}, {}
	local ok, message = PLUGIN:ApplyTemplateMigration(admin, token)
	assert(ok, message)
	assert(admin.notification:find("Migrated", 1, true), admin.notification)
end

Test("migration preserves storage custody, progression, furnishings and offline ownership across reloads", function()
	local admin, pilot, before = setup()
	local token = preview(admin)
	assert(PLUGIN:GetHideout("2").template == "old")
	local ok = PLUGIN:ApplyTemplateMigration(admin, token)
	assert(not ok)
	apply(admin, token)
	local record = PLUGIN:GetHideout("2")
	assert(record.template == "new" and record.id == "2" and record.owner == 22)
	assert(record.location == "village" and record.starterSlot == "general")
	assert(record.floorLevel == 2 and record.furnishingLevel == 1 and record.cassetteLevel == 1)
	local slot = record.containers.general
	assert(slot.inventoryID == 800 and slot.tier == 5 and slot.width == 8 and slot.height == 8)
	assert(slot.public and slot.guests["42"] and not slot.transform)
	assert(record.personalLayout.general.pos.x == 80)
	assert(record.furnishings[1].pos.x == 20 and record.ignoreTemplateSeeds)
	assert(record.seeds.earned.initialized and next(record.shell) == nil and not record.cassetteTransform)
	assert(PLUGIN.state.locations.village.template == "new")
	assert(PLUGIN:GetHideout("3").template == "old")
	assert(sql.Query("SELECT inventory_id FROM ix_items WHERE item_id = 900")[1].inventory_id == 800)
	PLUGIN:LoadData()
	assert(PLUGIN:GetHideout("2").containers.general.inventoryID == 800)
	assert(PLUGIN:GetHideout("2").templateMigration == token)
	assert(not PLUGIN:ApplyTemplateMigration(admin, token))
	-- Rollback uses its disk backup after restart and keeps subsequent upgrades and sharing changes.
	record = PLUGIN:GetHideout("2")
	record.containers.general.tier = 6
	record.containers.general.public = false
	record.floorLevel = 3
	assert(PLUGIN:RollbackTemplateMigration(admin, token))
	assert(admin.notification:find("restored", 1, true), admin.notification)
	record = PLUGIN:GetHideout("2")
	assert(record.template == "old" and not record.templateMigration and record.shell.stale == false)
	assert(record.containers.general.tier == 6 and record.containers.general.public == false)
	assert(record.containers.general.transform.pos.x == 50 and record.floorLevel == 3)
	assert(record.cassetteTransform.pos.x == 12 and PLUGIN.state.locations.village.template == "old")
	assert(not record.ignoreTemplateSeeds)
	assert(PLUGIN:RollbackTemplateMigration(admin, token))
	assert(admin.notification:find("changed migration", 1, true))
end)

Test("rollback normalizes numeric-looking room, slot and shell IDs from Helix JSON", function()
	local admin, pilot, source = setup()
	for _, template in pairs(PLUGIN.state.templates) do
		if template.containers then
			template.containers["10"] = template.containers.general
			template.containers.general = nil
		end
	end
	pilot.template.containers["10"] = pilot.template.containers.general
	pilot.template.containers.general = nil
	source.containers["10"], source.containers.general = source.containers.general, nil
	source.personalLayout["10"], source.personalLayout.general = source.personalLayout.general, nil
	source.starterSlot, source.shell = "10", {["123"] = false}
	local token = preview(admin)
	apply(admin, token)
	local decode = util.JSONToTable
	local function numericKeys(value)
		if type(value) ~= "table" then return value end
		local converted = {}
		for key, entry in pairs(value) do converted[tonumber(key) or key] = numericKeys(entry) end

		return setmetatable(converted, getmetatable(value))
	end
	util.JSONToTable = function(value) return numericKeys(decode(value)) end
	assert(PLUGIN:RollbackTemplateMigration(admin, token))
	util.JSONToTable = decode
	assert(admin.notification:find("restored", 1, true), admin.notification)
	assert(PLUGIN:GetHideout("2").containers["10"].inventoryID == 800)
	assert(PLUGIN:GetHideout("2").shell["123"] == false)
end)

Test("migration and rollback preserve lamp furnishings and restore original shell lamp settings", function()
	local admin, pilot, source = setup()
	assert(PLUGIN:ValidateDupe({Entities = {{Class = "gmod_lamp"}}, HeadEnt = {Pos = Vector()}}, pilot.template))
	local fixture = {
		class = "gmod_lamp", model = "models/lamps/torch.mdl", pos = Vector(24, 0, 24), angles = Angle(),
		lamp = {on = false, toggle = true, texture = "effects/flashlight/soft", fov = 65, distance = 768, brightness = 2.5},
	}
	source.furnishings[#source.furnishings + 1] = table.Copy(fixture)
	source.shell.lamp = table.Copy(fixture)
	local token = preview(admin)
	apply(admin, token)
	PLUGIN:LoadData()
	local record = PLUGIN:GetHideout("2")
	assert(record.furnishings[2].class == "gmod_lamp" and record.furnishings[2].lamp.on == false)
	assert(record.furnishings[2].lamp.brightness == 2.5 and next(record.shell) == nil)
	assert(PLUGIN:RollbackTemplateMigration(admin, token))
	assert(admin.notification:find("restored", 1, true), admin.notification)
	record = PLUGIN:GetHideout("2")
	assert(record.furnishings[2].lamp.texture == fixture.lamp.texture)
	assert(record.shell.lamp.lamp.fov == 65 and record.shell.lamp.lamp.on == false)
	assert(record.containers.general.inventoryID == 800 and record.containers.general.tier == 5)
end)

Test("migration rejects missing or changed installed slot recipes and incompatible starter slots", function()
	for _, mode in ipairs({"missing", "recipe", "starter", "uninstalled"}) do
		local admin, pilot, source = setup()
		if mode == "missing" then pilot.template.containers.general = nil end
		if mode == "recipe" then pilot.template.containers.general.recipe = "ammo" end
		if mode == "starter" then source.starterSlot = "retired" end
		if mode == "uninstalled" then
			source.containers.general.tier, source.containers.general.inventoryID = 0, nil
			pilot.template.containers.general.recipe = "ammo"
		end
		assert(not PLUGIN:PreviewTemplateMigration(admin, "old", "1"), mode)
		assert(source.template == "old")
	end
end)

Test("migration rejects stale previews, expired tokens, permission changes and busy rooms", function()
	for _, mode in ipairs({"dupe", "record", "locations", "template", "expired", "character", "admin", "purchase"}) do
		local admin, pilot, source = setup()
		local token = preview(admin)
		PLUGIN.instances, PLUGIN.members = {}, {}
		if mode == "dupe" then files["advdupe2/STALKERDupes/new.txt"] = "changed" end
		if mode == "record" then source.floorLevel = 3 end
		if mode == "locations" then PLUGIN.state.locations.village.name = "changed" end
		if mode == "template" then PLUGIN.state.templates.new.maxs.x = 500 end
		if mode == "expired" then Advance(601) end
		if mode == "character" then admin.cotzHideoutMigration.character = {} end
		if mode == "admin" then admin.IsAdmin = function() return false end end
		if mode == "purchase" then PLUGIN.personalPurchases["2"] = true end
		admin.notification = nil
		local ok = PLUGIN:ApplyTemplateMigration(admin, token)
		assert(not ok or admin.notification and not admin.notification:find("Migrated", 1, true), mode)
		assert(PLUGIN:GetHideout("2").template == "old", mode)
		PLUGIN.personalPurchases["2"] = nil
	end
end)

Test("migration verifies backups and stops admission after an uncertain save", function()
	local admin = setup()
	local token = preview(admin)
	PLUGIN.instances = {}
	failBackup = true
	assert(PLUGIN:ApplyTemplateMigration(admin, token))
	assert(admin.notification:find("backup", 1, true) and PLUGIN:GetHideout("2").template == "old")
	failBackup = false
	local persist = PLUGIN.Persist
	PLUGIN.Persist = function() return false end
	assert(PLUGIN:ApplyTemplateMigration(admin, token))
	PLUGIN.Persist = persist
	assert(not PLUGIN.ready and not PLUGIN.operationsReady)
	assert(PLUGIN:GetHideout("2").template == "old")
	local denied
	PLUGIN:SpawnInstance(PLUGIN:GetHideout("2"), function(ok) denied = not ok end)
	assert(denied)
end)

Test("migration and rollback reject floor items outside the destination bounds without changing rows", function()
	local admin = setup()
	local token = preview(admin)
	local data = util.TableToJSON({cotzHideout = {
		schema = Schema.folder, map = game.GetMap(), id = "2", pos = Vector(999, 0, 0), angles = Angle(),
	}})
	sql.Query("INSERT INTO ix_items (item_id, inventory_id, data) VALUES (901, 0, " .. sql.SQLStr(data) .. ")")
	PLUGIN.instances = {}
	assert(PLUGIN:ApplyTemplateMigration(admin, token))
	assert(admin.notification:find("Floor item 901", 1, true), admin.notification)
	assert(PLUGIN:GetHideout("2").template == "old")
	sql.Query("DELETE FROM ix_items WHERE item_id = 901")
	apply(admin, token)
	sql.Query("INSERT INTO ix_items (item_id, inventory_id, data) VALUES (901, 0, " .. sql.SQLStr(data) .. ")")
	assert(PLUGIN:RollbackTemplateMigration(admin, token))
	assert(admin.notification:find("Floor item 901", 1, true))
	assert(PLUGIN:GetHideout("2").template == "new")
	assert(sql.Query("SELECT inventory_id FROM ix_items WHERE item_id = 901")[1].inventory_id == 0)
end)

Test("rollback refuses to strand newly installed target storage", function()
	local admin, pilot = setup()
	pilot.template.containers.ammo = {recipe = "ammo", pos = Vector(0, 0, 8)}
	local token = preview(admin)
	apply(admin, token)
	PLUGIN:GetHideout("2").containers.ammo = {recipe = "ammo", tier = 1, inventoryID = 801}
	assert(PLUGIN:RollbackTemplateMigration(admin, token))
	assert(admin.notification:find("strand new storage", 1, true), admin.notification)
	assert(PLUGIN:GetHideout("2").template == "new")
end)

Test("migration aborts on database read failures and rechecks character identity after delayed reads", function()
	for _, mode in ipairs({"database", "character", "room"}) do
		local admin = setup()
		local token = preview(admin)
		PLUGIN.instances = {}
		local run = PLUGIN.RunAtomicQueries
		local complete
		PLUGIN.RunAtomicQueries = function(_, _, callback) complete = callback end
		assert(PLUGIN:ApplyTemplateMigration(admin, token))
		assert(not PLUGIN:ApplyTemplateMigration(admin, token))
		if mode == "character" then admin.GetCharacter = function() return nil end end
		if mode == "room" then PLUGIN:GetHideout("2").floorLevel = 99 end
		complete(mode ~= "database", {})
		PLUGIN.RunAtomicQueries = run
		assert(PLUGIN:GetHideout("2").template == "old", mode)
	end
end)

Test("migration command metadata is shared and server methods enforce administrator access", function()
	local admin = setup()
	for _, name in ipairs({"HideoutMigratePreview", "HideoutMigrateApply", "HideoutMigrateRollback"}) do
		assert(TEST_COMMANDS[name].adminOnly and #TEST_COMMANDS[name].arguments > 0)
		SERVER = false
		assert(TEST_COMMANDS[name]:OnRun(admin, "old", "1") == nil)
		SERVER = true
	end
	admin.IsAdmin = function() return false end
	assert(not PLUGIN:PreviewTemplateMigration(admin, "old", "1"))
	assert(not PLUGIN:RollbackTemplateMigration(admin, "0123456789abcdef"))
end)

Test("migrated room reload skips new dummy loot and preserves existing seed history", function()
	local admin = setup()
	local template = PLUGIN.state.templates.new
	template.spawns, template.exit, template.storage = {Vector(0, 0, 8)}, Vector(0, 64, 24), Vector(80, 64, 24)
	local token = preview(admin)
	apply(admin, token)
	local record = PLUGIN:GetHideout("2")
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(2000, 2000, 2000)}
	local lookup = ix.plugin.Get
	local integration = {DespawnDupe = function() end}
	local dummy
	function integration:SpawnDupe(_, _, _, origin, options, callback)
		assert(options.validate({Entities = {{Class = "ix_dupedummyitem"}}, HeadEnt = {Pos = Vector()}}))
		dummy = NewEntity(nil, origin + Vector(0, 0, 8))
		dummy.GetClass = function() return "ix_dupedummyitem" end
		dummy.GetItem = function() error("Migrated rooms must not capture new loot seeds") end
		callback(true, {dummy}, {fresh = dummy})
	end
	ix.plugin.Get = function(name) return name == "advdupeint" and integration or lookup(name) end
	local created
	PLUGIN:SpawnInstance(record, function(ok, result)
		assert(ok, result)
		created = result
		created.occupants[admin] = {character = 1}
	end)
	ix.plugin.Get = lookup
	assert(created and created.state == "active")
	assert(not IsValid(dummy) and record.seeds.earned.initialized and not record.seeds.fresh)
	assert(created.migrationDupeHash == PLUGIN:GetMigrationDupeHash(template))
	assert(record.containers.general.inventoryID == 800 and record.containers.general.tier == 5)
end)

Test("bulk migration accepts unused slot recipe changes and reconciles them on rollback", function()
	local admin, pilot, source = setup()
	source.containers.ammo_2 = {recipe = "general", tier = 0, public = false, guests = {}}
	source.personalLayout.ammo_2 = {recipe = "general", pos = Vector()}
	source.containers.retired_empty = {recipe = "general", tier = 0}
	pilot.template.containers.ammo_2 = {recipe = "ammo", pos = Vector(80, 40, 8)}
	local token = preview(admin)
	apply(admin, token)
	local moved = PLUGIN:GetHideout("2")
	assert(moved.containers.ammo_2.recipe == "ammo" and moved.containers.ammo_2.tier == 0)
	assert(not moved.containers.ammo_2.inventoryID and not moved.containers.retired_empty)
	assert(moved.containers.general.inventoryID == 800 and moved.containers.general.tier == 5)
	assert(PLUGIN:RollbackTemplateMigration(admin, token))
	assert(PLUGIN:GetHideout("2").template == "old")
	assert(PLUGIN:GetHideout("2").containers.ammo_2.recipe == "general")
end)

Test("unused-looking slots with inventory references still require matching recipes", function()
	local admin, pilot, source = setup()
	source.containers.ammo_2 = {recipe = "general", tier = 0, inventoryID = 801}
	pilot.template.containers.ammo_2 = {recipe = "ammo", pos = Vector()}
	assert(not PLUGIN:PreviewTemplateMigration(admin, "old", "1"))
	assert(source.containers.ammo_2.inventoryID == 801 and source.template == "old")
end)

local function personalOffer()
	local admin, pilot, source = setup()
	PLUGIN.personalPurchases = {}
	assert(PLUGIN:ConfigurePersonalMigration(admin, "old", "1"))
	local owner = FeatureClient(22, 100000)
	owner.SteamID64 = function() return "owner22" end
	owner.position = PLUGIN.state.entrances.gate.pos
	PLUGIN:ShowManagement(owner, source.id, "entrance")

	return owner, source, admin, pilot
end

Test("player migration preserves storage, upgrades and floor rows while discarding placed props", function()
	local owner, before = personalOffer()
	before.propTier = 3
	local data = util.TableToJSON({quantity = 7, cotzHideout = {
		schema = Schema.folder, map = game.GetMap(), id = before.id, pos = Vector(10, 20, 8), angles = Angle(),
	}})
	sql.Query("INSERT INTO ix_items (item_id, inventory_id, data) VALUES (901, 0, " .. sql.SQLStr(data) .. ")")
	local balance = owner:GetCharacter():GetMoney()
	assert(PLUGIN:HandleManagementAction(owner, before.id, 18, "", 0))
	local moved = PLUGIN:GetHideout(before.id)
	assert(moved.template == "new" and moved.owner == 22 and moved.entrance == before.entrance)
	assert(moved.propTier == 3 and moved.floorLevel == 2 and moved.furnishingLevel == 1 and moved.cassetteLevel == 1)
	assert(moved.containers.general.inventoryID == 800 and moved.containers.general.tier == 5)
	assert(moved.containers.general.width == 8 and moved.containers.general.height == 8)
	assert(moved.containers.general.public and moved.containers.general.guests["42"])
	assert(not moved.containers.general.transform and moved.personalLayout.general.pos.x == 80)
	assert(next(moved.furnishings) == nil and next(moved.shell) == nil and not moved.cassetteTransform)
	assert(moved.ignoreTemplateSeeds and moved.seeds.earned.initialized and moved.personalMigration)
	assert(owner:GetCharacter():GetMoney() == balance and not owner.cotzHideoutMenu)
	assert(sql.Query("SELECT data FROM ix_items WHERE item_id = 901")[1].data == data)
	assert(sql.Query("SELECT inventory_id FROM ix_items WHERE item_id = 900")[1].inventory_id == 800)
	assert(PLUGIN:GetHideout("3").template == "old" and PLUGIN:GetHideout("1").template == "new")
	assert(PLUGIN.state.locations.village.template == "old")
	assert(not PLUGIN:HandleManagementAction(owner, moved.id, 18, "", 0))
	assert(not PLUGIN.personalPurchases[moved.id])
	PLUGIN:LoadData()
	assert(PLUGIN:GetHideout(moved.id).template == "new")
	assert(PLUGIN:GetHideout(moved.id).containers.general.inventoryID == 800)
	assert(not PLUGIN:GetPersonalMigrationOffer(PLUGIN:GetHideout(moved.id)))
end)

Test("player migration adopts destination recipes only for empty uninstalled slots", function()
	local owner, source, admin, pilot = personalOffer()
	source.containers.ammo_2 = {recipe = "general", tier = 0, public = false, guests = {}}
	source.personalLayout.ammo_2 = {recipe = "general", pos = Vector()}
	pilot.template.containers.ammo_2 = {recipe = "ammo", pos = Vector(80, 40, 8)}
	assert(PLUGIN:ConfigurePersonalMigration(admin, "old", "1"))
	PLUGIN:ShowManagement(owner, source.id, "entrance")
	assert(PLUGIN:MigratePersonalHideout(owner, source))
	PLUGIN:LoadData()
	local moved = PLUGIN:GetHideout(source.id)
	assert(moved.template == "new" and moved.containers.ammo_2.recipe == "ammo")
	assert(moved.containers.ammo_2.tier == 0 and not moved.containers.ammo_2.inventoryID)
	assert(moved.containers.general.inventoryID == 800 and moved.containers.general.tier == 5)
end)

Test("player migration requires an owner, a quoted offer and an unloaded room at its entrance", function()
	local owner, record, admin, pilot = personalOffer()
	local guest = FeatureClient(42)
	guest.position = owner.position
	record.guests["42"] = true
	PLUGIN:ShowManagement(guest, record.id, "entrance")
	assert(not PLUGIN:HandleManagementAction(guest, record.id, 18, "", 0))
	assert(not PLUGIN:MigratePersonalHideout(admin, record))
	PLUGIN.instances[record.id] = {state = "active"}
	assert(not PLUGIN:MigratePersonalHideout(owner, record))
	PLUGIN.instances[record.id] = nil
	PLUGIN.personalPurchases[record.id] = true
	assert(not PLUGIN:MigratePersonalHideout(owner, record))
	PLUGIN.personalPurchases[record.id] = nil
	owner.position = PLUGIN.state.entrances.gate.pos + Vector(10000, 0, 0)
	assert(not PLUGIN:MigratePersonalHideout(owner, record))
	owner.position = PLUGIN.state.entrances.gate.pos
	owner.cotzHideoutMenu.migrations = {}
	assert(not PLUGIN:MigratePersonalHideout(owner, record))
	assert(record.template == "old")
end)

Test("player migration rejects incompatible storage, changed dupes and out-of-bounds ground items", function()
	for _, mode in ipairs({"slot", "recipe", "floor", "dupe"}) do
		local owner, record = personalOffer()
		if mode == "slot" then record.containers.missing = {tier = 1, inventoryID = 801} end
		if mode == "recipe" then record.containers.general.recipe = "ammo" end
		if mode == "dupe" then files["advdupe2/STALKERDupes/new.txt"] = "changed" end
		if mode == "floor" then
			local data = util.TableToJSON({cotzHideout = {
				schema = Schema.folder, map = game.GetMap(), id = record.id, pos = Vector(999, 0, 0),
			}})
			sql.Query("INSERT INTO ix_items (item_id, inventory_id, data) VALUES (901, 0, " .. sql.SQLStr(data) .. ")")
		end
		PLUGIN:HandleManagementAction(owner, record.id, 18, "", 0)
		assert(PLUGIN:GetHideout(record.id) == record and record.template == "old", mode)
		assert(record.furnishings[1] and record.containers.general.inventoryID == 800)
		assert(not PLUGIN.personalPurchases[record.id])
	end
end)

Test("player migration locks pending checks and rejects changed sessions, offers and database failures", function()
	for _, mode in ipairs({"database", "character", "disconnect", "session", "record", "offer", "location"}) do
		local owner, record = personalOffer()
		local run, complete = PLUGIN.RunAtomicQueries, nil
		PLUGIN.RunAtomicQueries = function(_, _, callback) complete = callback end
		assert(PLUGIN:MigratePersonalHideout(owner, record) and complete)
		assert(not PLUGIN:MigratePersonalHideout(owner, record))
		assert(not PLUGIN:RequestEntry(owner, record.id))
		local deleted
		PLUGIN:DeleteHideout(record.id, function(ok) deleted = ok end)
		assert(deleted == false)
		if mode == "character" then owner.GetCharacter = function() return nil end end
		if mode == "disconnect" then owner.valid = false end
		if mode == "session" then owner.cotzHideoutMenu = nil end
		if mode == "record" then record.floorLevel = 99 end
		if mode == "offer" then PLUGIN.state.migrationOffers.old = nil end
		if mode == "location" then owner.position = PLUGIN.state.entrances.gate.pos + Vector(10000, 0, 0) end
		complete(mode ~= "database", {})
		PLUGIN.RunAtomicQueries = run
		assert(PLUGIN:GetHideout(record.id).template == "old", mode)
		assert(record.furnishings[1] and not PLUGIN.personalPurchases[record.id])
	end
end)

Test("player migration verifies backups and stops admission on an uncertain save", function()
	local owner, record = personalOffer()
	failBackup = true
	assert(PLUGIN:MigratePersonalHideout(owner, record))
	assert(record.template == "old" and record.furnishings[1])
	failBackup = false
	local persist = PLUGIN.Persist
	PLUGIN.Persist = function() return false end
	assert(PLUGIN:MigratePersonalHideout(owner, record))
	PLUGIN.Persist = persist
	assert(PLUGIN:GetHideout(record.id) == record and record.template == "old")
	assert(not PLUGIN.ready and not PLUGIN.operationsReady and record.furnishings[1])
end)

Test("only administrators can publish player migration offers and failed saves restore the offer", function()
	local admin = setup()
	assert(TEST_COMMANDS.HideoutMigrationOffer.adminOnly)
	local nonAdmin = FeatureClient(22)
	assert(not PLUGIN:ConfigurePersonalMigration(nonAdmin, "old", "1"))
	local persist = PLUGIN.Persist
	PLUGIN.Persist = function() return false end
	assert(not PLUGIN:ConfigurePersonalMigration(admin, "old", "1"))
	PLUGIN.Persist = persist
	assert(not PLUGIN.state.migrationOffers.old)
	assert(not PLUGIN:ConfigurePersonalMigration(admin, "new", "1"))
	assert(PLUGIN:ConfigurePersonalMigration(admin, "old", "1"))
	PLUGIN:LoadData()
	assert(PLUGIN:GetPersonalMigrationOffer(PLUGIN:GetHideout("2")).target == "new")
end)

file, AdvDupe2, util.SHA256 = originalFile, originalAdvDupe, originalHash
string.GetPathFromFilename = originalPath
