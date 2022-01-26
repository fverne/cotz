ITEM.name = "Cassette"
ITEM.description = "A basic playable Cassette."
ITEM.category = "Cassette"
ITEM.model = "models/kek1ch/cassette_backkek.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 10000

ITEM.iconCam = {
	pos = Vector(0.40000000596046, 0, 200),
	ang = Angle(90, 0, -174.26751708984),
	fov = 2.3
}
ITEM.isCassette = true

ITEM.weight = 0.14

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description)
	else
        return (self.description..quantdesc..invdesc)
	end
end

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		if !self.entity then
			ix.util.PropertyDesc(tooltip, "Very Rare Item", Color(200, 200, 200))
			ix.util.PropertyDesc(tooltip, "Fits into cassette players", Color(200, 200, 200))
			ix.util.PropertyDesc2(tooltip, "Valuable", Color(218, 165, 32), Material("icon16/stalker/sell.png"))
		end
	end
end

ITEM.functions.insert = {
	name = "Insert into Target",
	icon = "icon16/stalker/attach.png",
	OnRun = function(item)
		local client = item.player
		local Hit = client:GetEyeTraceNoCursor()
		local entity = Hit.Entity
		local dist = client:GetPos():Distance(entity:GetPos())

		item.options = {}
		for k, v in pairs(item.cassette_options) do
			item.options[#item.options + 1] = k
		end

		if (entity:GetClass() == "ix_cassette_player") and (dist < 200) then
			if not (entity.PutCassette) then
				entity.sound = CreateSound( entity, table.Random(item.options))
				entity.sound:Play()
				entity.sound:SetSoundLevel(0)
				entity.PutCassette = item.uniqueID
				entity:EmitSound("stalkersound/inv_slot.mp3", 40)

				entity:Repeat(item.cassette_options)
			else
				return false
			end
		else
			return false
		end
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

