PLUGIN.name = "Stamina"
PLUGIN.author = "Chessnut"
PLUGIN.description = "Adds a stamina system to limit running."

-- luacheck: push ignore 631
ix.config.Add("staminaDrain", 1, "How much stamina to drain per tick (every quarter second). This is calculated before attribute reduction.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaRegeneration", 1.75, "How much stamina to regain per tick (every quarter second).", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaCrouchRegeneration", 2, "How much stamina to regain per tick (every quarter second) while crouching.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("punchStamina", 10, "How much stamina punches use up.", nil, {
	data = {min = 0, max = 100},
	category = "characters"
})
-- luacheck: pop
local function CalcStaminaChange(client)
	local character = client:GetCharacter()

	if (!character or client:GetMoveType() == MOVETYPE_NOCLIP) then
		return 0
	end

	local runSpeed

	if (SERVER) then
		runSpeed = ix.config.Get("runSpeed") + character:GetAttribute("stm", 0)

		if (client:WaterLevel() > 1) then
			runSpeed = runSpeed * 0.775
		end
	end

	local walkSpeed = ix.config.Get("walkSpeed")
	local maxAttributes = ix.config.Get("maxAttributes", 100)
	local offset

	if (client:KeyDown(IN_SPEED) and client:GetVelocity():LengthSqr() >= (walkSpeed * walkSpeed)) then
		-- characters could have attribute values greater than max if the config was changed
		offset = -ix.config.Get("staminaDrain", 1) + math.min(character:GetAttribute("end", 0), maxAttributes) / 100
	else
		offset = client:Crouching() and ix.config.Get("staminaCrouchRegeneration", 2) or ix.config.Get("staminaRegeneration", 1.75)
	end

	offset = hook.Run("AdjustStaminaOffset", client, offset) or offset

	if (CLIENT) then
		return offset -- for the client we need to return the estimated stamina change
	else
		local current = client:GetLocalVar("stm", 0)
		local value = math.Clamp(current + offset, 0, 100)

		if (current != value) then
			client:SetLocalVar("stm", value)

			if (value == 0 and !client:GetNetVar("brth", false)) then
				client:SetRunSpeed(walkSpeed)
				client:SetNetVar("brth", true)
				client:EmitSound("stalkersound/breath_1.ogg", 80, 100, 1)

				--character:UpdateAttrib("end", 0.1)
				--character:UpdateAttrib("stm", 0.01)

				hook.Run("PlayerStaminaLost", client)
			elseif (value >= 50 and client:GetNetVar("brth", false)) then
				if client:GetCharacter():Overweight() then
					client:SetRunSpeed(walkspeed)
				else
					client:SetRunSpeed(runSpeed)
				end
				client:SetNetVar("brth", nil)

				hook.Run("PlayerStaminaGained", client)
			end
		end
	end
end

if (CLIENT) then
	-- should disable jumping, needs testing though
	local function NoJump( cmd )
		if bit.band(cmd:GetButtons(), IN_JUMP) > 0 then
			cmd:SetButtons( cmd:GetButtons() - IN_JUMP )
		end
	end

	-- if the char is out of breath, disallow jumping
	function PLUGIN:CreateMove(cmd)
		if LocalPlayer():GetNetVar("brth", false) then
			NoJump(cmd)
		end
	end
end

if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
		local uniqueID = "ixStam" .. client:SteamID()

		timer.Create(uniqueID, 0.25, 0, function()
			if (!IsValid(client)) then
				timer.Remove(uniqueID)
				return
			end

			CalcStaminaChange(client)
		end)
	end

	function PLUGIN:CharacterPreSave(character)
		local client = character:GetPlayer()

		if (IsValid(client)) then
			character:SetData("stamina", client:GetLocalVar("stm", 0))
		end
	end

	function PLUGIN:PlayerLoadedCharacter(client, character)
		timer.Simple(0.25, function()
			client:SetLocalVar("stm", character:GetData("stamina", 100))
		end)
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:RestoreStamina(amount)
		local current = self:GetLocalVar("stm", 0)
		local value = math.Clamp(current + amount, 0, 100)

		self:SetLocalVar("stm", value)
	end

	function playerMeta:ConsumeStamina(amount)
		local current = self:GetLocalVar("stm", 0)
		local value = math.Clamp(current - amount, 0, 100)

		self:SetLocalVar("stm", value)
	end

else

	local predictedStamina = 100

	function PLUGIN:Think()
		local offset = CalcStaminaChange(LocalPlayer())
		-- the server check it every 0.25 sec, here we check it every [FrameTime()] seconds
		offset = math.Remap(FrameTime(), 0, 0.25, 0, offset)

		if (offset != 0) then
			predictedStamina = math.Clamp(predictedStamina + offset, 0, 100)
		end
	end

	function PLUGIN:OnLocalVarSet(key, var)
		if (key != "stm") then return end
		if (math.abs(predictedStamina - var) > 5) then
			predictedStamina = var
		end
	end

	function PLUGIN:HUDPaint()
		if (!LocalPlayer():GetCharacter() or !LocalPlayer():Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end

		local Texture2 = Material("cotz/panels/hp1.png", "noclamp smooth")

		surface.SetMaterial(Texture2)
		surface.SetDrawColor(Color(170, 170, 255, 255))
		surface.DrawTexturedRectUV(ScrW()*0.05, ScrH()*0.92,  math.Clamp(math.Round(predictedStamina / 100, 3), 0, 1) * ScrW()*0.15, ScrH()*0.008, 0, 0,  math.Clamp(math.Round(predictedStamina / 100, 3), 0, 1), 0)
	end

/*
	ix.bar.Add(function()
		return predictedStamina / 100
	end, Color(200, 200, 40), nil, "stm")*/
end
