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

	function PLUGIN:OnCharacterCreated(client, character)
		-- set savedspawn on charcreate, so people get sent here when they die
		if ix.plugin.list["simplecrossserver"].homemap == "rp_marsh_cs" then
			character:SetData("savedspawn", {Vector(-7182.672852, -10445.850586, 4972.751465), Angle(0,0,0), "rp_marsh_cs"})
		end
	end

	function PLUGIN:PlayerLoadout(client)
		local character = client:GetCharacter()
		
		if (character) then
			if !character:GetData("DiedRecently") then
				return
			end

			character:SetData("health", 15)
			client:SetHealth( 15 ) 

			character:SetData("DiedRecently", nil)

			local spawndata = character:GetData("savedspawn", nil)

			if !spawndata then return end

			if not (spawndata[3] == game.GetMap())then
				character:SetData("newpos", spawndata)
				ix.plugin.list["simplecrossserver"]:RedirectPlayerNoLoadZone(client, spawndata[3])
				return
			end

			client:SetPos(spawndata[1])
		end
	end

	function PLUGIN:DoDeathDrop(client, deathpos)
		client:GetCharacter():SetData("DiedRecently", true)
	end
end