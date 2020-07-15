AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Quest Board"
ENT.Author = "verne"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup 		= RENDERGROUP_BOTH
ENT.Category = "Helix"
ENT.AutomaticFrameAdvance = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/kek1ch/notes_letter_1.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetUseType(SIMPLE_USE)
		--self:SetupAnimation("pose_standing_02")
	end

	function ENT:Use(activator)
		if (activator:GetCharacter()) then
			activator:SetAction("Opening...", 1, function()
				if (activator:GetPos():Distance(self:GetPos()) <= 100) then
					if activator:GetCharacter():GetData("quests", nil) == nil then
						activator:GetCharacter():SetData("quests", {})
						activator:ixQuestGetNew()
						activator:ixQuestGetNew()
						activator:ixQuestGetNew()
					end
					netstream.Start(activator, "questmenu", activator, self, activator:GetCharacter():GetData("quests", {}))
				end
			end)
		end
	end
else
	--function ENT:CreateBubble()
	--	self.bubble = ClientsideModel("models/extras/info_speech.mdl", RENDERGROUP_OPAQUE)
	--	self.bubble:SetPos(self:GetPos() + Vector(0, 0, 84))
	--	self.bubble:SetModelScale(0.6, 0)
	--end

	--function ENT:Think()
		--if (not IsValid(self.bubble) and not noBubble) then
		--	self:CreateBubble()
		--end
		--self:SetNextClientThink(CurTime() + 0.25)
	--end

	--function ENT:OnRemove()
	--	if (IsValid(self.bubble)) then
	--		self.bubble:Remove()
	--	end
	--end

	function ENT:Draw()
		--self:DrawModel()
		/*local bubble = self.bubble

		if (IsValid(bubble)) then
			local realTime = RealTime()
			bubble:SetRenderOrigin(self:GetPos() + Vector(0, 0, 84 + math.sin(realTime * 3) * 0.05))
			bubble:SetRenderAngles(Angle(0, realTime * 100, 0))
		end*/

		self:DrawModel()
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Quest Board")
		name:SizeToContents()
		local descriptionText = self:GetNetVar("Description", "The old board has some notes stapled on it. It seems to be various objectives that needs to be done. \n\nThere are some specifically for you.")

		if (descriptionText != nil) then
			local description = container:AddRow("Description")
			description:SetText(descriptionText)
			description:SizeToContents()
		end
	end
end

function ENT:SetupAnimation(animation)
	if (animation and animation ~= -1) then
		--self:ResetSequence("pose_standing_02")
	else
		--self:ResetSequence("pose_standing_02")
	end
end