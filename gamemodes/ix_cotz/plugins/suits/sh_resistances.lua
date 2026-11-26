ix.suits = ix.suits or {}

-- No protection except radiation goes above this, on a definition's tooltip or as a worn total.
ix.suits.MAX_PROTECTION = 0.9

-- Worn totals are damage multipliers, so the protection cap is their floor.
function ix.suits.CapDamageMultiplier(multiplier)
	return math.max(multiplier, 1 - ix.suits.MAX_PROTECTION)
end

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
}

-- Impact is a combat stat: its hits resolve between bullet and rupture rather than as anomaly damage.
ix.suits.combatTypes = {
	{
		name = "Impact", field = "impactRes", flatField = "flatImpactRes", network = "impact",
		damageTypes = {DMG_CRUSH, DMG_BLAST, DMG_CLUB, DMG_FALL},
	},
}

-- Protection families in display order: combat stats first, then anomaly families.
function ix.suits.GetProtectionFamilies()
	local families = {}
	for _, definition in ipairs(ix.suits.combatTypes or {}) do families[#families + 1] = definition end
	for _, definition in ipairs(ix.suits.anomalyTypes) do families[#families + 1] = definition end

	return families
end

local function matchesDamageType(damageInfo, definition)
	for _, damageType in ipairs(definition.damageTypes) do
		if damageInfo:IsDamageType(damageType) then return true end
	end

	return false
end

function ix.suits.IsImpactDamage(damageInfo)
	for _, definition in ipairs(ix.suits.combatTypes) do
		if matchesDamageType(damageInfo, definition) then return true end
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
