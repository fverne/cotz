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

        if (item:GetData("cooldown",0) < os.time()) then

            ix.util.PlayerPerformBlackScreenAction(item.player, "Following the Compass", 30, function(player) 
        		item:SetData("cooldown", os.time()+(60*15) ) --15 minutes
        		local character = player:GetCharacter()
            	local spawndata = item:GetData("savedspawn", nil)
				if !spawndata then return end

				if not (spawndata[3] == game.GetMap())then
					character:SetData("newpos", spawndata)
					ix.plugin.list["simplecrossserver"]:RedirectPlayerNoLoadZone(player, spawndata[3])
					return
				end

				player:SetPos(spawndata[1])
            end)
        end

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

		item:SetData("savedspawn", {item.player:GetPos(), Angle(), game.GetMap()})
        item.player:Notify("Location Set")
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}