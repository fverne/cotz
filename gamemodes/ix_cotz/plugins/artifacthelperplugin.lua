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