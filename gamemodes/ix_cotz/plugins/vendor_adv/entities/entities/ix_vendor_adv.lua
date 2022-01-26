
ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.PrintName = "Vendor - Advanced"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.isVendor = true
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

ENT.RestockThinkInterval = 600
ENT.restockCheckTimer = 0

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "NoBubble")
	self:NetworkVar("Bool", 1, "BuyAll")
	self:NetworkVar("String", 0, "DisplayName")
	self:NetworkVar("String", 1, "Description")
	self:NetworkVar("String", 2, "IdleAnim")
	self:NetworkVar("String", 3, "SoundGroup")
	self:NetworkVar("Int", 0, "AnimGroupId")
end

function ENT:Initialize()
	if (SERVER) then
		self.restockCheckTimer = CurTime() + self.RestockThinkInterval
		self:SetModel("models/mossman.mdl")
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType(MOVETYPE_NONE)
		self:DrawShadow(true)
		self:SetSolid(SOLID_BBOX)
		self:PhysicsInit(SOLID_BBOX)
		self:SetNWBool("NoDrag", true)
		
		self.items = {}
		self.messages = {}
		self.factions = {}
		self.classes = {}

		self:SetDisplayName("John Doe")
		self:SetDescription("")

		self.dialogueid = "00templatenpc"

		self.receivers = {}

		self.ShouldResetSequence = false

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

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

function ENT:GetStockInterval(uniqueID)
	if (self.items[uniqueID]) then
		return self.items[uniqueID][VENDOR_RESTOCK_INTERVAL] or 0.5, self.items[uniqueID][VENDOR_RESTOCK_AMOUNT] or 1
	end
end

function ENT:GetPrice(uniqueID, selling, iteminstanceID)
	local price = ix.item.list[uniqueID] and self.items[uniqueID] and
		self.items[uniqueID][VENDOR_PRICE] or (ix.item.instances[iteminstanceID] and ix.item.list[uniqueID].GetPrice and ix.item.instances[iteminstanceID]:GetPrice()) or ix.item.list[uniqueID].price or 0



	if (selling) then
		if(self.items[uniqueID] and self.items[uniqueID][VENDOR_PRICE] and self.items[uniqueID][VENDOR_PRICE] < 5) then
			price = math.floor(((ix.item.instances[iteminstanceID] and ix.item.list[uniqueID].GetPrice and ix.item.instances[iteminstanceID]:GetPrice()) or ix.item.list[uniqueID].price) * self.items[uniqueID][VENDOR_PRICE])
		else
			price = math.floor(price * (self.scale or 0.5))
		end
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
	if( math.random(1,100) < 50) and self:GetAnimGroupId() > 0 and not self.ShouldResetSequence then
		local tab = ix.npctemplates.animtemplates[ix.npctemplates.animtemplatestranslation[self:GetAnimGroupId()]]
		local sel = math.random(1, #tab)
		local seq, dur = self:LookupSequence(tab[sel])
		timer.Simple( dur, function() self.ShouldResetSequence = true end)

		return self:ResetSequence(seq)
	end

	self.ShouldResetSequence = false

	if (self:GetIdleAnim() == "") then
		for k, v in ipairs(self:GetSequenceList()) do
			if (v:lower():find("idle") and v != "idlenoise") then
				return self:ResetSequence(k)
			end
		end
	else
		local seq, dur = self:LookupSequence(self:GetIdleAnim())
		return self:ResetSequence(seq)
	end

	if (self:GetSequenceCount() > 1) then
		self:ResetSequence(4)
	end
end

if (SERVER) then
	local PLUGIN = PLUGIN

	function ENT:SpawnFunction(client, trace)
		local angles = (trace.HitPos - client:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180

		local entity = ents.Create("ix_vendor_adv")
		entity:SetPos(trace.HitPos)
		entity:SetAngles(angles)
		entity:Spawn()

		PLUGIN:SaveData()

		return entity
	end

	function ENT:Use(activator)
		local character = activator:GetCharacter()

		if (!self:CanAccess(activator) or hook.Run("CanPlayerUseVendor", activator) == false) then
			if (self.messages[VENDOR_NOTRADE]) then
				activator:ChatPrint(self:GetDisplayName()..": "..self.messages[VENDOR_NOTRADE])
			else
				activator:NotifyLocalized("vendorNoTrade")
			end

			return
		end

		activator:dialogue(self.dialogueid, self)
	end

	function ENT:SetDialogueID(value)
		self.dialogueid = value
	end

	function ENT:SetMoney(value)
		self.money = value

		net.Start("ixVendorAdvMoney")
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

		net.Start("ixVendorAdvStock")
			net.WriteString(uniqueID)
			net.WriteUInt(value, 16)
		net.Send(self.receivers)
	end

	function ENT:AddStock(uniqueID, value)
		if (!self.items[uniqueID]) then return end
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


	function ENT:RestockThink()
		local theTime = os.time()

		if (!self.items) then return end

		for k,v in pairs(self.items) do
			if(!v[VENDOR_RESTOCK_AMOUNT]) then continue end

			v[VENDOR_RESTOCK_TIME] = v[VENDOR_RESTOCK_TIME] or 0
			v[VENDOR_RESTOCK_INTERVAL] = v[VENDOR_RESTOCK_INTERVAL] or 0.5
			v[VENDOR_RESTOCK_AMOUNT] = v[VENDOR_RESTOCK_AMOUNT] or 1

			if v[VENDOR_RESTOCK_TIME] < theTime then
				v[VENDOR_RESTOCK_TIME] = theTime + v[VENDOR_RESTOCK_INTERVAL] * 60 * 60 -- Interval is in hours, os.time() is in seconds
				self:AddStock(k, v[VENDOR_RESTOCK_AMOUNT])
			end
		end
	end

	function ENT:Think()
		if( self.restockCheckTimer < CurTime()) then
			self:RestockThink()
			self.restockCheckTimer = CurTime() + self.RestockThinkInterval
		end

		self:NextThink(CurTime())

		return true
	end

else
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

	function ENT:PlayerNearby()
		for k,v in pairs(player.GetAll()) do
			if self:GetPos():Distance(v:GetPos()) < 200 then return true end
		end

		return false
	end

	function ENT:MakeNoise()
		local tab = ix.npctemplates.soundtemplates[self:GetSoundGroup()] or {"buttons/lever1.wav"}
		self:EmitSound(tab[math.random(1, #tab)])
	end

	function ENT:Think()
		local noBubble = self:GetNoBubble()

		if (IsValid(self.bubble) and noBubble) then
			self.bubble:Remove()
		elseif (!IsValid(self.bubble) and !noBubble) then
			self:CreateBubble()
		end

		if ((self.nextAnimCheck or 0) < CurTime() or self.ShouldResetSequence) then
			self:SetAnim()
			self.nextAnimCheck = CurTime() + 15
		end

		if (((self.nextNoise or 0) < CurTime()) and self:PlayerNearby()) then
			self:MakeNoise()
			self:SetAnim()
			self.nextNoise = CurTime() + math.random(15,45)
		end

		self:SetNextClientThink(CurTime())

		return true
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
		name:SetText(self:GetDisplayName())
		name:SizeToContents()

		local descriptionText = self:GetDescription()

		if (descriptionText != "") then
			local description = container:AddRow("description")
			description:SetText(self:GetDescription())
			description:SizeToContents()
		end
	end
end

function ENT:GetMoney()
	return self.money
end

function ENT:LoadTemplate(templatename)
	local tmplt = ix.npctemplates.templates[templatename]

	if tmplt ~= nil then
		self:SetModel(tmplt.model or self.model)
		self:SetSkin(tmplt.skin or 0)

		self:SetNoBubble(tmplt.bubble or self:GetNoBubble())
		self:SetDisplayName(tmplt.name or self:GetDisplayName())
		self:SetDescription(tmplt.description or self:GetDescription())

		for id, bodygroup in pairs(tmplt.bodygroups or {}) do
			self:SetBodygroup(id, bodygroup)
		end

		local items = {}

		if tmplt.items then
			for uniqueID, data in pairs(tmplt.items) do
				items[tostring(uniqueID)] = data
			end
		end

		self.items = items
		self.factions = tmplt.factions or self.factions
		self.classes = tmplt.classes or self.classes
		self.money = tmplt.money or self.money
		self.scale = tmplt.scale or self.scale
		self:SetBuyAll(tmplt.buyAll or self:GetBuyAll())
		self.dialogueid = tmplt.dialogueid or self.dialogueid
		self:SetSoundGroup(tmplt.soundgroup or self:GetSoundGroup())
		self:SetAnimGroupId(tmplt.animgroup or self:GetAnimGroupId())
		self:SetIdleAnim(tmplt.idleanim or "")
	end
end

if(SERVER)then

function ENT:AddItemToList(uniqueID, setprice, stock, mode, maxstock, restockinterval, restockamount) --Any of these can be nil, except uniqueID
	if (!self.items[uniqueID]) then
		local transtable = {
			["SELLANDBUY"] = 1,
			["SELLONLY"] = 2,
			["BUYONLY"] = 3,
		}

		self.items[uniqueID] = { setprice, stock, transtable[mode], maxstock, restockinterval, restockamount }
	end
end

end