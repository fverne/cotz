local PLUGIN = PLUGIN
PLUGIN.name = "Perks"
PLUGIN.author = "Verne"
PLUGIN.desc = "Perks that can be added to a character.."

ix.command.Add("CharSetPerk", {
	description = "@cmdCharSetPerk",
	privilege = "Manage Character Attributes",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, target, perkName, level)
		for k, v in pairs(ix.perks.list) do
			if (ix.util.StringMatches(L(v.name, client), perkName) or ix.util.StringMatches(k, perkName)) then
				target:SetPrk(k, math.abs(level))
				return "@attributeSet", target:GetName(), L(v.name, client), math.abs(level)
			end
		end

		return "Perk not found!"
	end
})

ix.command.Add("CharAddPerk", {
	description = "@cmdCharAddPerk",
	privilege = "Manage Character Attributes",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, target, perkName, level)
		for k, v in pairs(ix.perks.list) do
			if (ix.util.StringMatches(L(v.name, client), perkName) or ix.util.StringMatches(k, perkName)) then
				target:UpdatePrk(k, math.abs(level))
				return "Perk Updated", target:GetName(), L(v.name, client), math.abs(level)
			end
		end

		return "Perk not found!"
	end
})

function PLUGIN:PostPlayerLoadout(client)
	ix.perks.Setup(client)
end

ix.config.Add("maxPerks", 5, "The total maximum amount of Perk points allowed.", nil, {
	data = {min = 0, max = 250},
	category = "characters"
})

ix.char.RegisterVar("perks", {
	field = "perks",
	fieldType = ix.type.text,
	default = {},
	index = 5,
	category = "attributes",
	isLocal = true,
	OnDisplay = function(self, container, payload)
		local maximum = hook.Run("GetDefaultPerkPoints", LocalPlayer(), payload) or ix.config.Get("maxPerks", 30)

		if (maximum < 1) then
			return
		end

		local perks = container:Add("DPanel")
		perks:Dock(TOP)

		local y
		local total = 0

		payload.perks = {}

		-- total spendable attribute points
		local totalBar = perks:Add("ixAttributeBar")
		totalBar:SetMax(2)
		totalBar:SetValue(2)
		totalBar:Dock(TOP)
		totalBar:DockMargin(2, 2, 2, 2)
		totalBar:SetText("Perk points left:".." ("..totalBar:GetValue()..")")
		totalBar:SetReadOnly(true)
		totalBar:SetColor(Color(20, 120, 20, 255))

		y = totalBar:GetTall() + 4

		for k, v in SortedPairsByMemberValue(ix.perks.list, "name") do
			payload.perks[k] = 0

			local bar = perks:Add("ixAttributeBar")
			bar:SetMax(maximum)
			bar:Dock(TOP)
			bar:DockMargin(2, 2, 2, 2)
			bar:SetText(L(v.name))
			bar.OnChanged = function(this, difference)
				if ((total + difference) > maximum) then
					return false
				end

				total = total + difference
				payload.perks[k] = payload.perks[k] + difference

				totalBar:SetValue(totalBar.value - difference)
				totalBar:SetText("Perk Points left:".." ("..totalBar:GetMax()-total..")")
			end

			if (v.noStartBonus) then
				bar:SetReadOnly()
			end

			y = y + bar:GetTall() + 4
		end

		perks:SetTall(y)
		return perks
	end,
	OnValidate = function(self, value, data, client)
		if (value != nil) then
			if (istable(value)) then
				local count = 0

				for _, v in pairs(value) do
					count = count + v
				end

				if (count > (hook.Run("GetDefaultPerkPoints", client, count) or ix.config.Get("maxPerks", 30))) then
					return false, "unknownError"
				end
			else
				return false, "unknownError"
			end
		end
	end,
	ShouldDisplay = function(self, container, payload)
		return true --!table.IsEmpty(ix.perks.list)
	end
})