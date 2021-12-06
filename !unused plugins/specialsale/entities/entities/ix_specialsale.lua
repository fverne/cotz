AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Special Item Purchaser"
ENT.Author = "verne, gumlefar"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup 		= RENDERGROUP_BOTH
ENT.Category = "Helix"
ENT.AutomaticFrameAdvance = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/stalkerisaac/playermodel/male_04_anorak.mdl")
		self:SetSolid(SOLID_BBOX)
		self:PhysicsInit(SOLID_BBOX)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetUseType(SIMPLE_USE)
		self:SetupAnimation("pose_ducking_02")
	end
	
	function ENT:Use(activator)
		ix.plugin.list["specialsale"]:checkSalesDate()
		if (activator:GetCharacter()) then
			if (activator:GetPos():Distance(self:GetPos()) <= 100) then
				local artSales = {ix.plugin.list["specialsale"]:getDailySales(), ix.plugin.list["specialsale"]:getWeeklySales()}
				
				netstream.Start(activator, "saleSpecialOpn", activator, self, artSales)
			end
		end
	end

else
	function ENT:CreateBubble()
		self.bubble = ClientsideModel("models/extras/info_speech.mdl", RENDERGROUP_OPAQUE)
		self.bubble:SetPos(self:GetPos() + Vector(0, 0, 84))
		self.bubble:SetModelScale(0.6, 0)
	end

	function ENT:Think()
		if (not IsValid(self.bubble) and not noBubble) then
			self:CreateBubble()
		end
		self:SetNextClientThink(CurTime() + 0.25)
	end

	function ENT:OnRemove()
		if (IsValid(self.bubble)) then
			self.bubble:Remove()
		end
	end

	function ENT:Draw()
		self:DrawModel()
		local bubble = self.bubble

		if (IsValid(bubble)) then
			local realTime = RealTime()
			bubble:SetRenderOrigin(self:GetPos() + Vector(0, 0, 84 + math.sin(realTime * 3) * 0.05))
			bubble:SetRenderAngles(Angle(0, realTime * 100, 0))
		end

		self:DrawModel()
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Oleksandr 'Spicy' Savchenko")
		name:SizeToContents()
		local descriptionText = self:GetNetVar("Description", "A person with asian features. He has a stern look on his face. Word has it he has a background as a smuggler.\n\nHe has connections outside the zone and is looking for special items to fulfill the needs of these peers.")

		if (descriptionText != nil) then
			local description = container:AddRow("Description")
			description:SetText(descriptionText)
			description:SizeToContents()
		end
	end
end

function ENT:SetupAnimation(animation)
	if (animation and animation ~= -1) then
		self:ResetSequence("pose_ducking_02")
	else
		self:ResetSequence("pose_ducking_02")
	end
end