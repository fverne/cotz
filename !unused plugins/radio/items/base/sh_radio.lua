ITEM.name = "Radio Base"
ITEM.model = "models/deadbodies/dead_male_civilian_radio.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Communication"
ITEM.price = 150
ITEM.permit = "elec"
ITEM.frequency = "base"
ITEM.isRadio = true

function ITEM:GetDescription()
	return "A radio that encourages long range communication between individuals\nThis radio is currently set to transmit on: " .. self.frequency
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("power", false)) then
			surface.SetDrawColor(110, 255, 110, 100)
		else
			surface.SetDrawColor(255, 110, 110, 100)
		end

		surface.DrawRect(w - 14, h - 14, 8, 8)
	end

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	local COLOR_ACTIVE = Color(0, 255, 0)
	local COLOR_INACTIVE = Color(255, 0, 0)

	function ITEM:drawEntity(entity, item)
		entity:DrawModel()
		local rt = RealTime()*100
		local position = entity:GetPos() + entity:GetForward() * 0 + entity:GetUp() * 2 + entity:GetRight() * 0

		if (entity:GetData("power", false) == true) then
			if (math.ceil(rt/14)%10 == 0) then
				render.SetMaterial(GLOW_MATERIAL)
				render.DrawSprite(position, rt % 14, rt % 14, entity:GetData("power", false) and COLOR_ACTIVE or COLOR_INACTIVE)
			end
		end
	end
end

function ITEM:OnTransferred(curInv, inventory)
	--I'm not really sure how to make sure it's not the ground otherwise.
	if curInv:GetID() != 0 then
		data = curInv:GetOwner():GetCharacter():GetData("freq", {})

		if table.HasValue(data, self.frequency) then
			table.RemoveByValue(data, self.frequency)
			curInv:GetOwner():GetCharacter():SetData("freq", data)
			curInv:GetOwner():SetNetVar("freq", data)
		end
	end
end
ITEM.functions.toggle = { -- sorry, for name order.
	name = "Switch Power",
	tip = "useTip",
	icon = "icon16/connect.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()
		if not char:GetInventory():HasItem(item.uniqueID) then
			return false
		end
		item:SetData("power", !item:GetData("power", false), player.GetAll(), false, true)
		item.player:EmitSound("buttons/button14.wav", 70, 150)
		item:SetData("freq", item.frequency)
		--print("toggle")
		if item:GetData("power", false) == true then
			
			local freqs = char:GetData("freq", {})
			table.insert(freqs, item.frequency)
			char:SetData("freq", freqs)
			item.player:SetNetVar("freq", freqs)
			if not char:GetData("curfreq") then
				char:SetData("curfreq", item.frequency)
				item.player:SetNetVar("curfreq", item.frequency)
			end
		end

		if item:GetData("power", false) == false then
			local char = item.player:GetCharacter()
			local freqs = char:GetData("freq", {})
			table.RemoveByValue(freqs, item.frequency)
			char:SetData("freq", freqs)
			item.player:SetNetVar("freq", freqs)
		end
		return false
	end,
}

ITEM.functions.setmaintransmit = { -- sorry, for name order.
	name = "Set as Primary Radio",
	tip = "useTip",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()
		if not char:GetInventory():HasItem(item.uniqueID) then
			return false
		end
		if not item:GetData("power", false) then
			item.player:Notify("You need to turn your radio on first!")

			return false
		else
			item.player:SetNetVar("curfreq", item.frequency)
			char:SetData("curfreq", item.frequency)
		end
		return false
	end,
}


--[[ITEM.functions.use = { -- sorry, for name order.
	name = "Freq",
	tip = "useTip",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		netstream.Start(item.player, "radioAdjust", item:GetData("freq", "000,0"), item.id)

		return false
	end,
}--]]
