local COMBAT_WEAR_RATE = 1 / 400
local ENVIRONMENT_WEAR_RATE = 1 / 100
local ENVIRONMENT_DAMAGE_TYPES = {
	DMG_SHOCK, DMG_BURN, DMG_ACID, DMG_BLAST, DMG_DROWN, DMG_POISON,
	DMG_NERVEGAS, DMG_SLOWBURN, DMG_RADIATION, DMG_SONIC, DMG_AIRBOAT,
}

local function getProtectedDamage(client, damageInfo, environmental)
	local damage = damageInfo:GetDamage()
	local resistance
	if damageInfo:IsDamageType(DMG_RADIATION) then
		-- Radiation's flat protection is measured after converting damage into radiation points.
		return math.max(damage * client:getPercentageRadResist() - client:getFlatRadResist() * 10, 0)
	elseif damageInfo:IsDamageType(DMG_SONIC) then
		resistance = "psy"
	elseif damageInfo:IsDamageType(DMG_BULLET) then
		resistance = "bullet"
	elseif damageInfo:IsDamageType(DMG_SLASH) then
		resistance = "slash"
	elseif environmental or damageInfo:GetDamageType() == DMG_GENERIC then
		resistance = "anom"
	end

	if not resistance then return math.max(damage, 0) end
	local flatProtection = client:GetNWInt("ixflat" .. resistance .. "res")
	local percentageProtection = client:GetNWFloat("ixper" .. resistance .. "res")

	return math.max((damage - flatProtection) * percentageProtection, 0)
end

function ix.util.DamageHeadgear(client, damageInfo)
	if not SERVER or damageInfo:IsDamageType(DMG_FALL) or not client:Alive() then return end
	local character = client:GetCharacter()
	if not character or IsValid(ix.temp.Corpses[client]) then return end
	if damageInfo:GetDamage() <= 0 then return end
	local wearRate = COMBAT_WEAR_RATE
	local attacker = damageInfo:GetAttacker()
	local environmental = damageInfo:GetDamageType() == DMG_GENERIC
		and not (IsValid(attacker) and (attacker:IsPlayer() or attacker:IsNPC()))

	for _, damageType in ipairs(ENVIRONMENT_DAMAGE_TYPES) do
		if damageInfo:IsDamageType(damageType) then
			environmental = true
			break
		end
	end

	local damage = getProtectedDamage(client, damageInfo, environmental)
	if damage <= 0 then return end
	if environmental then wearRate = ENVIRONMENT_WEAR_RATE end
	local changed = false

	for _, item in pairs(character:GetInventory():GetItems(true)) do
		local headgear = not item.isBodyArmor and (item.isHelmet or item.isGasmask)
		if headgear and item:GetData("equip") and not item:GetData("unlimitedDurability", false) then
			local durability = item:GetData("durability", 100)
			local remaining = math.Clamp(durability - damage * wearRate, 0, 100)
			if remaining ~= durability then
				item:SetData("durability", remaining)
				changed = true
			end
		end
	end

	if changed then client:RecalculateResistances() end
end
