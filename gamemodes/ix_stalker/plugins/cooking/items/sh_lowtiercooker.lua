ITEM.name = "Wood-Fueled Cooker"
ITEM.description = "A low tier cooker."
ITEM.longdesc = "No longer description available."
ITEM.model = "models/lostsignalproject/items/misc/wood_stove.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.cookertier = "low"
ITEM.maxStack = 1
ITEM.sound = "stalkersound/inv_cooking2.ogg"

-- Inventory drawing
if (CLIENT) then
	local Texture2 = Material("cotz/panels/hp1.png", "noclamp smooth") 

	function ITEM:PaintOver(item, w, h)
		--Less mental way of doing the above:
		local quantity = 0

		if item:GetData("quantity") then --checks if we are in the business menu
			quantity = item:GetData("quantity", item.maxStack)
		end

		//durability
		surface.SetMaterial(Texture2)
		surface.SetDrawColor(Color(120, 120, 120, 255))
		surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)

		surface.SetMaterial(Texture2)
		if (quantity >= 1) then 
			surface.SetDrawColor(Color(120, 255, 120, 255))
		end
		surface.DrawTexturedRectUV(5, h - 10, math.Clamp(quantity/item.maxStack, 0, 1)*38, 4.6, 0, 0, math.Clamp(quantity/item.maxStack, 0, 1)*0.2, 1)
	end
end

ITEM.functions.combine = {
  OnCanRun = function(item, data)
    if !data then
      return false
    end

    local targetItem = ix.item.instances[data[1]]
    print("1")
    if item.fueltier == "low" then
      return true
    end

    if item.cookable then
    	print("2")
      return true
    end

    return false
  end,
  OnRun = function(item, data)
    -- cook the item
    if item.cookable then
      item:CookMeat(item, {item})
      return false
    end

    --refuel
    local targetItem = ix.item.instances[data[1]]
    local targetAmmoDiff = targetItem.maxStack - targetItem:GetData("quantity", targetItem.maxStack)
    local localQuant = item:GetData("quantity", item.maxStack)
    local targetQuant = targetItem:GetData("quantity", targetItem.maxStack)
    item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

    if targetAmmoDiff >= localQuant then
      targetItem:SetData("quantity", targetQuant + localQuant)
      return true
    else
      item:SetData("quantity", localQuant - targetAmmoDiff)
      targetItem:SetData("quantity", targetItem.maxStack)
      return false
    end
  end,
}

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
    return (!IsValid(item.entity))
  end,
  OnRun = function(item, data)
    item:CookMeat(self, {data[1]})
    return false
  end,
}

function ITEM:CookMeat(item, data)
  local client = self.player or item:GetOwner()
  local char = client:GetCharacter()
  local inv = char:GetInventory()
  local items = inv:GetItems()
  local target = data[1]
  PrintTable(target)

  for k, invItem in pairs(items) do
    if (data[1]) then
      if (invItem:GetID() == data[1]) then
        target = invItem

        break
      end
    else
      client:Notify("No item selected.")
      return false
    end
  end

  print(targetID)
  
    
  if self then
    if (self:GetData("quantity", 0) != 0) then
      local client = self.player or item:GetOwner()
      local targetID = target:GetID()
      print(targetID)

      client:SetAction("Cooking", 6)
      client:Freeze(true) 
      client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 4 ) 
      timer.Simple(1, function() 
      	print(targetID)
      	PrintTable(ix.item.instances[targetID])
        ix.item.instances[targetID]:Remove()
        client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 4 ) 
      end)
      timer.Simple(5, function() 
        client:GetCharacter():GetInventory():Add(ix.item.instances[targetID].meal, 1, {["weight"] = target:GetWeight()})
        client:Notify(ix.item.instances[targetID].name.." successfully cooked.")
        ix.chat.Send(client, "iteminternal", "uses their "..self.name.." to cook some "..ix.item.instances[targetID].name..".", false)
        client:Freeze(false)
      end)

      client:EmitSound(self.sound or "items/battery_pickup.wav")
      if self:GetData("quantity",5) > 0 then
        self:SetData("quantity", self:GetData("quantity",5) - 1)
      end
      return false
    else
      client:Notify("Not enough fuel.")
      return false
    end

  else
    client:Notify("No fuel.")
    return false
  end
end

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("quantity", false)) then
        self:SetData("quantity", 0)
    end
end