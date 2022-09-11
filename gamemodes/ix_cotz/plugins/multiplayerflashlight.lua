PLUGIN.name = "Better Multiplayer Flashlight"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "This plugin makes your flashlight feels like it's from L4D2"



local meta = FindMetaTable("Player")

if (CLIENT) then
	if (FLASHES) then
		for k, v in pairs(FLASHES) do
			v:Remove()
		end
	end

	local flashType = {
		{"effects/flashlight001", 1024, 3},
		{"effects/flashlight001", 512, 3},
		{"effects/flashlight/flight04", 600, 2},
		{"effects/flashlight/hard", 512, 1},
		{"effects/flashlight/hard", 512, .5},
		{"effects/flashlight/soft", 600, 3},
		{"effects/flashlight/soft", 600, 1},
	}

	function meta:getFlashType()
		return 1
	end


	FLASHES = {}

	local matLight = Material( "sprites/light_ignorez" )
	local matBeam = Material( "effects/lamp_beam" )


	local function flashlightThink(client)
		if (client:GetNWBool("customFlashlight") != true) then 
			if (client.flash) then
				 client.flash:Remove()
			end
				 
			return
		end

		if (!IsValid(client.flash)) then
			client.flash = ProjectedTexture()
			FLASHES[client] =  client.flash
			
		end

		if (!client.flash) then return end

		

		local pos, ang = client:EyePos(), client:EyeAngles()
		pos = pos + ang:Forward() * 5
		pos = pos + ang:Up() * 3.5
		pos = pos + ang:Right() * -3

			 
		local flashlightInfo = client:getFlashType()
		client.flash:SetFOV(60)
		client.flash:SetFarZ(flashType[flashlightInfo or 1][2])
		client.flash:SetNearZ(1)
		client.flash:SetPos(pos)
		client.flash:SetAngles(ang)
		client.flash:SetTexture(flashType[flashlightInfo or 1][1])
		client.flash:SetColor(Color(255, 255, 255))
		client.flash:SetBrightness(flashType[flashlightInfo or 1][3])

		client.flash:SetEnableShadows(false)
		client.flash:Update()

		if (not client:GetNoDraw()) then

			client.pxvs = client.pxvs or util.GetPixelVisibleHandle()
			local isVisible = util.PixelVisible( pos, 16, client.pxvs )

			local dist = client:GetPos():Distance(LocalPlayer():GetPos())
			if ( dist > 512 ) then isVisible = 0 end

			local plyang = LocalPlayer():EyeAngles()
			local cliang = client:EyeAngles()

			cliang:Sub(Angle(0,180,0))
			cliang:Sub(plyang)
			cliang:Normalize()
			local cp, cy, cr = cliang:Unpack()
			if ( cp > 45 or cp < -45 or cy > 45 or cy < -45 or cr > 45 or cr < -45 ) then
				isVisible = 0
			end

			if ( isVisible == 0 ) then return end
			local size = 8 * isVisible

			local spritepos, spriteang = client:GetBonePosition(client:LookupBone("ValveBiped.Bip01_Head1") or 1)

			spriteang[1] = spriteang[1]+75
			--spritepos = spritepos + spriteang:Forward() * 5
			spritepos = spritepos + spriteang:Up() * 3.5
			spritepos = spritepos + spriteang:Right() * -2.8

			render.SetMaterial( matLight )
			render.DrawSprite( spritepos, size, size, Color( 255, 255, 255, 20 ) )
									
			render.SetMaterial( matBeam )

			render.StartBeam( 3 )
				render.AddBeam( spritepos + spriteang:Forward() * 1, size, 0.0, Color( 255, 255, 255, 20 * isVisible ) )
				render.AddBeam( spritepos + spriteang:Forward() * 10, size, 0.5, Color( 255, 255, 255, 10 * isVisible ) )
				render.AddBeam( spritepos + spriteang:Forward() * 20, size, 1, Color( 255, 255, 255, 10 * isVisible) )
			render.EndBeam()
		end
	end
		
	function PLUGIN:PostPlayerDraw(client)
		flashlightThink(client)
	end

	function PLUGIN:PreDrawTranslucentRenderables()
		if (LocalPlayer() and LocalPlayer():GetCharacter() and !LocalPlayer():ShouldDrawLocalPlayer()) then
			flashlightThink(LocalPlayer())
		end

	    for client, flash in pairs(FLASHES) do
			if (!client or !IsValid(client) or !client:IsPlayer()) then
				 flash:Remove()
				 FLASHES[client] = nil
					 
				 continue
			end

			if (client:GetNWBool("customFlashlight") != true) then 
				if (flash) then
					flash:Remove()
				end
					
				continue
			end

			local dist = client:GetPos():Distance(LocalPlayer():GetPos())

			if (dist > 512) then
				if (IsValid(client.flash)) then
					client.flash:Remove()
				end
				continue
			end

			if (!client:Alive()) then
				if (client.flash and client.flash.Remove) then
					client.flash:Remove()
				end

				continue
			end

			if (client:GetNWBool("customFlashlight") != true) then
				if (client.flash and client.flash.Remove) then
					client.flash:Remove()
				end

				continue
			end
		end
	end
else
	function PLUGIN:PlayerDeath(client)
		client:SetNWBool("customFlashlight", false)
	end
		
	function meta:FlashlightIsOn()
		return self:GetNWBool("customFlashlight", false)
	end

	function PLUGIN:PlayerSwitchFlashlight(client, bEnabled)
		local character = client:GetCharacter()
		if (character and character:GetData("headlamp", false) == true) then
		 	client:SetNWBool("customFlashlight", not client:GetNWBool("customFlashlight"))
		 	client:EmitSound("items/flashlight1.wav")
			return false
		end
	end
end

ix.command.Add("flashlightdebugon", {
	adminOnly = true,
	OnRun = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:IsPlayer()) then
			ent:SetNWBool("customFlashlight", true)
			client:Notify("attempted to force flashlight on")
		end
	end
})

ix.command.Add("flashlightdebugoff", {
	adminOnly = true,
	OnRun = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:IsPlayer()) then
			ent:SetNWBool("customFlashlight", false)
			client:Notify("attempted to force flashlight off")
		end
	end
})