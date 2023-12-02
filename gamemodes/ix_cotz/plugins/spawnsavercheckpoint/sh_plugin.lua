local PLUGIN = PLUGIN

PLUGIN.name = "Spawnsaver"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "An entity that allows you to set your spawn."

if (SERVER) then
	function PLUGIN:SaveData()
		local data = {}
		for k, v in ipairs(ents.FindByClass("ix_spawnsaver")) do
			data[#data + 1] = {v:GetPos(), v:GetAngles()}
		end
		self:SetData(data)
	end

	function PLUGIN:LoadData()
		local data = self:GetData()
		if (data) then
			for k, v in ipairs(data) do
				local ent = ents.Create("ix_spawnsaver")
				ent:SetPos(v[1])
				ent:SetAngles(v[2])
				ent:Spawn()
				ent:SetSolid(SOLID_VPHYSICS)
				ent:PhysicsInit(SOLID_VPHYSICS)

				local physObject = ent:GetPhysicsObject()

				if (IsValid(physObject)) then
					physObject:Sleep()
					physObject:EnableMotion(false)
				end
			end
		end
	end

	function PLUGIN:PlayerLoadout(client)
		local character = client:GetCharacter()
	
		if (character) then
			local spawndata = character:GetData("savedspawn")
			if not (spawndata[3] == game.GetMap())then
				ix.plugin.list["simplecrossserver"]:RedirectPlayerNoLoadZone(client, spawndata[3])
				character:SetData("newpos", spawndata)
				return
			end

			client:SetPos(spawndata[1])
		end
	end
end