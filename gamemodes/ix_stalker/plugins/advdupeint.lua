local PLUGIN = PLUGIN
PLUGIN.name = "AdvDupe2 integration"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Simple integration with AdvDupe2."

if(SERVER and AdvDupe2)then

ix.AdvDupeIntegration = {}
ix.AdvDupeIntegration = {}

ix.AdvDupeIntegration.Entities = {}
ix.AdvDupeIntegration.Constraints = {}
ix.AdvDupeIntegration.HeadEnt={}

ix.AdvDupeIntegration.CreatedEntities = {}

-- dupetospawn: filename of the dupe to spawn
-- uniqueid: special name to save this spawned dupe under to identify it again (eg. if multiple of the same dupe is spawned)
-- offset: Vector offset from the original spawn position
function PLUGIN:SpawnDupe(dupetospawn, uniqueid, offset)
	local path = AdvDupe2.DataFolder.."/STALKERDupes/"..dupetospawn..".txt"

	if(not file.Exists(path, "DATA"))then print("File does not exist:", dupetospawn) return end

	local read = file.Read(path)
	if not read then print("File could not be read:", dupetospawn) return end

	local success, dupe, info, moreinfo = AdvDupe2.Decode(read)

	if(success)then --This is where the magic happens

		ix.AdvDupeIntegration.CreatedEntities[dupetospawn] = {}

		ix.AdvDupeIntegration.Entities = {}
		ix.AdvDupeIntegration.Constraints = {}
		ix.AdvDupeIntegration.HeadEnt = {}

		ix.AdvDupeIntegration.Entities = dupe["Entities"]
		ix.AdvDupeIntegration.Constraints = dupe["Constraints"]
		ix.AdvDupeIntegration.HeadEnt = dupe["HeadEnt"]

		local ents = AdvDupe2.duplicator.Paste( nil, ix.AdvDupeIntegration.Entities, ix.AdvDupeIntegration.Constraints, nil, nil, ix.AdvDupeIntegration.HeadEnt.Pos + (offset or Vector(0,0,0)), true )

		if (not uniqueid) then uniqueid = dupetospawn end
		local PhysObj
		for k,v in pairs(ents) do -- Enable motion
			if(IsValid(v))then
				for i=0, #ix.AdvDupeIntegration.Entities[k].PhysicsObjects do
					PhysObj = v:GetPhysicsObjectNum( i )
					if IsValid(PhysObj) then
						PhysObj:EnableMotion(false)
					end
				end
				if v.CPPISetOwner then v:CPPISetOwner(game.GetWorld()) end
			end

			table.insert(ix.AdvDupeIntegration.CreatedEntities[uniqueid], v)
		end

		ix.AdvDupeIntegration.Entities = {}
		ix.AdvDupeIntegration.Constraints = {}
		ix.AdvDupeIntegration.HeadEnt = {}
	else
		print("Failed to decode file:", dupetospawn)
	end
end

function PLUGIN:DespawnDupe(dupetodespawn)
	for k,v in pairs(ix.AdvDupeIntegration.CreatedEntities[dupetodespawn]) do
		if( IsValid(v) ) then v:Remove() end
	end

	ix.AdvDupeIntegration.CreatedEntities[dupetodespawn] = {}
	ix.AdvDupeIntegration.CreatedEntities[dupetodespawn] = nil
end

end

ix.command.Add("debug_spawndupe", {
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, dupetospawn)
		PLUGIN:SpawnDupe(dupetospawn)
	end,
})

ix.command.Add("debug_despawndupe", {
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, dupetodespawn)
		PLUGIN:DespawnDupe(dupetodespawn)
	end,
})

function ix.util.SpawnAdvDupe2Dupe( dupetospawn, uniqueid, offset )
	ix.plugin.list["advdupeint"]:SpawnDupe(dupetospawn, uniqueid, offset)
end

function ix.util.DepawnAdvDupe2Dupe( dupetodespawn )
	ix.plugin.list["advdupeint"]:DespawnDupe(dupetodespawn)
end