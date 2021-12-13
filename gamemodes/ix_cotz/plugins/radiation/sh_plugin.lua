local PLUGIN = PLUGIN
PLUGIN.name = "Radiation"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Radiation System"

ix.util.Include("cl_plugin.lua")

ix.char.RegisterVar("radiation", {
	field = "radiation",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
})

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")

function playerMeta:getRadiation()
	return (self:GetNetVar("radiation")) or 0
end

function playerMeta:getRadiationPercent()
	return math.Clamp(self:getRadiation()/100, 0 ,1)
end

function playerMeta:addRadiation(amount)
	local curRadiation = self:getRadiation()

	self:SetNetVar("radiation", 
		math.Clamp(math.min(curRadiation) + amount, 0, 100)
	)
end

function playerMeta:setRadiation(amount)
	
	self:SetNetVar("radiation", math.Clamp(amount, 0, 100))
end

function playerMeta:hasGeiger()
	return self:GetNetVar("ixhasgeiger", false)
end

function PLUGIN:PostPlayerLoadout(client)
	if client:GetData("ixhasgeiger", false) then
		client:SetNetVar("ixhasgeiger", false)
	end
end

function playerMeta:getRadResist()
	local res = 0
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems(true)

	for j, i in pairs(items) do
		if (i.radProt and i:GetData("equip") == true) then
			res = res + i.radProt
			break
		end
	end

	if ix.plugin.list["buffs"] then
		if self:HasBuff("buff_radprotect") then
			res = res + 0.1
		end
	end

	return res
end

function PLUGIN:EntityTakeDamage(entity, dmgInfo)
	--RADIATION OVERRIDE
	if ( entity:IsPlayer() and entity:Alive() and dmgInfo:IsDamageType(DMG_RADIATION)) then
		local radAmount = (dmgInfo:GetDamage()/10)
		local radResist = entity:getRadResist()
		
		entity:addRadiation(math.Clamp(radAmount - radResist ,0, 100))
		dmgInfo:SetDamage(0)
	end
end

-- Register HUD Bars.
if (CLIENT) then
	function PLUGIN:RenderScreenspaceEffects()
		if (LocalPlayer():getRadiation() > 45 and LocalPlayer():getRadiation() < 75) then
			DrawMotionBlur(0.1, 0.3, 0.01)
		elseif(LocalPlayer():getRadiation() > 75) then
			DrawMotionBlur(0.1, 0.7, 0.01)
		end
    end
else
	local PLUGIN = PLUGIN
	
	function PLUGIN:CharacterPreSave(character)
		local savedRads = math.Clamp(character.player:getRadiation(), 0, 100)
		character:SetRadiation(savedRads)
	end

	function PLUGIN:PostPlayerLoadout(client)
		if (client:GetCharacter():GetRadiation()) then
			client:SetNetVar("radiation", client:GetCharacter():GetRadiation())
		else
			client:SetNetVar("radiation", 0)
		end
	end

	function PLUGIN:PlayerDeath(client)
		client.resetRads = true
	end

	function PLUGIN:PlayerSpawn(client)
		if (client.resetRads) then
			client:SetNetVar("radiation", math.min(44, client:GetNetVar("radiation", 0)))
			if (client:GetCharacter()) then client:GetCharacter():SetRadiation(math.min(44, client:GetNetVar("radiation", 0))) end
			client.resetRads = false
		end
	end

	local thinkTime = CurTime()
	local damageTime = CurTime()
	function PLUGIN:Think()
		if (thinkTime < CurTime()) then
			for k, v in ipairs(player.GetAll()) do
				if v:GetNetVar("radiation", 0) == 100 then
					if v:Alive() then
						v:Kill()
						ix.log.Add(v, "playerDeath", "radiation")
					end
				end	
			end
			thinkTime = CurTime() + .5
		end
		
		--damage
		if (damageTime < CurTime()) then
			for k, v in ipairs(player.GetAll()) do
				if (v:Alive()) then
					if (v:GetNetVar("radiation", 0) > 45 and v:GetNetVar("radiation", 0) < 75) then
						v:addRadiation(-0.5)
						v:SetHealth(v:Health()-1)
						if(v:Health() <= 0) then v:Kill() end
					elseif (v:GetNetVar("radiation", 0) > 75) then
						v:addRadiation(-0.5)
						v:SetHealth(v:Health()-2)
						if(v:Health() <= 0) then v:Kill() end
					end
				end
			end
			damageTime = CurTime() + 5
		end
	end
end

ix.command.Add("charsetradiation", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number,
	},
	OnRun = function(self, client, target, radiation)
		local target = ix.util.FindPlayer(target)
		local radiation = tonumber(radiation)

		target:setRadiation(radiation)

		if client == target then
            client:Notify("You have set your radiation to "..radiation)
        else
            client:Notify("You have set "..target:Name().."'s radiation to "..radiation)
            target:Notify(client:Name().." has set your radiation to "..radiation)
        end
	end
})
