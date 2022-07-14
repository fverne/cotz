local PLUGIN = PLUGIN
PLUGIN.name = "Addictions"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Adds periodically checked addictions."

local ADDICTION_STATE_OK = 1
local ADDICTION_STATE_NEED = 2
local ADDICTION_STATE_WITHDRAWAL = 4
local ADDICTION_STATE_HEAVYWITHDRAWAL = 8
local ADDICTION_STATE_WORSTWITHDRAWAL = 11

PLUGIN.addictionInterval = 300
PLUGIN.addictionTickInterval = 30

PLUGIN.addictionDefinitions = PLUGIN.addictionDefinitions or {}

ix.util.Include("sh_definitions.lua")

ix.char.RegisterVar("addictions", {
	field = "addictions",
	fieldType = ix.type.string,
	default = {},
	bNoDisplay = true,
})

--Unsure if this is the best way to do it, using data for now
--[[
ix.char.RegisterVar("addictions_nextcheck", {
	field = "addictions_nextcheck",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
})]]

local playerMeta = FindMetaTable("Player")

if SERVER then

	local updateinterval = CurTime() + PLUGIN.addictionTickInterval

	function PLUGIN:OnCharacterCreated(client, character)
		character:SetData("addictions_nextcheck", os.time() + self.addictionInterval*2) -- Little extra leeway when you're just starting out
	end

	function PLUGIN:CharacterLoaded(character)
		if(character:GetData("addictions_nextcheck", 0) < os.time()) then
			character:SetData("addictions_nextcheck", os.time() + self.addictionInterval/2)
		end
	end

	-- Dont actually know what this was supposed to do
	function playerMeta:CheckAddiction(addictionname)
		local char = self:GetCharacter()

		if (char) then

		end
	end

	function PLUGIN:Think()
		if updateinterval < CurTime() then

			for _,ply in pairs( player.GetAll()) do
				local char = ply:GetCharacter()

				if char then
					local addictions = char:GetAddictions()

					if not table.IsEmpty(addictions) then
						for k,v in pairs(addictions) do
							PLUGIN.addictionDefinitions[k].tickFunction(ply, v)

							if char:GetData("addictions_nextcheck", 0) < os.time() and PLUGIN.addictionDefinitions[k].checkChance > math.random(1,100) then
								PLUGIN.addictionDefinitions[k].updateFunction(ply, v, v+1)
								addictions[k] = math.Clamp(v+1, ADDICTION_STATE_OK, ADDICTION_STATE_WORSTWITHDRAWAL)
								
							end
						end
					end

					char:SetAddictions(addictions)

					if char:GetData("addictions_nextcheck", 0) < os.time() then
						char:SetData("addictions_nextcheck", os.time() + self.addictionInterval)
					end
				end
			end

			updateinterval = CurTime() + self.addictionTickInterval
		end
	end
end

function playerMeta:GetAddictionLevel(addictionname)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetAddictions()

		if addictions[addictionname] then
			return addictions[addictionname]
		end
	end

	return 0
end

function playerMeta:SatisfyAddictions(satisfyString)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetAddictions()
		
		if not table.IsEmpty(addictions) then
			for addictionName,v in pairs(addictions) do
				if v > ADDICTION_STATE_OK then
					for _, satstruct in pairs(PLUGIN.addictionDefinitions[addictionName].satisfyStruct) do
						if satstruct[1] == satisfyString and satstruct[2] > math.random(1,100) then
							PLUGIN.addictionDefinitions[addictionName].updateFunction(self, v, v-(satstruct[3] or 1))

							addictions[addictionName] = math.Clamp(v-(satstruct[3] or 1), ADDICTION_STATE_OK, ADDICTION_STATE_WORSTWITHDRAWAL)
						end
					end
				end
			end

			char:SetAddictions(addictions)
		end
	end
end

function playerMeta:AddAddiction(addictionname)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetAddictions()

		addictions[addictionname] = ADDICTION_STATE_OK

		char:SetAddictions(addictions)
	end
end

function playerMeta:RemoveAddiction(addictionname)
	local char = self:GetCharacter()

	if char then
		local addictions = char:GetAddictions()

		addictions[addictionname] = nil

		char:SetAddictions(addictions)
	end
end

local charMeta = ix.meta.character or {}

function charMeta:SatisfyAddictions(addictionname)
	if( self:GetPlayer() ) then self:GetPlayer():SatisfyAddictions(addictionname) end
end

function charMeta:GetAddictionLevel(addictionname)
	if( self:GetPlayer() ) then return self:GetPlayer():GetAddictionLevel() end

	return 0
end