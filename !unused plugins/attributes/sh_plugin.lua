local PLUGIN = PLUGIN
PLUGIN.name = "Rollable Attributes"
PLUGIN.author = "Verne"
PLUGIN.desc = "Attributes used for rolling in various situations."

ix.command.Add("RollStat20", {
	syntax = "<stat>",
	description = "Rolls and adds a bonus for the stat provided",
	arguments = {
		ix.type.text
	},
	OnRun = function(self, client, stat)
		local character = client:GetCharacter()

		if (character and character:GetAttribute(stat, 0)) then
			local bonus = character:GetAttribute(stat, 0)
			local roll = tostring(math.random(0, 20))

			ix.chat.Send(client, "roll", (roll + bonus).." ( "..roll.." + "..bonus.." )", nil, nil, { --tostring(math.random(0, 100))
				max = 20
			})
		end
	end
})

if (SERVER) then
	function PLUGIN:GetPlayerPunchDamage(client, damage, context)
		if (client:GetCharacter()) then
			-- Add to the total fist damage.
			context.damage = context.damage + (client:GetCharacter():GetAttribute("str", 0) * ix.config.Get("strengthMultiplier"))
		end
	end

	function PLUGIN:KeyPress(client, key)
		if (key == IN_JUMP) then
			if (client:OnGround()) then
				local current = client:GetLocalVar("stm", 0)
				local value = math.Clamp(current - 20, -5, 100)

				client:SetLocalVar("stm", value)
			end
		end
	end
end

-- Configuration for the plugin
ix.config.Add("strengthMultiplier", 0.3, "The strength multiplier scale", nil, {
	data = {min = 0, max = 1.0, decimals = 1},
	category = "Strength"
})
