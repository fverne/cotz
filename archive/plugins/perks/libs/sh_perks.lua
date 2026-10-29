
if (!ix.char) then
	include("sh_character.lua")
end

ix.perks = ix.perks or {}
ix.perks.list = ix.perks.list or {}

function ix.perks.LoadFromDir(directory)
	for _, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)

		PERK = ix.perks.list[niceName] or {}
			if (PLUGIN) then
				PERK.plugin = PLUGIN.uniqueID
			end

			ix.util.Include(directory.."/"..v)

			PERK.name = PERK.name or "Unknown"
			PERK.description = PERK.description or "No description availalble."

			ix.perks.list[niceName] = PERK
		PERK = nil
	end
end

function ix.perks.Setup(client)
	local character = client:GetCharacter()

	if (character) then
		for k, v in pairs(ix.perks.list) do
			if (v.OnSetup) then
				v:OnSetup(client, character:GetPerk(k, 0))
			end
		end
	end
end

-- Add updating of perks to the character metatable.
do
	local charMeta = ix.meta.character

	if (SERVER) then
		util.AddNetworkString("ixPerkUpdate")

		function charMeta:UpdatePrk(key, value)
			local perk = ix.perks.list[key]
			local client = self:GetPlayer()

			if (perk) then
				local prk = self:GetPerks()

				prk[key] = math.min((prk[key] or 0) + value, perk.maxValue or ix.config.Get("maxPerks", 30))

				if (IsValid(client)) then
					net.Start("ixPerkUpdate")
						net.WriteUInt(self:GetID(), 32)
						net.WriteString(key)
						net.WriteFloat(prk[key])
					net.Send(client)

					if (perk.Setup) then
						perk.Setup(prk[key])
					end
				end

				self:SetPerks(prk)
			end

			hook.Run("CharacterPerkUpdated", client, self, key, value)
		end

		function charMeta:SetPrk(key, value)
			local perk = ix.perks.list[key]
			local client = self:GetPlayer()

			if (perk) then
				local prk = self:GetPerks()

				prk[key] = value

				if (IsValid(client)) then
					net.Start("ixPerkUpdate")
						net.WriteUInt(self:GetID(), 32)
						net.WriteString(key)
						net.WriteFloat(prk[key])
					net.Send(client)

					if (perk.Setup) then
						perk.Setup(prk[key])
					end
				end

				self:SetPerks(prk)
			end

			hook.Run("CharacterPerkUpdated", client, self, key, value)
		end

		function charMeta:AddPerkBoost(boostID, prkID, boostAmount)
			local boosts = self:GetVar("boosts", {})

			boosts[prkID] = boosts[prkID] or {}
			boosts[prkID][boostID] = boostAmount

			hook.Run("CharacterPerkBoosted", self:GetPlayer(), self, prkID, boostID, boostAmount)

			return self:SetVar("boosts", boosts, nil, self:GetPlayer())
		end

		function charMeta:RemovePerkBoost(boostID, prkID)
			local boosts = self:GetVar("boosts", {})

			boosts[prkID] = boosts[prkID] or {}
			boosts[prkID][boostID] = nil

			hook.Run("CharacterPerkBoosted", self:GetPlayer(), self, prkID, boostID, true)

			return self:SetVar("boosts", boosts, nil, self:GetPlayer())
		end
	else
		net.Receive("ixPerkUpdate", function()
			local id = net.ReadUInt(32)
			local character = ix.char.loaded[id]

			if (character) then
				local key = net.ReadString()
				local value = net.ReadFloat()

				character:GetPerks()[key] = value
			end
		end)
	end

	function charMeta:GetPerkBoost(prkID)
		local boosts = self:GetBoosts()

		return boosts[prkID]
	end

	function charMeta:GetPerkBoosts()
		return self:GetVar("boosts", {})
	end

	function charMeta:GetPerk(key, default)
		local prk = self:GetPerks()[key] or default
		local boosts = self:GetBoosts()[key]

		if (boosts) then
			for _, v in pairs(boosts) do
				prk = prk + v
			end
		end

		return prk
	end
end

hook.Add("DoPluginIncludes", "ixPerksLib", function(path)
	ix.perks.LoadFromDir(path.."/perks")
end)
