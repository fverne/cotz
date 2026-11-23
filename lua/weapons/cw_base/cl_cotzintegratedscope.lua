local LENS_MATERIAL_NAME = "cotz_integrated_scope_lens"
local fallbackLens = Material("cw2/gui/lense"):GetTexture("$basetexture")
local lensMaterial = CreateMaterial(LENS_MATERIAL_NAME, "UnlitGeneric", {
	["$basetexture"] = fallbackLens:GetName(),
	["$model"] = 1,
})
local LENS_OVERRIDE = "!" .. LENS_MATERIAL_NAME
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

function SWEP:SetupCotzIntegratedScope()
	local zoom, reticle = self.AnomalyScopeZoom, self.AnomalyReticle
	if not zoom or zoom < 1 or not reticle or self.RenderTargetFunc or self.cotzIntegratedScope then return end
	if not IsValid(self.CW_VM) then return end

	for index, path in ipairs(self.CW_VM:GetMaterials()) do
		if path:lower():match("/lense_rt$") then
			self.cotzIntegratedScope = {
				slot = index - 1,
				zoom = zoom,
				simpleZoom = SIMPLE_BASE_FOV - SIMPLE_BASE_FOV / zoom,
				complexZoom = zoom > 1 and COMPLEX_ZOOM or 0,
				reticle = getReticle(reticle),
			}
			break
		end
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
	surface.DrawTexturedRect(x, y, size, size)
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
	if not scope or self.Peeking or not self:isAiming() or not self:canUseComplexTelescopics()
		or self.dt.M203Active and self.M203Chamber and not self.properM203Sights then
		lensMaterial:SetTexture("$basetexture", fallbackLens)
		return
	end

	local size = self:getRenderTargetSize()
	scopeView.w = size
	scopeView.h = size
	scopeView.origin = origin
	scopeView.angles = angles
	local halfView = math.tan(math.rad(fov) * 0.5)
	scopeView.fov = math.deg(2 * math.atan(halfView * LENS_VIEW_FRACTION / scope.zoom))

	renderingScope = true
	render.PushRenderTarget(self.ScopeRT, 0, 0, size, size)
		render.RenderView(scopeView)

		local clippingDisabled = DisableClipping(true)
		cam.Start2D()
			drawReticle(scope, 0, 0, size)
		cam.End2D()
		DisableClipping(clippingDisabled)
	render.PopRenderTarget()
	renderingScope = false

	lensMaterial:SetTexture("$basetexture", self.ScopeRT)
end
