local PLUGIN = PLUGIN

function PLUGIN:RenderScreenspaceEffects()
    if LocalPlayer():GetDrunkLevel() > 0 then
      --  DrawMotionBlur(ix.config.Get("intoxicationEffectAlphaRate", 0.03), LocalPlayer():GetDrunkLevel() / 100, ix.config.Get("intoxicationEffectDelay", 0))
        DrawSharpen( 1.5, LocalPlayer():GetDrunkLevel() / 10)
    end
end

local thinkTime = CurTime()

function PLUGIN:Think()
    if (thinkTime < CurTime()) then
        if LocalPlayer():GetDrunkLevel() > 50 then
            util.ScreenShake(LocalPlayer():GetPos(), 10, 5, 2, 0)
            LocalPlayer():SetEyeAngles(Angle(LocalPlayer():EyeAngles().p + math.random(-9, 9), LocalPlayer():EyeAngles().y + math.random(-5, 5), 0))
            LocalPlayer():EmitSound("npc/duble/psycho_talks_"..math.random(1, 5)..".ogg", math.random(65, 70), math.random(95, 110), 1, CHAN_AUTO)
            thinkTime = CurTime() + 10
        end
    end
end