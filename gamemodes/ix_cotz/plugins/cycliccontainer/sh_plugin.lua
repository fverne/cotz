PLUGIN.name = "Cyclical Containers"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Makes containers appear and disappear in semi-random intervals. Used for hidden stashes of loot."

ix.util.Include("sh_definitions.lua")
ix.util.Include("sh_stashtypes.lua")

if SERVER then

	function PLUGIN:AppearContainer(containerent)
		containerent:SetNoDraw(false)
		containerent:SetCollisionGroup(COLLISION_GROUP_WORLD)

		local selectedStashType = table.Random(self.categoryDefs[containerent:GetCyclicalCategory()].allowedStashTypes)
		local inventory = containerent:GetInventory()

		-- Wipe inventory content
		for _, item in pairs(inventory:GetItems()) do
			item:Remove()
		end
		
		-- Spawn in contents
		for _, group in pairs(self.stashTypes[selectedStashType]) do
			local idat = ix.util.GetRandomItemFromPool(group)
			inventory:Add(idat[1], 1, idat[2] or {})
		end

		local appTime = self.categoryDefs[containerent:GetCyclicalCategory()].appearTime

		containerent.cyclicalDisappearTime = os.time() + appTime + math.random(-appTime/10, appTime/10)
		containerent.cyclicalAppearTime = nil
	end

	function PLUGIN:DisappearContainer(containerent, firstspawn)
		containerent:SetNoDraw(true)
		containerent:SetCollisionGroup(COLLISION_GROUP_WORLD)

		local disTime = self.categoryDefs[containerent:GetCyclicalCategory()].disappearTime

		if firstspawn then
			containerent.cyclicalAppearTime = os.time() + math.random(0, disTime*2)
		else
			containerent.cyclicalAppearTime = os.time() + disTime + math.random(-disTime/10, disTime/10)
		end
		containerent.cyclicalDisappearTime = nil
	end



	local thinktime = 1
	function PLUGIN:Think()
		-- Think every 10s
		if thinktime > CurTime() then return end
		thinktime = CurTime() + 10

		-- Iterate all containers
		for k, v in pairs( ents.FindByClass( "ix_container" ) ) do
			-- Only check containers that have cyclical category defined
			if v:GetCyclicalCategory() != "" then
				-- First time this container has been hit
				if (v.cyclicalAppearTime == nil and v.cyclicalDisappearTime == nil) then
					self:DisappearContainer(v, true)
				end

				-- It's time for the stash to appear
				if (v.cyclicalAppearTime and v.cyclicalAppearTime < os.time()) then
					self:AppearContainer(v)
				end
				-- It's time for the stash to disappear
				if (v.cyclicalDisappearTime and v.cyclicalDisappearTime < os.time()) then
					self:DisappearContainer(v)
				end
			end
		end
	end
else
	netstream.Hook("ix_DisplayCyclicCaches", function(data)
		for k, v in pairs(data) do
			local emitter = ParticleEmitter( v )
			local smoke = emitter:Add( "sprites/glow04_noz", v )
			smoke:SetVelocity( Vector( 0, 0, 1 ) )
			smoke:SetDieTime(10)
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(255)
			smoke:SetStartSize(64)
			smoke:SetEndSize(64)
			smoke:SetColor(255,186,50)
			smoke:SetAirResistance(300)
		end
	end)
end


ix.command.Add("containercyclicaladd", {
	adminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, cyclgroup)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:GetClass() == "ix_container") then
			ent:SetCyclicalCategory(cyclgroup)
			client:Notify("Storage made cyclical with the following definition: ["..cyclgroup.."]")
			ix.plugin.list["containers"]:SaveContainer()
		else
			client:NotifyLocalized("invalid", "Entity")
		end
	end
})

ix.command.Add("containercyclicalremove", {
	adminOnly = true,
	OnRun = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:GetClass() == "ix_container") then
			ent:SetCyclicalCategory("")
			client:Notify("Storage is no longer cyclical")
			ix.plugin.list["containers"]:SaveContainer()
		else
			client:NotifyLocalized("invalid", "Entity")
		end
	end
})

ix.command.Add("containercyclicaldisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			local containers = {}
			for k, v in pairs( ents.FindByClass( "ix_container" ) ) do
				-- Only check containers that have cyclical category defined
				if v:GetCyclicalCategory() != "" then
					table.insert(containers, v:GetPos())
				end
			end

			netstream.Start(client, "ix_DisplayCyclicCaches", containers)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("containercyclicalmakenocollide", {
	adminOnly = true,
	OnRun = function(self, client, cyclgroup)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:GetClass() == "ix_container") then
			ent:SetCollisionGroup( COLLISION_GROUP_WORLD )
        	ent.CollisionGroup = COLLISION_GROUP_WORLD
			ent:GetPhysicsObject():EnableCollisions(false)

			client:Notify("Storage made no-collide")
			ix.plugin.list["containers"]:SaveContainer()
		else
			client:NotifyLocalized("invalid", "Entity")
		end
	end
})
