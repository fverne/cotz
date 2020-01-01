PLUGIN.name = "DeathDrop"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Handles items when player dies."

ix.config.Add("deathWeaponDura", true, "If true weapons will take damage.", nil, {
	category = "Death"
})

ix.config.Add("deathWeaponDuraDmg", 35, "How much damage a weapon will take from a playerdeath.", nil, {
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
			if item:GetData("durability", false) then
				if ix.config.Get("deathWeaponDura") then
					if item.isWeapon then
						item:SetData("durability", math.Clamp( item:GetData("durability") - ix.config.Get("deathWeaponDuraDmg", 35), 0, 100 ) )	
					end
				end
			end
	    end
	end
end