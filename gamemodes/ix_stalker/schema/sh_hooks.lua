
-- Here is where all of your shared hooks should go.

-- Disable entity driving.
function Schema:CanDrive(client, entity)
	return false
end

function Schema:CanPlayerUseBusiness(client, uniqueID)
	if !client:GetCharacter():HasFlags("1") then
    	return false
    end
end

function Schema:PlayerNoClip(client)
	if client:IsAdmin() or client:GetCharacter():HasFlags("N") then
		return true
	else
		return false
	end
end

function Schema:ShouldShowPlayerOnScoreboard(client)
	if client:GetCharacter():GetFaction() == FACTION_ADMINS then
		return false
	end
end

if SERVER then
	local playerMeta = FindMetaTable("Player")

	function playerMeta:requestQuery(title, subTitle, callback)
		local time = math.floor(os.time())

		self.nutQueReqs = self.nutQueReqs or {}
		self.nutQueReqs[time] = callback

		netstream.Start(self, "qurReq", time, title, subTitle)
	end
end


ix.command.Add("CharFallOver", {
	description = "disabled",
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnRun = function(self, client, time)
 		return
	end
})

do
	hook.Add("InitializedConfig", "ixMoneyCommands", function()
		local MONEY_NAME = string.gsub(ix.util.ExpandCamelCase(ix.currency.plural), "%s", "")

		ix.command.Add("Give" .. MONEY_NAME, {
			alias = {"GiveMoney"},
			description = "@cmdGiveMoney",
			arguments = ix.type.number,
			OnRun = function(self, client, amount)
				amount = math.floor(amount)

				if (amount <= 0) then
					return L("invalidArg", client, 1)
				end

				local data = {}
					data.start = client:GetShootPos()
					data.endpos = data.start + client:GetAimVector() * 96
					data.filter = client
				local target = util.TraceLine(data).Entity

				if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
					if (!client:GetCharacter():HasMoney(amount)) then
						return
					end

					target:GetCharacter():GiveMoney(amount)
					client:GetCharacter():TakeMoney(amount)

					target:NotifyLocalized("moneyTaken", ix.currency.Get(amount))
					client:NotifyLocalized("moneyGiven", ix.currency.Get(amount))
				end
			end
		})

		ix.command.Add("CharSet" .. MONEY_NAME, {
			alias = {"CharSetMoney"},
			description = "@cmdCharSetMoney",
			superAdminOnly = true,
			arguments = {
				ix.type.character,
				ix.type.number
			},
			OnRun = function(self, client, target, amount)
				amount = math.Round(amount)

				if (amount <= 0) then
					return "@invalidArg", 2
				end

				target:SetMoney(amount)
				client:NotifyLocalized("setMoney", target:GetName(), ix.currency.Get(amount))
			end
		})

		ix.command.Add("Drop" .. MONEY_NAME, {
			arguments = {
				ix.type.number
			},
			alias = {"DropMoney"},
			OnRun = function(self, client, amount)
				local amount = tonumber(amount)

				if (!amount or !isnumber(amount) or amount < 1) then
					return "@invalidArg", 1
				end

				if (!client:GetCharacter():HasMoney(amount)) then
					return "@insufficientMoney"
				end

				amount = math.Clamp(math.Round(amount),1,500000000)

				client:GetCharacter():TakeMoney(amount)
				ix.item.Spawn("bagrubles", client:GetItemDropPos(), nil, AngleRand(), {["quantity"] = amount})
			end
		})
	end)
end