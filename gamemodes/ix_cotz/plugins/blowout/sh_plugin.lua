local PLUGIN = PLUGIN
PLUGIN.name = "Blowout"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Blowout addon converted to plugin, and cleaned up a bit"
ix.util.Include("cl_plugin.lua")

ix.config.Add(
	"blowoutEnabled",
	true,
	("If true, blowouts will be able to be automatically triggered " .. "or manually by admins."),
	function()
		if SERVER then
			PLUGIN:ResetBlowoutVars()

			return
		end
	end,
	{
		category = "Blowout",
	}
)

ix.config.Add(
	"blowoutSpan",
	20,
	"How many randomised minutes to add or subtract at each blowout cycle.",
	function()
		if SERVER then
			timer.Simple(0.01, function()
				PLUGIN.BlowoutSpan = PLUGIN:GetRandomWithinSpan(ix.config.Get("blowoutSpan", 20))
				PLUGIN.NextBlowout = os.time()
					+ (ix.config.Get("blowoutRateCycle", 90) * 60)
					+ PLUGIN.BlowoutSpan
			end)
		end
	end,
	{
		data = {
			min = 1,
			max = 120,
		},
		category = "Blowout",
	}
)

ix.config.Add("blowoutSkybox", true, "If true, the blowout skybox will draw.", nil, {
	category = "Blowout",
})

ix.config.Add(
	"blowoutRateCycle",
	90,
	("How many minutes between the next blowout cycle. Default " .. "= 120 minutes (2 hours)"),
	function()
		if SERVER then
			timer.Simple(0.01, function()
				PLUGIN.NextBlowout = os.time()
					+ (ix.config.Get("blowoutRateCycle", 90) * 60)
					+ PLUGIN.BlowoutSpan
			end)
		end
	end,
	{
		data = {
			min = 10,
			max = 720,
		},
		category = "Blowout",
	}
)

ix.config.Add("blowoutRemoveNPCs", false, "If true, blowouts will remove all the NPCs on the map.", nil, {
	category = "Blowout",
})

ix.config.Add("blowoutRemoveItems", false, "If true, blowouts will remove all the items on the map.", nil, {
	category = "Blowout",
})

-- Register HUD Bars.
if SERVER then
	util.AddNetworkString("BlowoutPlaySound")
	util.AddNetworkString("BlowoutChangePhase")

	function PLUGIN:GetRandomWithinSpan(span)
		return (-span + (math.Round(os.time(), -3) % (span - -span + 1))) * 60
	end

	PLUGIN.BlowoutSpan = 0

	function PLUGIN:OnGamemodeLoaded()
		self.BlowoutSpan = PLUGIN:GetRandomWithinSpan(ix.config.Get("blowoutSpan", 20))
	end

	PLUGIN.NextBlowout = os.time() + (ix.config.Get("blowoutRateCycle", 90) * 60) + PLUGIN.BlowoutSpan
	PLUGIN.NextThink = 0
	PLUGIN.BlowoutVars = PLUGIN.BlowoutVars or {}
	PLUGIN.BlowoutVars.BlowoutStarted = false
	PLUGIN.BlowoutVars.PrehitTime = 0
	PLUGIN.BlowoutVars.BlastTime = 0
	PLUGIN.BlowoutVars.BuildupTime = 0
	PLUGIN.BlowoutVars.BlowoutHitTime = 0
	PLUGIN.BlowoutVars.FinalSoundTime = 0
	PLUGIN.BlowoutVars.NextAmbientSound = 0
	PLUGIN.BlowoutVars.NextHitSound = 0
	PLUGIN.BlowoutVars.BlowoutStep = 0
	PLUGIN.BlowoutVars.PostHitActionTime = 0
	PLUGIN.BlowoutVars.BlowoutFinishTime = 0
	PLUGIN.BlowoutVars.AdminWarningUsed = false
	PLUGIN.BlowoutVars.ProgressionWarningUsed = false

	function PLUGIN:MarkOutsidePlayersOnBlowout()
		local movetypes = {
			--[MOVETYPE_NONE] = true,
			--[MOVETYPE_FLYGRAVITY] = true,
			[MOVETYPE_NOCLIP] = true,
			[MOVETYPE_OBSERVER] = true,
		}

		for _, v in player.Iterator() do
			if
				not self:IsPosSafe(v:GetShootPos(), v, {})
				and not movetypes[v:GetMoveType()]
				and v:GetCharacter()
				and v:Alive()
			then
				if not v:GetCharacter() then
					return
				end

				v:GetCharacter():SetData("bInBlowoutWhenStart", true)
			end
		end
	end

	function PLUGIN:RemoveBlowoutMarkFromPlayers()
		for _, v in player.Iterator() do
			if v:GetCharacter() then
				v:GetCharacter():SetData("bInBlowoutWhenStart", false)
			end
		end
	end

	-- function PLUGIN:PlayerDisconnected(client)
	--     if client:GetCharacter():GetData("bInBlowoutWhenStart", false) then
	--         client:Spawn()
	--         client:Notify("Your character disconnected during a blowout, and was killed.")
	--     end
	-- end

	function PLUGIN:PlayerSpawn(client)
		if not client:GetCharacter() then
			return
		end

		if client:GetCharacter():GetData("bInBlowoutWhenStart", false) then
			timer.Simple(0, function()
				client:Kill()
				client:Notify("Your character disconnected during a blowout, and was killed.")
			end)
		end

		client:GetCharacter():SetData("bInBlowoutWhenStart", false)
	end

	function PLUGIN:ShutDown()
		for _, v in player.Iterator() do
			if not v:GetCharacter() then
				return
			end

			-- v:SetData("bInBlowoutWhenStart", false) -- failsafe if server restarts during blowout.
		end
	end

	function PLUGIN:Think()
		if not ix.config.Get("blowoutEnabled", true) then
			return
		end
		local currentTime = CurTime()
		if currentTime < self.NextThink then
			return
		end

		if
			math.Round(self.NextBlowout) == math.Round(os.time() + 60)
			and self.BlowoutVars.AdminWarningUsed == false
		then
			for _, v in player.Iterator() do
				if v:IsAdmin() then
					v:Notify(
						(
							"[ADMIN] A blowout is going to happen in 60 seconds. You "
							.. "can stop this if you wish by typing /blowoutresetcycle "
							.. "in chat."
						)
					)
				end
			end
			self.BlowoutVars.AdminWarningUsed = true
		end

		if
			math.Round(self.NextBlowout) == math.Round(os.time() + 30)
			and self.BlowoutVars.ProgressionWarningUsed == false
		then
			for _, ply in player.Iterator() do
				local character = ply:GetCharacter()
				if character and ix.progression.IsCompleted(character, "muteItemDelivery_BlowoutWarning") then
					ix.chat.Send(
						ply,
						"eventpdainternal",
						"A blowout is about to hit, seek shelter!",
						true,
						{ ply }
					)
				end
			end
			self.BlowoutVars.ProgressionWarningUsed = true
		end

		if self.NextBlowout < os.time() and not self.BlowoutVars.BlowoutStarted then
			self.BlowoutVars.BlowoutStarted = true
			self:MarkOutsidePlayersOnBlowout()

			local dur = 35 -- time until blowout hits - 60-90s probably
			self:ChangePhase(1, dur)
			self.BlowoutVars.PrehitTime = currentTime + dur - 15
			self.BlowoutVars.BlastTime = currentTime + dur
			self.BlowoutVars.BlowoutStep = 1
			self:PlaySoundOnClient("announce1")
		end

		if self.BlowoutVars.BlowoutStarted then
			self.NextThink = currentTime + 0.25

			if self.BlowoutVars.PrehitTime < currentTime and self.BlowoutVars.BlowoutStep < 2 then
				self.BlowoutVars.BlowoutStep = 2
				self:PlaySoundOnClient("prehit")
				-- print("Prehit - phase 2")
			end

			if self.BlowoutVars.BlastTime < currentTime and self.BlowoutVars.BlowoutStep < 3 then
				self.BlowoutVars.BlowoutStep = 3
				self.BlowoutVars.BlowoutHitTime = currentTime + 18
				self.BlowoutVars.BuildupTime = currentTime + 2
				self.BlowoutVars.FinalSoundTime = currentTime + 17.25
				self:PlaySoundOnClient("start")
				self:ChangePhase(2, 0)
				-- print("Start - phase 3")
				local e = ents.Create("env_shake") -- Shake the world a little
				e:SetKeyValue("amplitude", "1")
				e:SetKeyValue("frequency", "100.0")
				e:SetKeyValue("duration", "10")
				e:SetKeyValue("spawnflags", "5")
				e:Fire("startshake")
			end

			if self.BlowoutVars.BuildupTime < currentTime and self.BlowoutVars.BlowoutStep == 3 then
				self.BlowoutVars.BlowoutStep = 4
				self:PlaySoundOnClient("buildup")
				-- print("buildup - phase 4")
			end

			if self.BlowoutVars.FinalSoundTime < currentTime and self.BlowoutVars.BlowoutStep == 4 then
				self.BlowoutVars.BlowoutStep = 5
				self:PlaySoundOnClient("end")
				-- print("end - phase 5")
			end

			if self.BlowoutVars.BlowoutHitTime < currentTime and self.BlowoutVars.BlowoutStep == 5 then
				self.BlowoutVars.BlowoutStep = 6

				local movetypes = {
					--[MOVETYPE_NONE] = true,
					--[MOVETYPE_FLYGRAVITY] = true,
					[MOVETYPE_NOCLIP] = true,
					[MOVETYPE_OBSERVER] = true,
				}

				local tracefilter = {}
				local blacklistents = ents.FindByClass("ix_item")

				for _, ent in pairs(blacklistents) do
					table.insert(tracefilter, ent)
				end

				for _, v in player.Iterator() do
					if
						not self:IsPosSafe(v:GetShootPos(), v, tracefilter)
						and not movetypes[v:GetMoveType()]
						and v:GetCharacter()
						and v:Alive()
					then
						v:Kill()
					end
				end

				self:RemoveBlowoutMarkFromPlayers()

				self:ChangePhase(3, 0)
				ix.plugin.list["anomalycontroller"]:cleanAnomalies()
				ix.plugin.list["anomalycontroller"]:spawnAnomalies()
				for _ = 1, 3 do
					ix.plugin.list["anomalycontroller"]:trySpawnArtifacts()
				end
				if ix.config.Get("blowoutRemoveNPCs", false) then
					for _, v in ents.Iterator() do
						if
							IsValid(v)
							and (v:IsNPC() or baseclass.Get(v:GetClass()).Base == "base_nextbot" or baseclass.Get(
								v:GetClass()
							).Base == "nz_base" or baseclass.Get(v:GetClass()).Base == "nz_risen")
							and not IsFriendEntityName(v:GetClass())
						then
							v:Remove()
						end
					end
				end

				if ix.config.Get("blowoutRemoveItems", false) then
					for _, v in pairs(ents.FindByClass("ix_item")) do
						if v.bTemporary then
							v:Remove()
							continue
						end

						-- local itm = ix.item.instances[v.ixItemID]
						-- if (itm.isWeapon and itm:GetData("durability", 0) <= 10) or itm.cookable then
						--     v:Remove()
						--     continue
						-- end
					end
				end

				-- print("killing - phase 6")
				self.BlowoutVars.PostHitActionTime = currentTime + 1
			end

			if self.BlowoutVars.PostHitActionTime < currentTime and self.BlowoutVars.BlowoutStep > 5 then
				if self.BlowoutVars.BlowoutStep < 7 then
					self.BlowoutVars.BlowoutStep = 7
					self.BlowoutVars.PostHitActionTime = currentTime + 6
					-- print("waiting - phase 7")
				elseif self.BlowoutVars.BlowoutStep < 8 then
					self.BlowoutVars.BlowoutStep = 8
					self.BlowoutVars.PostHitActionTime = currentTime + 3.5
					self:ChangePhase(4, 3.5)
					-- print("clearing up - phase 8")
				elseif self.BlowoutVars.BlowoutStep < 9 then
					self.BlowoutVars.BlowoutStep = 9
					self.BlowoutVars.PostHitActionTime = currentTime + 8
					self:ChangePhase(5, CurTime() + 20)
					-- print("finishing - phase 9")
				elseif self.BlowoutVars.BlowoutStep < 10 then
					self.BlowoutVars.BlowoutStep = 10
					self:PlaySoundOnClient("posthit")
					self.BlowoutVars.PostHitActionTime = currentTime + 12
					-- print("announce - phase 10")
					self:ResetBlowoutVars()
				elseif self.BlowoutVars.BlowoutStep < 11 then
					self:ChangePhase(0, 0)
					self:ResetBlowoutVars()
					-- print("done - phase 11")
				end
			end

			if self.BlowoutVars.NextHitSound < currentTime and self.BlowoutVars.BlowoutStep > 3 then
				self.BlowoutVars.NextHitSound = currentTime + math.Rand(0.75, 4)
				self:PlaySoundOnClient("hit") -- Play the thunder sounds
				local e = ents.Create("env_shake") -- Shake the world a little
				e:SetKeyValue("amplitude", "3")
				e:SetKeyValue("frequency", "100.0")
				e:SetKeyValue("duration", "10")
				e:SetKeyValue("spawnflags", "5")
				e:Fire("startshake")
			end

			if self.BlowoutVars.NextAmbientSound == 0 then
				self.BlowoutVars.NextAmbientSound = currentTime + 15
			elseif currentTime > self.BlowoutVars.NextAmbientSound then
				self.BlowoutVars.NextAmbientSound = currentTime + math.random(15, 20)
				self:PlaySoundOnClient("ambient")
			end
		end
	end

	function PLUGIN:PlaySoundOnClient(snd)
		local id = 0

		if snd == "announce1" then
			id = 1
		elseif snd == "announce2" then
			id = 2
		elseif snd == "prehit" then
			id = 3
		elseif snd == "ambient" then
			id = math.random(4, 8)
		elseif snd == "start" then
			id = 9
		elseif snd == "buildup" then
			id = 10
		elseif snd == "hit" then
			id = math.random(11, 13)
		elseif snd == "end" then
			id = 14
		elseif snd == "posthit" then
			id = 15
		end

		if id > 0 then
			net.Start("BlowoutPlaySound")
			net.WriteUInt(id, 8)
			net.Broadcast()
		end
	end

	function PLUGIN:ChangePhase(phase, duration)
		net.Start("BlowoutChangePhase")
		net.WriteUInt(phase, 8)
		net.WriteFloat(duration or 0)
		net.Broadcast()
	end

	function PLUGIN:IsPosSafe(pos, client, blacklist)
		if not blacklist then
			local tracefilter = {}
			local blacklistents = ents.FindByClass("ix_item")

			for _, ent in pairs(blacklistents) do
				table.insert(tracefilter, ent)
			end
		end

		-- Add the client to the filter table
		table.insert(blacklist, client)
		local traceDataUp = {}
		traceDataUp.start = pos
		traceDataUp.endpos = pos + Vector(0, 0, 999999)
		traceDataUp.mask = MASK_SOLID + MASK_WATER
		traceDataUp.filter = blacklist
		local traceUp = util.TraceLine(traceDataUp) -- Can the entity see the sky?

		if traceUp.HitSky then
			local positionAbove = traceUp.HitPos
			local traceDataDown = {}
			traceDataDown.start = positionAbove
			traceDataDown.endpos = pos
			traceDataDown.mask = MASK_SOLID + MASK_WATER
			traceDataDown.filter = blacklist
			-- Can the sky see the entity? (excludes entities that are below displacements or inside
			local traceDown = util.TraceLine(traceDataDown)
			-- brushes)
			if not traceDown.Hit then
				return false
			end

			return true
		end

		return true
	end

	function PLUGIN:ResetBlowoutVars()
		self.BlowoutVars.BlowoutStarted = false
		self.BlowoutVars.PrehitTime = 0
		self.BlowoutVars.BlastTime = 0
		self.BlowoutVars.BuildupTime = 0
		self.BlowoutVars.BlowoutHitTime = 0
		self.BlowoutVars.FinalSoundTime = 0
		self.BlowoutVars.NextAmbientSound = 0
		self.BlowoutVars.NextHitSound = 0
		self.BlowoutVars.BlowoutStep = 0
		self.BlowoutVars.PostHitActionTime = 0
		self.BlowoutVars.BlowoutFinishTime = 0
		self.NextBlowout = os.time() + (ix.config.Get("blowoutRateCycle", 90) * 60) + self.BlowoutSpan
		self.BlowoutVars.AdminWarningUsed = false
		self.BlowoutVars.ProgressionWarningUsed = false
	end
end

ix.command.Add("blowouttrigger", {
	adminOnly = true,
	description = ("Triggers an instant blowout. Use /blowouttriggerdelay for " .. "a delayed blowout."),
	OnRun = function(self, client)
		if not ix.config.Get("blowoutEnabled") then
			if client:IsSuperAdmin() then
				client:Notify(
					(
						"Blowouts are currently disabled on the server! - You can "
						.. "enable it in the TAB menu config."
					)
				)
			else
				if not client:IsSuperAdmin() then
					client:Notify("Blowouts are currently disabled on the server!")
				end
			end

			return
		end

		if PLUGIN.BlowoutVars.BlowoutStarted then
			return client:Notify(
				(
					"A blowout is already active! You can not trigger another "
					.. "blowout until the active blowout has finished."
				)
			)
		end

		PLUGIN.NextBlowout = os.time()
		client:Notify("You have triggered a blowout to happen any moment now!")
	end,
})

ix.command.Add("blowouttriggerdelay", {
	adminOnly = true,
	description = "Triggers a blowout with a delay until it starts. Delay is in seconds.",
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnRun = function(self, client, delay)
		if not ix.config.Get("blowoutEnabled") then
			if client:IsSuperAdmin() then
				client:Notify(
					(
						"Blowouts are currently disabled on the server! - You can "
						.. "enable it in the TAB menu config."
					)
				)
			else
				if not client:IsSuperAdmin() then
					client:Notify("Blowouts are currently disabled on the server!")
				end
			end

			return
		end

		if PLUGIN.BlowoutVars.BlowoutStarted then
			return client:Notify(
				(
					"A blowout is already active! You can not trigger another "
					.. "blowout until the active blowout has finished."
				)
			)
		end

		if not delay then
			delay = 10
		end

		PLUGIN.NextBlowout = os.time() + delay
		client:Notify("You have triggered a blowout to happen in " .. delay .. " seconds!")
	end,
})

ix.command.Add("blowoutresetcycle", {
	adminOnly = true,
	description = "Resets the blowout rate cycle back to its original set time.",
	OnRun = function(self, client, delay)
		if not ix.config.Get("blowoutEnabled") then
			if client:IsSuperAdmin() then
				client:Notify(
					(
						"Blowouts are currently disabled on the server! - You can "
						.. "enable it in the TAB menu config."
					)
				)
			else
				if not client:IsSuperAdmin() then
					client:Notify("Blowouts are currently disabled on the server!")
				end
			end

			return
		end

		if PLUGIN.BlowoutVars.BlowoutStarted then
			return client:Notify(
				(
					"A blowout is already active! You can not reset its cycle "
					.. "until the blowout has finished."
				)
			)
		end

		PLUGIN.NextBlowout = os.time() + (ix.config.Get("blowoutRateCycle", 90) * 60) + PLUGIN.BlowoutSpan
		client:Notify(
			"You have reset the blowout cycle! The next one will happen in "
				.. ix.config.Get("blowoutRateCycle", 90) + PLUGIN.BlowoutSpan
				.. " minutes!"
		)
	end,
})

ix.command.Add("blowoutgetnexttime", {
	adminOnly = true,
	description = "Notifies yourself the time until the next automated blowout.",
	OnRun = function(self, client, delay)
		if not ix.config.Get("blowoutEnabled") then
			if client:IsSuperAdmin() then
				client:Notify(
					(
						"Blowouts are currently disabled on the server! - You can "
						.. "enable it in the TAB menu config."
					)
				)
			else
				if not client:IsSuperAdmin() then
					client:Notify("Blowouts are currently disabled on the server!")
				end
			end

			return
		end

		if PLUGIN.BlowoutVars.BlowoutStarted then
			return client:Notify(
				(
					"A blowout is already active! You can not get the next time "
					.. "until a blowout until after the blowout has finished."
				)
			)
		end

		client:Notify(
			"Time until the next automated blowout: "
				.. math.Round(PLUGIN.NextBlowout - os.time())
				.. " seconds ("
				.. math.Round((PLUGIN.NextBlowout - os.time()) / 60, 2)
				.. " minutes)."
		)
	end,
})
