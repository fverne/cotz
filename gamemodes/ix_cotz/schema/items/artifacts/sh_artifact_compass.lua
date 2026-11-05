ITEM.name = "Compass"
ITEM.model ="models/nasca/etherealsrp_artifacts/compass.mdl"
ITEM.description = "Legendary artifact formed in a space anomaly."
ITEM.longdesc = "An exceptionally rare artifact. Allows its wielder to locate breaches in anomaly fields and travel through the most complicated anomaly fields. Only a handful of stalkers have one, and fewer know how to use it."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 29000
ITEM.JumpPower = 100
ITEM.flag = "A"
ITEM.rarity = 5
ITEM.baseweight = 0.990
ITEM.varweight  = 0.220

ITEM.exRender = true

ITEM.iconCam = {
	pos = Vector(8.31, -7.09, -732.73),
	ang = Angle(-90.83, 317.52, 0),
	fov = 0.87
}

ITEM.functions.use = {
	name = "Follow",
	icon = "icon16/help.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		ix.util.UseTravelArtifact(item, item:GetData("savedspawn"), "Following the Compass")

		return false
	end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("savedspawn", false) and item:GetData("cooldown",0) < os.time() and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}

ITEM.functions.useSave = {
	name = "Record",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)

		local destination = ix.util.CaptureSavedLocation(item.player)
		if not destination then return false end
		item:SetData("savedspawn", destination)
        item.player:Notify("Location Set")
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}