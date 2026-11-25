PLUGIN.name = "DeathDrop"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Handles items when player dies."

ix.config.Add("deathWeaponDura", true, "If true weapons will take damage when player dies.", nil, {
	category = "Death"
})

ix.config.Add("deathWeaponWearDmg", 35, "How much wear damage a weapon will take from a playerdeath.", nil, {
	data = {min = 0, max = 100},
	category = "Death"
})

ix.config.Add("deathWeaponDuraDmg", 5, "How much durability damage a weapon will take from a playerdeath.", nil, {
	data = {min = 0, max = 100},
	category = "Death"
})

ix.config.Add("deathAmmoKeepFraction", 0.75, "Fraction of the rounds in an ammo pack that is kept when a player dies.", nil, {
	data = {min = 0, max = 1, decimals = 2},
	category = "Death"
})

ix.config.Add("deathDropValuable", false, "If true valuables will drop when player dies.", nil, {
	category = "Death"
})

if(SERVER)then

-- Packs keep the configured fraction of their current rounds on death; no cap, as packs can hold more than 100.
local function applyAmmoDeathLoss(item)
	if not item.ammoAmount then return end

	local quantity = math.Round(item:GetData("quantity", item.ammoAmount) * ix.config.Get("deathAmmoKeepFraction", 0.75))
	if quantity <= 0 then
		item:Remove()
		return
	end

	item:SetData("quantity", quantity)
end

function PLUGIN:DoPlayerDeath( client, attacker, dmg )
	
	if(ix.plugin.list["revive"] ~= nil) then return end

	local character = client:GetCharacter()
	if (client:GetCharacter()) then
		local items = client:GetCharacter():GetInventory():GetItems()
		local itemNames = {}
		local counter = 0

	    for k, item in pairs( items ) do
			if ix.config.Get("deathWeaponDura") and !item:GetData("unlimitedDurability") then
				if item.canRepair and item.isWeapon then
					item:SetData("durability", math.Clamp( item:GetData("durability") - ix.config.Get("deathWeaponDuraDmg", 5), 0, 100 ) )
					item:SetData("wear", math.Clamp( item:GetData("wear") - ix.config.Get("deathWeaponWearDmg", 35), 0, 100 ) )
				end
			end

			applyAmmoDeathLoss(item)

			if ( ix.config.Get("deathDropValuable") and item.DropOnDeath ) then
				ix.util.AddItemToDroppedPool(item.uniqueID, item.data)
				item:Remove()
			end
	    end
	end
end

function PLUGIN:DoDeathDrop( client, deathpos )
	local character = client:GetCharacter()
	if (client:GetCharacter()) then
		local items = client:GetCharacter():GetInventory():GetItems()
		local itemNames = {}
		local counter = 0

	    for k, item in pairs( items ) do
			if ix.config.Get("deathWeaponDura") and !item:GetData("unlimitedDurability") then
				if item.canRepair and item.isWeapon then
					item:SetData("durability", math.Clamp( item:GetData("durability") - ix.config.Get("deathWeaponDuraDmg", 5), 0, 100 ) )
					item:SetData("wear", math.Clamp( item:GetData("wear") - ix.config.Get("deathWeaponWearDmg", 35), 0, 100 ) )
				end
			end

			applyAmmoDeathLoss(item)

			if ( ix.config.Get("deathDropValuable") and item.DropOnDeath ) then
				ix.util.AddItemToDroppedPool(item.uniqueID, item.data)
				item:Remove()
			end
	    end
	end
end

hook.Add("DeathDrop", "DoDeathDrop", DoDeathDrop)

end