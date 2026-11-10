ix.dialogue = ix.dialogue or {}

function ix.dialogue.ConfigureMutantDefense(dialogue)
	if not dialogue.tree.TradeTopic then return end
	local function available(client, target)
		if not ix.mutantDefense or not IsValid(target) then return false end
		if target:GetClass() ~= "ix_vendor_adv" or target:GetSherpa() then return false end

		return client:GetCharacter() ~= nil
	end
	dialogue.addTopic("DefenseVoucher", {
		statement = "Hand over a restock voucher.",
		response = "",
		category = "trade",
		quickAction = true,
		ShouldAdd = function(_, client, target)
			if not available(client, target) then return false end

			return client:GetCharacter():GetInventory():HasItem("mutant_defense_voucher") and true or false
		end,
		postCallback = function(_, client, target)
			if SERVER and ix.mutantDefense then ix.mutantDefense:RedeemVoucher(client, target) end
		end,
		options = {"BackTopic"},
	})
	dialogue.addTopic("DefenseRewards", {
		statement = "Collect defense rewards.",
		response = "",
		category = "trade",
		quickAction = true,
		ShouldAdd = function(_, client, target)
			if not available(client, target) then return false end
			local state = client:GetCharacter():GetData("mutantDefenseRewards", {})

			return (state.pending or 0) > 0
		end,
		postCallback = function(_, client, target)
			if SERVER and ix.mutantDefense then ix.mutantDefense:CollectVouchers(client, target) end
		end,
		options = {"BackTopic"},
	})
	for _, id in ipairs({"GREETING", "BackTopic"}) do
		local root = dialogue.tree[id]
		if root then
			local options = {}
			for _, option in ipairs(root.options) do
				if option ~= "DefenseVoucher" and option ~= "DefenseRewards" then options[#options + 1] = option end
			end
			options[#options + 1], options[#options + 2] = "DefenseVoucher", "DefenseRewards"
			root.options = ix.dialogue.OrderOptions(options, true)
		end
	end
end
