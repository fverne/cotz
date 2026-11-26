-- COTZ overrides for the bundled Helix icon renderer (gamemodes/helix/gamemode/core/libs/thirdparty/cl_ikon.lua).
-- Helix itself stays unmodified; schema libraries load after it, so these definitions replace the upstream
-- methods. Differences from upstream:
--   * renderIcon accepts a trailing material argument and resets it for each request.
--   * Opacity-weighted blending, so translucent layers keep underlying detail and opaque faces cover earlier draws.
--     If this changes, bump ICON_CACHE_PREFIX so clients regenerate their cached icons.
--   * updateCache loads through a uniquely named file on the next tick, and the icon stays pending until then.
--     Loading an icon's own path in the frame it is written can leave a blank texture until the game restarts.

local ICON_CACHE_PREFIX = "v2_"
if ikon.cachePrefix ~= ICON_CACHE_PREFIX then
	ikon.cache = {}
	ikon.cachePrefix = ICON_CACHE_PREFIX
end
ikon.pending = ikon.pending or {}
ikon.renderCount = ikon.renderCount or 0

local function iconPath(name)
	return "helix/icons/" .. Schema.folder .. "/" .. ICON_CACHE_PREFIX .. name .. ".png"
end

-- Same named render target and material as the bundled renderer; these calls return the existing objects.
local tex_effect = GetRenderTarget("ixIconRenderedOutline", ikon.max, ikon.max)
local mat_outline = CreateMaterial("ixIconRenderedTemp", "UnlitGeneric", {
	["$basetexture"] = tex_effect:GetName(),
	["$translucent"] = 1
})

local lightPositions = {
	BOX_TOP = Color(255, 255, 255),
	BOX_FRONT = Color(255, 255, 255),
}

function ikon:renderHook()
	local entity = ikon.renderEntity

	if (halo.RenderedEntity() == entity) then
		return
	end

	local w, h = ikon.curWidth * 64, ikon.curHeight * 64
	local x, y = 0, 0
	local tab

	if (ikon.info) then
		tab = {
			origin = ikon.info.pos,
			angles = ikon.info.ang,
			fov = ikon.info.fov,
			outline = ikon.info.outline,
			outCol = ikon.info.outlineColor
		}

		if (!tab.origin and !tab.angles and !tab.fov) then
			table.Merge(tab, PositionSpawnIcon(entity, entity:GetPos(), true))
		end
	else
		tab = PositionSpawnIcon(entity, entity:GetPos(), true)
	end

	-- Taking MDave's Tip
	xpcall(function()
			render.OverrideAlphaWriteEnable(true, true) -- some playermodel eyeballs will not render without this
			render.SetWriteDepthToDestAlpha(false)
			-- Keep the source colour for the PNG and attenuate underlying colour and coverage
			-- by opacity. Opaque receiver faces fully replace magazine pixels drawn behind them.
			render.OverrideBlend(true,
				BLEND_ONE, BLEND_ONE_MINUS_SRC_ALPHA, BLENDFUNC_ADD,
				BLEND_ONE, BLEND_ONE_MINUS_SRC_ALPHA, BLENDFUNC_ADD
			)
			render.SuppressEngineLighting(true)
			render.Clear(0, 0, 0, 0, true, true)

			render.SetLightingOrigin(vector_origin)
			render.ResetModelLighting(200 / 255, 200 / 255, 200 / 255)
			render.SetColorModulation(1, 1, 1)

			for i = 0, 6 do
				local col = lightPositions[i]

				if (col) then
					render.SetModelLighting(i, col.r / 255, col.g / 255, col.b / 255)
				end
			end

			if (tab.outline) then
				ix.util.ResetStencilValues()
				render.SetStencilEnable(true)
				render.SetStencilWriteMask(137) -- yeah random number to avoid confliction
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
				render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
			end

			--[[
				Add more effects on the Models!
			]]--
			if (ikon.info and ikon.info.drawHook) then
				ikon.info.drawHook(entity)
			end

			cam.Start3D(tab.origin, tab.angles, tab.fov, 0, 0, w, h)
				render.SetBlend(1)
				entity:DrawModel()
			cam.End3D()

			if (tab.outline) then
				render.PushRenderTarget(tex_effect)
				render.Clear(0, 0, 0, 0)
				render.ClearDepth()
				cam.Start2D()
					cam.Start3D(tab.origin, tab.angles, tab.fov, 0, 0, w, h)
							render.SetBlend(0)
							entity:DrawModel()

							render.SetStencilWriteMask(138) -- could you please?
							render.SetStencilTestMask(1)
							render.SetStencilReferenceValue(1)
							render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
							render.SetStencilPassOperation(STENCILOPERATION_KEEP)
							render.SetStencilFailOperation(STENCILOPERATION_KEEP)
							cam.Start2D()
								surface.SetDrawColor(tab.outCol or color_white)
								surface.DrawRect(0, 0, ScrW(), ScrH())
							cam.End2D()
					cam.End3D()
				cam.End2D()
				render.PopRenderTarget()

				render.SetBlend(1)
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NOTEQUAL)

				--[[
					Thanks for Noiwex
					NxServ.eu
				]]--
				cam.Start2D()
					surface.SetMaterial(mat_outline)
					surface.DrawTexturedRectUV(-2, 0, w, h, 0, 0, w / ikon.max, h / ikon.max)
					surface.DrawTexturedRectUV(2, 0, w, h, 0, 0, w / ikon.max, h / ikon.max)
					surface.DrawTexturedRectUV(0, 2, w, h, 0, 0, w / ikon.max, h / ikon.max)
					surface.DrawTexturedRectUV(0, -2, w, h, 0, 0, w / ikon.max, h / ikon.max)
				cam.End2D()

				render.SetStencilEnable(false)
			end

			render.SuppressEngineLighting(false)
			render.SetWriteDepthToDestAlpha(true)
			render.OverrideAlphaWriteEnable(false)
	end, function(message)
		print(message)
	end)
	render.OverrideBlend(false)
end

--[[
	Renders the Icon with given arguments.
	returns nothing
]]--
function ikon:renderIcon(name, w, h, mdl, camInfo, updateCache, material)
	if (#ikon.requestList > 0) then return IKON_BUSY end
	if (ikon.requestList[name] or ikon.pending[name]) then return IKON_PROCESSING end
	if (!w or !h or !mdl) then return IKON_SOMETHINGWRONG end

	local capturedIcon
	ikon.curWidth = w or 1
	ikon.curHeight = h or 1
	ikon.renderModel = mdl

	if (camInfo) then
		ikon.info = camInfo
	end

	local w, h = ikon.curWidth * 64, ikon.curHeight * 64
	local sw, sh = ScrW(), ScrH()

	if (ikon.renderModel) then
		if (!IsValid(ikon.renderEntity)) then
			ikon.renderEntity = ClientsideModel(ikon.renderModel, RENDERGROUP_BOTH)
			ikon.renderEntity:SetNoDraw(true)
		end
	end

	ikon.renderEntity:SetModel(ikon.renderModel)
	ikon.renderEntity:SetMaterial(material or "")

	local bone = ikon.renderEntity:LookupBone("ValveBiped.Bip01_Head1")

	if (bone) then
		ikon.renderEntity:SetEyeTarget(ikon.renderEntity:GetBonePosition(bone) + ikon.renderEntity:GetForward() * 32)
	end

	local oldRT = render.GetRenderTarget()
	render.PushRenderTarget(ikon.RT)

	ikon.rendering = true
		ikon:renderHook()
	ikon.rendering = nil

	capturedIcon = render.Capture({
		format = "png",
		alpha = true,
		x = 0,
		y = 0,
		w = w,
		h = h
	})

	file.Write(iconPath(name), capturedIcon)
	ikon.info = nil
	render.PopRenderTarget()

	if (updateCache) then
		-- COTZ: loading the icon's own path in the frame it is written can leave the engine holding a blank
		-- texture for that path until the game restarts. Load a uniquely named copy on the next tick instead;
		-- os.time() alone let icons rendered in the same second share one texture.
		ikon.renderCount = ikon.renderCount + 1
		local materialID = string.lower("ikon_" .. ikon.renderCount .. "_" .. name)
		file.Write(materialID .. ".png", capturedIcon)
		ikon.pending[name] = true

		timer.Simple(0, function()
			local material = Material("../data/".. materialID ..".png")

			ikon.cache[name]  = material
			ikon.pending[name] = nil
			file.Delete(materialID .. ".png")
		end)
	end

	ikon.requestList[name] = nil
	return true
end

--[[
	Gets rendered icon with given unique name.
	returns IMaterial
]]--
function ikon:GetIcon(name)
	-- COTZ: do not touch the on-disk path while its deferred load is pending.
	if (ikon.pending[name]) then return false end

	if (ikon.cache[name]) then
		return ikon.cache[name] -- yeah return cache
	end

	local path = iconPath(name)
	if (file.Exists(path, "DATA")) then
		ikon.cache[name] = Material("../data/" .. path)
		return ikon.cache[name] -- yeah return cache
	else
		return false -- retryd
	end
end
