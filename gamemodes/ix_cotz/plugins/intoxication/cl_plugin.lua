local PLUGIN = PLUGIN

function PLUGIN:RenderScreenspaceEffects()
    if LocalPlayer():GetDrunkLevel() > 0 then
        DrawMotionBlur(ix.config.Get("intoxicationEffectAlphaRate", 0.03), LocalPlayer():GetDrunkLevel() / 100, ix.config.Get("intoxicationEffectDelay", 0))
    end
end

local thinkTime = CurTime()

function PLUGIN:Think()
    if (thinkTime < CurTime()) then
        if LocalPlayer():GetDrunkLevel() > 50 then
            util.ScreenShake(LocalPlayer():GetPos(), 10, 5, 2, 0)
            LocalPlayer():SetEyeAngles(Angle(LocalPlayer():EyeAngles().p + math.random(-9, 9), LocalPlayer():EyeAngles().y + math.random(-5, 5), 0))
            thinkTime = CurTime() + 10
        end
    end
end