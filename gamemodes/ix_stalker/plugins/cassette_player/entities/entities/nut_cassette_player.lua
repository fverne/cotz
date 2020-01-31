AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Проигрыватель"
ENT.Category = "Warfare ENT"
ENT.Spawnable = true
ENT.AdminOnly = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_c17/FurnitureCupboard001a.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetAngles(self:GetAngles() - Angle(0, 180, 0))
		self:DropToFloor()

		if (IsValid(self:GetPhysicsObject())) then
			self:GetPhysicsObject():EnableMotion(false)
		end
	end

	function ENT:Use(activator, caller)
		if (self.sound) then
			timer.Remove("repeat_player")
			self.sound:Stop()
			activator:GetCharacter():GetInventory():Add(self.PutCassette)
			self.PutCassette = nil
		end
	end

	function ENT:Repeat(data)
		local options = {}
		for k, v in pairs(data) do
			options[#options + 1] = k
		end

		timer.Remove("repeat_player")

		timer.Create("repeat_player", data[string.sub(tostring(self.sound), 14, 33)].dur, 0, function()
			if (self.sound) then
				self.sound:Stop()
			end

			self.sound = CreateSound( self, table.Random(options))
			self.sound:Play()
			self.sound:SetSoundLevel(0)
			self:Repeat(data)
		end)
	end

	function ENT:OnRemove()
		if (self.sound) then
			timer.Remove("repeat_player")
			self.sound:Stop()
		end
	end
end

