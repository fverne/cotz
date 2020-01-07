
//-----------------------------------------------------------------------------
// _registerVMShell adds passed entity to SWEPs table of active shells
//-----------------------------------------------------------------------------

local cvarSVM = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_shell_vm"]

function SWEP:_registerVMShell(ent)
	if cvarSVM:GetInt() == 1 then
		ent:SetNoDraw(true)
		ent._drawAsVM = CurTime() + 0.4

		table.insert(self._deployedShells, ent)

		local i = 1

		for _ = 1, #self._deployedShells do
			if !IsValid(self._deployedShells[i]) then
				table.remove(self._deployedShells, i)
			else
				i = i + 1
			end
		end
	end
end

//-----------------------------------------------------------------------------
// drawVMShells iterates SWEPs table of active shells and draws them
//-----------------------------------------------------------------------------

local sh, sw = ScrH(), ScrW()

function SWEP:drawVMShells()
	for _,v in pairs(self._deployedShells) do
		if IsValid(v) then
			-- local scr = v:GetPos():ToScreen()

			-- if scr.x < 0 or sw < scr.x or scr.y < 0 or sh < scr.y then
				-- v._drawAsVM = 0
			-- end

			if v._drawAsVM > CurTime() then
				v:DrawModel()
			else
				v:SetNoDraw(false)
			end
		end
	end
end

//-----------------------------------------------------------------------------
// idk
//-----------------------------------------------------------------------------

local vel = Vector()

function SWEP:calcShellAngleVelocity(ang)
	vel.x = 0
	vel.y = 0
	vel.z = math.random(80,130) * -100

	return vel * ang:Up()
end

//-----------------------------------------------------------------------------
// CreateShell edited to use
// - custom makeShell function
// - registerVMShell
//-----------------------------------------------------------------------------

function SWEP:CreateShell()
	if self.NoShells or self.Owner:ShouldDrawLocalPlayer() then
		return
	end

	if self.ShellDelay then
		CustomizableWeaponry.actionSequence.new(self, self.ShellDelay, nil, function()
			self:shellEvent()
		end)

		return
	end

	self:shellEvent()
end

//-----------------------------------------------------------------------------
// CreateShell versions used as sound table callbacks
//-----------------------------------------------------------------------------

function SWEP:shellEvent()
	if !IsValid(self.Owner) or self.Owner:ShouldDrawLocalPlayer() then
		local vm = self:getMuzzleModel()
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(self.ShellWorldAttachmentID)
		if not att then return end

		local pos = att.Pos
		local ang = att.Ang

		local baseVelocity = IsValid(self.Owner) and self.Owner:GetVelocity() or self:GetVelocity()
		local velocity = baseVelocity + ang:Forward() * (self.ShellEjectVelocity)

		local align = self.ShellWorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		local angleVelocity = self:calcShellAngleVelocity(ang)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			angleVelocity,
			self._shellTable1,
			self.ShellScale
		)
	else
		local vm = self.CW_VM
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(self.ShellViewAttachmentID)
		if not att then return end

		local pos = att.Pos
		local ang = att.Ang
		local velocity = self.Owner:GetVelocity() + ang:Forward() * (self.ShellEjectVelocity)

		local align = self.ShellViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		local angleVelocity = self:calcShellAngleVelocity(ang)

		shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			angleVelocity,
			self._shellTable1,
			self.ShellScale
		)

		self:_registerVMShell(shellEnt)
	end
end

function SWEP:shellEvent2()
	if self.Owner:ShouldDrawLocalPlayer() then
		local vm = self:getMuzzleModel()
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(self.Shell2WorldAttachmentID)
		if not att then return end

		local pos = att.Pos
		local ang = att.Ang
		local velocity = self.Owner:GetVelocity() + ang:Forward() * (self.Shell2EjectVelocity)
		local angleVelocity = self:calcShellAngleVelocity(ang)

		local align = self.Shell2WorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			angleVelocity,
			self._shellTable2,
			self.Shell2Scale
		)
	else
		local vm = self.CW_VM
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(self.Shell2ViewAttachmentID)
		if not att then return end

		local pos = att.Pos
		local ang = att.Ang
		local velocity = self.Owner:GetVelocity() + ang:Forward() * (self.Shell2EjectVelocity)
		local angleVelocity = self:calcShellAngleVelocity(ang)

		local align = self.Shell2ViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			angleVelocity,
			self._shellTable2,
			self.Shell2Scale
		)

		self:_registerVMShell(shellEnt)
	end
end

local m203 = CustomizableWeaponry.shells:getShell("KK_INS2_40mm")
local down = Vector(0,0,-10)
local downAngle = Vector()

function SWEP:shellEvent203()
	if self.Owner:ShouldDrawLocalPlayer() then
		local vm = self:getMuzzleModel()
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(8)
		if not att then return end

		local pos = att.Pos
		local ang = att.Ang

		local align = self.Shell2WorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			downAngle,
			m203,
			1
		)
	else
		local glAtt = self._currentGrenadeLauncher and self._currentGrenadeLauncher.name
		local vm = glAtt and self.AttachmentModelsVM[glAtt] and self.AttachmentModelsVM[glAtt].ent

		local att

		if IsValid(vm) then
			att = vm:GetAttachment(2)
		end

		local pos, ang

		if att then
			pos = att.Pos
			ang = att.Ang
		else
			ang = self.Owner:EyeAngles()
			pos = self.Owner:EyePos() - (15 * ang:Up())
		end

		local align = self.Shell2ViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			downAngle,
			m203,
			1
		)
	end
end

function SWEP:shellEventRev()
	if self.Owner:ShouldDrawLocalPlayer() then
		local vm = self:getMuzzleModel()
		if !IsValid(vm) then return end

		local m = vm:GetBoneMatrix(0)
		if not m then return end

		local pos = m:GetTranslation()
		local ang = m:GetAngles()

		local align = self.ShellWorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			downAngle,
			self._shellTable,
			self.ShellScale
		)
	else
		local vm = self.CW_VM
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(2)
		if not att then return end

		local pos = att.Pos
		local ang = att.Ang

		local align = self.ShellViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			downAngle,
			self._shellTable,
			self.ShellScale
		)
	end
end

function SWEP:shellEventRev2()
	if self.Owner:ShouldDrawLocalPlayer() then
		local vm = self:getMuzzleModel()
		if !IsValid(vm) then return end

		local m = vm:GetBoneMatrix(0)
		if not m then return end

		local pos = m:GetTranslation()
		local ang = m:GetAngles()

		local align = self.ShellWorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			downAngle,
			self._shellTable2,
			self.ShellScale
		)
	else
		local vm = self.CW_VM
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(2)
		if not att then return end

		local pos = att.Pos
		local ang = att.Ang

		local align = self.ShellViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			downAngle,
			self._shellTable2,
			self.ShellScale
		)
	end
end

local down = Vector(0,0,-10)
local downA = Vector()

function SWEP:shellEventWebley()
	if self.Owner:ShouldDrawLocalPlayer() then
		local vm = self:getMuzzleModel()
		if !IsValid(vm) then return end

		local m = vm:GetBoneMatrix(0)
		if not m then return end

		local pos = m:GetTranslation()
		local ang = m:GetAngles()

		local align = self.ShellWorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			downA,
			self._shellTable,
			self.ShellScale
		)
	else
		local vm = self.CW_VM
		if !IsValid(vm) then return end

		local att = vm:GetAttachment(2)
		if not att then return end

		local pos = att.Pos + att.Ang:Forward() * -7
		local ang = att.Ang
		local velocity = self.Owner:GetVelocity() + ang:Forward() * (self.ShellEjectVelocity or 200)

		local align = self.ShellViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)

		shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			downA,
			self._shellTable,
			self.ShellScale
		)

		self:_registerVMShell(shellEnt)
	end
end

local down = Vector(0,0,-10)
local downA = Vector()

function SWEP:shellEventReload()
	local att = wep.CW_VM:GetAttachment(2)
	local dir = att.Ang:Forward()
	local pos = att.Pos + dir * 10
	local ang = wep.Owner:EyeAngles()
	ang:RotateAroundAxis(ang:Up(), 180)

	CustomizableWeaponry_KK.ins2.shells:make(pos, ang, down, downA, wep._shellTable, 1)
end
