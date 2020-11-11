ITEM.name = "Harmonica"
ITEM.description = "A playable harmonica."
ITEM.model = "models/lostsignalproject/items/misc/harmonica.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 500
ITEM.img = Material("vgui/hud/harmonica.png")

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
		local soundplay = table.Random(item.sounds)
		item.player:EmitSound(soundplay, 50, 100, 0.5)
		ix.chat.Send(item.player, "iteminternal", "puts their "..item.name.." to their mouths and plays a tune.", false)

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
