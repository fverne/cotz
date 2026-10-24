ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.PrintName = "Vendor - Advanced"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.isVendor = true
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "NoBubble")
	self:NetworkVar("Bool", 1, "BuyAll")
	self:NetworkVar("Bool", 2, "Sherpa")
	self:NetworkVar("String", 0, "DisplayName")
	self:NetworkVar("String", 1, "Description")
	self:NetworkVar("String", 2, "IdleAnim")
	self:NetworkVar("String", 3, "SoundGroup")
	self:NetworkVar("Int", 0, "AnimGroupId")
end

function ENT:Initialize()
	if SERVER then
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

		if IsValid(physObj) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

	timer.Simple(1, function()
		if IsValid(self) then
			self:SetAnim()
		end
	end)
end

function ENT:CanAccess(client)
	return self:CanTalkTo(client) and ix.progression.CanUseNPC(client:GetCharacter(), self:GetDisplayName())
end

function ENT:CanTalkTo(client)
	if not client:GetCharacter() then
		return false
	end
	local hasFactionAccess = false
	local uniqueID = ix.faction.indices[client:Team()].uniqueID

	if self.factions and not table.IsEmpty(self.factions) then
		if self.factions[uniqueID] then
			hasFactionAccess = true
		else
			return false
		end
	end

	if hasFactionAccess and self.classes and not table.IsEmpty(self.classes) then
		local class = ix.class.list[client:GetCharacter():GetClass()]
		local classID = class and class.uniqueID

		if classID and not self.classes[classID] then
			return false
		end
	end

	return true
end

function ENT:GetStock(uniqueID, character)
	if SERVER and character then
		return ix.vendorStock.Get(character, self, uniqueID)
	end
	if self.items[uniqueID] and self.items[uniqueID][VENDOR_MAXSTOCK] then
		return self.items[uniqueID][VENDOR_STOCK] or 0, self.items[uniqueID][VENDOR_MAXSTOCK]
	end
end

function ENT:GetStockInterval(uniqueID)
	if self.items[uniqueID] then
		return self.items[uniqueID][VENDOR_RESTOCK_INTERVAL] or 0.5,
			self.items[uniqueID][VENDOR_RESTOCK_AMOUNT] or 1
	end
end

function ENT:GetPrice(uniqueID, selling, itemInstanceID)
	local instance = ix.item.instances[itemInstanceID]
	local price = ix.item.list[uniqueID] and self.items[uniqueID] and self.items[uniqueID][VENDOR_PRICE]
		or (instance and ix.item.list[uniqueID].GetPrice and instance:GetPrice())
		or ix.item.list[uniqueID].price
		or 0

	if selling then
		if
			self.items[uniqueID]
			and self.items[uniqueID][VENDOR_PRICE]
			and self.items[uniqueID][VENDOR_PRICE] < 5
		then
			price = math.floor(
				(
					(
						ix.item.instances[itemInstanceID]
						and ix.item.list[uniqueID].GetPrice
						and ix.item.instances[itemInstanceID]:GetPrice()
					) or ix.item.list[uniqueID].price
				) * self.items[uniqueID][VENDOR_PRICE]
			)
		else
			price = math.floor(price * (self.scale or 0.5))
		end
	end

	return price
end

function ENT:CanSellToPlayer(client, uniqueID)
	local data = self.items[uniqueID]

	if not data or not client:GetCharacter() or not ix.item.list[uniqueID] then
		return false
	end

	if data[VENDOR_MODE] == VENDOR_BUYONLY then
		return false
	end

	if not client:GetCharacter():HasMoney(self:GetPrice(uniqueID)) then
		return false
	end

	local stock = self:GetStock(uniqueID, client:GetCharacter())
	if stock and stock < 1 then
		return false
	end

	return true
end

function ENT:CanBuyFromPlayer(client, uniqueID)
	local data = self.items[uniqueID]

	if not data or not client:GetCharacter() or not ix.item.list[uniqueID] then
		return false
	end

	if data[VENDOR_MODE] ~= VENDOR_SELLONLY then
		return false
	end

	if not self:HasMoney(data[VENDOR_PRICE] or ix.item.list[uniqueID].price or 0) then
		return false
	end

	return true
end

function ENT:HasMoney(amount)
	-- Vendor not using money system so they can always afford it.
	if not self.money then
		return true
	end

	return self.money >= amount
end

function ENT:SetAnim()
	if (math.random(1, 100) < 50) and self:GetAnimGroupId() > 0 and not self.ShouldResetSequence then
		local tab =
			ix.npctemplates.animtemplates[ix.npctemplates.animtemplatestranslation[self:GetAnimGroupId()]]
		local sel = math.random(1, #tab)
		local seq, dur = self:LookupSequence(tab[sel])
		timer.Simple(dur, function()
			self.ShouldResetSequence = true
		end)

		return self:ResetSequence(seq)
	end

	self.ShouldResetSequence = false

	if self:GetIdleAnim() == "" then
		for k, v in ipairs(self:GetSequenceList()) do
			if v:lower():find("idle") and v ~= "idlenoise" then
				return self:ResetSequence(k)
			end
		end
	else
		local seq, dur = self:LookupSequence(self:GetIdleAnim())

		return self:ResetSequence(seq)
	end

	if self:GetSequenceCount() > 1 then
		self:ResetSequence(4)
	end
end

if SERVER then
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

		if not self:CanTalkTo(activator) or hook.Run("CanPlayerUseVendor", activator) == false then
			if self.messages[VENDOR_NOTRADE] then
				activator:ChatPrint(self:GetDisplayName() .. ": " .. self.messages[VENDOR_NOTRADE])
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
		if self.money then
			self:SetMoney(self:GetMoney() + value)
		end
	end

	function ENT:TakeMoney(value)
		if self.money then
			self:GiveMoney(-value)
		end
	end

	function ENT:SetStock(uniqueID, value, character)
		if character then
			return ix.vendorStock.Set(character, self, uniqueID, value)
		end
		if not self.items[uniqueID][VENDOR_MAXSTOCK] then
			return
		end

		self.items[uniqueID] = self.items[uniqueID] or {}
		self.items[uniqueID][VENDOR_STOCK] = math.min(value, self.items[uniqueID][VENDOR_MAXSTOCK])

		net.Start("ixVendorAdvStock")
		net.WriteString(uniqueID)
		net.WriteUInt(self.items[uniqueID][VENDOR_STOCK], 16)
		local editors = {}
		for _, client in ipairs(self.receivers) do
			if IsValid(client) and client.ixVendorAdvEditing == self then
				editors[#editors + 1] = client
			end
		end
		net.Send(editors)
	end

	function ENT:AddStock(uniqueID, value, character)
		assert(character, "Stock changes require a character")
		local stock = self:GetStock(uniqueID, character)
		if stock == nil then
			return
		end

		return self:SetStock(uniqueID, stock + (value or 1), character)
	end

	function ENT:TakeStock(uniqueID, value, character)
		return self:AddStock(uniqueID, -(value or 1), character)
	end

	function ENT:SherpaAddStock(uniqueID, value, character)
		if not self.items[uniqueID] then
			self.items[uniqueID] = { nil, 0, VENDOR_SELLANDBUY, 100, 0, 0 }
		end

		return self:AddStock(uniqueID, value, character)
	end

	function ENT:SherpaTakeStock(uniqueID, value, character)
		return self:TakeStock(uniqueID, value, character)
	end

	function ENT:Think()
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

		if IsValid(bubble) then
			local realTime = RealTime()

			bubble:SetRenderOrigin(self:GetPos() + Vector(0, 0, 84 + math.sin(realTime * 3) * 0.05))
			bubble:SetRenderAngles(Angle(0, realTime * 100, 0))
		end

		self:DrawModel()
	end

	function ENT:PlayerNearby()
		for _, v in pairs(player.GetAll()) do
			if self:GetPos():Distance(v:GetPos()) < 200 then
				return true
			end
		end

		return false
	end

	function ENT:MakeNoise()
		local tab = ix.npctemplates.soundtemplates[self:GetSoundGroup()] or { "buttons/lever1.wav" }
		self:EmitSound(tab[math.random(1, #tab)])
	end

	function ENT:Think()
		local noBubble = self:GetNoBubble()

		if IsValid(self.bubble) and noBubble then
			self.bubble:Remove()
		elseif not IsValid(self.bubble) and not noBubble then
			self:CreateBubble()
		end

		if (self.nextAnimCheck or 0) < CurTime() or self.ShouldResetSequence then
			self:SetAnim()
			self.nextAnimCheck = CurTime() + 15
		end

		if ((self.nextNoise or 0) < CurTime()) and self:PlayerNearby() then
			self:MakeNoise()
			self:SetAnim()
			self.nextNoise = CurTime() + math.random(15, 45)
		end

		self:SetNextClientThink(CurTime())

		return true
	end

	function ENT:OnRemove()
		if IsValid(self.bubble) then
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

		if descriptionText ~= "" then
			local description = container:AddRow("description")
			description:SetText(self:GetDescription())
			description:SizeToContents()
		end
	end
end

function ENT:GetMoney()
	return self.money
end

function ENT:LoadTemplate(templateName)
	local template = ix.npctemplates.templates[templateName]

	if template ~= nil then
		self:SetModel(template.model or self.model)
		self:SetSkin(template.skin or 0)

		self:SetNoBubble(template.bubble or self:GetNoBubble())
		self:SetDisplayName(template.name or self:GetDisplayName())
		self:SetDescription(template.description or self:GetDescription())

		for id, bodygroup in pairs(template.bodygroups or {}) do
			self:SetBodygroup(id, bodygroup)
		end

		local items = {}

		if template.items then
			local vendorMult = ix.config.Get("VendorStockMult")

			for uniqueID, templateData in pairs(template.items) do
				local data = table.Copy(templateData)
				if data[2] ~= nil then
					data[2] = data[2] * vendorMult
				end

				if data[4] ~= nil then
					data[4] = data[4] * vendorMult
				end

				if data[6] ~= nil then
					data[6] = data[6] * vendorMult
				end

				items[tostring(uniqueID)] = data
			end
		end

		self.items = items
		self.factions = template.factions or self.factions
		self.classes = template.classes or self.classes
		self.money = template.money or self.money
		self.scale = template.scale or self.scale
		self:SetBuyAll(template.buyAll or self:GetBuyAll())
		self:SetSherpa(template.sherpa or self:GetSherpa())
		self.dialogueid = template.dialogueid or self.dialogueid
		self:SetSoundGroup(template.soundgroup or self:GetSoundGroup())
		self:SetAnimGroupId(template.animgroup or self:GetAnimGroupId())
		self:SetIdleAnim(template.idleanim or "")
	end
end

if SERVER then
	-- Any of these can be nil, except uniqueID
	function ENT:AddItemToList(uniqueID, setPrice, stock, mode, maxStock, restockInterval, restockAmount)
		if not self.items[uniqueID] then
			local TRADE_MODES = {
				["SELLANDBUY"] = 1,
				["SELLONLY"] = 2,
				["BUYONLY"] = 3,
			}

			self.items[uniqueID] = {
				setPrice,
				stock * ix.config.Get("VendorStockMult"),
				TRADE_MODES[mode],
				maxStock * ix.config.Get("VendorStockMult"),
				restockInterval,
				restockAmount * ix.config.Get("VendorStockMult"),
			}
		end
	end
end
