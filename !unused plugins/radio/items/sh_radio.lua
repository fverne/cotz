ITEM.name = "Handheld Radio"
ITEM.model = "models/hgn/srp/items/radio.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 150
--ITEM.busflag = "MERCH4"
ITEM.busflag = {"hardware2"}

local function getText(togga)
	if (togga) then
		return "<color=39, 174, 96>" .. L"on" .. "</color>"
	else
		return "<color=192, 57, 43>" .. L"off" .. "</color>"
	end
end

function ITEM:getDesc()
	local str
	
	if (!self.entity or !IsValid(self.entity)) then
		str = "A handheld radio, used for two-way communication. \nPower: %s\nFrequency: %s"
		return Format(str, (self:getData("power") and "On" or "Off"), self:getData("freq", "000.0"))
	else
		local data = self.entity:getData()
		
		str = "A handheld radio, used for two-way communication. Power: %s Frequency: %s"
		return Format(str, (self.entity:getData("power") and "On" or "Off"), self.entity:getData("freq", "000.0"))
	end
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("power", false)) then
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

		if (entity:getData("power", false) == true) then
			if (math.ceil(rt/14)%10 == 0) then
				render.SetMaterial(GLOW_MATERIAL)
				render.DrawSprite(position, rt % 14, rt % 14, entity:getData("power", false) and COLOR_ACTIVE or COLOR_INACTIVE)
			end
		end
	end
end

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.toggle = { -- sorry, for name order.
	name = "Toggle",
	tip = "useTip",
	icon = "icon16/stalker/accept.png",
	onRun = function(item)
		item:setData("power", !item:getData("power", false), nil, nil)
		item.player:EmitSound("buttons/button14.wav", 70, 150)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

ITEM.functions.use = { -- sorry, for name order.
	name = "Freq",
	tip = "useTip",
	icon = "icon16/stalker/customize.png",
	onRun = function(item)
		netstream.Start(item.player, "radioAdjust", item:getData("freq", "000,0"), item.id)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
