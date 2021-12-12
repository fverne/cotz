local PLUGIN = PLUGIN
PLUGIN.name = "Hidden Stash System"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Simple hidestash system."
PLUGIN.stashpoints = PLUGIN.stashpoints or {}

if SERVER then
	local spawntime = 1

	function PLUGIN:ItemShouldSave(entity)
		return (!entity.generated)
	end

	function PLUGIN:LoadData()
		self.stashpoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.stashpoints)
	end

	function PLUGIN:SpawnStash(pos, item)
  		for k, v in pairs( item ) do
    		table.insert( PLUGIN.stashpoints, { pos, v[1], Angle(), v[2] } )
  		end
	end

else

	netstream.Hook("nut_DisplaySpawnPoints", function(data)
		for k, v in pairs(data) do
			local emitter = ParticleEmitter( v[1] )
			local smoke = emitter:Add( "sprites/glow04_noz", v[1] )
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

function PLUGIN:StashHide(client)
	ix.util.PlayerPerformBlackScreenAction(client, "Hiding the stash...", 3, function(client) 
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local stasheditem = ix.item.instances
		local mt = 0
		
		for k, v in pairs( stasheditem ) do
			if v:GetEntity() then
				local dist = hitpos:Distance(client:GetPos())
				local distance = v:GetEntity():GetPos():Distance( hitpos )
				if dist <= 70 then
					if distance <= 32 then
						table.insert( PLUGIN.stashpoints, { hitpos, v.uniqueID, v:GetEntity():GetAngles(), v.data } )
						ix.log.Add(client, "command", "created a stash at x:"..hitpos.x.." y:"..hitpos.y.." z:"..hitpos.z.." containing: "..v.name)
						--if v:getData("id") then
						--	att = nut.item.inventories[ v:getData("id") ]:getItems()
						--	for h,j in pairs (att) do
						--		j:transfer()
						--	end
						--end
						v:Remove()
						mt = mt + 1
					end
				end
			end
		end
		if mt > 0 then
			client:Notify( "You hid ".. mt .. " items." )
			ix.chat.Send(client, "iteminternal", "hides something away.", false)
		end
	end)
end

function PLUGIN:StashUnhide(client)
	ix.util.PlayerPerformBlackScreenAction(client, "Searching for a stash...", 8, function(client) 
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local mt = 0
		
		for k, v in pairs( PLUGIN.stashpoints ) do
			local dist = hitpos:Distance(client:GetPos())
			local distance = v[1]:Distance( hitpos )
			if dist <= 70 then
				if distance <= 32 then
					--local itemdata = v[4]
					ix.item.Spawn(v[2], v[1] + Vector( 0, 0, 10 + (mt * 5) ), nil, v[3], v[4])
					PLUGIN.stashpoints[k] = nil
					mt = mt + 1
				end
			end
		end
		if mt == 0 then
			client:Notify( "You didn't find anything" )
		else
			client:Notify( "You found ".. mt .. " items.")
			ix.chat.Send(client, "iteminternal", "uncovers something.", false)
		end
	end)
end

ix.command.Add("stashhide", {
	adminOnly = true,
	OnRun = function(self, client)
		PLUGIN:StashHide(client)
	end,
})

ix.command.Add("stashunhide", {
	adminOnly = true,
	OnRun = function(self, client)
		PLUGIN:StashUnhide(client)
	end
})

ix.command.Add("stashdisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.stashpoints)
			client:Notify( "Displayed all stashes for 10 secs." )
		end
	end
})
