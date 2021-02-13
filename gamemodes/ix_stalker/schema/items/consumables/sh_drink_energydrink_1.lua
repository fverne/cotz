ITEM.name = "Red Bull, 250ml"
ITEM.description = "An aluminium can with an energy drink inside."
ITEM.longdesc = "Red Bull is the most popular energy drink in the world, based on its share of sales. Red Bull's slogan is 'it gives you wings'. The product is strongly marketed through advertising, tournament sponsorship, sports team ownerships, celebrity endorsements, and with its record label. Red Bull's invigorating effects are attributed to its high caffeine content. A single can of Red Bull contains 80 mg/250 ml of caffeine. This is about the same as one cup of normal coffee, or slightly less depending on the brewing method."
ITEM.model = "models/illusion/eftcontainers/hotrod.mdl"

ITEM.price = 120
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.050

ITEM.thirst = 5
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/energydrink_1.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 50, { amount = 1.5 })
	ix.chat.Send(item.player, "iteminternal", "cracks open and drinks their "..item.name..".", false)
end)

ITEM:DecideFunction()