/*
	PLUGIN.eventdefs["Key123"] = {
		key = "Key123", --Should be identical to the actual key
		difficulty = {1},
		funcPrestart = function(dat) 

		end,
		funcStart = function(dat) 

		end,
		funcUpdate = function(dat) 

		end,
		funcShouldEnd = function(dat)
		
		end,
		funcEnd = function(dat) 
		
		end
	}
*/
--difficulty: Given difficulty for the encounter
--funcPrestart: Things to set up before starting, possibly some data tables
--funcStart: Things to do when starting, most likely spawn stuff
--funcUpdate: To allow a more dynamic structure, will be ran every few seconds
--funcShouldEnd: Predicate to determine if the encounter is done
--funcEnd: Cleanup to do after the encounter is over

--Example with spawning zombies:
/*
	PLUGIN.eventdefs["Zombie1"] = {
		key = "Zombie1",
		difficulty = {1},
		funcPrestart = function(dat)
			ix.item.Spawn("makarov", dat.eventpoint[1], nil, AngleRand(), {["durability"] = 30})
			for k, ply in pairs( player.GetAll() ) do
				ix.chat.Send(ply, "eventpdainternal", Format("Flot zimbis ved %s.", dat.eventpoint[2]), true, ply)
			end
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
		end,
		funcUpdate = function(dat) {
			local zombalive = 0
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
			end
			--return dat
		},
		funcShouldEnd = function(dat) {
			shouldend = false

			local zombalive = 0
			for k,v in pairs(dat.data.zombies) do
				if IsValid(v) then zombalive = zombalive+1 end
			end

			if zombalive < 1 then
				shouldend = true
			end
			return shouldend
		},
		funcEnd = function(dat) {
			ix.item.Spawn("mp5", dat.eventpoint[1], nil, AngleRand(), {["durability"] = 100})
			--return dat
		}
	}
*/