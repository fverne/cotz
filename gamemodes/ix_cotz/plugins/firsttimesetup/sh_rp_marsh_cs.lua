-- Presets for rp_marsh_cs

PLUGIN.map_presets["rp_marsh_cs"] = {
  containers = {
    {
      model = "models/props_forest/footlocker01_closed.mdl",
      position = Vector(-6159.7724609375,-9435.3583984375,4970.3862304688),
      angles = Angle(-0.0010346689959988,-179.97814941406,-0.0054931640625),
      spawnCategory = "",
      cyclicalCategory = "",
    },
    {
      model = "models/props_forest/footlocker01_closed.mdl",
      position = Vector(-6160.6552734375,-9504.5498046875,4970.5258789063),
      angles = Angle(-0.018871011212468,-179.86129760742,-0.009033203125),
      spawnCategory = "",
      cyclicalCategory = "",
    },
    {
      model = "models/props_forest/footlocker01_closed.mdl",
      position = Vector(-6161.037109375,-9565.6552734375,4970.5258789063),
      angles = Angle(0.00014697267033625,-179.93852233887,3.0517578125e-05),
      spawnCategory = "",
      cyclicalCategory = "",
    },
  },
  vendors = {
    {
      template = "tutorialnpc",
      position = Vector(-8142.958008, -11082.580078, 4939.861328),
      angles = Angle(0.000, 179.194, 0.000)
    },
    {
      template = "technpc",
      position = Vector(-6006.653809, -11071.930664, 5026.031250),
      angles = Angle(0,-177.793,0)
    },
    {
      template = "owlnpc",
      position = Vector(-6728.806152, -9394.196289, 4962.929199),
      angles = Angle(0.000, -89.888, 0.000)
    },
    {
      template = "medicnpc",
      position = Vector(-7328.550293, -9329.122070, 4973.031250),
      angles = Angle(0.000, -90, 0.000)
    },
  },

  plugindata = {
    ["anomalycontroller"] = {

    },
    ["boxspawner"] = {

    },
    ["eventcontroller"] = {

    },
    ["eventcontrolleradv"] = {

    },
    ["hidestashspawner"] = {

    },
    ["radiationcontroller"] = {

    },
    ["simplecrossserver"] = {

    },
    ["worlditemspawner"] = {

    },
  },

  -- For setting up generic entities to spawn
  entities = {
    {
      class = "ix_noticeboard",
      position = Vector(-6149.0317382813,-9549.83203125,5056.4912109375),
      angles = Angle(89.976348876953,-0.002155341906473,180),
    },


  }
}



