ITEM.name = "База для кассет"
ITEM.desc = "Обычная кассета. На нее записано несколько треков от ТрипПила, Лизера, Флеша и Фейса. Можно сказать, что ее бывший вледелец «шарил»."
ITEM.category = "Кассета"
ITEM.price = 10000
ITEM.model = "models/kek1ch/cassette_backkek.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.40000000596046, 0, 200),
	ang = Angle(90, 0, -174.26751708984),
	fov = 2.3
}
ITEM.weight = 0.14
ITEM.isCassette = true

function ITEM:GetDescription()
	local description = self.desc
	description = description.."\n\nХАРАКТЕРИСТИКИ:\n-рекдкая вещь\n-повсеместное применение\n\nПри активации необходимо смотреть на проигрыватель"
	return description
end

ITEM.functions.View = {
	name = "воспроизвести",
	OnRun = function(item)
		local client = item.player
		local Hit = client:GetEyeTraceNoCursor()
		local entity = Hit.Entity
		local dist = client:GetPos():Distance(entity:GetPos())

		item.options = {}
		for k, v in pairs(item.cassette_options) do
			item.options[#item.options + 1] = k
		end

		if (entity:GetClass() == "nut_cassette_player") and (dist < 200) then
			if not (entity.PutCassette) then
				entity.sound = CreateSound( entity, table.Random(item.options))
				entity.sound:Play()
				entity.sound:SetSoundLevel(0)
				entity.PutCassette = item.uniqueID

				entity:Repeat(item.cassette_options)
			else
				return false
			end
		else
			return false
		end
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

