-- PLUGIN.name = "Artifact Helper Plugin"
-- PLUGIN.author = "gumlefar"
-- PLUGIN.desc = "Helper functions and hooks for artifacts"

-- Run by the suits plugin after mitigation and before equipment wear.
-- Returns true when an artifact absorbed the hit.
function PLUGIN:CotzArtifactAbsorbDamage(target, dmginfo)
	if not target:IsPlayer() or not target:GetCharacter() then return end

	if dmginfo:IsDamageType(DMG_SHOCK) then
		local cap = target:GetCharacter():GetInventory():HasItem("artifact_capacitor")

		if cap and cap:GetData("cooldown", 0) < os.time() then
			cap:SetData("cooldown", os.time() + cap.absorbCooldown)
			dmginfo:SetDamage(0)
			ix.chat.Send(target, "iteminternal", "'s Capacitor artifact absorbs the shock.", false)

			return true
		end
	end

	-- Radiation and psychic damage never reach health directly; their own plugins handle them.
	if dmginfo:IsDamageType(DMG_RADIATION) or dmginfo:IsDamageType(DMG_SONIC) then return end

	if (target.ixHaloProtectedUntil or 0) > CurTime() then
		dmginfo:SetDamage(0)

		return true
	end

	if dmginfo:IsDamageType(DMG_SHOCK) then return end

	local halo = target:GetCharacter():GetInventory():HasItem("artifact_halo")

	if not halo or halo:GetData("cooldown", 0) >= os.time() then return end
	if not target:Alive() or target:Health() - dmginfo:GetDamage() > 0 then return end
	if math.random(1, 100) > halo.saveChance then return end

	halo:SetData("cooldown", os.time() + halo.saveCooldown)
	target.ixHaloProtectedUntil = CurTime() + halo.invulnerabilityDuration
	dmginfo:SetDamage(0)
	target:GodEnable()
	ix.chat.Send(target, "iteminternal", "'s Halo flares brilliantly, defying death.", false)
	ParticleEffect("aurora_shockwave", target:GetPos() + Vector(0, 0, 16), Angle(0, 0, 0))
	target:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 150), 0.5, 0.5)
	target:EmitSound("plasma_impact1.wav")
	timer.Simple(halo.invulnerabilityDuration, function() if IsValid(target) then target:GodDisable() end end)

	return true
end

if SERVER then
    function PLUGIN:DoPlayerDeath(client, attacker, dmg)
        if not client:GetCharacter() then return end

        if client:HasBuff("buff_hijump") then
            client:RemoveBuff("buff_hijump", {
                amount = 0
            })

            client:SetJumpPower(160)
        end
    end
end

local thinkTime = CurTime()

function PLUGIN:Think()
    if (thinkTime < CurTime()) then
        for k2, v2 in ipairs(ents.FindByClass("ix_item")) do
            if (IsValid(v2) and v2.ixItemID) then
                local itm = ix.item.instances[v2.ixItemID]

                if (itm and itm.base == "base_artifacts" and not itm.NoJump) then
                    for k, v in pairs(ents.FindInSphere(v2:GetPos(), 2560)) do
                        if (v:IsPlayer() and v:GetCharacter() and v:GetMoveType() ~= MOVETYPE_NOCLIP) then
                            if v:GetPos():Distance(v2:GetPos()) <= 192 then
                                v2:GetPhysicsObject():EnableMotion(true)
                                v2:GetPhysicsObject():ApplyForceCenter(Vector(0, 0, itm.JumpPower or v2:GetPhysicsObject():GetMass() * 90))
                                break
                            end
                        else
                            if v:GetPos():Distance(v2:GetPos()) > 192 then
                                v2:GetPhysicsObject():EnableMotion(false)
                            end
                        end
                    end
                end
            end

            thinkTime = CurTime() + math.Rand(0.5, 0.8)
        end
    end
end

ix.config.Add("jumpPower", 160, "How high a player normally jumps.", function(oldValue, newValue)
	for _, v in player.Iterator() do
        v:SetJumpPower(newValue)
    end
end, {
    data = {min = 75, max = 500},
    category = "characters"
})