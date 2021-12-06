AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Type = "anim"
ENT.PrintName = "Radio"
ENT.Category = "Helix"
ENT.Spawnable = true
--ENT.RenderGroup = RENDERGROUP_BOTH

ENT.RatioList = {}
ENT.RatioList['radio/radiomix_1.ogg'] = {dur = 258}
ENT.RatioList['radio/radiomix_2.ogg'] = {dur = 245}
ENT.RatioList['radio/radiomix_3.ogg'] = {dur = 254}
ENT.RatioList['radio/radiomix_4.ogg'] = {dur = 260}
ENT.RatioList['radio/radiomix_5.ogg'] = {dur = 245}
ENT.RatioList['radio/radiomix_6.ogg'] = {dur = 231}
ENT.RatioList['radio/radiomix_7.ogg'] = {dur = 261}
ENT.RatioList['radio/radiomix_8.ogg'] = {dur = 257}
ENT.RatioList['radio/radiomix_9.ogg'] = {dur = 256}
ENT.RatioList['radio/radiomix_a.ogg'] = {dur = 237}
ENT.RatioList['radio/radiomix_b.ogg'] = {dur = 260}

ENT.AfterRandom = {}
for k, v in pairs(ENT.RatioList) do
	ENT.AfterRandom[#ENT.AfterRandom + 1] = k
end

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/lostsignalproject/items/misc/radio.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end

		self.sound = CreateSound(self, table.Random(self.AfterRandom))
		self.sound:Play()
		self.sound:SetSoundLevel(45)

		self:Repeat(self.RatioList)
	end

	function ENT:Repeat(data)
		local options = {}
		for k, v in pairs(data) do
			options[#options + 1] = k
		end

		timer.Remove("RepeatRadio")

		timer.Create("RepeatRadio", data[string.sub(tostring(self.sound), 14, 33)].dur, 0, function()
			if (self.sound) then
				self.sound:Stop()
			end

			self.sound = CreateSound( self, table.Random(options))
			self.sound:Play()
			self.sound:SetSoundLevel(45)
			self:Repeat(data)
		end)
	end

	function ENT:OnRemove()
		if (self.sound) then
			timer.Remove("RepeatRadio")
			self.sound:Stop()
		end
	end
end
