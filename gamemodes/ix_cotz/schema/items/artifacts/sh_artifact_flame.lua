ITEM.name = "Flame"
ITEM.model ="models/lostsignalproject/items/artefacts/flame.mdl"
ITEM.description = "A spherical artifact resembling a large translucent pearl, with what appears to be a firestorm raging inside of it."
ITEM.longdesc = "It radiates an oppressive heat, leaving you sweating if you're even close to it. Holding it in your hands without a suit would be dangerous, most likely leading to burning your hands off, if held for more than a couple of seconds. Because of the intense temperatures emitted by this artifact, it is very popular among STALKERs as a fuel source for campfires. Scientists are very interested in the inner workings of this artifact, as it might help unlock the secrets behind nuclear fusion."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 34600
ITEM.flag = "A"
ITEM.rarity = 9
ITEM.baseweight = 1.900
ITEM.varweight  = 0.300

ITEM.fueltier = 8

ITEM:Hook("take", function(item)
	if(item.player)then

		local TEMP_TargetDamage = DamageInfo()
						
		TEMP_TargetDamage:SetDamage(80)
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