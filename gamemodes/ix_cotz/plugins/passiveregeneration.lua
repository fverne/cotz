PLUGIN.name = "fverne"
PLUGIN.author = "Passive Regeneration"
PLUGIN.description = "Adds passive regeneration to players around certain objects."

PLUGIN.healingEntities = {}

ix.config.Add("regenHealAmount", 1, "The health restored at each healing interval.", nil, {
	data = {min = 0, max = 1000},
	category = "passive health regeneration"
})

ix.config.Add("regenHealInterval", 5, "The healing interval (in seconds).", nil, {
	data = {min = 0, max = 1000},
	category = "passive health regeneration"
})

ix.config.Add("regenHealRadius", 256, "The radius around the entities for which players are healed.", nil, {
	data = {min = 0, max = 10000},
	category = "passive health regeneration"
})

ix.config.Add("regenHealRadiusVendorMult", 2048, "The radius multiplier around the vendors for which players are healed.", nil, {
	data = {min = 0, max = 10000},
	category = "passive health regeneration"
})


function PLUGIN:EntityKeyValue(ent, key, value)
	-- campfires on rp_pripyat_remaster, rp_waystation, rp_marsh_cs
	if IsValid(ent) and string.find(ent:GetName(), "knopka_zalup") then
		table.insert(self.healingEntities, ent)
	end
end

function PLUGIN:PostLoadData()
	-- bedrolls, vendors
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "ix_spawnsaver" or v:GetClass() == "ix_vendor_adv" then
			table.insert(self.healingEntities, v)
		end
	end
end


if SERVER then
	local nextHealTime = 0
	
	function PLUGIN:Think()
		if nextHealTime > CurTime() then return end
		
		for k, v in pairs(self.healingEntities) do
			if !IsValid(v:GetClass()) then table.RemoveByValue(self.healingEntities, v) return end
			
			local radius = ix.config.Get("regenHealRadius", 256)
			if v:GetClass() == "ix_vendor_adv" then
				radius = ix.config.Get("regenHealRadiusVendorMult", ix.config.Get("regenHealRadius", 256) * 8)
			end

			for _, v2 in pairs(ents.FindInSphere(v:GetPos(), radius)) do
				if !v2:IsPlayer() or !v2:GetCharacter() then continue end

				if v2.nextRegen and v2.nextRegen <= CurTime() then
					v2:SetHealth(math.min(v2:Health() + ix.config.Get("regenHealAmount", 1), v2:GetMaxHealth()))
				end
				
				v2.nextRegen = CurTime() + ix.config.Get("regenHealInterval", 8)
			end
		end

		nextHealTime = CurTime() + ix.config.Get("regenHealInterval", 8)
	end
end
