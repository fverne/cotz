local PLUGIN = PLUGIN

local MELEE_BASE = "tfa_nmrimelee_base"

local function meleeWeapon(attacker, dmginfo)
	if not (dmginfo:IsDamageType(DMG_SLASH) or dmginfo:IsDamageType(DMG_CLUB)) then return end
	local weapon = dmginfo:GetInflictor()
	-- The bullet hit path can report the player as the inflictor instead of the weapon.
	if weapon == attacker then weapon = attacker:GetActiveWeapon() end
	if not IsValid(weapon) or not weapon:IsWeapon() then return end
	if weapons.IsBasedOn(weapon:GetClass(), MELEE_BASE) then return weapon end
end

-- A suit with `meleeDamageBonus` raises its wearer's melee damage and returns the stamina of a swing
-- that hits a player or NPC. The bonus is a fixed definition value: wear and attachments leave it alone.
function PLUGIN:ApplyMeleePerk(target, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) or not attacker:IsPlayer() or attacker == target then return end
	if not (target:IsPlayer() or target:IsNPC() or target:IsNextBot()) then return end
	local weapon = meleeWeapon(attacker, dmginfo)
	if not weapon then return end
	local suit = attacker:getEquippedBodyArmor()
	local bonus = suit and suit.meleeDamageBonus
	if not bonus then return end

	dmginfo:ScaleDamage(1 + bonus)
	-- Set by the melee base when a swing spends stamina; cleared so one swing is returned once.
	if weapon.cotzSwingStamina then
		attacker:RestoreStamina(weapon.cotzSwingStamina)
		weapon.cotzSwingStamina = nil
	end
end
