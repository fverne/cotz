local PLUGIN = PLUGIN
PLUGIN.name = "Hidden Stash System Spawning"
PLUGIN.author = "verne"
PLUGIN.desc = "Simple autospawning hidestash system."
PLUGIN.stashspawnpoints = PLUGIN.stashspawnpoints or {}

ix.util.Include("sh_definitions.lua")

if SERVER then
	local spawntime = 1

	function PLUGIN:ItemShouldSave(entity)
		return (!entity.generated)
	end

	function PLUGIN:LoadData()
		self.stashspawnpoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.stashspawnpoints)
	end

	--[[
	function PLUGIN:GetPointFromCategory(category)
		if(!isstring(category)) then return end
		self.stashspawnpoints[category] = self.stashspawnpoints[category] or {}
		return table.Random(self.stashspawnpoints[category])
	end
	]]--

	function PLUGIN:GetPoint()
		self.stashspawnpoints = self.stashspawnpoints or {}
		return table.Random(self.stashspawnpoints)
	end

else

	netstream.Hook("nut_DisplayStashSpawnPoints", function(data)
		for i=1, #data do
			local emitter = ParticleEmitter( data[i] )
			local smoke = emitter:Add( "sprites/glow04_noz", data[i] )
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

	netstream.Hook("nut_DisplayStashSpawnPointsSingle", function(data)
		local stashmaterial = Material("vgui/icons/stash.png", "smooth noclamp")
		local emitter = ParticleEmitter( data )
		local smoke = emitter:Add( stashmaterial, data )
		smoke:SetVelocity( Vector( 0, 0, 1 ) )
		smoke:SetDieTime(10)
		smoke:SetStartAlpha(255)
		smoke:SetEndAlpha(255)
		smoke:SetStartSize(2)
		smoke:SetEndSize(2)
		smoke:SetColor(255,255,255)
		smoke:SetAirResistance(300)

	end)
end
--[[
ix.command.Add("stashspawntest", {
	adminOnly = true,
	arguments = {
		ix.type.text,
	},
	OnRun = function(self, client, category)
		local stashcontent = "CONTENT: "
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local mt = 0

		local loot = table.Random(PLUGIN.StashItems[category])
		local spawnpoint = table.Random(PLUGIN.stashspawnpoints)
		ix.plugin.list["hidestash"]:SpawnStash(spawnpoint, { loot[1], loot[2] })

		for i = 1, #loot[1] do
			stashcontent = stashcontent..", "..loot[i][1]
			client:Notify( "You hid ".. loot[i][1] )
		end

		ix.log.Add(client, "command", "created a stash at x:"..spawnpoint.x.." y:"..spawnpoint.y.." z:"..spawnpoint.z.." with "..stashcontent)
		mt = mt + 1
		
		if mt > 0 then
			--ix.chat.Send(client, "iteminternal", "hides something away.", false)
		end
	end
}) ]]--

ix.command.Add("stashspawneradd", {
	superAdminOnly = true,
	arguments = {
		ix.type.text,
	},
	OnRun = function(self, client, text)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local text = text
        PLUGIN.stashspawnpoints = PLUGIN.stashspawnpoints or {}
		table.insert( PLUGIN.stashspawnpoints, {hitpos, text} )
		client:Notify( "You added a hidden stash spawner." )
	end
})

ix.command.Add("stashspawnerremove", {
	superAdminOnly = true,
	arguments = {
		ix.type.number,
	},
	OnRun = function(self, client, radius)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = radius or 128
		local mt = 0
		for k, v in pairs( PLUGIN.stashspawnpoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.stashspawnpoints[k] = nil
				mt = mt + 1
			end
		end
		client:Notify( "You have removed "..mt.." stash spawners." )
	end
})

ix.command.Add("stashspawnerdisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			local data = {}

			for k, v in pairs(PLUGIN.stashspawnpoints) do
				table.insert(data, v[1])
			end	

			netstream.Start(client, "nut_DisplayStashSpawnPoints", data)
			client:Notify( "Displayed all stash spawners for 10 secs." )
		end
	end
})
