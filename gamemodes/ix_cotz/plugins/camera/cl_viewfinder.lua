local SCREEN_TEXTURE_SIZE = 512
local SCREEN_WIDTH = 700
local SCREEN_HEIGHT = 510
local SCREEN_SCALE = 0.005
local SCREEN_OFFSET = Vector(-0.4, -0.3, 0.075)
local SCREEN_CLIP_OFFSET = 0.5
local screenTarget
local screenMaterial
local renderingScreen = false

local function getActiveCamera()
	local client = LocalPlayer()
	if not IsValid(client) or not client:Alive() or not client:GetCharacter() then return end
	if client:GetViewEntity() ~= client or client:ShouldDrawLocalPlayer() then return end
	local weapon = client:GetActiveWeapon()
	if not IsValid(weapon) or weapon:GetClass() ~= "ix_camera" then return end

	return client, weapon
end

function PLUGIN:UpdateCameraScreen()
	if renderingScreen then return end
	local client, weapon = getActiveCamera()
	if not client then return end

	if not screenTarget then
		screenTarget = GetRenderTarget("cotz_camera_screen", SCREEN_TEXTURE_SIZE, SCREEN_TEXTURE_SIZE)
		screenMaterial = CreateMaterial("cotz_camera_screen", "UnlitGeneric", {
			["$basetexture"] = screenTarget:GetName(),
			["$vertexcolor"] = "1",
			["$vertexalpha"] = "1",
		})
	end

	-- Render outside the viewmodel callback so the screen never samples itself while being updated.
	renderingScreen = true
	local wasHidden = weapon:GetNoDraw()
	weapon:SetNoDraw(true)
	render.PushRenderTarget(screenTarget)
	render.Clear(0, 0, 0, 255, true, true)
	cam.Start2D()
	render.RenderView({
		origin = client:GetShootPos(),
		angles = client:EyeAngles(),
		x = 0, y = 0, w = SCREEN_TEXTURE_SIZE, h = SCREEN_TEXTURE_SIZE,
		fov = self.photoFOV,
		aspect = self.photoAspect,
		drawviewmodel = false,
		drawhud = false,
		drawmonitors = false,
	})
	cam.End2D()
	render.PopRenderTarget()
	weapon:SetNoDraw(wasHidden)
	renderingScreen = false
end

local function toWorldProjection(position, viewModelFOV)
	local origin, angles = EyePos(), EyeAngles()
	local factor = math.tan(math.rad(LocalPlayer():GetFOV() / 2)) / math.tan(math.rad(viewModelFOV / 2))
	local offset = position - origin

	return origin + angles:Right() * (offset:Dot(angles:Right()) / factor)
		+ angles:Up() * (offset:Dot(angles:Up()) / factor) + angles:Forward() * offset:Dot(angles:Forward())
end

function PLUGIN:DrawCameraScreen(viewModel, viewModelFOV)
	if renderingScreen or not screenMaterial or not IsValid(viewModel) then return end
	if not getActiveCamera() then return end
	local lower = viewModel:GetAttachment(viewModel:LookupAttachment("controlpanel0_ll"))
	local upper = viewModel:GetAttachment(viewModel:LookupAttachment("controlpanel0_ur"))
	if not lower or not upper then return end

	-- Attachment geometry and offsets follow akua's original INFRA camera screen placement.
	local verticalDistance = -(upper.Pos - lower.Pos):Dot(lower.Ang:Right())
	local origin = lower.Pos - lower.Ang:Right() * verticalDistance
		+ lower.Ang:Forward() * SCREEN_OFFSET.x + lower.Ang:Right() * SCREEN_OFFSET.y
		+ lower.Ang:Up() * SCREEN_OFFSET.z
	local clipPosition = upper.Pos - lower.Ang:Right() * SCREEN_CLIP_OFFSET
	local clipNormal = lower.Ang:Right()
	local wasClipping = render.EnableClipping(true)
	render.PushCustomClipPlane(clipNormal, clipNormal:Dot(toWorldProjection(clipPosition, viewModelFOV)))
	cam.Start3D2D(toWorldProjection(origin, viewModelFOV), lower.Ang, SCREEN_SCALE)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	local width = math.min(SCREEN_WIDTH, SCREEN_HEIGHT * self.photoAspect)
	local height = width / self.photoAspect
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(screenMaterial)
	surface.DrawTexturedRect((SCREEN_WIDTH - width) / 2, (SCREEN_HEIGHT - height) / 2, width, height)
	cam.End3D2D()
	render.PopCustomClipPlane()
	render.EnableClipping(wasClipping)
end
