local PLUGIN = PLUGIN
PLUGIN.name = "Blowout"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Blowout addon converted to plugin, and cleaned up a bit"

ix.util.Include("cl_plugin.lua")

-- Register HUD Bars.
if (SERVER) then

	util.AddNetworkString("BlowoutPlaySound")
	util.AddNetworkString("BlowoutChangePhase")

	PLUGIN.NextBlowout = CurTime() + 600
	
	PLUGIN.NextThink = 0

	PLUGIN.BlowoutVars = PLUGIN.BlowoutVars or {}
	PLUGIN.BlowoutVars.BlowoutStarted 	= false
	PLUGIN.BlowoutVars.PrehitTime  		= 0
	PLUGIN.BlowoutVars.BlastTime   		= 0
	PLUGIN.BlowoutVars.BuildupTime 		= 0
	PLUGIN.BlowoutVars.BlowoutHitTime   = 0
	PLUGIN.BlowoutVars.FinalSoundTime   = 0

	PLUGIN.BlowoutVars.NextAmbientSound = 0
	PLUGIN.BlowoutVars.NextHitSound 	= 0
	PLUGIN.BlowoutVars.BlowoutStep 		= 0

	PLUGIN.BlowoutVars.PostHitActionTime= 0
	PLUGIN.BlowoutVars.BlowoutFinishTime= 0

	function PLUGIN:Think()
		local CT = CurTime()
		if CT < self.NextThink then return end


		if self.NextBlowout < CurTime() and (!self.BlowoutVars.BlowoutStarted) then
			self.BlowoutVars.BlowoutStarted = true
			local dur = 30 --time until blowout hits - 60-90s probably

			self:ChangePhase(1, dur)
			self.BlowoutVars.PrehitTime  = CT + dur - 6
			self.BlowoutVars.BlastTime   = CT + dur

			self.BlowoutVars.BlowoutStep = 1

			self:PlaySoundOnClient( "announce1" )
		end

		if( self.BlowoutVars.BlowoutStarted ) then
			self.NextThink = CT + 0.25

			if( self.BlowoutVars.PrehitTime < CT and self.BlowoutVars.BlowoutStep < 2 ) then
				self.BlowoutVars.BlowoutStep = 2
				self:PlaySoundOnClient( "prehit" )
				print("Prehit - phase 2")
			end

			if( self.BlowoutVars.BlastTime < CT and self.BlowoutVars.BlowoutStep < 3 ) then
				self.BlowoutVars.BlowoutStep = 3
				self.BlowoutVars.BlowoutHitTime = CT + 18
				self.BlowoutVars.BuildupTime = CT + 2
				self.BlowoutVars.FinalSoundTime = CT + 17.25
				self:PlaySoundOnClient( "start" )
				self:ChangePhase(2, 0)

				print("Start - phase 3")

				local e=ents.Create("env_shake")	--Shake the world a little
				e:SetKeyValue( "amplitude", "1")
				e:SetKeyValue("frequency","100.0")
				e:SetKeyValue("duration","10")
				e:SetKeyValue("spawnflags", "5")
				e:Fire("startshake")
			end

			if( self.BlowoutVars.BuildupTime < CT and self.BlowoutVars.BlowoutStep == 3 ) then
				self.BlowoutVars.BlowoutStep = 4
				self:PlaySoundOnClient( "buildup" )

				print("buildup - phase 4")
			end

			if( self.BlowoutVars.FinalSoundTime < CT and self.BlowoutVars.BlowoutStep == 4 ) then
				self.BlowoutVars.BlowoutStep = 5
				self:PlaySoundOnClient( "end" )
				print("end - phase 5")
			end

			if( self.BlowoutVars.BlowoutHitTime < CT and self.BlowoutVars.BlowoutStep == 5 ) then
				self.BlowoutVars.BlowoutStep = 6

				local movetypes = {
					[0] = true,
					[5] = true,
					[8] = true,
					[10] = true
				}

				for _, v in pairs(player.GetAll()) do

					if (!self:IsPosSafe(v:GetShootPos()) or !movetypes[v:GetMoveType()]) then
						v:Kill()
					end

					
				end
				self:ChangePhase(3, 0)

				ix.plugin.list["anomalycontroller"]:cleanAnomalies()
				ix.plugin.list["anomalycontroller"]:spawnAnomalies()
				
				print("killing - phase 6")
				self.BlowoutVars.PostHitActionTime = CT+1
			end

			if( self.BlowoutVars.PostHitActionTime < CT and self.BlowoutVars.BlowoutStep > 5 ) then
				if( self.BlowoutVars.BlowoutStep < 7 ) then
					self.BlowoutVars.BlowoutStep = 7
					self.BlowoutVars.PostHitActionTime = CT + 6
					print("waiting - phase 7")
				elseif( self.BlowoutVars.BlowoutStep < 8 ) then
					self.BlowoutVars.BlowoutStep = 8
					self.BlowoutVars.PostHitActionTime = CT + 3.5
					self:ChangePhase(4, 3.5)
					print("clearing up - phase 8")
				elseif( self.BlowoutVars.BlowoutStep < 9 ) then
					self.BlowoutVars.BlowoutStep = 9
					self.BlowoutVars.PostHitActionTime = CT + 8
					self:ChangePhase(5,CurTime()+20)
					print("finishing - phase 9")

				elseif( self.BlowoutVars.BlowoutStep < 10 ) then
					self.BlowoutVars.BlowoutStep = 10
					self:PlaySoundOnClient( "posthit" )
					self.BlowoutVars.PostHitActionTime = CT + 12
					print("announce - phase 10")

					self:ResetBlowoutVars()
				elseif( self.BlowoutVars.BlowoutStep < 11 ) then
					self:ChangePhase(0,0)
					self:ResetBlowoutVars()

					print("done - phase 11")
				end
			end

			if self.BlowoutVars.NextHitSound < CT and self.BlowoutVars.BlowoutStep > 3 then		
				self.BlowoutVars.NextHitSound = CT + math.Rand(0.75,4)
				self:PlaySoundOnClient( "hit" )		--Play the thunder sounds

				local e=ents.Create("env_shake")	--Shake the world a little
				e:SetKeyValue( "amplitude", "3")
				e:SetKeyValue("frequency","100.0")
				e:SetKeyValue("duration","10")
				e:SetKeyValue("spawnflags", "5")
				e:Fire("startshake")
			end

			if self.BlowoutVars.NextAmbientSound == 0 then
				self.BlowoutVars.NextAmbientSound = CT + 5
			elseif CT > self.BlowoutVars.NextAmbientSound then
				self.BlowoutVars.NextAmbientSound = CT + math.random(15,20)
				self:PlaySoundOnClient( "ambient" )
			end
		end
	end

	function PLUGIN:PlaySoundOnClient(snd)
		local ID = 0
		if snd == "announce1" then ID = 1
		elseif snd == "announce2" then ID = 2
		elseif snd == "prehit" then ID = 3
		elseif snd == "ambient" then ID = math.random(4,8)
		elseif snd == "start" then ID = 9
		elseif snd == "buildup" then ID = 10
		elseif snd == "hit" then ID = math.random(11,13)
		elseif snd == "end" then ID = 14
		elseif snd == "posthit" then ID = 15
		end

		if ID > 0 then
			net.Start("BlowoutPlaySound")
				net.WriteUInt(ID, 8)
			net.Broadcast()
		end
	end


	function PLUGIN:ChangePhase(phase,duration)
		net.Start("BlowoutChangePhase")
			net.WriteUInt(phase, 8)
			net.WriteFloat(duration or 0)
		net.Broadcast()
	end

	function PLUGIN:IsPosSafe(pos)
		local tracedata_up = {}
		tracedata_up.start = pos
		tracedata_up.endpos = pos + Vector(0,0,999999)
		tracedata_up.mask = MASK_SOLID + MASK_WATER 
		local trace_up = util.TraceLine(tracedata_up)	--Can the entity see the sky?
    
		if trace_up.HitSky then
			local Pos_up = trace_up.HitPos
			local tracedata_down = {}
			tracedata_down.start = Pos_up
			tracedata_down.endpos = pos
			tracedata_down.mask = MASK_SOLID + MASK_WATER 
			local trace_down = util.TraceLine(tracedata_down)	--Can the sky see the entity? (excludes entities that are below displacements or inside brushes)
		
			if (!trace_down.Hit) then
				return false
			end
		
			return true
		end

		return true
	end

	function PLUGIN:ResetBlowoutVars()
		self.BlowoutVars.BlowoutStarted 	= false
		self.BlowoutVars.PrehitTime  		= 0
		self.BlowoutVars.BlastTime   		= 0
		self.BlowoutVars.BuildupTime 		= 0
		self.BlowoutVars.BlowoutHitTime   	= 0
		self.BlowoutVars.FinalSoundTime  	= 0
	
		self.BlowoutVars.NextAmbientSound 	= 0
		self.BlowoutVars.NextHitSound 		= 0
		self.BlowoutVars.BlowoutStep 		= 0
	
		self.BlowoutVars.PostHitActionTime	= 0
		self.BlowoutVars.BlowoutFinishTime	= 0

		self.NextBlowout = CurTime() + 600
	end
end

ix.command.Add("blowouttrigger", {
	adminOnly = true,
	OnRun = function(self, client)
		PLUGIN.NextBlowout = CurTime()
	end
})