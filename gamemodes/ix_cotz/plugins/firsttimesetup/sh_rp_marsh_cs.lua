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
      { Vector(-683.80651855469,-11031.477539063,84.522201538086) , "behind the old stove in the southeastern village" }, 
      { Vector(216.93879699707,-11155.455078125,74.308601379395) , "behind stranded boat in the southeastern village" }, 
      { Vector(326.37359619141,-10930.890625,92.580902099609) , "in the barn in the southeastern village" }, 
      { Vector(-328.98220825195,-8529.5927734375,69) , "under a tree near the southeastern village" }, 
      { Vector(2122.568359375,-11540.890625,70.847198486328) , "in the crane cabin in the southeastern construction site" }, 
      { Vector(3177.9816894531,-12223.0703125,69) , "in a bush near the southeastern construction site" }, 
      { Vector(2540.8562011719,-8351.8603515625,85.566703796387) , "behind a rock near the southern watchtower" }, 
      { Vector(2732.8735351563,-9192.5537109375,188.15510559082) , "on top of some green crates near the southern watchtower" }, 
      { Vector(5079.7797851563,-11201.4296875,69) , "under the CAT machine near the church" }, 
      { Vector(5175.32421875,-7736.7065429688,64.138000488281) , "in the church graveyard" }, 
      { Vector(6475.48046875,-7076.4428710938,66.478202819824) , "in the church graveyard" }, 
      { Vector(6459.8530273438,-9556.6494140625,14.207699775696) , "under a drain pipe in the church" }, 
      { Vector(6868.6923828125,-9120.078125,627.09582519531) , "under the roof dome in the church" }, 
      { Vector(5719.71875,-9163.8251953125,226.75939941406) , "under the roof of the southern entrance of the church" }, 
      { Vector(6086.9091796875,-10122.076171875,68.299797058105) , "near the large tree in the church" }, 
      { Vector(6915.2104492188,-10388.212890625,69) , "by the log pile in the church" }, 
      { Vector(7140.8012695313,-6431.3212890625,405.93908691406) , "near the gazebo at the church hill" }, 
      { Vector(7322.4858398438,-5829.494140625,366.60189819336) , "in a bush on the church hill" }, 
      { Vector(1462.3845214844,-6252.216796875,65.553703308105) , "on a boat far west of the southern watchtower" }, 
      { Vector(-2063.4157714844,-7343.0170898438,69) , "by a wall in a grove west of the southeastern village" }, 
      { Vector(-867.0302734375,-6543.626953125,69) , "under a large tree in a grove west of the southeastern village" }, 
      { Vector(-3643.8471679688,-4769.5180664063,68.131103515625) , "under a tree in the southern part of the swamps" }, 
      { Vector(-5385.0571289063,-3654.2407226563,69) , "near a large dead tree in the southern part of the swamps" }, 
      { Vector(-7788.2797851563,-5403.0874023438,69) , "in the ruins of a house in the southeastern part of the swamps" }, 
      { Vector(-7403.3759765625,-2841.5148925781,69) , "by a rock formation in the southeastern part of the swamps" }, 
      { Vector(-3266.0229492188,-2384.2927246094,69) , "near a large tree in the southern part of the swamps" }, 
      { Vector(-2381.6723632813,-1947.3864746094,69) , "near a rock formation in the southern part of the swamps" }, 
      { Vector(-8269.9404296875,-40.023101806641,78.67130279541) , "in the cabin in the southwestern part of the swamps" }, 
      { Vector(-7845.6591796875,10.276399612427,69) , "under the southwestern watchtower" }, 
      { Vector(-7656.431640625,973.18017578125,69) , "near a tree by the southwestern watchtower" }, 
      { Vector(-4700.0043945313,1248.6026611328,90.408599853516) , "in an old wooden boat that can be seen from the southwestern watchtower" }, 
      { Vector(-3045.5791015625,8.2144002914429,69) , "by a fallen tree south of the pumping station" }, 
      { Vector(-2490.2446289063,3397.6335449219,130.35729980469) , "on top of an old fan unit south west of the pumping station" }, 
      { Vector(-4186.8735351563,6337.1640625,55.004600524902) , "by a bridge in the western part of the swamps" }, 
      { Vector(-3660.0581054688,8399.37109375,60.524700164795) , "in a barn in the western fishing village" }, 
      { Vector(-2726.791015625,8356.595703125,69) , "under a picnic table in the western fishing village" }, 
      { Vector(-1890.5971679688,9245.59375,69) , "by a red container in the western fishing village" }, 
      { Vector(-2683.6101074219,9594.3798828125,190.9841003418) , "behind the raised house in the western fishing village" }, 
      { Vector(-74.383697509766,6220.8793945313,75.91780090332) , "in a broken concrete pipe near the town with the water tower" }, 
      { Vector(1.1447999477386,7267.8491210938,156.19619750977) , "on a CAT machine visible from the western fishing village" }, 
      { Vector(400.46340942383,9014.18359375,77.63200378418) , "in an unfinished house north of the western fishing village" }, 
      { Vector(-1136.1566162109,11508.69140625,179.71569824219) , "under a truck by the railroad" }, 
      { Vector(2653.3679199219,9955.798828125,96.510200500488) , "in the trunk of a white car visible from the railroad" }, 
      { Vector(1974.9173583984,12472.759765625,353.84030151367) , "behind the pillar of the 4th arch from the south on the railroad" }, 
      { Vector(1482.2620849609,5589.6796875,107.53939819336) , "on a wooden crate in the watertower village" }, 
      { Vector(2607.0434570313,5557.4018554688,70.145698547363) , "behind the slim storage building in the watertower village" }, 
      { Vector(2290.9030761719,4256.4155273438,232.95230102539) , "in the attic of a burnt out building in the watertower village" }, 
      { Vector(4829.8388671875,6314.166015625,64.776901245117) , "under a concrete slab in a construction site near the watertower village" }, 
      { Vector(5054.62890625,7468.7094726563,69) , "behind a pile of concrete slabs in a construction site near the watertower village" }, 
      { Vector(7151.2260742188,12158.018554688,343.03131103516) , "under the derailed train car on the railroad" }, 
      { Vector(8213.130859375,11988.965820313,326.19198608398) , "near the derailed train car by the railroad" }, 
      { Vector(3907.94140625,9380.3837890625,69) , "behind a tree near the bunker entrance" }, 
      { Vector(9703.03125,10553.678710938,98.969703674316) , "in a rock formation near the railroad" }, 
      { Vector(10536.870117188,10450.248046875,90.696899414063) , "in a rock formation near the railroad" }, 
      { Vector(9033.388671875,9934.099609375,69) , "in a rock formation near the railroad" }, 
      { Vector(8762.2998046875,6075.5297851563,46.821300506592) , "in a green bin near the machine yard" }, 
      { Vector(13556.053710938,7616.21484375,69) , "near a log pile in the northwestern village" }, 
      { Vector(12029.389648438,9150.00390625,69) , "behind a tree in the northwestern village" }, 
      { Vector(12077.41796875,7320.0854492188,107.13770294189) , "on a wooden crate in the northwestern village" }, 
      { Vector(9212.4833984375,4189.2270507813,69) , "in a secluded corner behind the machine yard" }, 
      { Vector(8550.3935546875,3679.5666503906,69.741302490234) , "behind an oil tank in the machine yard" }, 
      { Vector(7587.3828125,3832.4152832031,102.20809936523) , "in a curved pipe in the machine yard" }, 
      { Vector(6771.6538085938,4653.66015625,69.430801391602) , "in a ruined house in the machine yard" }, 
      { Vector(13118.323242188,1503.2514648438,73.531303405762) , "in a trash container in the northern part of the swamps" }, 
      { Vector(13047.921875,-1965.5948486328,296.64428710938) , "in a bush near the fire anomaly" }, 
      { Vector(5684.0830078125,1072.2578125,55.418201446533) , "in a ruined house in the village near the machine yard" }, 
      { Vector(6338.1547851563,36.57799911499,74.110702514648) , "near a ruined house in the village near the machine yard" }, 
      { Vector(5251.4272460938,121.00820159912,78.031303405762) , "in a burnt out house in the village near the machine yard" }, 
      { Vector(4309.25,-2954.734375,79.185997009277) , "in a green cabin west of the church" }, 
      { Vector(13056.489257813,-12099.395507813,72.031303405762) , "behind a fireplace in the northeastern village" }, 
      { Vector(11530.590820313,-12085.772460938,69) , "in a bush in the northeastern village" }, 
      { Vector(11254.20703125,-10946.861328125,68.315002441406) , "behind a large tree in the northeastern village" }, 
      { Vector(9737.0517578125,3580.6076660156,24.287200927734) , "under the watertower in the machine yard" }, 
      { Vector(11967.177734375,-8159.7065429688,69) , "near a large tree north of the church" }, 
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



