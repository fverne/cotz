ix.suits = ix.suits or {}

ix.suits.anomalyTypes = {
	{
		name = "Thermal", field = "thermalRes", flatField = "flatThermalRes", network = "thermal",
		damageTypes = {DMG_BURN, DMG_SLOWBURN},
	},
	{
		name = "Electrical", field = "electricalRes", flatField = "flatElectricalRes", network = "electrical",
		damageTypes = {DMG_SHOCK},
	},
	{
		name = "Chemical", field = "chemicalRes", flatField = "flatChemicalRes", network = "chemical",
		damageTypes = {DMG_ACID, DMG_DROWN, DMG_POISON, DMG_NERVEGAS},
	},
	{
		name = "Gravitational", field = "gravitationalRes", flatField = "flatGravitationalRes", network = "gravitational",
		damageTypes = {DMG_CRUSH, DMG_BLAST},
	},
}

local function matchesDamageType(damageInfo, definition)
	for _, damageType in ipairs(definition.damageTypes) do
		if damageInfo:IsDamageType(damageType) then return true end
	end

	return false
end

function ix.suits.GetAnomalyDamage(client, damageInfo)
	local damage = damageInfo:GetDamage()
	local protectedDamage

	for _, definition in ipairs(ix.suits.anomalyTypes) do
		if matchesDamageType(damageInfo, definition) then
			local multiplier = client:GetNWFloat("ixper" .. definition.network .. "res", 1)
			local flat = client:GetNWInt("ixflat" .. definition.network .. "res", 0)
			local remaining = math.max((damage - flat) * multiplier, 0)
			-- Mixed flags use the weakest applicable protection once, rather than stacking reductions.
			protectedDamage = math.max(protectedDamage or 0, remaining)
		end
	end

	return protectedDamage
end
