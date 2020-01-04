local PLUGIN = PLUGIN
PLUGIN.name = "Resistances"
PLUGIN.author = "Chancer"
PLUGIN.desc = "Handles damage resistances from items, among other things."

local function bulBleed(client, res, dmg)
	--no bleeding if they have enough resistance
	if(!PLUGIN:calcBleed(client, res, dmg)) then return false end
	
	local bleedDmg = (dmg * 0.1) --damage is 10% of the attack damage (after reduction) that caused the bleeding.
	local bleedLength = math.Round(12 * (1 - res)) --duration of the bleed effect depends on resistance, max three minutes (36 * 5).
	
	if(!timer.Exists(client:Name().."res_bleed")) then
		client:Notify("You are bleeding.")

		--bleeds every five seconds 'bleedLength' times.
		timer.Create(client:Name().."res_bleed", 5, bleedLength, function()
			if (IsValid(client) and client:Health() > 0) then
				local dmgInfo = DamageInfo()
				dmgInfo:SetDamage(bleedDmg)
				dmgInfo:SetAttacker(client)
				dmgInfo:SetDamageType(DMG_DIRECT) --DMG_DIRECT for pure damage.
				
				client:TakeDamageInfo(dmgInfo)
			else
				timer.Remove(client:Name().."res_bleed")
			end
		end)
	else --restarts the timer if they get shot while already bleeding
		timer.Adjust(client:Name().."res_bleed", 5, bleedLength, function()
			if (IsValid(client) and client:Health() > 0) then
				local dmgInfo = DamageInfo()
				dmgInfo:SetDamage(bleedDmg)
				dmgInfo:SetAttacker(client)
				dmgInfo:SetDamageType(DMG_DIRECT) --DMG_DIRECT for pure damage.
				
				client:TakeDamageInfo(dmgInfo)
			else
				timer.Remove(client:Name().."res_bleed")
			end
		end)
	end
end

local function chemBleed(client, res, dmg)
	local bleedDmg = (dmg * 0.05) --damage is based off of the attack damage (after reduction) that caused the effect.
	local bleedLength = math.Round(13 * (1 - res)) --duration of the bleed effect depends on resistance, max three minutes (36 * 5).
	
	if(!timer.Exists(client:Name().."res_chem")) then
		client:Notify("You are taking chemical damage.")

		--bleeds every five seconds 'bleedLength' times.
		timer.Create(client:Name().."res_chem", 1, bleedLength, function()
			if (IsValid(client) and client:Health() > 0) then
				local dmgInfo = DamageInfo()
				dmgInfo:SetDamage(bleedDmg)
				dmgInfo:SetAttacker(client)
				dmgInfo:SetDamageType(DMG_DIRECT) --DMG_DIRECT for pure damage.
				
				client:TakeDamageInfo(dmgInfo)
			else
				timer.Remove(client:Name().."res_chem")
			end
		end)
	else --restarts the timer if they get shot while already bleeding
		timer.Adjust(client:Name().."res_chem", 1, bleedLength, function()
			if (IsValid(client) and client:Health() > 0) then
				local dmgInfo = DamageInfo()
				dmgInfo:SetDamage(bleedDmg)
				dmgInfo:SetAttacker(client)
				dmgInfo:SetDamageType(DMG_DIRECT) --DMG_DIRECT for pure damage.
				
				client:TakeDamageInfo(dmgInfo)
			else
				timer.Remove(client:Name().."res_chem")
			end
		end)
	end	
end

PLUGIN.damageTypes = {
	[DMG_FALL] = {
		name = "Fall",
		--func = bulBleed,
		max = 1
	},
	[8194] = {
		name = "Bullet",
		func = bulBleed,
		max = 1
	},
	[DMG_BULLET] = {
		name = "Bullet",
		func = bulBleed,
		max = 1
	},
	[DMG_SLASH] = {
		name = "Bullet",
		func = bulBleed,
		max = 1
	},
	[DMG_BLAST] = {
		name = "Blast",
		max = 1
	},
	[DMG_BURN] = {
		name = "Burn",
		max = 1	
	},
	[DMG_SHOCK] = {
		name = "Shock",
		max = 1
	},
	[DMG_ACID] = {
		name = "Chemical", 
		func = chemBleed,
		max = 1
	},
	[DMG_RADIATION] = {
		name = "Radiation",
		max = 1
	},
	[DMG_SONIC] = {
		name = "Psi",
		max = 1
	}
}

function PLUGIN:EntityTakeDamage(target, dmginfo)
	if(target:IsPlayer()) then
		local dmgType = self.damageTypes[dmginfo:GetDamageType()]
		
		if(dmgType) then
			local res, resItems = self:calculateRes(target, dmgType)
			
			--reduces damage based on calculated resistance
			dmginfo:ScaleDamage(1 - res)
			local dmg = dmginfo:GetDamage() --damage after reduction			
			
			if(dmgType.func) then
				dmgType.func(target, res, dmg)
			end
			
			--damages durability for all equipped res items
			for k, v in pairs(resItems) do
				local curDura = v:GetData("durability", 100)
				local duraDamage = (dmg/10)
				local newDura = math.Round(math.Clamp(curDura - duraDamage, 0, 100))
				print(newDura)
				v:SetData("durability", newDura)
			end
		end
	end
end

function PLUGIN:calculateRes(client, dmgType)
	local char = client:GetChar()
	local inventory = char:GetInv()
	
	local total = 0 --the total damage resistance provided by items
	local resItems = {} --the items that provide resistance
	for k, v in pairs (inventory:GetItems()) do
		if(!v:GetData("equip", false)) then continue end --ignores unequipped items
		
		--local dura = v:GetData("durability", 10000)
		--if(dura <= 0) then continue end --ignores items with 0 durability
	
		local res = v.res and v.res[dmgType.name] --grabs durability values from item
		if (res) then
			table.insert(resItems, v)
			total = total + res
		end
		
		local modData = v:GetData("mod", {})
		for k, modTable in pairs(modData) do
			local modItem = ix.item.list[modTable[1]]
			if(!modItem) then continue end
			if(modItem.res and modItem.res[dmgType.name]) then
				if(!table.HasValue(resItems, v)) then
					table.insert(resItems, v)
				end
				total = total + modItem.res[dmgType.name]
			end
		end
	end
	
	--prevents resistance from going over 100%
	total = math.Clamp(total, -1, 1)
	
	--limits resistance to specified maximum
	total = math.min(total, dmgType.max)
	
	return total, resItems
end

--calculates whether or not to bleed specified target.
function PLUGIN:calcBleed(client, res, dmg)
	if(dmg < 1) then return false end
	
	--uses (post reduction) damage to determine whether or not a bleed happens.
	if(math.random(0, math.Round(dmg)) > 6) then
		return true
	else
		return false
	end
end

--resets bleed timers, if there end up being more of these it might be a good idea to get a better data structure for them.
function PLUGIN:PlayerDeath(victim, inflictor, attacker)
	if(victim and victim:Name()) then
		if(timer.Exists(victim:Name().."res_bleed")) then
			timer.Remove(victim:Name().."res_bleed")
		end
		
		if(timer.Exists(victim:Name().."res_chem")) then
			timer.Remove(victim:Name().."res_chem")
		end
	end
end