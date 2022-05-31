ITEM.name = "Wood-Fueled Cooker"
ITEM.description = "A low tier cooker."
ITEM.longdesc = "A small metallic portable pocket stove that allows you to cook up various foods. Some STALKERs like to carry a mini portable cooker around when they camp out. It requires a fuel source to cook with. Those who are experienced STALKERs tend to use the likes of a heat producing artifact to cook their food as it acts as an unlimited fuel source. The rest typically use some wooden branches they find or some charcoal to add a nice smokey flavour."
ITEM.model = "models/lostsignalproject/items/misc/wood_stove.mdl"

ITEM.width = 2
ITEM.height = 2

ITEM.price = 2500

ITEM.cookertier = 1

ITEM.sound = "stalkersound/inv_cooking2.ogg"

-- Inventory drawing
if (CLIENT) then
	local bar = Material("cotz/panels/hp1.png", "noclamp smooth")

	function ITEM:PaintOver(item, w, h)
		local cancook = item:GetData("cancook", false)

		surface.SetMaterial(bar)
		surface.SetDrawColor(Color(120, 120, 120, 255))
		surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)

    if (cancook) then
		  surface.SetMaterial(bar)
			surface.SetDrawColor(Color(120, 255, 120, 255))
		  surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)
    end
	end
end

ITEM.functions.use = {
  name = "Cook",
  tip = "useTip",
  icon = "icon16/stalker/eat.png",
  isMulti = true,
  multiOptions = function(item, client)
    local targets = {}
    local char = client:GetCharacter()

    if (char) then
      local inv = char:GetInventory()

      if (inv) then
        local items = inv:GetItems()

        for k, v in pairs(items) do
          if (v.cookable == true  and !v.meatTier == true) then
            table.insert(targets, {
              name = L(""..v.name.." ("..ix.weight.WeightString(v:GetWeight(), ix.option.Get("imperial", false))..")"),
              data = {v:GetID()},
            })
          else
            continue
          end
        end
      end
    end

    return targets
    end,
  OnCanRun = function(item)
    return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
  end,
  OnRun = function(item, data)
    if(!data[1]) then return false end
    item:CookMeat(self, data[1])
    return false
  end,
}

function ITEM:CookMeat(item, targetID)
  local client = self.player or item:GetOwner()
  local char = client:GetCharacter()
  local inv = char:GetInventory()
  local items = inv:GetItems()
  local target = targetID

  for k, invItem in pairs(items) do
    if (targetID) then
      if (invItem:GetID() == targetID) then
        target = invItem

        break
      end
    else
      client:Notify("No item selected.")
      return false
    end
  end

  if (self:GetData("cancook", false)) then
    local client = self.player or item:GetOwner()

    client:SetAction("Cooking", 6)
    client:Freeze(true)
    client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 4 )
    timer.Simple(1, function()
      target:Remove()
      client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 4 )
    end)
    timer.Simple(5, function()
      client:GetCharacter():GetInventory():Add(target.meal, 1, {["weight"] = target:GetWeight()})
      client:Notify(target.name.." successfully cooked.")
      ix.chat.Send(client, "iteminternal", "uses their "..self.name.." to cook some "..target.name..".", false)
      client:Freeze(false)
    end)

    client:EmitSound(self.sound or "items/battery_pickup.wav")
    self:SetData("cancook", false)

    return false
  else
    client:Notify("No fuel.")
    return false
  end
end

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("cancook")) then
        self:SetData("cancook", false)
    end
end
