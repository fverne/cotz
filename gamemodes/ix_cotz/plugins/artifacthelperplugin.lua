PLUGIN.name = "Artifact Helper Plugin"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Helper functions and hooks for artifacts"

function PLUGIN:EntityTakeDamage(target, dmginfo)
    -- Capacitor
    if (target:IsPlayer() and dmginfo:IsDamageType(DMG_SHOCK)) then
        local cap = target:GetCharacter():GetInventory():HasItem("artifact_capacitor")

        if (cap and cap:GetData("cooldown", 0) < os.time()) then
            cap:SetData("cooldown", os.time() + 5)
            dmginfo:SetDamage(0)
            ix.chat.Send(target, "iteminternal", "'s Capactior artifact absorbs the shock.", false)
        end
    end
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
