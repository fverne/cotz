
-- Here is where all of your clientside hooks should go.

netstream.Hook("qurReq", function(time, title, subTitle)
	if (title:sub(1, 1) == "@") then
		title = L(title:sub(2))
	end

	if (subTitle:sub(1, 1) == "@") then
		subTitle = L(subTitle:sub(2))
	end

	Derma_Query(subTitle, title, "Yes", function()
		netstream.Start("qurReq", time, true)
	end, "No", function()
		netstream.Start("qurReq", time, false)
	end)
end)

function Schema:BuildBusinessMenu(panel)
	local bHasItems = false

	for k, _ in pairs(ix.item.list) do
		if (hook.Run("CanPlayerUseBusiness", LocalPlayer(), k) != false) then
			bHasItems = true

			break
		end
	end

	return bHasItems
end

function Schema:ShouldDrawItemSize(item)
	return false
end

function Schema:SpawnMenuOpen()
	if LocalPlayer():GetCharacter():HasFlags("petN") or LocalPlayer():IsAdmin() then
		return true
	else
		return false
	end
end

function Schema:ContextMenuOpen()
	if LocalPlayer():GetCharacter():HasFlags("petN") or LocalPlayer():IsAdmin() then
		return true
	else
		return false
	end
end

hook.Add( "OnEntityCreated", "R_Optimisation.OnEntityCreated", function(ply)
    if ply != LocalPlayer() then return end
    -- RunConsoleCommand("rope_smooth", "0")
    -- RunConsoleCommand("Rope_wind_dist", "0")
    -- RunConsoleCommand("Rope_shake", "0")
    -- RunConsoleCommand("violence_ablood", "1")
    -- RunConsoleCommand("mat_queue_mode", "-1")
    -- RunConsoleCommand("cl_threaded_bone_setup", "1")
    RunConsoleCommand("gmod_mcore_test", "1")
    -- RunConsoleCommand("cl_threaded_client_leaf_system", "0") 
    -- RunConsoleCommand("r_queued_ropes", "1")
    -- RunConsoleCommand("r_threaded_client_shadow_manager", "1") 
    -- RunConsoleCommand("r_fastzreject", "-1")
    -- RunConsoleCommand("Cl_ejectbrass", "0")
    -- RunConsoleCommand("Muzzleflash_light", "0")
    -- RunConsoleCommand("cl_wpn_sway_interp", "0")
    -- RunConsoleCommand("in_usekeyboardsampletime", "0")
    -- RunConsoleCommand("r_3dsky", "0")
end)

function Schema:ScoreboardShow()
	if (LocalPlayer():GetCharacter() && !hook.Run("ShouldSuppressMenu", LocalPlayer())) then
		vgui.Create("ixMenu")
	end

	return "suppress"
end