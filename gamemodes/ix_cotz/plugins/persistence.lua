-- Extends the bundled Helix "persistence" plugin (gamemodes/helix/plugins/persistence.lua). Sharing its unique ID
-- makes this file load into the same PLUGIN table after the bundled one, so Helix itself stays unmodified.
-- Light entities can be persisted with the property menu even when flagged bNoPersist. Their key values are
-- saved and applied before spawning, because lights read their settings only at spawn.
-- The "persist" property, LoadData and SaveData are copies of upstream with those additions.
local PLUGIN = PLUGIN

local LIGHT_CLASSES = {
	light = true,
	light_dynamic = true,
	light_environment = true,
	light_spot = true
}

local function getRealModel(entity)
	return entity:GetClass() == "prop_effect" and IsValid(entity.AttachedEntity) and entity.AttachedEntity:GetModel()
		or entity:GetModel()
end

properties.Add("persist", {
	MenuLabel = "#makepersistent",
	Order = 400,
	MenuIcon = "icon16/link.png",

	Filter = function(self, entity, client)
		if entity:IsPlayer() or entity:IsVehicle() or entity.bNoPersist and not LIGHT_CLASSES[entity:GetClass()] then
			return false
		end
		if not gamemode.Call("CanProperty", client, "persist", entity) then return false end

		return not entity:GetNetVar("Persistent", false)
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if not IsValid(entity) then return end
		if not self:Filter(entity, client) then return end

		PLUGIN.stored[#PLUGIN.stored + 1] = entity

		entity:SetNetVar("Persistent", true)

		ix.log.Add(client, "persist", getRealModel(entity), true)
	end
})

if SERVER then
	function PLUGIN:LoadData()
		local entities = self:GetData() or {}

		for _, v in ipairs(entities) do
			local entity = ents.Create(v.Class)

			if IsValid(entity) then
				if istable(v.KeyValues) then
					for key, value in pairs(v.KeyValues) do
						entity:SetKeyValue(key, value)
					end
				end

				entity:SetPos(v.Pos)
				entity:SetAngles(v.Angle)
				entity:SetModel(v.Model)
				entity:SetSkin(v.Skin)
				entity:SetColor(v.Color)
				entity:SetMaterial(v.Material)
				entity:Spawn()
				entity:Activate()

				if v.bNoCollision then
					entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
				end

				if istable(v.BodyGroups) then
					for k2, v2 in pairs(v.BodyGroups) do
						entity:SetBodygroup(k2, v2)
					end
				end

				if istable(v.SubMaterial) then
					for k2, v2 in pairs(v.SubMaterial) do
						if isnumber(k2) and isstring(v2) then
							entity:SetSubMaterial(k2 - 1, v2)
						end
					end
				end

				local physicsObject = entity:GetPhysicsObject()

				if IsValid(physicsObject) then
					physicsObject:EnableMotion(v.Movable)
				end

				self.stored[#self.stored + 1] = entity

				entity:SetNetVar("Persistent", true)
			end
		end
	end

	function PLUGIN:SaveData()
		local entities = {}

		for _, v in ipairs(self.stored) do
			if IsValid(v) then
				local data = {}
				data.Class = v.ClassOverride or v:GetClass()
				data.Pos = v:GetPos()
				data.Angle = v:GetAngles()
				data.Model = getRealModel(v)
				data.Skin = v:GetSkin()
				data.Color = v:GetColor()
				data.Material = v:GetMaterial()
				data.bNoCollision = v:GetCollisionGroup() == COLLISION_GROUP_WORLD

				if LIGHT_CLASSES[v:GetClass()] then
					data.KeyValues = v:GetKeyValues()
				end

				local materials = v:GetMaterials()

				if istable(materials) then
					data.SubMaterial = {}

					for k2, _ in pairs(materials) do
						if v:GetSubMaterial(k2 - 1) ~= "" then
							data.SubMaterial[k2] = v:GetSubMaterial(k2 - 1)
						end
					end
				end

				local bodyGroups = v:GetBodyGroups()

				if istable(bodyGroups) then
					data.BodyGroups = {}

					for _, v2 in pairs(bodyGroups) do
						if v:GetBodygroup(v2.id) > 0 then
							data.BodyGroups[v2.id] = v:GetBodygroup(v2.id)
						end
					end
				end

				local physicsObject = v:GetPhysicsObject()

				if IsValid(physicsObject) then
					data.Movable = physicsObject:IsMoveable()
				end

				entities[#entities + 1] = data
			end
		end

		self:SetData(entities)
	end
end
