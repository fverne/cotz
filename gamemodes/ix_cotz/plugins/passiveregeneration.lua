local PLUGIN = PLUGIN
local MIN_HEAL_INTERVAL = 1
local RADIATION_BUFF_GRACE = 1
local VENDOR_RADIUS_MULTIPLIER = 8

PLUGIN.name = "Passive Regeneration"
PLUGIN.author = "fverne"
PLUGIN.description = "Adds passive regeneration to players around certain objects."

PLUGIN.healingEntities = {}

ix.config.Add("regenHealAmount", 1, "The health restored at each healing interval.", nil, {
	data = { min = 0, max = 1000 },
	category = "passive health regeneration",
})

ix.config.Add("regenHealInterval", 5, "The healing interval (in seconds).", nil, {
	data = { min = 0, max = 1000 },
	category = "passive health regeneration",
})

ix.config.Add("regenHealRadius", 256, "The radius around the entities for which players are healed.", nil, {
	data = { min = 0, max = 10000 },
	category = "passive health regeneration",
})

ix.config.Add(
	"regenHealRadiusVendorMult",
	2048,
	"The radius multiplier around the vendors for which players are healed.",
	nil,
	{
		data = { min = 0, max = 10000 },
		category = "passive health regeneration",
	}
)

function PLUGIN:EntityKeyValue(ent, key, value)
	-- campfires on rp_pripyat_remaster, rp_waystation, rp_marsh_cs
	if IsValid(ent) and string.find(ent:GetName(), "knopka_zalup") then
		table.insert(self.healingEntities, ent)
	end
end

function PLUGIN:PostLoadData()
	-- bedrolls, vendors
	for _, entity in ents.Iterator() do
		if entity:GetClass() == "ix_spawnsaver" or entity:GetClass() == "ix_vendor_adv" then
			table.insert(self.healingEntities, entity)
		end
	end
end

if SERVER then
	local nextHealTime = 0

	function PLUGIN:RegeneratePlayer(client, protectRadiation)
		local interval = math.max(MIN_HEAL_INTERVAL, ix.config.Get("regenHealInterval", 8))
		if protectRadiation then
			client:AddBuff("buff_townradprotect", interval + RADIATION_BUFF_GRACE, {})
		end
		if (client.nextRegen or 0) > CurTime() then
			return
		end
		client:SetHealth(
			math.min(client:Health() + ix.config.Get("regenHealAmount", 1), client:GetMaxHealth())
		)
		client:AddBuff("buff_passivehealthregen", interval, {})
		client.nextRegen = CurTime() + interval
	end

	function PLUGIN:Think()
		if nextHealTime > CurTime() then
			return
		end
		for _, entity in pairs(self.healingEntities) do
			if not IsValid(entity) then
				table.RemoveByValue(self.healingEntities, entity)
				continue
			end

			local radius = ix.config.Get("regenHealRadius", 256)
			if entity:GetClass() == "ix_vendor_adv" then
				radius = ix.config.Get(
					"regenHealRadiusVendorMult",
					ix.config.Get("regenHealRadius", 256) * VENDOR_RADIUS_MULTIPLIER
				)
			end

			for _, client in ipairs(ents.FindInSphere(entity:GetPos(), radius)) do
				if not client:IsPlayer() or not client:GetCharacter() then
					continue
				end

				self:RegeneratePlayer(client, entity:GetClass() == "ix_vendor_adv")
			end
		end

		for _, client in player.Iterator() do
			if client:Alive() and client:GetCharacter() and hook.Run("IsPlayerInSafeZone", client) then
				self:RegeneratePlayer(client, true)
			end
		end

		nextHealTime = CurTime() + ix.config.Get("regenHealInterval", 8)
	end
end
