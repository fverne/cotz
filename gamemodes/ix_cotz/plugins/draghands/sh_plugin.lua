PLUGIN.name = "Drag Hands"
PLUGIN.author = "armdupe"
PLUGIN.description = "An update to the helix hands allowing you to drag items depending on their weight."

--[[
Note:
If you want to make it so that this plugin doesn't override helix's default hands and instead makes its own hands swep + functionaility to give it on loadout,
uncomment the code below and change the sweps file name to 'cotz_hands' instead.
Some of the code is scuffed and practically glued together by wacky if statements, enjoy the pyramid scopes.
]]--

--[[
if ( SERVER ) then
  local firstTime

  function PLUGIN:PlayerLoadout(ply)
    firstTime = not firstTime
    if ( not firstTime ) then return end

    netstream.Start(player.GetAll(), "cotz_PlayerLoadout", ply)
  end

  hook.Add("PlayerSpawn", "giveHands", function(ply)
    timer.Create("cotzHandsGive", 0.001, 100, function()
      ply:StripWeapon("ix_hands")
      ply:Give("cotz_hands")
      ply:SelectWeapon("cotz_hands")
    end)
  end)
else
  netstream.Hook("cotz_PlayerLoadout", function(ply)
    hook.Run("PlayerLoadout", ply)
  end)
end ]]--
