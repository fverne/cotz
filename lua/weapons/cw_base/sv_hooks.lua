local function CW_EntityTakeDamage(ent, damageInfo)
	local attacker = damageInfo:GetInflictor()

	if attacker:IsPlayer() then
		local weapon = attacker:GetActiveWeapon()

		if IsValid(weapon) and weapon.CW20Weapon and not weapon.NoDistance and weapon.EffectiveRange then
			local distance = ent:GetPos():Distance(attacker:GetPos())

			if distance >= weapon.EffectiveRange * 0.5 then
				distance = distance - weapon.EffectiveRange * 0.5

				local mul = math.Clamp(distance / weapon.EffectiveRange, 0, 1)
				damageInfo:ScaleDamage(1 - weapon.DamageFallOff * mul)
			end
		end
	end
end

hook.Add("EntityTakeDamage", "CW_EntityTakeDamage", CW_EntityTakeDamage)