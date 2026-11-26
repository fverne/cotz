local PROFILES = include("cotz/weapon_attachment_profiles.lua")
local FALLBACK_SOUNDS = {
	md_tundra9mm = "CW_M49MM_FIRE_SUPPRESSED",
	md_cobram2 = "CW_M1911_FIRE_SUPPRESSED",
	md_pbs1 = "CW_AK74_FIRE_SUPPRESSED",
	md_saker = "CW_G3A3_FIRE_SUPPRESSED",
}

-- zoom is the full-screen FOV change. lensZoom is the lighter view zoom while the lens renders the magnified scene.
local SCOPES = {
	cw_anomaly_1p29 = {
		zoom = 67.5,
		lensZoom = 15,
		reticleCenter = {0, -1.25 / 2048},
		overlay = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_1p29",
	},
	cw_anomaly_mosin = {
		zoom = 64.3,
		lensZoom = 15,
		reticleCenter = {-0.5 / 1024, -3.5 / 1024},
		overlay = "models/flaymi/stalker/anomaly/attachments/wpn_crosshair_mosin",
	},
}

-- Matches the FOV that CW's zoom amounts are measured against.
local SIMPLE_BASE_FOV = 90

local ALIGN_FIELDS = {
	md_acog = "ACOGAxisAlign",
	md_nightforce_nxs = "NXSAlign",
	md_pso1 = "PSO1AxisAlign",
	md_schmidt_shortdot = "SchmidtShortDotAxisAlign",
}

local OPTIC_VIEW_FIELDS = {
	"AimOverlay", "DrawBlackBarsOnAim", "ScaleOverlayToScreenHeight", "StretchOverlayToScreen",
	"MoveWepAwayWhenAiming", "InstantDissapearOnAim",
}

-- Saved separately: CW optics such as the PSO-1 set these in attachFunc, before the COTZ sight view applies.
local LENS_VIEW_FIELDS = {"SimpleTelescopicsFOV", "ZoomTextures"}

local poses
if CLIENT then
	poses = include("cotz/weapon_attachment_poses.lua")
end

local function setSlot(weapon, matches, header, choices)
	local slot
	for key, group in pairs(weapon.Attachments) do
		-- weapons.Get merges inherited tables and adds Attachments.BaseClass, which is not a category.
		if key ~= "BaseClass" then
			local remaining = {}
			for _, id in ipairs(group.atts) do
				if not matches(id) then
					remaining[#remaining + 1] = id
				end
			end

			group.atts = remaining
			if #remaining == 0 then
				if type(key) == "number" and (not slot or key < slot.key) then
					slot = {key = key, offset = group.offset}
				end
				weapon.Attachments[key] = nil
			end
		end
	end

	if #choices == 0 then return end

	local key = slot and slot.key
	if not key then
		key = 1
		while weapon.Attachments[key] do key = key + 1 end
	end

	weapon.Attachments[key] = {header = header, atts = choices, offset = slot and slot.offset or {800, -250}}
end

local function isAnomalyAttachment(id)
	return string.StartWith(id, "cw_anomaly_")
end

local function isSuppressor(id)
	return CustomizableWeaponry.suppressors[id] ~= nil
end

local function scopeFallback(definition, scope)
	local fallback = table.Copy(definition)
	fallback.aimPos = {definition.name .. "Pos", definition.name .. "Ang"}
	fallback.FOVModifier = scope.lensZoom or scope.zoom
	fallback.attachFunc = nil
	fallback.detachFunc = nil
	if CLIENT then
		fallback.overlay = surface.GetTextureID(scope.overlay)
		fallback.reticleCenter = scope.reticleCenter
		if scope.lensZoom then
			-- Complex telescopics draw into the lens; simple telescopics keep the full-screen reticle.
			fallback.lensScope = {
				zoom = SIMPLE_BASE_FOV / (SIMPLE_BASE_FOV - scope.zoom),
				simpleZoom = scope.zoom,
				reticlePath = scope.overlay,
				reticleCenter = scope.reticleCenter,
				zoomTextures = {{tex = fallback.overlay, offset = {0, 0}, center = scope.reticleCenter}},
			}
		end
	end

	return fallback
end

function SWEP:GetCotzAttachment(definition)
	if not definition or not self.cotzAttachmentDefinitions then return definition end

	return self.cotzAttachmentDefinitions[definition.name] or definition
end

function SWEP:ApplyCotzSightView(attachment)
	if not CLIENT or not self.cotzAttachmentDefinitions then return end
	if not table.HasValue(PROFILES.sights, attachment.name) then return end

	local native = self.AnomalyAttachmentOrder and table.HasValue(self.AnomalyAttachmentOrder, attachment.name)
	if native then return end

	local view = {}
	for _, field in ipairs(OPTIC_VIEW_FIELDS) do
		view[field] = self[field]
		self[field] = false
	end
	self.cotzSightView = view
	self.cotzSight = attachment.name

	local lens = attachment.lensScope
	if lens then
		for _, field in ipairs(LENS_VIEW_FIELDS) do
			view[field] = self[field]
		end
		self.cotzLensScope = lens
		self.SimpleTelescopicsFOV = lens.simpleZoom
		self.ZoomTextures = lens.zoomTextures
		self.ScaleOverlayToScreenHeight = true
	elseif attachment.overlay then
		self.AimOverlay = attachment.overlay
		self.cotzScopeReticleCenter = attachment.reticleCenter
		self.DrawBlackBarsOnAim = true
		self.ScaleOverlayToScreenHeight = true
		self.MoveWepAwayWhenAiming = true
	end
end

function SWEP:ResetCotzSightView(attachment)
	if not CLIENT or self.cotzSight ~= attachment.name then return end

	for _, field in ipairs(OPTIC_VIEW_FIELDS) do
		self[field] = self.cotzSightView[field]
	end
	if self.cotzLensScope then
		for _, field in ipairs(LENS_VIEW_FIELDS) do
			self[field] = self.cotzSightView[field]
		end
	end
	self.cotzLensScope = nil
	self.cotzSightView = nil
	self.cotzSight = nil
	self.cotzScopeReticleCenter = nil
	self.renderTargetFunc = nil
end

local function addModels(weapon, class)
	local layout = poses.weapons[class]
	weapon.AttachmentModelsVM = table.Copy(weapon.AttachmentModelsVM or {})
	for id, values in pairs(layout) do
		if id ~= "bone" then
			weapon.AttachmentModelsVM[id] = {
				model = poses.models[id],
				bone = layout.bone,
				pos = Vector(values[1], values[2], values[3]),
				angle = Angle(values[4], values[5], values[6]),
				size = Vector(values[7], values[8], values[9]),
			}

			local attachment = weapon:GetCotzAttachment(CustomizableWeaponry:findAttachment(id))
			local aim = attachment and attachment.aimPos
			if aim then
				weapon[aim[1]] = Vector(values[10], values[11], values[12])
				weapon[aim[2]] = Vector()
			end
		end
	end

	for _, field in pairs(ALIGN_FIELDS) do
		weapon[field] = weapon[field] or {right = 0, up = 0, forward = 0}
	end
end

local function applyAnomalyAdapters(weapon, suppressor)
	local applyAnomalyAttachments = weapon.ApplyAnomalyAttachments
	weapon.ApplyAnomalyAttachments = function(self, ...)
		local zoom = self.ZoomAmount
		applyAnomalyAttachments(self, ...)
		if suppressor and self.ActiveAttachments[suppressor] then
			self.dt.Suppressed = true
		end
		if CLIENT and self.cotzSight then
			self.ZoomAmount = zoom
			self.MoveWepAwayWhenAiming = self.AimOverlay and true or false
		end
	end

	if CLIENT then
		local drawAttachments = weapon.drawAttachments
		weapon.drawAttachments = function(self)
			drawAttachments(self)
			baseclass.Get("cw_base").drawAttachments(self)
		end

		local drawHUD = weapon.DrawHUD
		weapon.DrawHUD = function(self)
			if self.cotzSight then
				baseclass.Get("cw_base").DrawHUD(self)
			else
				drawHUD(self)
			end
		end
	end
end

function SWEP:ApplyCotzAttachmentProfile()
	local class = self:GetClass()
	local profile = PROFILES.GetForModel(class, self.ViewModel)
	if self.cotzAttachmentDefinitions then return end

	-- Anomaly firearms only take the COTZ CW 2.0 attachments, never the pack's own.
	local isAnomalyWeapon = string.StartWith(class, "cw_anomaly_")
	if not profile then
		if isAnomalyWeapon and self.Attachments then
			self.Attachments = table.Copy(self.Attachments)
			setSlot(self, isAnomalyAttachment, nil, {})
		end

		return
	end

	local suppressor = profile.suppressor
	self.cotzAttachmentDefinitions = {}
	local choices = {}
	for _, id in ipairs(PROFILES.GetSights(class)) do
		local definition = CustomizableWeaponry:findAttachment(id)
		if definition then
			choices[#choices + 1] = id
			local native = self.AnomalyAttachmentOrder and table.HasValue(self.AnomalyAttachmentOrder, id)
			if SCOPES[id] and not native then
				self.cotzAttachmentDefinitions[id] = scopeFallback(definition, SCOPES[id])
			end
		end
	end

	self.Attachments = table.Copy(self.Attachments)
	setSlot(self, function(id)
		return table.HasValue(choices, id)
			or string.StartWith(id, "cw_anomaly_") and CustomizableWeaponry.sights[id] ~= nil
	end, "Sight", choices)
	-- Some legacy integrally suppressed variants use CW slots for their fixed muzzle models.
	if suppressor or not self.SuppressedOnEquip then
		setSlot(self, isSuppressor, "Suppressor", suppressor and {suppressor} or {})
	end
	if isAnomalyWeapon then
		setSlot(self, isAnomalyAttachment, nil, {})
	end
	if suppressor and (not self.FireSoundSuppressed or self.FireSoundSuppressed == self.FireSound) then
		self.FireSoundSuppressed = FALLBACK_SOUNDS[suppressor]
	end

	if CLIENT then
		addModels(self, PROFILES.GetSourceClass(class))
	end
	if self.ApplyAnomalyAttachments then
		applyAnomalyAdapters(self, suppressor)
	end
end
