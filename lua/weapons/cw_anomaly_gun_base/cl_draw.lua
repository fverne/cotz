local RETICLE_COLOR = Color(255, 70, 50)
local SCOPE_MASK = Material("cw2/reticles/scope_pso")
local RETICLE_SCREEN_FRACTION = 0.035
local overlayMaterials = {}

-- Scope reticles are lit model materials; an unlit copy draws them at full brightness on the HUD.
-- A missing texture is cached as false so the HUD falls back to the generic mask without retrying.
local function getOverlayMaterial(path)
	if overlayMaterials[path] ~= nil then return overlayMaterials[path] or nil end
	local texture = Material(path):GetTexture("$basetexture")
	overlayMaterials[path] = false
	if not texture or texture:IsError() then return end

	local name = "cotz_anomaly_overlay_" .. string.gsub(path, "%W", "_")
	overlayMaterials[path] = CreateMaterial(name, "UnlitGeneric", {
		["$basetexture"] = texture:GetName(),
		["$translucent"] = 1,
		["$vertexcolor"] = 1,
		["$vertexalpha"] = 1,
	})

	return overlayMaterials[path]
end

local function setMaterials(model, materials)
	if not IsValid(model) then return end
	local count = #model:GetMaterials()

	for index = 0, count - 1 do
		model:SetSubMaterial(index, materials and materials[index + 1] or "")
	end
end

function SWEP:UpdateAnomalyMaterials()
	setMaterials(self.CW_VM, self.AnomalyState.MaterialTable_V)
	setMaterials(self.WMEnt, self.AnomalyState.MaterialTable_W)
end

function SWEP:DrawAnomalyElements(parent, elements, realm)
	if not IsValid(parent) then return end
	self.AnomalyModels = self.AnomalyModels or {view = {}, world = {}}
	local models = self.AnomalyModels[realm]

	for id, data in pairs(elements or {}) do
		if not data.active or data.type ~= "Model" then continue end
		local model = models[id]

		if not IsValid(model) then
			model = self:createManagedCModel(data.model, RENDERGROUP_BOTH)
			if not IsValid(model) then continue end
			model:SetNoDraw(true)
			model:SetSkin(data.skin or 0)
			local matrix = Matrix()
			matrix:Scale(data.size)
			model:EnableMatrix("RenderMultiply", matrix)
			models[id] = model
		end

		if data.bonemerge then
			if model:GetParent() ~= parent then
				model:SetParent(parent)
				model:AddEffects(EF_BONEMERGE)
			end
		else
			local bone = parent:LookupBone(data.bone)
			if not bone then continue end
			local matrix = parent:GetBoneMatrix(bone)
			if not matrix then continue end
			local position, angle = LocalToWorld(data.pos, data.angle, matrix:GetTranslation(), matrix:GetAngles())
			model:SetPos(position)
			model:SetAngles(angle)
		end

		model:SetupBones()
		model:DrawModel()
	end
end

function SWEP:DrawAnomalyHands()
	if not self.UseHands then return end
	local hands = self:GetOwner():GetHands()
	if not IsValid(hands) then return end
	local model = self.AnomalyHands

	if not IsValid(model) or model:GetModel() ~= hands:GetModel() then
		if IsValid(model) then model:Remove() end
		model = self:createManagedCModel(hands:GetModel(), RENDERGROUP_BOTH)
		if not IsValid(model) then return end
		model:SetNoDraw(true)
		model:SetParent(self.CW_VM)
		model:AddEffects(EF_BONEMERGE)
		model:SetSkin(hands:GetSkin())
		for _, group in ipairs(hands:GetBodyGroups()) do
			model:SetBodygroup(group.id, hands:GetBodygroup(group.id))
		end
		self.AnomalyHands = model
	end

	model:SetupBones()
	model:DrawModel()
end

function SWEP:drawAttachments()
	self:DrawAnomalyHands()

	if self.AnomalyState then
		self:DrawAnomalyElements(self.CW_VM, self.AnomalyState.VElements, "view")
	end
end

function SWEP:DrawWorldModel()
	baseclass.Get("cw_base").DrawWorldModel(self)
	if not self.AnomalySource then return end
	local networkState = self:GetNWString("cotz/anomaly/attachments", "")

	if self.AnomalyRemoteState ~= networkState and self:GetOwner() ~= LocalPlayer() then
		self.AnomalyRemoteState = networkState
		self.AnomalyAttachmentState = {}

		for id in string.gmatch(networkState, "[^,]+") do
			if table.HasValue(self.AnomalyAttachmentOrder, id) then
				self.AnomalyAttachmentState[id] = true
			end
		end

		self:ApplyAnomalyAttachments()
	end

	if self.AnomalyState then
		self:DrawAnomalyElements(self.WMEnt, self.AnomalyState.WElements, "world")
	end
end

function SWEP:DrawHUD()
	baseclass.Get("cw_base").DrawHUD(self)
	if self.dt.State ~= CW_AIMING then return end
	local width, height = ScrW(), ScrH()
	local centerX, centerY = width * 0.5, height * 0.5

	if self.AnomalyScopeActive then
		surface.SetDrawColor(255, 255, 255)
		local reticle = self.AnomalyScopeReticle and getOverlayMaterial(self.AnomalyScopeReticle)
		surface.SetMaterial(reticle or SCOPE_MASK)
		surface.DrawTexturedRect(centerX - height * 0.5, 0, height, height)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, centerX - height * 0.5, height)
		surface.DrawRect(centerX + height * 0.5, 0, centerX - height * 0.5, height)
	elseif self.AnomalyState and self.AnomalyState.StencilSight then
		if self.AnomalyReticleMaterial then
			surface.SetMaterial(self.AnomalyReticleMaterial)
			surface.SetDrawColor(255, 255, 255)
			local scale = (self.AnomalyState.StencilSight_ReticleSize or 100) / 100
			local size = height * RETICLE_SCREEN_FRACTION * scale
			surface.DrawTexturedRect(centerX - size * 0.5, centerY - size * 0.5, size, size)
		else
			surface.SetDrawColor(RETICLE_COLOR)
			surface.DrawRect(centerX - 1, centerY - 1, 2, 2)
		end
	end

	if self.AnomalyGLActive then
		draw.SimpleText("Grenade launcher", "DermaDefault", centerX, height * 0.65, color_white, TEXT_ALIGN_CENTER)
	end
end
