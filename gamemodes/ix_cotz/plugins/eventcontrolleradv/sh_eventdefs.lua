/*
	PLUGIN.eventdefs["Key123"] = {
		key = "Key123", --Should be identical to the actual key
		allowedPoints = {"gm_flatgrass_point1", "gm_flatgrass_point2"}
		difficulty = 1,
		funcPrestart = function(dat) 
			return dat
		end,
		funcStart = function(dat) 
			return dat
		end,
		funcUpdate = function(dat) 
			return dat
		end,
		funcShouldEnd = function(dat)
			return dat
		end,
		funcEnd = function(dat) 
			return dat
		end
	}
*/
--difficulty: Given difficulty for the encounter
--allowedPoints: Points that can spawn this event
--funcPrestart: Things to set up before starting, possibly some data tables
--funcStart: Things to do when starting, most likely spawn stuff
--funcUpdate: To allow a more dynamic structure, will be ran every few seconds
--funcShouldEnd: Predicate to determine if the encounter is done
--funcEnd: Cleanup to do after the encounter is over
-- NOTE : All func* functions should return the parameter dat!

--Example with spawning zombies:
/*
	PLUGIN.eventdefs["Zombie1"] = {
		key = "Zombie1",
		allowedPoints = {"gm_flatgrass_point2"},
		difficulty = 1,
		funcPrestart = function(dat)
			ix.item.Spawn("makarov", dat.eventpoint[1], nil, AngleRand(), {["durability"] = 30})
			for k, ply in pairs( player.GetAll() ) do
				ix.chat.Send(ply, "eventpdainternal", Format("The dead walks the earth at %s.", dat.eventpoint[2]), true, ply)
			end

			dat.data.zombies = {}

			return dat
		end,
		funcStart = function(dat)
			for i=1,5 do
				local position = dat.eventpoint[1] + Vector( math.Rand(-64,64), math.Rand(-64,64), 64 )
				local data = {}
				data.start = position
				data.endpos = position
				data.mins = Vector(-16, -16, 0)
				data.maxs = Vector(16, 16, 71)
				local trace = util.TraceHull(data)

				if trace.Entity:IsValid() then
					continue
				end

				dat.data.zombies[i] = ents.Create("npc_mutant_classiczombie")
				dat.data.zombies[i]:SetPos(position)
				dat.data.zombies[i]:Spawn()
			end

			return dat
		end,
		funcUpdate = function(dat) 
			if data.respawndone then
				return dat
			end

			local zombalive = 0

			if !dat.data.zombies then
				return dat
			end

			for k,v in pairs(dat.data.zombies) do
				if IsValid(v) then zombalive = zombalive+1 end
			end

			if zombalive < 3 then
				for k, ply in pairs( player.GetAll() ) do
					ix.chat.Send(ply, "eventpdainternal", "More zombies rise from the ground.", true, ply)
				end
				for i=#dat.data.zombies,#dat.data.zombies+3 do
					local position = dat.eventpoint[1] + Vector( math.Rand(-64,64), math.Rand(-64,64), 64 )
					local data = {}
					data.start = position
					data.endpos = position
					data.mins = Vector(-16, -16, 0)
					data.maxs = Vector(16, 16, 71)
					local trace = util.TraceHull(data)

					if trace.Entity:IsValid() then
						continue
					end
					dat.data.zombies[i] = ents.Create("npc_mutant_classiczombie")
					dat.data.zombies[i]:SetPos(position)
					dat.data.zombies[i]:Spawn()
				end
				data.respawndone = true
			end
			return dat
		end,
		funcShouldEnd = function(dat)
			shouldend = false

			local zombalive = 0
			for k,v in pairs(dat.data.zombies) do
				if IsValid(v) then zombalive = zombalive+1 end
			end

			if zombalive < 1 then
				shouldend = true
			end
			return shouldend
		end,
		funcEnd = function(dat)
			ix.item.Spawn("mp5", dat.eventpoint[1], nil, AngleRand(), {["durability"] = 100})
			return dat
		end
	}
*/

	PLUGIN.eventdefs["Dog_Ambush"] = {
		key = "Dog_Ambush",
		allowedPoints = {"dog_ambush"},
		difficulty = 1,
		funcPrestart = function(dat)
			local spawnedItem 
			ix.item.Spawn("food_can_tushonka", dat.eventpoint[1]+Vector(0,0,32), function(item, entity) spawnedItem = entity end, AngleRand(), {})

			dat.data.itement = spawnedItem

			dat.data.dogs = {}
			dat.data.spawnsleft = 2

			return dat
		end,
		funcStart = function(dat)
			return dat
		end,
		funcUpdate = function(dat) 
			if dat.data.spawnsleft == 0 then
				dat.data.eventdone = true
				return dat
			end

			if !dat.data.dogs then
				return dat
			end

			if IsValid(dat.data.itement) then

				return dat
			end

			local bsalive = 0

			for k,v in pairs(dat.data.dogs) do
				if IsValid(v) then bsalive = bsalive+1 end
			end

			if bsalive == 0 then
				sound.Play( "hgn/stalker/creature/dog/bdog_idle_4.wav", dat.eventpoint[1])

				for i=#dat.data.dogs,#dat.data.dogs+2 do
					local position = dat.eventpoint[1] + Vector( math.Rand(-256,256), math.Rand(-256,256), 128 )
					local data = {}
					data.start = position
					data.endpos = position
					data.mins = Vector(-16, -16, 0)
					data.maxs = Vector(16, 16, 71)
					local trace = util.TraceHull(data)

					if trace.Entity:IsValid() then
						continue
					end
					dat.data.dogs[i] = ents.Create("npc_mutant_dog")
					dat.data.dogs[i]:SetPos(position)
					dat.data.dogs[i]:Spawn()
				end
				dat.data.spawnsleft = dat.data.spawnsleft - 1
			end
			return dat
		end,
		funcShouldEnd = function(dat)
			shouldend = false

			shouldend = dat.data.eventdone

			return shouldend
		end,
		funcEnd = function(dat)
			ix.item.Spawn("artifact_battery", dat.eventpoint[1] + Vector(0,0,64), nil, AngleRand(), {})
			sound.Play( "anomaly/electra_blast1.mp3", dat.eventpoint[1])

			return dat
		end
	}


PLUGIN.eventdefs["ShippingCrate_1"] = {
		key = "ShippingCrate_1",
		allowedPoints = {"shippingcrate_1"},
		difficulty = 1,
		funcPrestart = function(dat)
			ix.util.SpawnAdvDupe2Dupe("event_shippingcrate_1", "shippingcrate")

			return dat
		end,
		funcStart = function(dat)

			return dat
		end,
		funcUpdate = function(dat) 
			
			return dat
		end,
		funcShouldEnd = function(dat)
			shouldend = true

			for i,j in pairs (ents.FindInSphere( dat.eventpoint[1], 512 )) do
				if(j:GetClass() == "ix_entbox" || j:GetClass() == "ix_wood_entbox") then
					shouldend = false
					break
				end
			end

			return shouldend
		end,
		funcEnd = function(dat)
			ix.util.DepawnAdvDupe2Dupe("shippingcrate")
			return dat
		end
	}


	PLUGIN.eventdefs["Jumppuzzle_1"] = {
		key = "Jumppuzzle_1",
		allowedPoints = {"jumppuzzle_1"},
		difficulty = 1,
		funcPrestart = function(dat)
			ix.util.SpawnAdvDupe2Dupe("event_jumppuzzle_1", "jumppuzzle")

			return dat
		end,
		funcStart = function(dat)

			return dat
		end,
		funcUpdate = function(dat) 
			return dat
		end,
		funcShouldEnd = function(dat)
			shouldend = true
			for i,j in pairs (ents.FindInSphere( dat.eventpoint[1] + Vector(0, 0, 800), 512 )) do
				if(j:GetClass() == "ix_item") then
					shouldend = false
					break
				end
			end

			return shouldend
		end,
		funcEnd = function(dat)
			timer.Simple(300, function() 
				ix.util.DepawnAdvDupe2Dupe("jumppuzzle")
			end)
			
			return dat
		end
	}