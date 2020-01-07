--[[Thanks to Clavus.  I'm proud to have your code in my base, and even though you didn't include a liscense anywhere I could find, it's only fit to credit you.]]--

SWEP.vRenderOrder = nil

--[[ 
Function Name:  InitMods
Syntax: self:InitMods().  Should be called only once for best performance.
Returns:  Nothing.
Notes:  Creates the VElements and WElements table, and sets up mods.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:InitMods()
	--Create a new table for every weapon instance.
	self.VElements = self:CPTbl( self.VElements )
	self.WElements = self:CPTbl( self.WElements )
	self.ViewModelBoneMods = self:CPTbl( self.ViewModelBoneMods )
	self:CreateModels(self.VElements) -- create viewmodels
	self:CreateModels(self.WElements) -- create worldmodels
	
	--Build the bones and such.
	if self:OwnerIsValid() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
			if (self.ShowViewModel == nil or self.ShowViewModel) then
				vm:SetColor(Color(255,255,255,255))
			else
				vm:SetMaterial("Debug/hsv")--This hides the viewmodel, FYI, lol.
			end
		end
	end
end


--[[ 
Function Name:  ViewModelDrawn
Syntax: self:ViewModelDrawn().  Automatically called already.
Returns:  Nothing.
Notes:  This draws the mods.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

SWEP.CameraAttachmentOffsets = {
	{"p",0},
	{"y",0},
	{"r",0}
}

SWEP.CameraAttachment = nil
SWEP.CameraAttachments = {
	"camera",
	"attach_camera",
	"view",
	"cam",
	"look"
}
SWEP.CameraAngCache = nil

local tmpvec = Vector(0,0,-2000)

function SWEP:ViewModelDrawn()
	if !IsValid(self) or !self:OwnerIsValid() then return end
	local vm = self.Owner:GetViewModel()
	
	if self.UseHands then
		local hands = self.Owner:GetHands()
		if IsValid(hands) then
			if !self:IsHidden() then
				hands:SetParent(vm)
			else
				hands:SetParent(nil)
				hands:SetPos(tmpvec)
			end
		end
	end
	
	self:UpdateBonePositions(vm)
	
	if !self.CameraAttachment then
		self.CameraAttachment = -1
		for k,v in pairs(self.CameraAttachments) do
			local attid = vm:LookupAttachment(v)
			if attid and attid>0 then
				self.CameraAttachment = attid
				break
			end
		end
	end
	
	if self.CameraAttachment and self.CameraAttachment>0 then
		local angpos = vm:GetAttachment(self.CameraAttachment)
		local angv = angpos.Ang
		local off = vm:WorldToLocalAngles(angv)
		local spd = 10
		local cycl = vm:GetCycle()
		local dissipatestart = 0
		self.CameraAngCache = self.CameraAngCache or off
		for k,v in pairs(self.CameraAttachmentOffsets) do
			local offtype = v[1]
			local offang = v[2]
			if offtype=="p" then
				off:RotateAroundAxis(off:Right(),offang)
			elseif offtype=="y" then
				off:RotateAroundAxis(off:Up(),offang)
			elseif offtype=="r" then
				off:RotateAroundAxis(off:Forward(),offang)
			end
		end
		
		if self.ViewModelFlip then
			off = Angle()
		end
		
		local actind = vm:GetSequenceActivity(vm:GetSequence())
		if ( actind==ACT_VM_DRAW or actind==ACT_VM_HOLSTER_DRAW_EMPTY or actind==ACT_VM_DRAW_SILENCED ) and vm:GetCycle()<0.05 then
			self.CameraAngCache.p = 0
			self.CameraAngCache.y = 0
			self.CameraAngCache.r = 0
		end
		if ( actind==ACT_VM_HOLSTER or actind==ACT_VM_HOLSTER_EMPTY ) and cycl>dissipatestart then
			self.CameraAngCache.p = self.CameraAngCache.p * (1-cycl)/(1-dissipatestart)
			self.CameraAngCache.y = self.CameraAngCache.y * (1-cycl)/(1-dissipatestart)
			self.CameraAngCache.r = self.CameraAngCache.r * (1-cycl)/(1-dissipatestart)
		end
		self.CameraAngCache.p=math.ApproachAngle(self.CameraAngCache.p,off.p,(self.CameraAngCache.p-off.p)*FrameTime()*spd)
		self.CameraAngCache.y=math.ApproachAngle(self.CameraAngCache.y,off.y,(self.CameraAngCache.y-off.y)*FrameTime()*spd)
		self.CameraAngCache.r=math.ApproachAngle(self.CameraAngCache.r,off.r,(self.CameraAngCache.r-off.r)*FrameTime()*spd)
		
	end
	
	if (!self.VElements) then return end
	if (!self.vRenderOrder) then
		-- // we build a render order because sprites need to be drawn after models
		self.vRenderOrder = {}
		for k, v in pairs( self.VElements ) do
			if (v.type == "Model") then
				table.insert(self.vRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.vRenderOrder, k)
			end
		end
	end
	for k, name in ipairs( self.vRenderOrder ) do
		local v = self.VElements[name]
		if (!v) then self.vRenderOrder = nil break end
		if (v.hide) then continue end
		
		local model = v.curmodel
		local sprite = v.spritemat
		
		if (!v.bone) then continue end
		
		local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
		
		if (!pos) then continue end
		
		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			
			if (!v.material) or (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() != v.material) then
				model:SetMaterial( v.material )
			end
			
			if (v.skin and v.skin != model:GetSkin()) then
				model:SetSkin(v.skin)
			end
			
			if (v.bodygroup) then
				for k, v in pairs( v.bodygroup ) do
					if (type(k)=="number") and (model:GetBodygroup(k) != v) then
						model:SetBodygroup(k, v)
					end
				end
			end
			
			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end
			
			render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			render.SetBlend(v.color.a/255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)
			
			render.SuppressEngineLighting(false)
			
		elseif (v.type == "Sprite" and sprite) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			
		elseif (v.type == "Quad" and v.draw_func) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			
			cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func( self )
			cam.End3D2D()
			end
		
	end
	
end

SWEP.wRenderOrder = nil

--[[ 
Function Name:  DrawWorldModel
Syntax: self:DrawWorldModel().  Automatically called already.
Returns:  Nothing.
Notes:  This draws the world model, plus its attachments.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

local culldistancecvar = GetConVar("sv_tfa_worldmodel_culldistance")

function SWEP:DrawWorldModel()
	if (self.ShowWorldModel == nil or self.ShowWorldModel) then
	
		if game.SinglePlayer() or CLIENT then
			local hand, offset, rotate

			local ply = self:GetOwner()

			if IsValid( ply ) and self.Offset and self.Offset.Pos and self.Offset.Ang then
				local handBone = ply:LookupBone( "ValveBiped.Bip01_R_Hand" )
				if ply.SetupBones then ply:SetupBones() end
				if handBone then
					local pos, ang = ply:GetBonePosition( handBone )
					pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
					ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
					ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
					ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )
					self:SetRenderOrigin( pos )
					self:SetRenderAngles( ang )
					--if self.Offset.Scale and ( !self.MyModelScale or ( self.Offset and self.MyModelScale!=self.Offset.Scale ) ) then
						self:SetModelScale( self.Offset.Scale or 1, 0 )
						self.MyModelScale = self.Offset.Scale
					--end
				end
			else
				self:SetRenderOrigin( nil )
				self:SetRenderAngles( nil )
				if !self.MyModelScale or self.MyModelScale!=1 then
					self:SetModelScale( 1, 0 )
					self.MyModelScale = 1
				end
			end
		end
		
		if !(culldistancecvar:GetFloat()>=0 and self:GetPos():Distance(EyePos and EyePos() or LocalPlayer():GetShootPos())>culldistancecvar:GetFloat() ) then
			self:DrawModel()
		end
	end
	
	if (!self.WElements) then return end
	
	if (!self.wRenderOrder) then
		self.wRenderOrder = {}
		for k, v in pairs( self.WElements ) do
			if (v.type == "Model") then
				table.insert(self.wRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.wRenderOrder, k)
			end
		end
	end
	
	bone_ent = self.Owner and self.Owner or self
	
	for k, name in pairs( self.wRenderOrder ) do
		local v = self.WElements[name]
		if (!v) then self.wRenderOrder = nil break end
		if (v.hide) then continue end
		
		local pos, ang
		
		if (v.bone) then
			pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
		else
			pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
		end
		
		if (!pos) then continue end
		
		local model = v.curmodel
		local sprite = v.spritemat
		
		if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
			-- //model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix( "RenderMultiply", matrix )
			
			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() != v.material) then
				model:SetMaterial( v.material )
			end
			
			if (v.skin and v.skin != model:GetSkin()) then
				model:SetSkin(v.skin)
			end
			
			if (v.bodygroup) then
				for k, v in pairs( v.bodygroup ) do
					if (model:GetBodygroup(k) != v) then
						model:SetBodygroup(k, v)
					end
				end
			end
			
			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end
			
			render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			render.SetBlend(v.color.a/255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)
			
			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
			
		elseif (v.type == "Sprite" and sprite) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			
		elseif (v.type == "Quad" and v.draw_func) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			
			cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func( self )
			cam.End3D2D()
		end
	end
end

--[[ 
Function Name:  GetBoneOrientation
Syntax: self:GetBoneOrientation( base bone mod table, bone mod table, entity, bone override ). 
Returns:  Position, Angle.
Notes:  This is a very specific function for a specific purpose, and shouldn't be used generally to get a bone's orientation.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:GetBoneOrientation( basetabl, tabl, ent, bone_override )
	
	local bone, pos, ang
	
	if !IsValid(ent) then
		return Vector(0,0,0), Angle(0,0,0)
	end
	
	if (tabl.rel and tabl.rel != "") then
		
		local v = basetabl[tabl.rel]
		
		if (!v) then return end
		
		--As clavus states in his original code, don't make your elements named the same as a bone, because recursion.
		pos, ang = self:GetBoneOrientation( basetabl, v, ent )
		
		if (!pos) then return end
		
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			
	else
		bone = ent:LookupBone(bone_override or tabl.bone)
		if (!bone) or (bone==-1) then return end
		
		pos, ang = Vector(0,0,0), Angle(0,0,0)
		local m = ent:GetBoneMatrix(bone)
		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end
		
		if (IsValid(self.Owner) and self.Owner:IsPlayer() and ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r -- For mirrored viewmodels.  You might think to scale negatively on X, but this isn't the case.
		end
	
	end
	
	return pos, ang
end

--[[ 
Function Name:  CleanModels
Syntax: self:CleanModels( elements table ). 
Returns:   Nothing.
Notes:  Removes all existing models.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:CleanModels( tabl )
	if (!tabl) then return end
		-- // Create the clientside models here because Garry says we can't do it in the render hook
	for k, v in pairs( tabl ) do
		if (v.type == "Model" and v.curmodel) then
			
			if v.curmodel and v.curmodel.Remove then
				
				timer.Simple(0,function()
					if v.curmodel and v.curmodel.Remove then v.curmodel:Remove() end
					v.curmodel = nil
				end)
				
			else
				v.curmodel = nil
			end
			
		elseif ( v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spritemat or v.cursprite != v.sprite) ) then
			
			v.cursprite = nil
			v.spritemat = nil
			
		end
	end
	
end

--[[ 
Function Name:  CreateModels
Syntax: self:CreateModels( elements table ). 
Returns:   Nothing.
Notes:  Creates the elements for whatever you give it.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:CreateModels( tabl )
	if (!tabl) then return end
		-- // Create the clientside models here because Garry says we can't do it in the render hook
	for k, v in pairs( tabl ) do
		if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.curmodel) or v.curmodelname != v.model) and 
				string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
			
			v.curmodel = ClientsideModel(v.model, RENDERGROUP_VIEWMODEL)
			if (IsValid(v.curmodel)) then
				v.curmodel:SetPos(self:GetPos())
				v.curmodel:SetAngles(self:GetAngles())
				v.curmodel:SetParent(self)
				v.curmodel:SetNoDraw(true)
				local matrix = Matrix()
				matrix:Scale(v.size)
				v.curmodel:EnableMatrix( "RenderMultiply", matrix )
				v.curmodelname = v.model
			else
				v.curmodel = nil
			end
			
		elseif ( v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spritemat or v.cursprite != v.sprite) ) then
			
			local name = v.sprite.."-"
			local params = { ["$basetexture"] = v.sprite }
			-- // make sure we create a unique name based on the selected options
			local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
			for i, j in pairs( tocheck ) do
				if (v[j]) then
					params["$"..j] = 1
					name = name.."1"
				else
					name = name.."0"
				end
			end
			v.cursprite = v.sprite
			v.spritemat = CreateMaterial(name,"UnlitGeneric",params)
			
		end
	end
	
end
	
--[[ 
Function Name:  UpdateBonePositions
Syntax: self:UpdateBonePositions( viewmodel ). 
Returns:   Nothing.
Notes:   Updates the bones for a viewmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:UpdateBonePositions(vm)
	
	if self.ViewModelBoneMods or self.BlowbackBoneMods then
		
		if !self.ViewModelBoneMods then
			self.ViewModelBoneMods = {}
		end
		
		if !self.BlowbackBoneMods then
			self.BlowbackBoneMods = {}
		end
		
		if (!vm:GetBoneCount()) then return end
		
		local loopthrough = {}
		
		local vbones = {}
		for i=0, vm:GetBoneCount() do
			local bonename = vm:GetBoneName(i)
			if (self.ViewModelBoneMods[bonename]) then 
				vbones[bonename] = self.ViewModelBoneMods[bonename]
			else
				vbones[bonename] = { 
					scale = Vector(1,1,1),
					pos = Vector(0,0,0),
					angle = Angle(0,0,0)
				}
			end
			if self.BlowbackBoneMods[bonename] then
				if !( self.SequenceEnabled[ACT_VM_RELOAD_EMPTY] and self:GetReloading() ) or !( self.Blowback_PistolMode and self:GetReloading() ) then
					vbones[bonename].pos = vbones[bonename].pos + self.BlowbackBoneMods[bonename].pos * self.BlowbackCurrent
					vbones[bonename].angle = vbones[bonename].angle + self.BlowbackBoneMods[bonename].angle * self.BlowbackCurrent
					vbones[bonename].scale = Lerp(self.BlowbackCurrent, vbones[bonename].scale,vbones[bonename].scale  *  self.BlowbackBoneMods[bonename].scale )
				else
					self.BlowbackCurrent = math.Approach(self.BlowbackCurrent,0,self.BlowbackCurrent*FrameTime()*30)
				end
			end
		end
		
		loopthrough = vbones
		
		for k, v in pairs( loopthrough ) do
			--print(v)
			local bone = vm:LookupBone(k)
			if (!bone) or (bone==-1) then continue end
			
			local s = Vector(v.scale.x,v.scale.y,v.scale.z)
			local p = Vector(v.pos.x,v.pos.y,v.pos.z)
			local childscale = Vector(1,1,1)
			local cur = vm:GetBoneParent(bone)
			while( cur != -1) do
				local pscale = loopthrough[vm:GetBoneName(cur)].scale
				childscale = childscale * pscale
				cur = vm:GetBoneParent(cur)
			end
			
			s = s * childscale
			
			if vm:GetManipulateBoneScale(bone) != s then
				vm:ManipulateBoneScale( bone, s )
			end
			
			if vm:GetManipulateBoneAngles(bone) != v.angle then
				vm:ManipulateBoneAngles( bone, v.angle )
			end
			
			if vm:GetManipulateBonePosition(bone) != p then
				vm:ManipulateBonePosition( bone, p )
			end
			
		end
	else
		self:ResetBonePositions(vm)
	end
end
	
--[[ 
Function Name:  ResetBonePositions
Syntax: self:ResetBonePositions( viewmodel ). 
Returns:   Nothing.
Notes:   Resets the bones for a viewmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--
 
function SWEP:ResetBonePositions(vm)
	
	if !self.ViewModelBoneMods and !self.BlowbackBoneMods then return end
	
	if SERVER then
		self:CallOnClient("ResetBonePositions","")
	end
	
	if !vm or vm=="" then	
		local pl
		if LocalPlayer then
			pl = LocalPlayer()
		else
			pl = Entity(1)
		end
		
		local pl = self.Owner and self.Owner or pl
		
		if !IsValid(pl) or !pl.GetViewModel then return end
		
		vm = pl:GetViewModel()
	end
	if !IsValid(vm) then return end
	if (!vm:GetBoneCount()) then return end
	for i=0, vm:GetBoneCount() do
		vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
		vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		vm:ManipulateBonePosition( i, vector_origin )
	end
end
