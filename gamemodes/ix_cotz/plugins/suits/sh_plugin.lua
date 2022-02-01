local PLUGIN = PLUGIN
PLUGIN.name = "Suits"
PLUGIN.author = "Subleader and Alexgrist and verne (Outfit base used)"
PLUGIN.desc = "Compatible with bad air and localized damage, plus it adds damage resistance"

ix.util.Include("cl_plugin.lua")

ix.config.Add("disablePVP", true, "If true, disables player versus player damage.", nil, {
	category = "pvp"
})

function PLUGIN:EntityTakeDamage( target, dmginfo )
	--disable pvp
	if (ix.config.Get("disablePVP", true)) then
		if target:IsPlayer() and dmginfo:GetAttacker():IsPlayer() and (target != dmginfo:GetAttacker()) then
			return true
		end
	end

    -- Bullet resistance
	if ( target:IsPlayer() and dmginfo:IsDamageType(DMG_BULLET)) then
		local damage = dmginfo:GetDamage()
		local perRes = target:GetNWFloat("ixperbulletres")
		local flatRes = target:GetNWInt("ixflatbulletres")
		local suitDuraDmg = damage / 100
		local suit = target:getEquippedBodyArmor()

		if suit != nil then
			suit:SetData("durability", math.Clamp(suit:GetData("durability", 100) - suitDuraDmg, 0, 100))
		end

		damage = damage - flatRes
		damage = damage * perRes

		--Make sure we dont heal the player
		damage = math.max(damage,0)

		dmginfo:SetDamage(damage)

	end

	--Anomaly resistance
	local anomtypes = {}
	anomtypes[DMG_SHOCK] = true
	anomtypes[DMG_BURN] = true
	anomtypes[DMG_ACID] = true
	anomtypes[DMG_BLAST] = true
	anomtypes[DMG_SONIC] = true
	anomtypes[DMG_DROWN] = true
	anomtypes[DMG_POISON] = true
	anomtypes[DMG_NERVEGAS] = true
	anomtypes[DMG_SLOWBURN] = true
	anomtypes[DMG_GENERIC] = true

	if ( target:IsPlayer() and anomtypes[dmginfo:GetDamageType()]) then
		local damage = dmginfo:GetDamage()
		local perRes = target:GetNWFloat("ixperanomres")
		local flatRes = target:GetNWInt("ixflatanomres")
		local suitDuraDmg = damage / 50
		local suit = target:getEquippedBodyArmor()

		if suit != nil then
			suit:SetData("durability", math.Clamp(suit:GetData("durability", 100) - suitDuraDmg, 0, 100))
		end

		damage = damage - flatRes
		damage = damage * perRes

		--Make sure we dont heal the player
		damage = math.max(damage,0)

		dmginfo:SetDamage(damage)
	end
end

local playerMeta = FindMetaTable("Player")

function playerMeta:getPercentageBulletRes()
	local res = 1
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems()

	for k, v in pairs(items) do
		if (v.isBodyArmor and v:GetData("equip")) then
			res = v:getBR(v)
		end

		if (v.br ~= nil and !v.isBodyArmor and v:GetData("equip") == true) then
			res = res * (1 - v.br)
		end
	end

	--BUFFS GO HERE

	return res
end

function playerMeta:getFlatBulletRes()
	local res = 0
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems()

	for k, v in pairs(items) do
		if (v.isBodyArmor and v:GetData("equip")) then
			res = res + v:getFBR(v)
		end

		if (v.fbr ~= nil and !v.isBodyArmor and v:GetData("equip") == true) then
			res = res + v.fbr
		end
	end

	--BUFFS GO HERE

	return res
end

function playerMeta:getPercentageAnomalyRes()
	local res = 1
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems()

	for k, v in pairs(items) do
		if (v.isBodyArmor and v:GetData("equip")) then
			res = v:getAR(v)
		end

		if (v.ar ~= nil and !v.isBodyArmor and v:GetData("equip") == true) then
			res = res * (1 - v.ar)
		end
	end

	--BUFFS GO HERE

	return res
end

function playerMeta:getFlatAnomalyRes()
	local res = 0
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems()

	for k, v in pairs(items) do
		if (v.isBodyArmor and v:GetData("equip")) then
			res = res + v:getFAR(v)
		end

		if (v.far ~= nil and !v.isBodyArmor and v:GetData("equip") == true) then
			res = res + v.far
		end
	end

	--BUFFS GO HERE

	return res
end

function playerMeta:getEquippedBodyArmor()
	local char = self:GetCharacter()
	local inventory = char:GetInventory()
	if inventory then
		local items = char:GetInventory():GetItems(true)

		for k, v in pairs(items) do
			if (v.isBodyArmor and v:GetData("equip")) then
				return v
			end
		end

		return nil
	end
	return nil
end

function playerMeta:getEquippedHelmet()
	local char = self:GetCharacter()
	local inventory = char:GetInventory()
	if inventory then
		local items = char:GetInventory():GetItems(true)

		for k, v in pairs(items) do
			if (v.isHelmet and v:GetData("equip")) then
				return v
			end
		end

		return nil
	end
	return nil
end

function playerMeta:getEquippedGasmask()
	local char = self:GetCharacter()
	local inventory = char:GetInventory()
	if inventory then
		local items = char:GetInventory():GetItems(true)

		for k, v in pairs(items) do
			if (v.isGasmask and v:GetData("equip")) then
				return v
			end
		end

		return nil
	end
	return nil
end

function playerMeta:RecalculateResistances()
	self:SetNWFloat("ixperbulletres", self:getPercentageBulletRes())
	self:SetNWInt("ixflatbulletres", self:getFlatBulletRes())
	self:SetNWFloat("ixperanomres", self:getPercentageAnomalyRes())
	self:SetNWInt("ixflatanomres", self:getFlatAnomalyRes())
end

function playerMeta:ReevaluateOverlay()
	local char = self:GetCharacter()
	local inventory = char:GetInventory()
	if inventory then
		local items = char:GetInventory():GetItems(true)

		for k, v in pairs(items) do
			if (v.overlayPath and v:GetData("equip")) then
				self:SetNetVar("gasmask", false)
			else
				self:SetNetVar("gasmask", true)
			end
		end
	end
end

function playerMeta:ReevaluateGasmaskDSP()
    if self:getEquippedGasmask() then
        self:SetDSP(31)
    end
end

function playerMeta:ApplyDSPGasmask()
    self:SetDSP(31)
end

function playerMeta:UnApplyDSPGasmask()
    self:SetDSP(1)
end

function PLUGIN:EntityEmitSound(sndTable)
    local client = sndTable.Entity
    if (client and IsValid(client) and client:IsPlayer() and client:GetCharacter()) then
        local gasmaskequip = client:getEquippedGasmask()

        if gasmaskequip then
            local sndName = sndTable.SoundName:lower()

            if (sndName:find("male") or sndName:find("voice")) then
                sndTable.DSP = 15
            end

            return true
        end
    end
end

function PLUGIN:PostPlayerLoadout(client)
	client:RecalculateResistances()
	client:ReevaluateOverlay()
	client:ReevaluateGasmaskDSP()
end
