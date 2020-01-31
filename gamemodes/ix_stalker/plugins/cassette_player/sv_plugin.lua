local PLUGIN = PLUGIN

netstream.Hook("StartPlayMusicCar", function(client, data)
	local entity = client:GetVehicle()
	local item = ix.item.list[data]

	if entity.sound then
		entity.sound:Stop()
	end

	item.options = {}
	for k, v in pairs(item.cassette_options) do
		item.options[#item.options + 1] = k
	end

	entity.CurCassette = data
	entity.sound = CreateSound(entity, table.Random(item.options))
	entity.sound:Play()
	entity.sound:SetSoundLevel(0)
	--entity:Repeat(item.cassette_options)
end)

netstream.Hook("StopCarRadioPlz", function(client)
	local entity = client:GetVehicle()
	if entity.sound then
		entity.sound:Stop()
	end
end)


