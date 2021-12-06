local PLUGIN = PLUGIN
PLUGIN.name = "Cassette Player"
PLUGIN.author = "Kek1ch"
PLUGIN.desc = "Playable tapes from cassette players."

function PLUGIN:LoadData()
	data = self:GetData()

	for k, v in ipairs(data or {}) do
		local entity = ents.Create("ix_cassette_player")
		entity:SetPos(v.pos)
		entity:SetAngles(v.angles)
		entity:Spawn()
		entity.PutCassette = v.PutCassette
	end
end

function PLUGIN:SaveData()
	local data = {}
	for k, v in ipairs(ents.FindByClass("ix_cassette_player")) do
		data[#data + 1] = {
			pos = v:GetPos(),
			angles = v:GetAngles(),
			PutCassette = v.PutCassette,
		}
	end

	self:SetData(data)
end