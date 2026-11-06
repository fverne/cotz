local PLUGIN = PLUGIN
local pendingPhoto
local photoTarget
local renderingFrame = false

net.Receive("cotz/camera/photo", function()
	local photo = {
		origin = net.ReadVector(),
		angles = net.ReadAngle(),
		truncated = net.ReadBool(),
		map = game.GetMap(),
		subjects = {},
	}
	local count = net.ReadUInt(8)

	for index = 1, count do
		photo.subjects[index] = {
			kind = net.ReadBool() and "spawnpoint" or "entity",
			id = net.ReadString(),
			class = net.ReadString(),
			label = net.ReadString(),
			position = net.ReadVector(),
		}
	end

	pendingPhoto = photo
	surface.PlaySound("items/camera/snap.wav")
end)

function PLUGIN:PostRender()
	if renderingFrame then return end
	renderingFrame = true
	self:UpdateCameraScreen()
	if not pendingPhoto then
		renderingFrame = false

		return
	end

	local photo = pendingPhoto
	pendingPhoto = nil
	photoTarget = photoTarget or GetRenderTarget("cotz_camera_photo", self.photoWidth, self.photoHeight)
	render.PushRenderTarget(photoTarget)
	render.Clear(0, 0, 0, 255, true, true)
	cam.Start2D()
	render.RenderView({
		origin = photo.origin,
		angles = photo.angles,
		x = 0, y = 0, w = self.photoWidth, h = self.photoHeight,
		fov = self.photoFOV,
		aspect = self.photoAspect,
		drawviewmodel = false,
		drawhud = false,
		drawmonitors = false,
	})
	cam.End2D()
	local image = render.Capture({
		format = "jpeg", quality = 90,
		x = 0, y = 0, w = self.photoWidth, h = self.photoHeight,
	})
	render.PopRenderTarget()
	renderingFrame = false

	if not image then
		return
	end

	file.CreateDir("cotz/camera")
	file.Write("cotz/camera/latest.jpg", image)
	file.Write("cotz/camera/latest.json", util.TableToJSON(photo, true))
end

-- function PLUGIN:HUDPaint()
-- 	local client = LocalPlayer()
-- 	if not IsValid(client) or not client:Alive() or not client:GetCharacter() then return end
-- 	local weapon = client:GetActiveWeapon()
-- 	if not IsValid(weapon) or weapon:GetClass() ~= "ix_camera" then return end
-- 	if client:ShouldDrawLocalPlayer() or gui.IsGameUIVisible() then return end

-- 	local width = math.min(ScrW(), ScrH() * self.photoAspect)
-- 	local height = width / self.photoAspect
-- 	local x, y = (ScrW() - width) / 2, (ScrH() - height) / 2
-- 	surface.SetDrawColor(ix.cotzUI.colors.border)
-- 	surface.DrawOutlinedRect(x, y, width, height)
-- 	local padding = ix.cotzUI.Scale(12)
-- 	draw.SimpleText("Camera | Left-click", "cotzUISmall", x + padding, y + padding, ix.cotzUI.colors.text)
-- end
