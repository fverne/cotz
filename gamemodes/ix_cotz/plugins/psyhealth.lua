PLUGIN.name = "PsyHealth System"
PLUGIN.author = "gumlefar"
PLUGIN.description = "A PsyHealth system akin to the STALKER games."

ix.config.Add("PsyHealthRecoverTime", 30, "How many seconds it takes to restore 1 percent PsyHealth.", nil, {
	data = { min = 30, max = 3600 },
	category = "Player",
})

ix.char.RegisterVar("PsyHP", {
	field = "PsyHP",
	fieldType = ix.type.number,
	default = 100,
	bNoDisplay = true,
})

if SERVER then
	function PLUGIN:OnCharacterCreated(client, character)
		character:SetPsyHP(100)
	end

	function PLUGIN:PlayerLoadedCharacter(client, character)
		timer.Simple(0.25, function()
			client:SetLocalVar("psyhealth", character:GetPsyHP())
		end)

		timer.Simple(1, function()
			client:UpdatePsyHealthState(client)
		end)
	end

	function PLUGIN:CharacterPreSave(character)
		local client = character:GetPlayer()

		if IsValid(client) then
			character:SetPsyHP(client:GetLocalVar("psyhealth", 0))
		end
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:DamagePsyHealth(amount)
		local char = self:GetCharacter()

		if char then
			char:SetPsyHP(char:GetPsyHP() - amount)
			self:SetLocalVar("psyhealth", char:GetPsyHP() - amount)
		end
	end

	function playerMeta:HealPsyHealth(amount)
		self:DamagePsyHealth(-amount)
	end

	function playerMeta:SetPsyHealth(amount)
		local char = self:GetCharacter()

		if char then
			char:SetPsyHP(amount)
			self:SetLocalVar("psyhealth", amount)
		end
	end

	function playerMeta:TickPsyHealth(amount)
		local char = self:GetCharacter()

		if char then
			char:SetPsyHP(char:GetPsyHP() + amount)
			self:SetLocalVar("psyhealth", char:GetPsyHP() + amount)

			if char:GetPsyHP() > 100 then
				char:SetPsyHP(100)
				self:SetLocalVar("psyhealth", 100)
			end
			self:UpdatePsyHealthState(self)
		end
	end

	function PLUGIN:PlayerTick(ply)
		if ply:GetNetVar("psyhealthtick", 0) <= CurTime() then
			ply:SetNetVar("psyhealthtick", ix.config.Get("PsyHealthRecoverTime", 30) + CurTime())
			ply:TickPsyHealth(1)
		end
	end

	function playerMeta:UpdatePsyHealthState(client)
		if self:GetNetVar("ix_psysuppressed", false) then
			return
		end
	end
end

local playerMeta = FindMetaTable("Player")

function playerMeta:GetPsyHealth()
	local char = self:GetCharacter()

	if char then
		return self:GetLocalVar("psyhealth", 100)
	end
end

local BLUR_MATERIAL = CLIENT and Material("pp/blurscreen")
local PSY_ICON = "stalker/ui/psy.png"

function PLUGIN:PreDrawHUD()
	local lp = LocalPlayer()

	if not lp:GetCharacter() or not lp:Alive() or ix.gui.characterMenu:IsVisible() then
		return
	end

	if lp:GetNWBool("ix_psysuppressed") then
		return
	end

	local psyDamageBeforeSuppression = (100 - lp:GetPsyHealth())

	if lp:GetNetVar("ix_psysuppressed", false) then
		psyDamageBeforeSuppression = psyDamageBeforeSuppression / 2
	end

	if psyDamageBeforeSuppression > 25 then
		local psyDamage =
			math.Clamp((ix.util.mapValueToRange(psyDamageBeforeSuppression, 25, 100, 0, 100) / 100), 0, 1)

		local tab = {
			["$pp_colour_addr"] = 0.01 * (psyDamage * 2),
			["$pp_colour_addg"] = 0.02 * (psyDamage * 2),
			["$pp_colour_addb"] = 0.3 * (psyDamage * 2),
			["$pp_colour_brightness"] = -0.33 * (psyDamage * 2),
			["$pp_colour_contrast"] = 1 - (0.22 * (psyDamage * 2)),
			["$pp_colour_colour"] = 1 - (0.5 * (psyDamage * 2)),
		}

		DrawColorModify(tab)

		DrawMotionBlur(0.3, 0.3 * (psyDamage * 2), 0.001)

		DrawMaterialOverlay("effects/water_warp01", math.sin(CurTime()) * psyDamage * 0.1)

		if psyDamageBeforeSuppression > 75 then
			local shakeValue = ix.util.mapValueToRange(psyDamage, 0.75, 1, 0, 1)
			util.ScreenShake(LocalPlayer():GetPos(), shakeValue * 7, shakeValue * 2, 0.2, 5)
		end

		cam.Start2D()

		local x, y = 0, 0
		local scrW, scrH = ScrW(), ScrH()
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(BLUR_MATERIAL)

		for i = 1, 3 do
			BLUR_MATERIAL:SetFloat("$blur", (psyDamage * 1.5) * i)
			BLUR_MATERIAL:Recompute()
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

		if not target then
			client:Notify("Invalid Target!")

			return
		end
		target:SetPsyHealth(psyhealth)

		if client == target then
			client:Notify("You have set your psyhealth to " .. psyhealth)
		else
			client:Notify("You have set " .. target:Name() .. "'s psyhealth to " .. psyhealth)
			target:Notify(client:Name() .. " has set your psyhealth to " .. psyhealth)
		end
		target:UpdatePsyHealthState(target)
	end,
})

function PLUGIN:EntityTakeDamage(entity, dmgInfo)
	-- Prevent custom damage side effects regardless of hook execution order.
	if hook.Run("ShouldBlockSafeZoneDamage", entity, dmgInfo) then
		dmgInfo:SetDamage(0)

		return true
	end
	if entity:IsPlayer() and entity:GetCharacter() and dmgInfo:IsDamageType(DMG_SONIC) then
		local damage = dmgInfo:GetDamage()
		local perRes = entity:GetNWFloat("ixperpsyres")
		local flatRes = entity:GetNWInt("ixflatpsyres")

		damage = damage - flatRes
		damage = damage * perRes

		damage = math.max(damage, 0)

		entity:DamagePsyHealth(damage)
		dmgInfo:SetDamage(0)

		if entity:GetPsyHealth() < 0 and entity:Alive() then
			entity:Kill()
		end
	end
end

if SERVER then
	function PLUGIN:PlayerDeath(client)
		client.resetPsyHealth = true
	end

	function PLUGIN:PlayerSpawn(client)
		if client.resetPsyHealth then
			client:SetPsyHealth((math.max(65, client:GetPsyHealth())))
			client.resetPsyHealth = nil
		end
	end
end

function PLUGIN:HUDPaint()
	local lp = LocalPlayer()
	if
		not lp:GetCharacter()
		or not lp:Alive()
		or ix.gui.characterMenu:IsVisible()
		or ix.option.Get("disablehud", false)
	then
		return
	end

	ix.util.DrawStatusIcon(PSY_ICON, lp:GetPsyHealth(), ScrW() * 0.94, ScrH() * 0.79)
end
