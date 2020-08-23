PLUGIN.name = "PsyHealth System"
PLUGIN.author = "some faggot"
PLUGIN.description = "A PsyHealth system akin to the STALKER games."

ix.config.Add("PsyHealthRecoverTime", 600, "How many seconds it takes to restore 1 percent PsyHealth.", nil, {
	data = {min = 30, max = 3600},
	category = "Player"
})


if SERVER then
	function PLUGIN:OnCharacterCreated(client, character)
		character:SetData("psyhealth", 100)
	end

	function PLUGIN:PlayerLoadedCharacter(client, character)
		timer.Simple(0.25, function()
			client:SetLocalVar("psyhealth", character:GetData("psyhealth", 100))
			
		end)

		timer.Simple(1, function()
			client:UpdatePsyHealthState(client)
		end)
	end

	function PLUGIN:CharacterPreSave(character)
		local client = character:GetPlayer()

		if (IsValid(client)) then
			character:SetData("psyhealth", client:GetLocalVar("psyhealth", 0))
		end
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:DamagePsyHealth(amount)
		local char = self:GetCharacter()

		if (char) then
			char:SetData("psyhealth", char:GetData("psyhealth", 100) - amount)
			self:SetLocalVar("psyhealth", char:GetData("psyhealth", 100) - amount)
		end
	end

	function playerMeta:HealPsyHealth(amount)
		self:DamagePsyHealth(-amount)
	end

	function playerMeta:SetPsyHealth(amount)
		local char = self:GetCharacter()

		if (char) then
			char:SetData("psyhealth", amount)
			self:SetLocalVar("psyhealth", amount)
		end
	end

	function playerMeta:TickPsyHealth(amount)
		local char = self:GetCharacter()

		if (char) then
			char:SetData("psyhealth", char:GetData("psyhealth", 100) + amount)
			self:SetLocalVar("psyhealth", char:GetData("psyhealth", 100) + amount)

			if char:GetData("psyhealth", 100) > 100 then
				char:SetData("psyhealth", 100)
				self:SetLocalVar("psyhealth", 100)
			end
			self:UpdatePsyHealthState(self)
		end
	end

	local TEMP_CAMSHAKENUM = 0
	local TEMP_CAMSHAKESIDE = -1

	function PLUGIN:PlayerTick(ply)
		if ply:GetNetVar("psyhealthtick", 0) <= CurTime() then
			ply:SetNetVar("psyhealthtick", ix.config.Get("PsyHealthRecoverTime", 600) + CurTime())
			ply:TickPsyHealth(1)
		end
	end

	function playerMeta:UpdatePsyHealthState(client)

		if (self:GetNetVar("ix_psysuppressed", false)) then return end --if psysuppressed, we dont do anything
		--Do whatever PsyHealth will do in here
	end
end



local playerMeta = FindMetaTable("Player")

function playerMeta:GetPsyHealth()
	local char = self:GetCharacter()

	if (char) then
		return char:GetData("psyhealth", 100)
	end
end

function playerMeta:GetPsyResist()
	local res = 0
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems(true)

	for j, i in pairs(items) do
		if (i.psyProt and i:GetData("equip") == true) then
			res = res + i.psyProt
			break
		end
	end

	res = res + self:GetNetVar("ix_psyblock",0)

	return res
end

function PLUGIN:PreDrawHUD()
	local lp = LocalPlayer()
	local wep = LocalPlayer():GetActiveWeapon()
	local char = lp:GetCharacter()

	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible()) then return end

	if (lp:GetNWBool("ix_psysuppressed")) then return end

	local psydmgPre = (100 - lp:GetPsyHealth())

	if psydmgPre > 25 then
		local psydmg = math.Clamp((ix.util.mapValueToRange(psydmgPre,25,100,0,100)/100),0,1)

		local tab = {
			[ "$pp_colour_addr" ] = 0.01*(psydmg*2),
			[ "$pp_colour_addg" ] = 0.02*(psydmg*2),
			[ "$pp_colour_addb" ] = 0.3*(psydmg*2),
			[ "$pp_colour_brightness" ] = -0.33*(psydmg*2),
			[ "$pp_colour_contrast" ] = 1-(0.22*(psydmg*2)),
			[ "$pp_colour_colour" ] = 1-(0.7*(psydmg*2)),
		}

		DrawColorModify( tab )
				
		DrawMotionBlur( 0.3, 0.9*(psydmg*2), 0.001 )

		if psydmgPre > 75 then
			local shakeval = ix.util.mapValueToRange(psydmg,0.75,1,0,1)
			util.ScreenShake( LocalPlayer():GetPos(), shakeval*7, shakeval*2, 0.2, 5 )
		end
				
		local TEMP_BLUR = Material("pp/blurscreen")
		cam.Start2D()
			
			

			local x, y = 0, 0
			local scrW, scrH = ScrW(), ScrH()
			surface.SetDrawColor(255, 255, 255)
			surface.SetMaterial( TEMP_BLUR )
					
			for i = 1, 3 do
				TEMP_BLUR:SetFloat("$blur", (psydmg*3)*i)
				TEMP_BLUR:Recompute()
				render.UpdateScreenEffectTexture()
				surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
			end
		cam.End2D()
	end
end

ix.command.Add("CharSetPsyHealth", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number,
	},
	OnRun = function(self, client, target, psyhealth)
		local target = ix.util.FindPlayer(target)
		local psyhealth = tonumber(psyhealth)
		
		if !target then
			client:Notify("Invalid Target!")
			return
		end
		target:SetPsyHealth(psyhealth)

		if client == target then
            client:Notify("You have set your psyhealth to "..psyhealth)
        else
            client:Notify("You have set "..target:Name().."'s psyhealth to "..psyhealth)
            target:Notify(client:Name().." has set your psyhealth to "..psyhealth)
        end
        target:UpdatePsyHealthState(target)
	end
})

function PLUGIN:EntityTakeDamage(entity, dmgInfo)
	--SONIC OVERRIDE
	if ( entity:IsPlayer() and dmgInfo:IsDamageType(DMG_SONIC)) then
		local dmgAmount = dmgInfo:GetDamage()
		local psyResist = entity:GetPsyResist()
		
		entity:DamagePsyHealth(math.Clamp(dmgAmount *((100-psyResist)/100) ,0, 100))
		dmgInfo:SetDamage(0)
	end
end

if (SERVER) then
	function PLUGIN:PlayerDeath(client)
		client.resetPsyHealth = true
	end

	function PLUGIN:PlayerSpawn(client)
		if (client.resetPsyHealth) then
			client:SetPsyHealth(75)
			client.resetPsyHealth = nil
		end
	end
end