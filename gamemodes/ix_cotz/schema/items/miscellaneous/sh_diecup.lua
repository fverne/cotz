ITEM.name = "Cup of dice"
ITEM.description = "A cup of dice"
ITEM.longdesc = "A plastic container with a blue lid on the top that contains a total of 6 dices inside. The dices appear to have circles representing numbers on each face of an individual die. Many STALKERS tend to keep a cup of dice on them just in case they wish to entertain themselves, gamble with them or settle a dispute with a good game of dice."
ITEM.model = "models/lostsignalproject/items/misc/jar.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.price = 300

ITEM.maxDie = 6

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("diecount")) then
			draw.SimpleText("d:"..item:GetData("diecount", 1), "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end
	end
end

ITEM.functions.Roll = {
	icon = "icon16/stalker/dice.png",
	sound = "stalkersound/inv_slot.mp3",
	OnRun = function(item)
		local client = item.player
		local resultsum = 0
		local resultstr = ""
		for i = 1, item:GetData("diecount", 1) do
			local randommeme = math.random(1,6)
			resultsum = resultsum+randommeme
			resultstr = resultstr.." "..randommeme
			if i ~= item:GetData("diecount", 1) then
				if i == (item:GetData("diecount", 1) - 1) then
					resultstr = resultstr.." and a"
				else
					resultstr = resultstr..","
				end
			end
		end

		if item:GetData("diecount", 1) > 1 then
			resultstr = resultstr.." for a total of "..resultsum
		end

		ix.chat.Send(client, "iteminternal", "rolls the dice and gets a"..resultstr.."." , false)
		return false
	end,
}

ITEM.functions.Amount = {
	icon = "icon16/coins.png",
	sound = "physics/body/body_medium_impact_soft1.wav",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
        local tempName
		for i=1,item.maxDie do
			if i == 1 then
					tempName = i.." die"
			else
					tempName = i.." dice"
			end
			table.insert(targets, {
				name = tempName,
				data = {i} ,
			})
		end

		return targets
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end,
	OnRun = function(item, data)
		if !data[1] then
			return false
		end

		item:SetData("diecount", data[1])

		return false
	end,
}

function ITEM:OnInstanced(invID, x, y)
	if !self:GetData("diecount") then
		self:SetData("diecount", 1)
	end
end
