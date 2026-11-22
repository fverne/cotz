ITEM.name = "Halo"
ITEM.model ="models/lostsignalproject/items/artefacts/ring.mdl"
ITEM.description = "A glowing ring of a soft, slightly malleable, but still elastic material."
ITEM.longdesc = "The symbolic value of this artifact needs no introduction, being a staple of many religions. Dubbed the 'Crown of Immortality' by many of a more religious background, some believe it protects one from death itself. There is no proof of this happening, as many a STALKER have been found dead with a Halo in his possession. Nevertheless, the legend of the Halo makes it a popular artifact, especially among STALKERs, however the scientists also have an interest in figuring out why it has that eerie glow."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 20812.5
ITEM.flag = "A"
ITEM.rarity = 5
ITEM.baseweight = 1.200
ITEM.varweight  = 0.125

ITEM.saveChance = 10
ITEM.invulnerabilityDuration = 5
ITEM.saveCooldown = 15

function ITEM:GetIndividualProperties()
	return {
		{id = "passiveEffect", text = "Passive: " .. ix.itemProperties.Format("percent", self.saveChance)
			.. " chance to survive a lethal hit, then invulnerable for "
			.. ix.itemProperties.Format("duration", self.invulnerabilityDuration)},
		{id = "cooldown", text = "Recovery cooldown: " .. ix.itemProperties.Format("duration", self.saveCooldown)},
	}
end
