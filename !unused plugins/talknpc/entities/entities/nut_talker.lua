ENT.Type = "anim"
ENT.PrintName = "Talker"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true
ENT.isVendor = true

NUT_VENDORS = NUT_VENDORS or {}

function ENT:SpawnFunction(client, trace)
	local angles = (trace.HitPos - client:GetPos()):Angle()
	angles.r = 0
	angles.p = 0
	angles.y = angles.y + 180

	local entity = ents.Create("nut_talker")
	entity:SetPos(trace.HitPos)
	entity:SetAngles(angles)
	entity:Spawn()

	return entity
end

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/Humans/Group01/Male_04.mdl")
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType(MOVETYPE_NONE)
		self:DrawShadow(true)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_BBOX)

		self:SetNetVar("name", "John Doe")
		self:SetNetVar("desc", "")

		--makes it so all factions are defaulted on.
		local facts = {}
		for k, v in pairs(ix.faction.indices) do
			facts[v.uniqueID] = 1
		end
		self:SetNetVar("factiondata", facts)

		self.receivers = {}

		NUT_VENDORS[self:EntIndex()] = self
		
		local physObj = self:GetPhysicsObject()
		
		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:EnableGravity(false)
			--physObj:Sleep()
			physObj:EnableCollisions(false)
		end
	end
	
	self.items = {}
	self.factions = {}
	self.messages = {}
	self.classes = {}
	self.hasSetupVars = true

	timer.Simple(1, function()
		if (IsValid(self)) then
			self:SetAnim()
		end
	end)
end

function ENT:CanAccess(client)
	local bAccess = false
	local uniqueID = ix.faction.indices[client:Team()].uniqueID

	if (self.factions and !table.IsEmpty(self.factions)) then
		if (self.factions[uniqueID]) then
			bAccess = true
		else
			return false
		end
	end

	if (bAccess and self.classes and !table.IsEmpty(self.classes)) then
		local class = ix.class.list[client:GetCharacter():GetClass()]
		local classID = class and class.uniqueID

		if (classID and !self.classes[classID]) then
			return false
		end
	end

	return true
end

function ENT:GetStock(uniqueID)
	if (self.items[uniqueID] and self.items[uniqueID][VENDOR_MAXSTOCK]) then
		return self.items[uniqueID][VENDOR_STOCK] or 0, self.items[uniqueID][VENDOR_MAXSTOCK]
	end
end

function ENT:GetPrice(uniqueID, selling)
	local price = ix.item.list[uniqueID] and self.items[uniqueID] and
		self.items[uniqueID][VENDOR_PRICE] or ix.item.list[uniqueID].price or 0

	if (selling) then
		price = math.floor(price * (self.scale or 0.5))
	end

	return price
end

function ENT:CanSellToPlayer(client, uniqueID)
	local data = self.items[uniqueID]

	if (!data or !client:GetCharacter() or !ix.item.list[uniqueID]) then
		return false
	end

	if (data[VENDOR_MODE] == VENDOR_BUYONLY) then
		return false
	end

	if (!client:GetCharacter():HasMoney(self:GetPrice(uniqueID))) then
		return false
	end

	if (data[VENDOR_STOCK] and data[VENDOR_STOCK] < 1) then
		return false
	end

	return true
end

function ENT:CanBuyFromPlayer(client, uniqueID)
	local data = self.items[uniqueID]

	if (!data or !client:GetCharacter() or !ix.item.list[uniqueID]) then
		return false
	end

	if (data[VENDOR_MODE] != VENDOR_SELLONLY) then
		return false
	end

	if (!self:HasMoney(data[VENDOR_PRICE] or ix.item.list[uniqueID].price or 0)) then
		return false
	end

	return true
end

function ENT:HasMoney(amount)
	-- Vendor not using money system so they can always afford it.
	if (!self.money) then
		return true
	end

	return self.money >= amount
end

function ENT:SetAnim()
	for k, v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("idle") and v != "idlenoise") then
			return self:ResetSequence(k)
		end
	end

	if (self:GetSequenceCount() > 1) then
		self:ResetSequence(4)
	end
end

if (CLIENT) then
	function ENT:Think()
	end

	function ENT:Draw()
		self:DrawModel()
	end
	
	netstream.Hook("nut_Dialogue", function(data)
		if (IsValid(ix.gui.dialogue)) then
			ix.gui.dialogue:Remove()
			return
		end
		ix.gui.dialogue = vgui.Create("Nut_Dialogue")
		ix.gui.dialogue:Center()
		ix.gui.dialogue:SetEntity(data)
		
		if LocalPlayer():IsAdmin() then
			if (IsValid(ix.gui.edialogue)) then
				ix.gui.edialogue:Remove()
				return
			end
			ix.gui.edialogue = vgui.Create("Nut_DialogueEditor")
			--ix.gui.edialogue:Center()
			ix.gui.edialogue:SetEntity(data)
		end
	end)
	
	function ENT:openQuest()
		if (IsValid(ix.gui.quest)) then
			ix.gui.quest:Remove()
			return
		end
		
		if (IsValid(ix.gui.dialogue)) then
			ix.gui.dialogue:Remove()
		end		
		
		ix.gui.quest = vgui.Create("Nut_Quest")
		ix.gui.quest:Center()
		ix.gui.quest:SetEntity(self)
		if LocalPlayer():IsAdmin() then
			if (IsValid(ix.gui.edialogueq)) then
				ix.gui.edialogueq:Remove()
				return
			end
			
			if (IsValid(ix.gui.edialogue)) then
				ix.gui.edialogue:Remove()
			end			
			
			ix.gui.edialogueq = vgui.Create("Nut_QuestEditor")
			--ix.gui.edialogueq:Center()
			ix.gui.edialogueq:SetEntity(self)
		end
	end	

	function ENT:CreateBubble()
		self.bubble = ClientsideModel("models/extras/info_speech.mdl", RENDERGROUP_OPAQUE)
		self.bubble:SetPos(self:GetPos() + Vector(0, 0, 84))
		self.bubble:SetModelScale(0.6, 0)
	end

	function ENT:Draw()
		local bubble = self.bubble

		if (IsValid(bubble)) then
			local realTime = RealTime()

			bubble:SetRenderOrigin(self:GetPos() + Vector(0, 0, 84 + math.sin(realTime * 3) * 0.05))
			bubble:SetRenderAngles(Angle(0, realTime * 100, 0))
		end

		self:DrawModel()
	end


	function ENT:OnRemove()
		if (IsValid(self.bubble)) then
			self.bubble:Remove()
		end
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText(self:GetNetVar("name", "John Doe"))
		name:SizeToContents()

		local descriptionText = self:GetNetVar("desc", "")

		if (descriptionText != "") then
			local description = container:AddRow("description")
			description:SetText(self:GetNetVar("desc", ""))
			description:SizeToContents()
		end
	end
else
	function ENT:Think()
		if(!self:IsPlayerHolding()) then
			local physObj = self:GetPhysicsObject()
			
			if(!physObj:IsAsleep()) then
				physObj:Sleep()
			end
		end
	end

	function ENT:Use(activator)
		local factionData = self:GetNetVar("factiondata", {})
		if !factionData[ix.faction.indices[activator:Team()].uniqueID] and !activator:IsAdmin() then
			activator:ChatPrint(self:GetNetVar( "name", "John Doe" )..": I don't want talk with you.")
			return
		end
		
		netstream.Start(activator, "nut_Dialogue", self)

		--rotates the npc towards whoever used it, off until I think of a way to do it better
		--[[
		if(self:LookupBone("ValveBiped.Bip01_Head1")) then
			self:PointAtEntity(activator)
			local angle = self:GetAngles()
			self:SetAngles(Angle(0, angle.y, 0))
		end
		--]]
		
		self.receivers[#self.receivers + 1] = activator
		activator.nutVendor = self
		
		--hook.Run("PlayerAccessVendor", activator, self)
	end
	
	netstream.Hook("nut_DialogueData", function(client, data)
		if (!client:IsAdmin()) then
			return
		end
		
		local entity = data[1]
		local dialogue = data[2]
		local factionData = data[3]
		local classData = data[4]
		local name = data[5]
		local desc = data[6]
		local model = data[7]
		local skin = data[8]
		local groups = data[9]
		local anim = data[10]
		
		if (IsValid(entity)) then
			entity:SetNetVar("dialogue", dialogue)
			entity:SetNetVar("factiondata", factionData)
			entity:SetNetVar("classdata", classData)
			entity:SetNetVar("name", name)
			entity:SetNetVar("desc", desc)
			entity:SetNetVar("anim", anim)
			entity:SetModel(model)
			entity:SetSkin(skin)
			entity:SetAnim()
			
			if(groups) then
				entity:SetBodygroup(1, groups[1] or 0)
				entity:SetBodygroup(2, groups[2] or 0)
				entity:SetBodygroup(3, groups[3] or 0)
				entity:SetBodygroup(4, groups[4] or 0)
				entity:SetBodygroup(5, groups[5] or 0)
				entity:SetBodygroup(6, groups[6] or 0)
			end			

			client:Notify("You have updated this talking npc's data.")
		end
	end)
	
	netstream.Hook("nut_QuestData", function(client, data)
		if (!client:IsAdmin()) then
			return
		end
		
		local entity = data[1]
		local quests = data[2]
		
		if (IsValid(entity)) then
			entity:SetNetVar("quests", quests)

			client:Notify("You have updated this talking npc's quest data.")
		end
	end)

	--vendor functions
	local PLUGIN = PLUGIN

	function ENT:SpawnFunction(client, trace)
		local angles = (trace.HitPos - client:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180

		local entity = ents.Create("nut_talker")
		entity:SetPos(trace.HitPos)
		entity:SetAngles(angles)
		entity:Spawn()

		PLUGIN:SaveData()

		return entity
	end

	function ENT:SetMoney(value)
		self.money = value

		net.Start("ixVendorMoney")
			net.WriteUInt(value and value or -1, 16)
		net.Send(self.receivers)
	end

	function ENT:GiveMoney(value)
		if (self.money) then
			self:SetMoney(self:GetMoney() + value)
		end
	end

	function ENT:TakeMoney(value)
		if (self.money) then
			self:GiveMoney(-value)
		end
	end

	function ENT:SetStock(uniqueID, value)
		if (!self.items[uniqueID][VENDOR_MAXSTOCK]) then
			return
		end

		self.items[uniqueID] = self.items[uniqueID] or {}
		self.items[uniqueID][VENDOR_STOCK] = math.min(value, self.items[uniqueID][VENDOR_MAXSTOCK])

		net.Start("ixVendorStock")
			net.WriteString(uniqueID)
			net.WriteUInt(value, 16)
		net.Send(self.receivers)
	end

	function ENT:AddStock(uniqueID, value)
		if (!self.items[uniqueID][VENDOR_MAXSTOCK]) then
			return
		end

		self:SetStock(uniqueID, self:GetStock(uniqueID) + (value or 1))
	end

	function ENT:TakeStock(uniqueID, value)
		if (!self.items[uniqueID][VENDOR_MAXSTOCK]) then
			return
		end

		self:AddStock(uniqueID, -(value or 1))
	end
end

function ENT:GetMoney()
	return self.money
end
