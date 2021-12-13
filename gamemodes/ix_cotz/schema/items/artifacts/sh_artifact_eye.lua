ITEM.name = "Eye"
ITEM.model ="models/lostsignalproject/items/artefacts/eye.mdl"
ITEM.description = "A slim, teardrop-shaped artifact."
ITEM.longdesc = "It is red hot with heat, and even picking it up unprotected will give you some nasty burns on your hand. Some say this is simply a higher quality Droplet, however most STALKERs consider it a completely seperate artifact, both because of its uses as a campfire fuel, but also because of the much higher price compared to a regular Droplet."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 12200
ITEM.flag = "A"
ITEM.rarity = 6
ITEM.baseweight = 0.180
ITEM.varweight  = 0.100

ITEM.fueltier = 1

ITEM:Hook("take", function(item)
	if(item.player)then

		local TEMP_TargetDamage = DamageInfo()
						
		TEMP_TargetDamage:SetDamage(10)
		TEMP_TargetDamage:SetAttacker(item.player)
		TEMP_TargetDamage:SetDamageType(DMG_BURN)
		TEMP_TargetDamage:SetInflictor(item.player)
		TEMP_TargetDamage:SetDamagePosition(item.player:NearestPoint(item.player:GetPos()))
		TEMP_TargetDamage:SetDamageForce(item.player:GetForward()*10000)

		item.player:TakeDamageInfo(TEMP_TargetDamage)
	end
end)

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if (!data) or (!data[1]) then
			return false
		end

		local targetItem = ix.item.instances[data[1]]
		return (targetItem.cookertier and targetItem.cookertier >= item.fueltier)

	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		if ( targetItem.cookertier and targetItem.cookertier <= item.fueltier and !targetItem:GetData("cancook", false) ) then
			targetItem:SetData("cancook", true)
		end

		return false
	end,
}