ITEM.name = "Multi-Fuel Cooker"
ITEM.description = "A high tier cooker."
ITEM.longdesc = "A stainless steel cooker that accepts a various amounts of fuel. Easy to clean, this is the best cooker found in a place like the zone. Experienced STALKERs tend to use various types of heat-related artifacts to fuel the cooker."
ITEM.model = "models/lostsignalproject/items/misc/multi_fuel_stove.mdl"

ITEM.width = 2
ITEM.height = 1

ITEM.flatweight = 1.520
ITEM.weight  = 0.100

ITEM.price = 2500

ITEM.cookertier = 2
ITEM.maxFuel = 10

ITEM.sound = "stalkersound/inv_cooking_cooker.ogg"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(215.46, 58.46, 231.87),
	ang = Angle(45.76, 196.1, 0),
	fov = 4.08
}

-- Inventory drawing
if (CLIENT) then
	local bar = Material("cotz/panels/hp1.png", "noclamp smooth")

	function ITEM:PaintOver(item, w, h)
    local fuelpercent =  item:GetData("fuel", 0) / item.maxFuel * 100

    //fuelbar
		surface.SetMaterial(bar)
		surface.SetDrawColor(Color(120, 120, 120, 255))
		surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)

		surface.SetMaterial(bar)
		if (fuelpercent >= 80) then 
			surface.SetDrawColor(Color(120, 255, 120, 255))
		elseif (fuelpercent >= 60) then 
			surface.SetDrawColor(Color(180, 255, 120, 255))
		elseif (fuelpercent >= 40) then 
			surface.SetDrawColor(Color(255, 255, 120, 255))
		elseif (fuelpercent >= 20) then 
			surface.SetDrawColor(Color(255, 180, 120, 255))
		elseif (fuelpercent > 0) then 
			surface.SetDrawColor(Color(255, 120, 120, 255))	
		end
		surface.DrawTexturedRectUV(5, h - 10, math.Clamp(fuelpercent/100, 0, 1)*38, 4.6, 0, 0, math.Clamp(fuelpercent/100, 0, 1)*0.2, 1)

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
          if (v.cookable == true and v.meattier <= item.cookertier) then
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
    return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
  end,
  OnRun = function(item, data)
    if(!data[1]) then return false end
    item:CookMeat(self, data[1])
    return false
  end,
}

ITEM.functions.useAll = {
  name = "Cook All",
  tip = "useTip",
  icon = "icon16/stalker/eat.png",
  OnCanRun = function(item)
    return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
  end,
  OnRun = function(item, data)
    local cookables = {}
    local fuels = {}
    local char = item.player:GetCharacter()
    local infinite = false
    local fuelcount = item:GetData("fuel", 0)
    local cookquantity = 0
    if (char) then
      local inv = char:GetInventory()

      if (inv) then
        local items = inv:GetItems()

        for k, v in pairs(items) do
          if (v.cookable == true  and v.meattier <= item.cookertier) then
            table.insert(cookables, v) -- testo testo
          elseif (v.fueltier and v.fueltier == item.cookertier and v.flag == "A") then
            infinite = true
          elseif (v.fueltier and v.fueltier == item.cookertier) then
            table.insert(fuels, v)
            fuelcount = fuelcount + v:GetData("quantity",v.quantity) -- just to doublecheck
          else
            continue
          end
        end
        if (#cookables == 0) then
          item.player:Notify("No meat to cook.")
          return false
        elseif (fuelcount <= 0 and !infinite) then
          item.player:Notify("No fuel to cook with.")
          return false
        end
        item.player:EmitSound(item.sound or "items/battery_pickup.wav")
        cookquantity = math.min(#cookables,math.max(fuelcount,(infinite and 1 or 0)*100))
        ix.chat.Send(item.player, "iteminternal", "uses their "..item.name.." to begin cooking "..cookquantity.." portions of meat.", false)
        ix.util.PlayerPerformBlackScreenAction(item.player, "Cooking...", math.min(cookquantity*6, 60), function(player) 
          for k,v in pairs(cookables) do
            if infinite then 
            elseif fuelcount <= 0 then
              break
            elseif item:GetData("fuel", 0) then
              fuelcount = fuelcount - 1
              item:SetData("fuel", fuelcount)
            elseif !(fuels[1] == nil) then
              fuels[1]:SetData("quantity", fuels[1]:GetData("quantity",fuels[1].quantity) - 1)
              fuelcount = fuelcount - 1
              if (fuels[1]:GetData("quantity", fuels[1].quantity) <= 0) then
                fuels[1]:Remove()
                table.remove(fuels, 1)
              end
            else
              break
            end
            v:Remove()
            char:GetInventory():Add(v.meal, 1, {["weight"] = v:GetWeight()})
          end
          ix.chat.Send(player, "iteminternal", "finished cooking "..cookquantity.." portions of meat.", false)
        end)
      end
    end
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

  if (self:GetData("fuel", 0) > 0) then
    local client = self.player or item:GetOwner()
    
    ix.util.PlayerPerformBlackScreenAction(client, "Cooking...", 6, function(player) 
      target:Remove()
      client:GetCharacter():GetInventory():Add(target.meal, 1, {["weight"] = target:GetWeight()})
      player:Notify(target.name.." successfully cooked.")
      ix.chat.Send(player, "iteminternal", "uses their "..self.name.." to cook some "..target.name..".", false)
    end)
    
    client:EmitSound(self.sound or "items/battery_pickup.wav")
    self:SetData("fuel", self:GetData("fuel", 0) - 1)

    return false
  else
    client:Notify("No fuel.")
    return false
  end
end

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("fuel")) then
        self:SetData("fuel", 0)
    end
end

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("fuel", 1))
end