ITEM.name = "Harmonica"
ITEM.description = "A playable harmonica."
ITEM.longdesc = "A free reed wind instrument that is used throughout the Zone in which it is featured in many musical genres. The instrument appears to have around 10 holes which the user would blow into to produce a sound. Some STALKERS have mastered the Harmonica and use it over a Guitar for their instrument choice, mostly due to how easy it is to carry around."
ITEM.model = "models/lostsignalproject/items/misc/harmonica.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.price = 400

ITEM.img = ix.util.GetMaterial("vgui/hud/harmonica.png")

ITEM.sounds = {
	Sound("stalkersound/harmonica/harmonica_1.ogg"),
	Sound("stalkersound/harmonica/harmonica_2.ogg"),
	Sound("stalkersound/harmonica/harmonica_3.ogg"),
	Sound("stalkersound/harmonica/harmonica_4.ogg"),
	Sound("stalkersound/harmonica/harmonica_5.ogg")
}

ITEM.functions.use = { -- sorry, for name order.
	name = "Play",
	icon = "icon16/stalker/sell.png",
	OnRun = function(item)

		if(item:GetData("cooldown", 0) < os.time()) then

			local soundplay = table.Random(item.sounds)
			item.player:EmitSound(soundplay, 50, 100, 0.5)
			ix.chat.Send(item.player, "iteminternal", "puts their "..item.name.." to their mouths and plays a tune.", false)

			item:SetData("cooldown", os.time() + 15 )
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}
