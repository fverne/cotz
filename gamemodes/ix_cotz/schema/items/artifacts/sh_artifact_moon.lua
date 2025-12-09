ITEM.name = "Moon"
ITEM.model ="models/lostsignalproject/items/artefacts/peas.mdl"
ITEM.description = "Your eyelids become heavy just by looking at it"
ITEM.longdesc = "This artifact is known for its ability to put those who gaze upon it under a weird sleep-like trance. Despite that, it is considered a safe to use artifact, since hypnotised stalkers focus on heading to their rest spot while still avoiding danger."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 29000
ITEM.JumpPower = 900
ITEM.flag = "A"
ITEM.rarity = 5
ITEM.baseweight = 0.990
ITEM.varweight  = 0.220

ITEM.exRender = true

ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, 0, 0),
	fov = 2.61
}



ITEM.functions.use = {
	name = "Gaze upon",
	icon = "icon16/help.png",
	sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)

        if (item:GetData("cooldown",0) < os.time()) then

            ix.util.PlayerPerformBlackScreenAction(item.player, "Looking at the Moon", 30, function(player) 
        		item:SetData("cooldown", os.time()+(60*15) ) --15 minutes
        		local character = player:GetCharacter()
				local spawndata = character:GetData("savedspawn", nil)

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
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}