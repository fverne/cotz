local PLUGIN = PLUGIN
local BUFF_NAME = "buff_bandageclotting"

local function isPositive(value)
	return type(value) == "number" and value == value and value > 0 and value < math.huge
end

function PLUGIN:ProcessBandageClotting(client, now)
	local buff = client:HasBuff(BUFF_NAME)
	if not buff then return end
	local parameters = buff[2]
	if type(parameters) ~= "table" or not isPositive(parameters.amount)
		or not isPositive(parameters.remaining) then return end
	if not client:Alive() or client.cotzClottingCharacter ~= client:GetCharacter() then return end

	now = math.min(now or CurTime(), buff[1])
	local elapsed = math.max(now - (client.cotzClottingTime or now), 0)
	client.cotzClottingTime = now
	local reduction = math.min(elapsed * parameters.amount, parameters.remaining)
	parameters.remaining = math.max(parameters.remaining - reduction, 0)
	self:HealBleeding(client, reduction)
end

function PLUGIN:StartBandageClotting(client, total, duration)
	if not client:Alive() or not client:GetCharacter() then return false end
	if not isPositive(total) or not isPositive(duration) then return false end

	self:ProcessBandageClotting(client)
	local buff = client:HasBuff(BUFF_NAME)
	local rate = total / duration
	if not isPositive(rate) then return false end
	if buff and buff[1] > CurTime() and type(buff[2]) == "table"
		and isPositive(buff[2].amount) and buff[2].amount > rate then return false end

	client:AddBuff(BUFF_NAME, duration, {amount = rate, remaining = total})
	client.cotzClottingTime = CurTime()
	client.cotzClottingCharacter = client:GetCharacter()

	return true
end
