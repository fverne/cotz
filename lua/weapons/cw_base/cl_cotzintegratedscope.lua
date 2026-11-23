local LENS_MATERIAL_NAME = "cotz_integrated_scope_lens"
local fallbackLens = Material("cw2/gui/lense"):GetTexture("$basetexture")
local lensMaterial = CreateMaterial(LENS_MATERIAL_NAME, "UnlitGeneric", {
	["$basetexture"] = fallbackLens:GetName(),
	["$model"] = 1,
})
local LENS_OVERRIDE = "!" .. LENS_MATERIAL_NAME
-- Attachment optics, such as the USP-1 "Tulip", get their own lens so an integrated lens never shows their view.
local ATTACHMENT_LENS_MATERIAL_NAME = "cotz_attachment_scope_lens"
local attachmentLensMaterial = CreateMaterial(ATTACHMENT_LENS_MATERIAL_NAME, "UnlitGeneric", {
	["$basetexture"] = fallbackLens:GetName(),
	["$model"] = 1,
})
local ATTACHMENT_LENS_OVERRIDE = "!" .. ATTACHMENT_LENS_MATERIAL_NAME
local CW_LENS_PATH = "cw2/attachments/lens/rt"
local FALLBACK_RETICLE = Material("cw2/reticles/scope_leo")
local reticles = {}
local scopeView = {
	x = 0,
	y = 0,
	aspectratio = 1,
	drawviewmodel = false,
	drawhud = false,
	dopostprocess = false,
}
local renderingScope = false
local SIMPLE_BASE_FOV = 90
local COMPLEX_ZOOM = 15
-- The square render target covers the lens, which occupies only part of the player's view.
local LENS_VIEW_FRACTION = 0.2

local function getReticle(path)
	if reticles[path] then return reticles[path] end

	local texture = Material(path):GetTexture("$basetexture")
	local reticle = FALLBACK_RETICLE
	if texture and not texture:IsError() then
		reticle = CreateMaterial("cotz_integrated_scope_" .. util.CRC(path), "UnlitGeneric", {
			["$basetexture"] = texture:GetName(),
			["$translucent"] = 1,
			["$vertexcolor"] = 1,
			["$vertexalpha"] = 1,
		})
	end
	reticles[path] = reticle

	return reticle
end

-- Anomaly models mark their scope glass with a TFA-proxied lense_rt material.
local function findLensSlot(model, materialPath)
	for index, path in ipairs(model:GetMaterials()) do
		path = path:lower()
		if path == materialPath or (not materialPath and path:match("/lense_rt$")) then
			return index - 1
		end
	end
end

function SWEP:GetCotzLegacyAttachmentLens()
	local data = self.cotzAimModel
	if not data or not data.active or not IsValid(data.ent) then return end

	if data.cwLensEntity ~= data.ent then
		data.cwLensEntity = data.ent
		data.cwLensSlot = findLensSlot(data.ent, CW_LENS_PATH)
	end

	local slot = data.cwLensSlot
	if not slot then return end

	if data.ent:GetSubMaterial(slot) ~= ATTACHMENT_LENS_OVERRIDE then
		data.ent:SetSubMaterial(slot, ATTACHMENT_LENS_OVERRIDE)
	end

	return attachmentLensMaterial
end

function SWEP:SetupCotzIntegratedScope()
	local zoom, reticle = self.AnomalyScopeZoom, self.AnomalyReticle
	if not zoom or zoom < 1 or not reticle or self.RenderTargetFunc or self.cotzIntegratedScope then return end
	if not IsValid(self.CW_VM) then return end

	local slot = findLensSlot(self.CW_VM)
	if slot then
		self.cotzIntegratedScope = {
			slot = slot,
			zoom = zoom,
			simpleZoom = SIMPLE_BASE_FOV - SIMPLE_BASE_FOV / zoom,
			complexZoom = zoom > 1 and COMPLEX_ZOOM or 0,
			reticle = getReticle(reticle),
		}
	end
	if not self.cotzIntegratedScope or not self.ApplyAnomalyAttachments then return end

	-- The Anomaly base draws its own fullscreen overlay. Integrated scopes use CW's HUD and RT instead.
	local drawHUD = self.DrawHUD
	self.DrawHUD = function(weapon)
		if weapon:GetCotzIntegratedScope() then
			baseclass.Get("cw_base").DrawHUD(weapon)
		else
			drawHUD(weapon)
		end
	end
end

function SWEP:GetCotzIntegratedScope()
	local scope = self.cotzIntegratedScope
	if not scope or self.cotzSight or self.AimPos ~= self.CurIronsightPos then return end
	local state = self.AnomalyState
	if state and (state.INS2_SightVElement or state.StencilSight) then return end

	return scope
end

local function drawReticle(scope, x, y, size)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(scope.reticle)

	local center = scope.reticleCenter
	if center then
		surface.DrawTexturedRectUV(x, y, size, size, center[1], center[2], 1 + center[1], 1 + center[2])
	else
		surface.DrawTexturedRect(x, y, size, size)
	end
end

local function canRenderScope(weapon)
	if weapon.Peeking or not weapon:isAiming() or not weapon:canUseComplexTelescopics() then return false end

	return not (weapon.dt.M203Active and weapon.M203Chamber and not weapon.properM203Sights)
end

local function renderScope(weapon, scope, origin, angles, fov, material)
	local size = weapon:getRenderTargetSize()
	scopeView.w = size
	scopeView.h = size
	scopeView.origin = origin
	scopeView.angles = angles
	local halfView = math.tan(math.rad(fov) * 0.5)
	scopeView.fov = math.deg(2 * math.atan(halfView * LENS_VIEW_FRACTION / scope.zoom))

	renderingScope = true
	render.PushRenderTarget(weapon.ScopeRT, 0, 0, size, size)
		render.RenderView(scopeView)

		local clippingDisabled = DisableClipping(true)
		cam.Start2D()
			drawReticle(scope, 0, 0, size)
		cam.End2D()
		DisableClipping(clippingDisabled)
	render.PopRenderTarget()
	renderingScope = false

	material:SetTexture("$basetexture", weapon.ScopeRT)
end

function SWEP:DrawCotzSimpleIntegratedScope(scope, width, height)
	local side = math.max(0, (width - height) * 0.5)
	drawReticle(scope, (width - height) * 0.5, 0, height)

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, side, height)
	surface.DrawRect(width - side, 0, side, height)
end

function SWEP:DrawCotzIntegratedScope(origin, angles, fov)
	local config = self.cotzIntegratedScope
	if not config or renderingScope or not IsValid(self.CW_VM) then return end

	-- Replace the TFA-proxied placeholder on this viewmodel without changing the original material.
	local vm = self.CW_VM
	if vm:GetSubMaterial(config.slot) ~= LENS_OVERRIDE then
		vm:SetSubMaterial(config.slot, LENS_OVERRIDE)
	end

	local scope = self:GetCotzIntegratedScope()
	if not scope or not canRenderScope(self) then
		lensMaterial:SetTexture("$basetexture", fallbackLens)
		return
	end

	renderScope(self, scope, origin, angles, fov, lensMaterial)
end

-- Returns the lens configuration and model of an installed attachment optic that renders through its lens.
function SWEP:GetCotzLensScope()
	local scope, data = self.cotzLensScope, self.cotzAimModel
	if not scope or not data or not data.active or not IsValid(data.ent) then return end

	return scope, data
end

function SWEP:DrawCotzLensScope(origin, angles, fov)
	if renderingScope then return end
	local scope, data = self:GetCotzLensScope()
	if not scope then return end

	if data.lensSlot == nil then
		data.lensSlot = findLensSlot(data.ent) or false
	end
	if not data.lensSlot then return end

	if data.ent:GetSubMaterial(data.lensSlot) ~= ATTACHMENT_LENS_OVERRIDE then
		data.ent:SetSubMaterial(data.lensSlot, ATTACHMENT_LENS_OVERRIDE)
	end

	-- Backup iron sights and simple telescopics leave the glass showing the plain lens.
	if self.AimPos ~= self.ActualSightPos or not canRenderScope(self) then
		attachmentLensMaterial:SetTexture("$basetexture", fallbackLens)
		return
	end

	scope.reticle = scope.reticle or getReticle(scope.reticlePath)
	renderScope(self, scope, origin, angles, fov, attachmentLensMaterial)
end
