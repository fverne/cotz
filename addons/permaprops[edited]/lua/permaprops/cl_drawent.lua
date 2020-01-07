/*
   ____          _          _   ____          __  __       _ _                     
  / ___|___   __| | ___  __| | | __ ) _   _  |  \/  | __ _| | |__   ___  _ __ ___  
 | |   / _ \ / _` |/ _ \/ _` | |  _ \| | | | | |\/| |/ _` | | '_ \ / _ \| '__/ _ \ 
 | |__| (_) | (_| |  __/ (_| | | |_) | |_| | | |  | | (_| | | |_) | (_) | | | (_) |
  \____\___/ \__,_|\___|\__,_| |____/ \__, | |_|  |_|\__,_|_|_.__/ \___/|_|  \___/ 
                                      |___/                                        
*/

local function PermaPropsViewer()

	if not LocalPlayer().DrawPPEnt or not istable(LocalPlayer().DrawPPEnt) then return end

    local pos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 10
    local ang = LocalPlayer():EyeAngles()

    ang = Angle(ang.p + 90, ang.y, 0)

    for k, v in pairs(LocalPlayer().DrawPPEnt) do

    	if not v or not v:IsValid() then LocalPlayer().DrawPPEnt[k] = nil continue end

	    render.ClearStencil()
	    render.SetStencilEnable(true)
	        render.SetStencilWriteMask(255)
	        render.SetStencilTestMask(255)
	        render.SetStencilReferenceValue(15)
	        render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	        render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	        render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
	        render.SetBlend(0)
	        v:DrawModel()
	        render.SetBlend(1)
	        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	        cam.Start3D2D(pos, ang, 1)
	                surface.SetDrawColor(255, 0, 0, 255)
	                surface.DrawRect(-ScrW(), -ScrH(), ScrW() * 2, ScrH() * 2)
	        cam.End3D2D()
	        v:DrawModel()
	    render.SetStencilEnable(false)

	end

end
hook.Add("PostDrawOpaqueRenderables", "PermaPropsViewer", PermaPropsViewer)