local PLUGIN = PLUGIN
PLUGIN.name = "Addictions"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Adds periodically checked addictions."

local ADDICTION_STATE_OK = 1
local ADDICTION_STATE_NEED = 2
local ADDICTION_STATE_WITHDRAWAL = 3
local ADDICTION_STATE_HEAVYWITHDRAWAL = 4

PLUGIN.addictionInterval = 600
PLUGIN.addictionTickInterval = 30


ix.util.Include("sh_definitions.lua")

local playerMeta = FindMetaTable("Player")

if SERVER then

	local updateinterval = CurTime() + PLUGIN.addictionTickInterval

	function PLUGIN:OnCharacterCreated(client, character)
		character:SetData("addictions_nextcheck", os.time() + self.addictionInterval*2) -- Little extra leeway when you're just starting out
	end

	function PLUGIN:CharacterLoaded(character)
		if(character:GetData("addictions_nextcheck") < os.time()) then
			character:SetData("addictions_nextcheck", os.time() + self.addictionInterval/2)
		end
	end

	function playerMeta:CheckAddiction(addictionname)
		local char = self:GetCharacter()

		if (char) then

		end
	end

	function PLUGIN:Think()
		local checktime = false
		if character:GetData("addictions_nextcheck") < os.time() then checktime = true end

		if updateinterval < CurTime() then

			for _,ply in pairs( player.GetAll()) do
				local char = ply:GetCharacter()

				if char then
					local addictions = char:GetData("addictions", {})

					if not addictions.IsEmpty() then
						for k,v in pairs(addictions) do
							PLUGIN.addictionDefinitions[k].tickFunction(ply, v)

							if checktime and PLUGIN.addictionDefinitions[k].checkChance > math.random(1,100) then
								PLUGIN.addictionDefinitions[k].updateFunction(ply, v, v+1)
								addictions[k] = math.Clamp(v+1, ADDICTION_STATE_OK, ADDICTION_STATE_HEAVYWITHDRAWAL)
							end
						end
					end

					char:SetData("addictions", addictions)
				end
			end

			updateinterval = CurTime() + self.addictionTickInterval
			if checktime then
				character:SetData("addictions_nextcheck", os.time() + self.addictionInterval)
			end
		end
	end
end

function playerMeta:GetAddictionLevel(addictionname)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetData("addictions", {})

		if not addictions.IsEmpty() then
			for k,v in pairs(addictions) do
				if k = addictionname then
					return v
				end
			end
		end
	end
end

function playerMeta:SatisfyAddictions(satisfyString)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetData("addictions", {})

		if not addictions.IsEmpty() then
			for addictionName,v in pairs(addictions) do
				if v > ADDICTION_STATE_OK then
					for _, satstruct in pairs(PLUGIN.addictionDefinitions[addictionName].satisfyStruct) do
						if satstruct[1] == satisfyString and satstruct[2] > math.random(1,100) then
							PLUGIN.addictionDefinitions[addictionName].updateFunction(ply, v, v-1)

							addictions[addictionName] = math.Clamp(v-1, ADDICTION_STATE_OK, ADDICTION_STATE_HEAVYWITHDRAWAL)
						end
					end
				end
			end

			char:SetData("addictions", addictions)
		end
	end
end

function playerMeta:AddAddiction(addictionname)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetData("addictions", {})

		addictions[addictionname] = ADDICTION_STATE_OK

		char:SetData("addictions", addictions)
	end
end

function playerMeta:RemoveAddiction(addictionname)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetData("addictions", {})

		addictions[addictionname] = nil

		char:SetData("addictions", addictions)
	end
end