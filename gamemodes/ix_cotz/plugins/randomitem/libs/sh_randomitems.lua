
ix.randomitems = ix.randomitems or {}
ix.randomitems.tables = ix.randomitems.tables or {}
ix.randomitems.tableweights = ix.randomitems.tableweights or {}
ix.randomitems.droppedplayeritems = ix.randomitems.droppedplayeritems or {}

function ix.util.GetRandomItemFromDroppedPool(allowfallback, fallbackpool)
  local cnt = #ix.randomitems.droppedplayeritems
  if(cnt > 0) then
    local index = math.random(1, cnt)
    local ret = ix.randomitems.droppedplayeritems[index]

    table.remove(ix.randomitems.droppedplayeritems, index)

    return ret
  elseif(allowfallback) then
    return ix.util.GetRandomItemFromPool(fallbackpool)
  else
    return false
  end
end

function ix.util.AddItemToDroppedPool(uniqueid, data)
  table.insert(ix.randomitems.droppedplayeritems,{uniqueid,data})
end

function ix.util.GetSizeOfDroppedPool()
  return #ix.randomitems.droppedplayeritems
end

-- Function for getting weighted random item
-- Will return a table where:
-- [1] = uniqueid (string)
-- [2] = data (table) <optional>
function ix.util.GetRandomItemFromPool(itempool)
  if (itempool == nil || !isstring(itempool) || ix.randomitems.tables[itempool] == nil) then 
    itempool = "default" 
  end
  
  local totalweight = ix.randomitems.tableweights[itempool] or 0

  if (totalweight == 0) then
    for _,tableentry in pairs(ix.randomitems.tables[itempool]) do
      totalweight = totalweight + tableentry[1]
    end

    -- Cache weight for later
    ix.randomitems.tableweights[itempool] = totalweight
  end

  local roll = math.random(1, totalweight)
  local itemtoreturn = {}

  for _,tableentry in pairs(ix.randomitems.tables[itempool]) do
    roll = roll - tableentry[1]
    if (roll <= 0) then
      itemtoreturn = tableentry[2]
      break
    end
  end

  return itemtoreturn
end

-- Example and default/fallback item table
ix.randomitems.tables["default"] = {
  {2000, {"food_bread"}},
  {50, {"mp5",{ ["durability"] = 35, ["wear"] = 80}}},
  {200, {"9x19", { ["quantity"] = 25}}},
}

ix.util.Include("ix_entbox_drops.lua","shared")
ix.util.Include("ix_wood_entbox_drops.lua","shared")

ix.util.Include("worldspawn_1.lua","shared")
ix.util.Include("worldspawn_2.lua","shared")

ix.util.Include("worldspawn_3.lua","shared")
ix.util.Include("worldspawn_4.lua","shared")

ix.util.Include("reward_aid_low.lua","shared")
ix.util.Include("reward_aid_high.lua","shared")

ix.util.Include("reward_ammo_low.lua","shared")
ix.util.Include("reward_ammo_high.lua","shared")
ix.util.Include("reward_ammo_rare.lua","shared")

ix.util.Include("reward_consumable.lua","shared")

ix.util.Include("reward_generic_valuable.lua","shared")

ix.util.Include("event_anomaly_burner.lua","shared")
ix.util.Include("event_anomaly_redrazor.lua","shared")