local LocalPlayer = LocalPlayer
local IsValid = IsValid
local FrameTime = FrameTime
local CurTime = CurTime
local EyePos = EyePos
local EyeAngles = EyeAngles
local Lerp = Lerp

local _reg = debug.getregistry()
local _ent = _reg.Entity

local EntGetBoneMatrix = _ent.GetBoneMatrix
local EntGetAttachment = _ent.GetAttachment
local EntLookupBone = _ent.LookupBone

local _ang = _reg.Angle
local AngRotateAroundAxis = _ang.RotateAroundAxis
local AngUp = _ang.Up
local AngRight = _ang.Right
local AngForward = _ang.Forward

//-----------------------------------------------------------------------------
// getMuzzlePosition edited to be usable in third person
//-----------------------------------------------------------------------------

local att, vm

local muz = {}

function SWEP:getMuzzlePosition()
	if self.Owner:ShouldDrawLocalPlayer() then
		muz.Pos = EntGetAttachment(self.WMEnt, 1).Pos
		muz.Ang = EyeAngles()
		return muz
	end

	if self.MuzzleAttachment != 0 then
		return EntGetAttachment(self.CW_VM, self.MuzzleAttachment)
	end

	muz.Pos = self.Owner:EyePos()
	muz.Ang = self.Owner:EyeAngles()
	return muz
end

//-----------------------------------------------------------------------------
// LookupBone("[__INVALIDBONE__]") returns nil
// so I store int that I used with GetBoneName
//-----------------------------------------------------------------------------

function SWEP:buildBoneTable()
	local vm = self.CW_VM

	for i = 0, vm:GetBoneCount() - 1 do
		local boneName = vm:GetBoneName(i)
		local bone

		if boneName then
			bone = EntLookupBone(vm, boneName)
		end

		-- some ins models have [__INVALIDBONE__]s so to prevent nilpointerexceptions bone = 1
		self.vmBones[i + 1] = {boneName = boneName, bone = i, curPos = Vector(), curAng = Angle(), targetPos = Vector(), targetAng = Angle()}
	end
end

//-----------------------------------------------------------------------------
// createCustomVM edited to initialize additional models
//-----------------------------------------------------------------------------

function SWEP:createCustomVM(mdl)
	self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
	self.CW_VM:SetNoDraw(true)
	self.CW_VM:SetupBones()
	self.CW_VM:SelectWeightedSequence(ACT_VM_HOLSTER)
	self.CW_VM:SetCycle(1)

	self.CW_KK_HANDS = self:createManagedCModel(self.CW_KK_HANDS_MDL, RENDERGROUP_BOTH)
	self.CW_KK_HANDS:SetNoDraw(true)
	self.CW_KK_HANDS:SetupBones()
	self.CW_KK_HANDS:SetParent(self.CW_VM)
	self.CW_KK_HANDS:AddEffects(EF_BONEMERGE)
	self.CW_KK_HANDS:AddEffects(EF_BONEMERGE_FASTCULL)

	self.CW_GREN = self:createManagedCModel(self.CW_GREN_TWEAK.vm, RENDERGROUP_BOTH)
	self.CW_GREN:SetNoDraw(true)
	self.CW_GREN:SetupBones()

	self.CW_KK_KNIFE = self:createManagedCModel(self.CW_KK_KNIFE_TWEAK.vm, RENDERGROUP_BOTH)
	self.CW_KK_KNIFE:SetNoDraw(true)
	self.CW_KK_KNIFE:SetupBones()

	// not rly a viewmodel but still need to stick it somewhere

	self.WMEnt = self:createManagedCModel(self.WorldModel, RENDERGROUP_BOTH)
	self.WMEnt:SetNoDraw(true)
	self.WMEnt:SetupBones()
end

//-----------------------------------------------------------------------------
// drawViewModel edited to draw quick knife viewmodel
//-----------------------------------------------------------------------------

function SWEP:drawViewModel()
	if not self.CW_VM then
		return
	end

	self:offsetBones()

	local FT = FrameTime()

	self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 0, FT * 10 * self.LuaVMRecoilLowerSpeed)
	self.LuaVMRecoilLowerSpeed = math.Approach(self.LuaVMRecoilLowerSpeed, 1, FT * 2)

	self:applyOffsetToVM()
	self:_drawViewModel()

	self:drawGrenade()
	self:drawKKKnife()
end

function SWEP:drawQuickViewModel(vm)
	local pos, ang = EyePos(), EyeAngles()
	local FT = FrameTime()

	self.GrenadePos.z = Lerp(FT * 10, self.GrenadePos.z, 0)

	pos = pos + AngUp(ang) * self.GrenadePos.z
	pos = pos + AngForward(ang) * 2

	vm:SetPos(pos)
	vm:SetAngles(ang)
	vm:FrameAdvance(FT)

	cam.IgnoreZ(true)
		vm:DrawModel()
		self:DrawVMHandsModel()
	cam.IgnoreZ(false)
end

//-----------------------------------------------------------------------------
// _drawViewModel edited to draw hands-model entity and viewmodel shells
//-----------------------------------------------------------------------------

local cvAmmoHud = GetConVar("cw_customhud_ammo")
local cvSVM = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_shell_vm"]

function SWEP:_drawViewModel()
	self.CW_VM:FrameAdvance(FrameTime())
	self.CW_VM:SetupBones()

	local overrideVM = false
	for _,e in pairs(self.AttachmentModelsVM) do
		overrideVM = overrideVM or (e.active and e.hideVM)
		if overrideVM then break end
	end

	if not overrideVM then
		self.CW_VM:DrawModel()
	end

	local CT = CurTime()

	if CT > self.grenadeTime and CT > self.knifeTime then
		if self.CW_KK_HANDS:GetParent() != self.CW_VM then
			self.CW_KK_HANDS:SetParent(self.CW_VM)
		end

		self:DrawVMHandsModel()
	end

	if cvSVM:GetInt() == 1 then
		self:drawVMShells()
	end

	self:drawAttachments()
	self:drawInteractionMenu()

	if self.reticleFunc then
		self.reticleFunc(self)
	end

	if cvAmmoHud:GetInt() >= 1 then
		self:draw3D2DHUD()
	end
end

//-----------------------------------------------------------------------------
// createGrenadeModel contents moved to createCustomVM
//-----------------------------------------------------------------------------

function SWEP:createGrenadeModel() end

//-----------------------------------------------------------------------------
// drawGrenade edited to draw hands-model entity
//-----------------------------------------------------------------------------

function SWEP:drawGrenade()
	if CurTime() > self.grenadeTime then
		return
	end

	local pos, ang = EyePos(), EyeAngles()
	local FT = FrameTime()

	self.GrenadePos.z = Lerp(FT * 10, self.GrenadePos.z, 0)

	pos = pos + AngUp(ang) * self.GrenadePos.z
	pos = pos + AngForward(ang) * 2

	self.CW_GREN:SetPos(pos)
	self.CW_GREN:SetAngles(ang)
	self.CW_GREN:FrameAdvance(FT)

	cam.IgnoreZ(true)
		self.CW_GREN:DrawModel()
		self:DrawVMHandsModel()
	cam.IgnoreZ(false)
end

//-----------------------------------------------------------------------------
// drawKKKnife is exactly same as drawGrenade
//-----------------------------------------------------------------------------

function SWEP:drawKKKnife()
	if CurTime() > self.knifeTime then
		return
	end

	local pos, ang = EyePos(), EyeAngles()
	local FT = FrameTime()

	self.GrenadePos.z = Lerp(FT * 10, self.GrenadePos.z, 0)

	pos = pos + AngUp(ang) * self.GrenadePos.z
	pos = pos + AngForward(ang) * 2

	self.CW_KK_KNIFE:SetPos(pos)
	self.CW_KK_KNIFE:SetAngles(ang)
	self.CW_KK_KNIFE:FrameAdvance(FT)

	cam.IgnoreZ(true)
		self.CW_KK_KNIFE:DrawModel()
		self:DrawVMHandsModel()
	cam.IgnoreZ(false)
end

//-----------------------------------------------------------------------------
// setupAttachmentModels edited to support
// - custom attach points, bone-merging
// - globally pre-set sub-material override
// - individually set material and sub-material override
// - WElement init
//-----------------------------------------------------------------------------

function SWEP:setupAttachmentModels()
	if self.AttachmentModelsVM then
		for k, v in pairs(self.AttachmentModelsVM) do
			if v.models then
				for key, data in ipairs(v.models) do
					self:_setupAttachmentModel(data)
				end
			else
				self:_setupAttachmentModel(v)
			end
		end

		for k, v in pairs(self.AttachmentModelsVM) do
			if v.models then
				for key, data in ipairs(v.models) do
					self:_setupAttachmentModelMerge(data)
				end
			else
				self:_setupAttachmentModelMerge(v)
			end
		end
	end

	self:setupAttachmentWModels()
end

function SWEP:_setupAttachmentModel(v)
	v.ent = self:createManagedCModel(v.model, RENDERGROUP_BOTH)
	v.ent:SetNoDraw(true)

	v.active = v.active or false
	v.nodraw = v.nodraw or false

	v.matrix = Matrix()

	if v.size then
		v.matrix:Scale(v.size)
	end

	v.ent:EnableMatrix("RenderMultiply", v.matrix)

	if v.bodygroups then
		for main, sec in pairs(v.bodygroups) do
			v.ent:SetBodygroup(main, sec)
		end
	end

	if v.skin then
		v:SetSkin(v.skin)
	end

	v.ent:SetupBones()

	-- if v.merge then
		-- v.ent:SetParent(self.CW_VM)
		-- v.ent:AddEffects(EF_BONEMERGE)
		-- v.ent:AddEffects(EF_BONEMERGE_FASTCULL)
	-- end

	if v.attachment then
		v._attachment = self.CW_VM:LookupAttachment(v.attachment)
	end

	if v.bone then
		v._bone = EntLookupBone(self.CW_VM, v.bone)
	end

	for i,mat in pairs(v.ent:GetMaterials()) do
		if CustomizableWeaponry_KK.ins2.nodrawMat[mat] then
			v.ent:SetSubMaterial(i - 1, CustomizableWeaponry_KK.ins2.nodrawMatPath)
		end
	end

	if v.material then
		v.ent:SetMaterial(v.material)
	elseif v.materials then
		for i,path in pairs(v.materials) do
			v.ent:SetSubMaterial(i - 1, path)
		end
	end
end

function SWEP:_setupAttachmentModelMerge(v)
	if v.merge then
		if v.rel and self.AttachmentModelsVM[v.rel] then
			v.ent:SetParent(self.AttachmentModelsVM[v.rel].ent)
		else
			v.ent:SetParent(self.CW_VM)
		end

		v.ent:AddEffects(EF_BONEMERGE)
		v.ent:AddEffects(EF_BONEMERGE_FASTCULL)
	end
end

//-----------------------------------------------------------------------------
// drawAttachments edited to support custom attach points and lighting recomp.
//-----------------------------------------------------------------------------

function SWEP:drawAttachments()
	if not self.AttachmentModelsVM then
		return false
	end

	local FT = FrameTime()

	for k, v in pairs(self.AttachmentModelsVM) do
		if v.active and self._skipDrawingScope != k then
			self:_drawAttachmentModels(v)
		end
	end

	for k, v in pairs(self.elementRender) do
		v(self)
	end

	return true
end

local nFront, nRight, nTop = Vector(1,0,0), Vector(0,1,0), Vector(0,0,1)
local nBack, nLeft, nBottom = -1 * nFront, -1 * nRight, -1 * nTop

local function recomputeLighting(i, pos, ang)
	if i == 1 then
		render.SuppressEngineLighting(true)

		local lFront = render.ComputeLighting(pos, nFront)
		local lBack = render.ComputeLighting(pos, nBack)

		local lRight = render.ComputeLighting(pos, nRight)
		local lLeft = render.ComputeLighting(pos, nLeft)

		local lTop = render.ComputeLighting(pos, nTop)
		local lBottom = render.ComputeLighting(pos, nBottom)

		render.SetModelLighting(BOX_FRONT, lFront.x, lFront.y, lFront.z)
		render.SetModelLighting(BOX_BACK, lBack.x, lBack.y, lBack.z)

		render.SetModelLighting(BOX_RIGHT, lRight.x, lRight.y, lRight.z)
		render.SetModelLighting(BOX_LEFT, lLeft.x, lLeft.y, lLeft.z)

		render.SetModelLighting(BOX_TOP, lTop.x, lTop.y, lTop.z)
		render.SetModelLighting(BOX_BOTTOM, lBottom.x, lBottom.y, lBottom.z)
	else
		render.SuppressEngineLighting(false)
	end
end

local cvarFixScopes = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_scopelightingfix"]

local active, pos, ang, m, vma, model, doRecompute, parent

function SWEP:_drawAttachmentModel(v)
	if not v.ent then
		return
	end

	if v.rel and self.AttachmentModelsVM[v.rel] then
		parent = self.AttachmentModelsVM[v.rel].ent
	else
		parent = self.CW_VM
	end

	model = v.ent

	pos = parent:GetPos()
	ang = parent:GetAngles()

	if v.merge then
		-- if model:GetParent() != parent then
			-- model:SetParent(parent)
		-- end
	else
		if v._attachment then
			vma = EntGetAttachment(parent, v._attachment)
			pos = vma.Pos
			ang = vma.Ang
		elseif v._bone then
			m = EntGetBoneMatrix(parent, v._bone)
			pos = m:GetTranslation()
			ang = m:GetAngles()
		end

		pos = pos + AngForward(ang) * v.pos.x + AngRight(ang) * v.pos.y + AngUp(ang) * v.pos.z

		AngRotateAroundAxis(ang, AngUp(ang), v.angle.y)
		AngRotateAroundAxis(ang, AngRight(ang), v.angle.p)
		AngRotateAroundAxis(ang, AngForward(ang), v.angle.r)

		model:SetPos(pos)
		model:SetAngles(ang)
	end

	if v.animated then
		model:FrameAdvance(FrameTime())
		model:SetupBones()
	end

	if !v.nodraw then
		doRecompute = v.rLight and cvarFixScopes:GetInt() == 1
		recomputeLighting(doRecompute and 1 or false, pos, ang)
			model:DrawModel()
		recomputeLighting(true or whatever, pos, ang)
	end
end

//-----------------------------------------------------------------------------
// DrawWorldModel edited to support
// - attachment world models (WElements)
// - 3rd person 3D2D HUD
//-----------------------------------------------------------------------------

function SWEP:DrawWorldModel()
	if self.dt.Safe then
		if self.CHoldType != self.RunHoldType then
			self:SetHoldType(self.RunHoldType)
			self.CHoldType = self.RunHoldType
		end
	else
		if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.CHoldType != self.NormalHoldType then
				self:SetHoldType(self.NormalHoldType)
				self.CHoldType = self.NormalHoldType
			end
		end
	end

	if IsValid(self.Owner) then
		if not self.OwnerAttachBoneID then
			self.OwnerAttachBoneID = EntLookupBone(self.Owner, "ValveBiped.Bip01_R_Hand")
		end
        if isnumber(self.OwnerAttachBoneID) then
    		m = EntGetBoneMatrix(self.Owner, self.OwnerAttachBoneID)
    
    		if not m then
    		    if isnumber(EntLookupBone(self.Owner, "ValveBiped.Bip01_R_Hand")) then
        			m = EntGetBoneMatrix(self.Owner, EntLookupBone(self.Owner, "ValveBiped.Bip01_R_Hand"))
        
        			if not m then
        				return
        			end
        		end
    		end
    
    		pos = m:GetTranslation()
    		ang = m:GetAngles()
    
    		pos = pos + AngForward(ang) * self.WMPos.x + AngRight(ang) * self.WMPos.y + AngUp(ang) * self.WMPos.z
    
    		AngRotateAroundAxis(ang, AngUp(ang), self.WMAng.y)
    		AngRotateAroundAxis(ang, AngRight(ang), self.WMAng.x)
    		AngRotateAroundAxis(ang, AngForward(ang), self.WMAng.z)
    	end
	else
		self.OwnerAttachBoneID = false

		pos = self:GetPos()
		ang = self:GetAngles()
	end

	if !IsValid(self.WMEnt) then
	    self.WMEnt = self:createManagedCModel(self.WorldModel, RENDERGROUP_BOTH)
    	self.WMEnt:SetNoDraw(true)
    	self.WMEnt:SetupBones()
    	self:setupAttachmentWModels()
	end
    
    if isvector(pos) then
	    self.WMEnt:SetPos(pos)
	end
	
	if isangle(ang) then
	    self.WMEnt:SetAngles(ang)
    end
    
	self.WMEnt:DrawShadow(true)

	local overrideVM = false
	if self.AttachmentModelsWM then
		for _,e in pairs(self.AttachmentModelsWM) do
			overrideVM = overrideVM or (e.active and e.hideVM)
			if overrideVM then break end
		end
	end

	if not overrideVM then
		self.WMEnt:DrawModel()
	end

	self:drawAttachmentsWorld(self.WMEnt)

	self.HUD_3D2DScale = self.HUD_3D2DScale * 1.5
	self.CustomizationMenuScale = self.CustomizationMenuScale * 1.5

	if IsValid(self.Owner) and self.Owner == LocalPlayer() then
		cam.IgnoreZ(true)
		self:drawInteractionMenu()
		if cvAmmoHud:GetInt() >= 1 then
			self:draw3D2DHUD()
		end
		cam.IgnoreZ(false)
	end

	self.HUD_3D2DScale = self.HUD_3D2DScale / 1.5
	self.CustomizationMenuScale = self.CustomizationMenuScale / 1.5
end

//-----------------------------------------------------------------------------
// initialize attachment world models (WElements)
//-----------------------------------------------------------------------------

function SWEP:setupAttachmentWModels()
	if self.AttachmentModelsWM then
		local parent = self
		if IsValid(self.WMEnt) then
			parent = self.WMEnt
		end

		parent:SetupBones()

		for k, v in pairs(self.AttachmentModelsWM) do
			v.ent = self:createManagedCModel(v.model, RENDERGROUP_BOTH)
			v.ent:SetNoDraw(true)

			v.active = v.active or false

			if v.size then
				v.matrix = Matrix()

				v.matrix:Scale(v.size)
				v.ent:EnableMatrix("RenderMultiply", v.matrix)
			end

			if v.bodygroups then
				for main, sec in pairs(v.bodygroups) do
					v.ent:SetBodygroup(main, sec)
				end
			end

			if v.skin then
				v:SetSkin(v.skin)
			end

			if v.merge then
				v.ent:SetParent(parent)
				v.ent:AddEffects(EF_BONEMERGE)
				v.ent:AddEffects(EF_BONEMERGE_FASTCULL)
			end

			if v.attachment then
				v._attachment = parent:LookupAttachment(v.attachment)
			end

			if v.bone then
				v._bone = EntLookupBone(parent, v.bone)
			end

			for i,mat in pairs(v.ent:GetMaterials()) do
				if CustomizableWeaponry_KK.ins2.nodrawMat[mat] then
					v.ent:SetSubMaterial(i - 1, CustomizableWeaponry_KK.ins2.nodrawMatPath)
				end
			end

			if v.material then
				v.ent:SetMaterial(v.material)
			elseif v.materials then
				for i,path in pairs(v.materials) do
					v.ent:SetSubMaterial(i - 1, path)
				end
			end

			v.ent:SetupBones()
		end
	end
end

//-----------------------------------------------------------------------------
// draw attachment world models (WElements)
//-----------------------------------------------------------------------------

function SWEP:drawAttachmentsWorld(parent)
	if !IsValid(parent) then
		return
	end

	if self.AttachmentModelsWM then
		for k, v in pairs(self.AttachmentModelsWM) do
			if v.ent and v.active then
				model = v.ent

				if v.merge then
					-- if model:GetParent() != parent then
						-- model:SetParent(parent)
					-- end
				else
					pos = parent:GetPos()
					ang = parent:GetAngles()

					if v._attachment then
						vma = EntGetAttachment(parent, v._attachment)
						pos = vma.Pos
						ang = vma.Ang
					elseif v._bone then
						m = EntGetBoneMatrix(parent, v._bone)
						pos = m:GetTranslation()
						ang = m:GetAngles()
					end

					pos = pos + AngForward(ang) * v.pos.x + AngRight(ang) * v.pos.y + AngUp(ang) * v.pos.z

					AngRotateAroundAxis(ang, AngUp(ang), v.angle.y)
					AngRotateAroundAxis(ang, AngRight(ang), v.angle.p)
					AngRotateAroundAxis(ang, AngForward(ang), v.angle.r)

					model:SetPos(pos)
					model:SetAngles(ang)
				end

				if !v.nodraw then
					model:DrawModel()
				end
			end
		end
	end
end

//-----------------------------------------------------------------------------
// processFOVChanges edited to take dt.INS2GLActive into account
//-----------------------------------------------------------------------------

function SWEP:processFOVChanges(deltaTime)
	if self.dt.State == CW_AIMING then
		if self.dt.INS2GLActive then
			self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, 60)
		else
			if self.AimPos == self.SightBackUpPos and self.AimAng == self.SightBackUpAng then
				self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.AimViewModelFOV_Orig)
			else
				self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.AimViewModelFOV)
			end
		end
	else
		self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.ViewModelFOV_Orig)
	end

	self.ViewModelFOV = self.CurVMFOV
end

//-----------------------------------------------------------------------------
// scaleMovement edited to use sprint state dependent base values
//-----------------------------------------------------------------------------

local sth = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_sprint"]

function SWEP:scaleMovement(val, mod)
	local scale = self.ViewModelMovementScale

	if sth:GetInt() == 1 then
		if self.Sequence:find("sprint") then
			return 0
		else
			return val * self.ViewModelMovementScale_base * mod
		end
	end

	if self.Slot != 2 and self.Slot != 3 then
		if self.Sequence:find("sprint") then
			scale = self.ViewModelMovementScale_sprint
		else
			scale = self.ViewModelMovementScale_base
		end
	end

	if self.ActiveAttachments.kk_ins2_ww2_knife or self.ActiveAttachments.kk_ins2_ww2_knife_fat then
		if self.Sequence:find("sprint") then
			scale = self.ViewModelMovementScale_base / 4
		else
			scale = self.ViewModelMovementScale_base
		end
	end

	return val * scale * mod
end

//-----------------------------------------------------------------------------
// DrawVMHandsModel detached from and shared between
// _drawViewModel, drawGrenade and drawKKKnife
//-----------------------------------------------------------------------------

function SWEP:DrawVMHandsModel()
	local gm = self.Owner:GetHands()

	if !IsValid(gm) then
		self.CW_KK_HANDS:DrawModel()
		return
	end

	if self.UseGMHands then
		if gm:GetParent() != self.CW_KK_HANDS then
			gm:SetParent(self.CW_KK_HANDS)
			gm:AddEffects(EF_BONEMERGE)
			gm:AddEffects(EF_BONEMERGE_FASTCULL)
		end

		gm:DrawModel()
	else
		if gm:GetParent() == self.CW_KK_HANDS then
			gm:SetParent(nil)
		end

		self.CW_KK_HANDS:DrawModel()
	end
end