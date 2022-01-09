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

function Schema:OnItemSpawned(entity)
	entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	entity.OnTakeDamage = nil
end

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
			adminOnly = true,
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

--query, primarily used by simplecrossserver
if SERVER then
	local playerMeta = FindMetaTable("Player")

	function playerMeta:requestQuery(title, subTitle, callback)
		local time = math.floor(os.time())

		self.ixQueReqs = self.ixQueReqs or {}
		self.ixQueReqs[time] = callback

		netstream.Start(self, "qurReq", time, title, subTitle)
	end

	netstream.Hook("qurReq", function(client, time, bResponse)
		if (client.ixQueReqs and client.ixQueReqs[time]) then
			client.ixQueReqs[time](bResponse)
			client.ixQueReqs[time] = nil
		end
	end)
end

if CLIENT then
	netstream.Hook("qurReq", function(time, title, subTitle)
		if (title:sub(1, 1) == "@") then
			title = L(title:sub(2))
		end

		if (subTitle:sub(1, 1) == "@") then
			subTitle = L(subTitle:sub(2))
		end

		Derma_Query(subTitle, title, "Yes", function()
			netstream.Start("qurReq", time, true)
		end, "No", function()
			netstream.Start("qurReq", time, false)
		end)
	end)
end


function Schema:PlayerWeaponChanged(client, weapon)
	if (CLIENT) then
		return
	end
	-- If player already had weapon raised
	if (client:GetNetVar("keepraised",false)) then
		client:SetWepRaised(client:GetNetVar("keepraised",false), weapon)
		return true
	end
end

function Schema:PlayerSwitchWeapon(client, oldWeapon, weapon)
    if (not IsFirstTimePredicted()) then return end

    if (SERVER) then
        if IsValid(client:GetActiveWeapon()) then
            if client:Alive() and client:GetActiveWeapon():GetClass() == "ix_hands" then
                client:SetWepRaised(true, weapon)
            end

            client:SetNetVar("keepraised", client:IsWepRaised())
        end
    end
end

-- To make sure suit attachments get their detach function run when character disconnects
function Schema:OnCharacterDisconnect(client, character)
	local armor = client:getEquippedBodyArmor()
	if(armor and armor.RunAllAttachmentDetach) then
		armor:RunAllAttachmentDetach()
	end
end
