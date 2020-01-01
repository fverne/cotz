ATTRIBUTE.name = "Dexterity"
ATTRIBUTE.description = "Affects your agility."

function ATTRIBUTE:OnSetup(client, value)
	client:SetRunSpeed(ix.config.Get("runSpeed") + value)
end
