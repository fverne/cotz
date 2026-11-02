local META = ix.squad.meta or ix.middleclass("ix_squad")
META.__index = META

META.name = META.name or "ERROR"
META.members = META.members or {}

function META:__tostring()
	return "squad["..self.owner.."]["..self.name.."]"
end

function META:Initialize(owner, name)
	self.owner = owner
	self.name = name

	self.members = {}
	self.memberInfo = {}
end

function META:GetReceivers()
	local receivers = {}

	for _, v in ipairs(player.GetHumans()) do
		local character = v:GetCharacter()

		if (character and character:GetSquadID() == self.owner and self.members[character:GetID()] ~= nil) then
			receivers[#receivers + 1] = v
		end
	end

	return receivers
end

function META:GetRank(client)
	local character = IsValid(client) and client:GetCharacter()
	return character and self.members[character:GetID()]
end

function META:IsLeader(client)
	local character = IsValid(client) and client:GetCharacter()
	return character and self.leaderID == character:GetID()
end

if (SERVER) then
	function META:CollectData()
		return {
			owner = self.owner,
			leaderID = self.leaderID,
			memberInfo = self.memberInfo,
			name = self.name,
			members = self.members,
			color = self.color,
			description = self.description
		}
	end

	function META:Sync(client, bSetColor)
		for _, member in ipairs(self:GetReceivers()) do
			local character = member:GetCharacter()
			local color = self.color or Color(105, 139, 87)
			local current = character:GetSquadColor()
			if (current.r ~= color.r or current.g ~= color.g or current.b ~= color.b) then
				character:SetSquadColor(color)
			end


			if (character and character:GetSquadID() == self.owner and character:GetSquadName() ~= self.name) then
				character:SetSquadName(self.name)
			end
		end

		for characterID in pairs(self.members) do
			local character = ix.char.loaded[characterID]

			if (character and not (ix.squad.cross and ix.squad.cross.Enabled())) then
				self.memberInfo[characterID] = {name = character:GetName(), pdaavatar = character:GetPdaavatar()}
			end
		end

		local receivers

		if (IsValid(client)) then
			if (self:GetRank(client) == nil) then return end
			receivers = {client}
		else
			receivers = self:GetReceivers()

			if (#receivers == 0) then
				receivers = nil
			end
		end

		if (!receivers) then return end

		if (bSetColor and (self.hasColor or ix.util.IsColor(self.color))) then
			self.hasColor = true

			for _, v in ipairs(receivers) do
				if (v:Alive()) then
					v:SetPlayerColor(Vector(self.color.r / 255, self.color.g / 255, self.color.b / 255))
				end
			end
		end

		net.Start("ixSquadSync")
			net.WriteTable(self:CollectData())
		net.Send(receivers)
	end
end

ix.squad.meta = META
