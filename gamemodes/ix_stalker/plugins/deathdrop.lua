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

function PLUGIN:DoPlayerDeath( client, attacker, dmg )
	local character = client:GetCharacter()
	if (client:GetCharacter()) then
		local items = client:GetCharacter():GetInventory():GetItems()
		local itemNames = {}
		local counter = 0

	    for k, item in pairs( items ) do
			if ix.config.Get("deathWeaponDura") then
				if item.canRepair and item.isWeapon then
					item:SetData("durability", math.Clamp( item:GetData("durability") - ix.config.Get("deathWeaponDuraDmg", 5), 0, 100 ) )
					item:SetData("wear", math.Clamp( item:GetData("wear") - ix.config.Get("deathWeaponWearDmg", 35), 0, 100 ) )
				end
			end

			if item.ammoAmount then
				item:SetData("quantity", math.Clamp( math.Round(item:GetData("quantity") - item.ammoAmount/2), 0, 100 ) )
			end
	    end
	end
end