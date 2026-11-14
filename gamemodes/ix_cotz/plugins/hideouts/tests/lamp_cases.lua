local function lamp(entity)
	entity = entity or NewEntity()
	entity.GetClass = function() return "gmod_lamp" end
	entity.lampValues = {On = false, Toggle = false, FlashlightTexture = "effects/flashlight001",
		LightFOV = 90, Distance = 1024, Brightness = 4}
	for _, field in ipairs({"On", "Toggle", "FlashlightTexture", "LightFOV", "Distance", "Brightness"}) do
		entity["Get" .. field] = function(self) return self.lampValues[field] end
		entity["Set" .. field] = function(self, value)
			self.lampValues[field] = value
			if field == "FlashlightTexture" then self.Texture = value end
		end
	end
	entity.GetColor = function(self) return self.lampColor or {r = 10, g = 20, b = 30, a = 255} end
	entity.SetColor = function(self, value) self.lampColor = value end
	entity.UpdateLight = function(self) self.lightUpdates = (self.lightUpdates or 0) + 1 end

	return entity
end

Test("hideout shell validation accepts lamps while rejecting unrelated scripted entities", function()
	FeatureReset()
	assert(PLUGIN.allowedShellClasses.gmod_lamp)
	assert(PLUGIN:ValidateDupe({Entities = {{Class = "gmod_lamp"}}, HeadEnt = {Pos = Vector()}}, {}))
	assert(not PLUGIN:ValidateDupe({Entities = {{Class = "gmod_light"}}, HeadEnt = {Pos = Vector()}}, {}))
	assert(not PLUGIN:ValidateDupe({Entities = {{Class = "env_projectedtexture"}}, HeadEnt = {Pos = Vector()}}, {}))
end)

Test("lamp save and restore preserve both enabled and disabled lighting without changing legacy saves", function()
	FeatureReset()
	for _, enabled in ipairs({true, false}) do
		local source = lamp()
		source:SetModel("models/lamps/torch.mdl")
		source:SetPos(Vector(100, 200, 24))
		source:SetOn(enabled)
		source:SetToggle(true)
		source:SetFlashlightTexture("effects/flashlight/soft")
		source:SetLightFOV(65)
		source:SetDistance(768)
		source:SetBrightness(2.5)
		local saved = PLUGIN:SerializeProp(source, Vector(100, 100, 0))
		assert(saved.class == "gmod_lamp" and saved.lamp.on == enabled and saved.pos.y == 100)
		local restored = lamp()
		restored:SetModel(source:GetModel())
		PLUGIN:ApplyPropData(restored, saved, Vector(500, 500, 0))
		assert(restored:GetPos().x == 500 and restored:GetPos().y == 600)
		for field, value in pairs(source.lampValues) do assert(restored.lampValues[field] == value, field) end
		assert(restored.lightUpdates == 1 and restored.Texture == "effects/flashlight/soft")
		assert(restored.fov == 65 and restored.distance == 768 and restored.brightness == 2.5)
		assert(restored.r == 10 and restored.g == 20 and restored.b == 30)
		saved.lamp = nil
		restored:SetBrightness(7)
		PLUGIN:ApplyPropData(restored, saved, Vector())
		assert(restored:GetBrightness() == 7 and restored.lightUpdates == 1)
	end
end)

Test("shell and furnishing lamps keep their lighting through instance save, unload and reallocation", function()
	FeatureReset()
	local owner = FeatureClient(1)
	local instance, record = FeatureHome(owner)
	local shell = lamp(NewEntity(nil, instance.origin + Vector(40, 40, 24)))
	shell:SetOn(true)
	shell:SetLightFOV(55)
	instance.shell.light = shell
	PLUGIN:TagEntity(instance, shell)
	assert(PLUGIN:GetHideoutEntityPermission(owner, shell) == false)
	local furnishing = lamp(NewEntity(nil, instance.origin + Vector(80, 40, 24)))
	furnishing:SetToggle(true)
	furnishing:SetBrightness(1.5)
	furnishing:SetFlashlightTexture("effects/flashlight/soft")
	instance.props[furnishing] = true
	PLUGIN:TagEntity(instance, furnishing)
	local saved
	PLUGIN:SaveInstance(instance, function(ok) saved = ok end)
	assert(saved and record.shell.light.lamp.on and record.shell.light.lamp.fov == 55)
	assert(record.furnishings[1].lamp.brightness == 1.5)
	PLUGIN.instances, PLUGIN.members = {}, {}
	PLUGIN:LoadData()
	record = PLUGIN:GetHideout(record.id)
	local template = PLUGIN.state.templates.room
	template.dupe = "lamp_test"
	template.mins, template.maxs = Vector(-256, -256, -16), Vector(256, 256, 256)
	template.spawns, template.exit, template.storage = {Vector(0, 0, 8)}, Vector(0, 64, 24), Vector(80, 64, 24)
	PLUGIN.state.areas.remote = {mins = Vector(), maxs = Vector(3000, 3000, 3000)}
	local lookup, create = ix.plugin.Get, ents.Create
	local integration = {DespawnDupe = function() end}
	function integration:SpawnDupe(_, _, _, origin, options, callback)
		assert(options.validate({Entities = {{Class = "gmod_lamp"}}, HeadEnt = {Pos = Vector()}}))
		shell:SetPos(origin + Vector(40, 40, 24))
		callback(true, {shell}, {light = shell})
	end
	ents.Create = function(class)
		local entity = create(class)

		return class == "gmod_lamp" and lamp(entity) or entity
	end
	ix.plugin.Get = function(name) return name == "advdupeint" and integration or lookup(name) end
	local restored
	PLUGIN:SpawnInstance(record, function(ok, result)
		assert(ok, result)
		restored = result
		restored.occupants[owner] = {character = 1}
	end)
	ix.plugin.Get, ents.Create = lookup, create
	assert(restored and restored.shell.light:GetLightFOV() == 55 and restored.shell.light:GetOn())
	local count = 0
	for entity in pairs(restored.props) do
		assert(entity:GetClass() == "gmod_lamp" and entity:GetBrightness() == 1.5)
		assert(entity:GetToggle() and not entity:GetOn())
		assert(entity:GetFlashlightTexture() == "effects/flashlight/soft")
		count = count + 1
	end
	assert(count == 1)
end)
