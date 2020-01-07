
CustomizableWeaponry_KK.ins2.rtSight = CustomizableWeaponry_KK.ins2.rtSight or {}

local ang, light
local iLens = surface.GetTextureID("cw2/gui/lense")
-- local iMatLens = Material("cw2/gui/lense")
local iMatLens = Material("models/weapons/attachments/cw_kk_ins2_shared/fake")
local alpha = 0.5

local cd = {}
cd.aspectratio = 1
cd.x = 0
cd.y = 0
cd.w = 1024
cd.h = 1024
cd.drawhud = false
cd.drawmonitors = true
cd.drawviewmodel = false
cd.viewmodelfov = 10
cd.dopostprocess = false
cd.bloomtone = false

local strInnerRim = "models/weapons/attachments/cw_kk_ins2_shared/fake"
local strOuterRim = "models/weapons/attachments/cw_kk_ins2_shared/fake20"

local iInnerRim = surface.GetTextureID(strInnerRim)
local iOuterRim = surface.GetTextureID(strOuterRim)
local iRearMat = surface.GetTextureID("cw2/reticles/scope_leo")

local iMatInnerRim = Material(strInnerRim)
local iMatOuterRim = Material(strOuterRim)
local iMatFront = Material("models/weapons/optics/kobra_dot")

local colWhite = Color(255,255,255)
local colBlack = Color(0,0,0)

local CW2ATTS = CustomizableWeaponry.registeredAttachmentsSKey
local tblLams = {
	"kk_ins2_lam",
	"kk_ins2_m6x",
	"kk_ins2_anpeq15"
}

local cvFreeze = CustomizableWeaponry_KK.ins2.conVars.other["cw_kk_freeze_reticles"]
local cvDrawVM = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_draw_vm_in_rt"]

local attachmEnt, mdlAttRear, mdlAttFront
local retPos, retAng, retNorm

local complexTelescopics, rtSize, oldStencilChk

local cvFOVDesired = GetConVar("fov_desired")

function CustomizableWeaponry_KK.ins2.rtSight:renderTarget(wep, att)
	if not att then return end
	if not wep.ActiveAttachments[att.name] then return end

	complexTelescopics = wep:canUseComplexTelescopics()

	if not complexTelescopics then
		wep.TSGlass:SetTexture("$basetexture", iMatLens:GetTexture("$basetexture"))
		return
	end

	if !wep.dt.INS2GLActive and wep:canSeeThroughTelescopics(att.aimPos[1]) then
		alpha = math.Approach(alpha, 0, FrameTime() * 5)
	else
		alpha = math.Approach(alpha, 1, FrameTime() * 5)
	end

	attachmEnt = wep.AttachmentModelsVM[att.name].ent
	-- attachmEnt:SetupBones()
	mdlAttRear = attachmEnt:GetAttachment(1)
	mdlAttFront = attachmEnt:GetAttachment(2)

	if not (mdlAttRear and mdlAttFront) then
		CustomizableWeaponry_KK.ins2.stencilSight:_SpamErrors(wep, att)
		return
	end

	ang = mdlAttRear.Ang
	ang:RotateAroundAxis(ang:Forward(), -90)

	rtSize = wep:getRenderTargetSize()

	-- // fovmods
	local retSizeMult = 1 / (wep.AttachmentModelsVM[att.name].retSizeMult or 1)
	local curCLFOV = math.Clamp(cvFOVDesired:GetInt() + wep.CurFOVMod, 0, cvFOVDesired:GetInt())
	local fovDiff = math.Clamp(curCLFOV - wep.CurVMFOV, 0, curCLFOV)
	local camOriginDist = EyePos():Distance(mdlAttRear.Pos) * retSizeMult
	local niceZoomSetting = att.zoomDesired

	wep.rt2 = {
		["curCLFOV"] = curCLFOV,
		["fovDiff"] = fovDiff,
		["camOriginDist"] = camOriginDist,
		["scopeLength"] = mdlAttRear.Pos:Distance(mdlAttFront.Pos),
	}

	cd.fov = att._rtFov
	-- cd.angles = ang
	-- cd.origin = EyePos()

	-- cd.fov = fovDiff * (1 / niceZoomSetting) / (camOriginDist) * 8
	cd.angles = mdlAttRear.Ang
	cd.origin = mdlAttRear.Pos

	cd.w = rtSize
	cd.h = rtSize

	render.PushRenderTarget(wep.ScopeRT, 0, 0, rtSize, rtSize)
		pac.ForceRendering(true)
		if alpha != 1 then
			wep._skipDrawingScope = att.name
			render.RenderView(cd)
			wep._skipDrawingScope = false
		end

		cam.Start3D(mdlAttRear.Pos, ang)
			if cvDrawVM:GetInt() == 1 then
				wep.CW_VM:DrawModel()
				
				-- wep:drawAttachments()
				-- wep.AttachmentModelsVM.kk_ins2_optic_iron.ent:DrawModel()

				-- for _,e in pairs(wep.AttachmentModelsVM) do
					-- e.ent:Draw()
				-- end
			end

			oldStencilChk = wep._KK_INS2_stencilsDisableLaser
			wep._KK_INS2_stencilsDisableLaser = false
				for _,lam in pairs(tblLams) do
					if wep.ActiveAttachments[lam] then
						CW2ATTS[lam].elementRender(wep)
					end
				end
			wep._KK_INS2_stencilsDisableLaser = oldStencilChk

			-- self:DrawParallax(wep, att)
		cam.End3D()

		cam.Start2D()
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetTexture(att._rtReticle or iInnerRim)
			surface.DrawTexturedRect(0, 0, rtSize, rtSize)

			if cvFreeze:GetInt() == 1 then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(iRearMat)
				for _ = 1,3 do
					surface.DrawTexturedRect(-rtSize/2, -rtSize/2, rtSize * 2, rtSize * 2)
				end
			end

			surface.SetDrawColor(0, 0, 0, 255 * alpha)
			surface.DrawRect(0, 0, rtSize, rtSize, 90)
		cam.End2D()

	render.PopRenderTarget()

	if wep.TSGlass then
		wep.TSGlass:SetTexture("$basetexture", wep.ScopeRT)
	end
end

local MP = !game.SinglePlayer()

local colBlack = Color(0,255,0)

function CustomizableWeaponry_KK.ins2.rtSight:stencil(wep, att)
	if MP then return end

	-- self:DrawParallax(wep, att)

	if cvFreeze:GetInt() != 1 then return end
	attachmEnt = wep.AttachmentModelsVM[att.name].ent
	mdlAttRear = attachmEnt:GetAttachment(1)
	mdlAttFront = attachmEnt:GetAttachment(2)

	// front
	retPos = mdlAttFront.Pos
	retAng = -90 - mdlAttFront.Ang.z
	retNorm = -mdlAttFront.Ang:Forward()

	cam.IgnoreZ(true)
		render.SetMaterial(iMatFront)
		render.DrawQuadEasy(retPos, retNorm, 50, 50, colWhite, retAng)
		render.DrawQuadEasy(retPos, retNorm, 50, 50, colWhite, retAng)
	cam.IgnoreZ(false)

	// rear
	retPos = mdlAttRear.Pos
	retAng = -90 - mdlAttRear.Ang.z
	retNorm = -mdlAttRear.Ang:Forward()

	cam.IgnoreZ(true)
		render.SetMaterial(iMatFront)
		render.DrawQuadEasy(retPos, retNorm, 0.5, 0.5, colBlack, retAng)
	cam.IgnoreZ(false)
end

function CustomizableWeaponry_KK.ins2.rtSight:DrawParallax(wep, att)
	local size = 1
	local intersect = size / 100


	-- local spriteAng3d = EyeAngles()
	-- local spritePos3d = EyePos() + spriteAng3d:Forward() * 20

	local spriteAng3d = wep.Owner:EyeAngles()
	local spritePos3d = wep.Owner:EyePos() + spriteAng3d:Forward() * 20


	local spriteNormal = -spriteAng3d:Forward()
	local spriteAng2d = 0

	cam.IgnoreZ(true)
		render.SetMaterial(iMatInnerRim)
		render.DrawQuadEasy(spritePos3d, spriteNormal, size, size, colWhite, spriteAng2d)

		render.SetMaterial(iMatOuterRim)

		/*UP*/
		offset = spriteAng3d:Up() * size * 3
		render.DrawQuadEasy(spritePos3d + offset, spriteNormal, size + intersect, size * 5 + intersect, colBlack, spriteAng2d)

		/*RIGHT*/
		offset = spriteAng3d:Right() * size*3
		render.DrawQuadEasy(spritePos3d + offset, spriteNormal, size * 5 + intersect, size * 11 + intersect, colBlack, spriteAng2d)

		/*DOWN*/
		offset = -spriteAng3d:Up() * size*3
		render.DrawQuadEasy(spritePos3d + offset, spriteNormal, size + intersect, size * 5 + intersect, colBlack, spriteAng2d)

		/*LEFT*/
		offset = -spriteAng3d:Right() * size*3
		render.DrawQuadEasy(spritePos3d + offset, spriteNormal, size * 5 + intersect, size * 11 + intersect, colBlack, spriteAng2d)
	cam.IgnoreZ(false)

	-- if !IsValid(self._parallaxEnt) then
		-- self._parallaxEnt = ClientsideModel(
			-- "models/weapons/misc/v_cw_kk_ins2_parallax.mdl",
			-- RENDERGROUP_BOTH
		-- )
		-- self._parallaxEnt:SetNoDraw(true)
	-- end

	-- local ent = self._parallaxEnt

	-- local m = Matrix()
	-- m:Scale(Vector(100,8,8))
	-- ent:EnableMatrix("RenderMultiply", m)

	-- ent:SetPos(wep.Owner:EyePos())
	-- ent:SetAngles(wep.Owner:EyeAngles())

	-- cam.IgnoreZ(true)
		-- ent:DrawModel()
	-- cam.IgnoreZ(false)
end
