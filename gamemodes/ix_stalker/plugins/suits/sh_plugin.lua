local PLUGIN = PLUGIN
PLUGIN.name = "Suits"
PLUGIN.author = "Subleader and Alexgrist and verne (Outfit base used)"
PLUGIN.desc = "Compatible with bad air and localized damage, plus it adds damage resistance"

ix.util.Include("cl_plugin.lua")

function PLUGIN:EntityTakeDamage( target, dmginfo )
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

		damage = damage * (1-perRes)
		damage = damage - flatRes

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
	anomtypes[DMG_AIRBOAT] = true
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
			
		damage = damage * (1-perRes)
		damage = damage - flatRes

		dmginfo:SetDamage(damage)
	end
end

local playerMeta = FindMetaTable("Player")

function playerMeta:getPercentageBulletRes()
	local res = 0
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems()

	for k, v in pairs(items) do
		if (v.resistance and v:GetData("equip")) then
			if v:GetData("durability",100) < 80 then
				res = res + v:getBR(v) * (v:GetData("durability",0)/80)
			else
				res = res + v:getBR(v)
			end
		end

		if (v.br ~= nil and !v.resistance and v:GetData("equip") == true) then
			res = res + v.br
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
		if (v.resistance and v:GetData("equip")) then
			if v:GetData("durability",100) < 80 then
				res = res + v:getFBR(v) * (v:GetData("durability",0)/80)
			else
				res = res + v:getFBR(v)
			end
		end

		if (v.fbr ~= nil and !v.resistance and v:GetData("equip") == true) then
			res = res + v.fbr
		end
	end
	
	--BUFFS GO HERE

	return res
end

function playerMeta:getPercentageAnomalyRes()
	local res = 0
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems()

	for k, v in pairs(items) do
		if (v.resistance and v:GetData("equip")) then
			if v:GetData("durability",100) < 80 then
				res = res + v:getAR(v) * (v:GetData("durability",0)/80)
			else
				res = res + v:getAR(v)
			end
		end

		if (v.ar ~= nil and !v.resistance and v:GetData("equip") == true) then
			res = res + v.ar
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
		if (v.resistance and v:GetData("equip")) then
			if v:GetData("durability",100) < 80 then
				res = res + v:getFAR(v) * (v:GetData("durability",0)/80)
			else
				res = res + v:getFAR(v)
			end
		end

		if (v.far ~= nil and !v.resistance and v:GetData("equip") == true) then
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

function PLUGIN:PostPlayerLoadout(client)
	client:RecalculateResistances()
	client:ReevaluateOverlay()
end