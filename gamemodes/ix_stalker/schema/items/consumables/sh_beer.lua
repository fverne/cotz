ITEM.name = "Ochakovo Beer, 2l"
ITEM.model = "models/kek1ch/dev_beer.mdl"
ITEM.thirst = 31
ITEM.description = "A bottle of beer"
ITEM.longdesc = "Ochakovo Beer is not subject to pasteurization. \nLong-term storage is based on cold filtering technology with the use of fine-meshed polymeric membranes which filter out even the smallest yeast."
ITEM.quantity = 2
ITEM.price = 350
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.busflag = {"consumables1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.5 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 1.0
ITEM.flatweight = 0.500

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
end