if SERVER then AddCSLuaFile() end

if CLIENT then

	local function tfaNMRIHOptionServer(panel)
		--Here are whatever default categories you want.
		
		local tfaOptionNMRIHSV = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA NRMIH Settings Server"}
		
		tfaOptionNMRIHSV.Options["#Default"] = {
			sv_tfa_nmrih_flashlight_required = "0",
			sv_tfa_nmrih_fx_fext_override = "-1",
			sv_tfa_nmrih_fx_tnt = "1",
			sv_tfa_nmrih_melee_multiplier = "1"
		}
		
		panel:AddControl("ComboBox", tfaOptionNMRIHSV)
		
		panel:AddControl("CheckBox", {
			Label = "Require flashlight to be held",
			Command = "sv_tfa_nmrih_flashlight_required",
		})
		
		panel:AddControl("CheckBox", {
			Label = "Enable TNT FX",
			Command = "sv_tfa_nmrih_fx_tnt",
		})
		
		panel:AddControl("Slider", {
			Label = "Override CL Extinguisher FX (-1 = Clientside)",
			Command = "sv_tfa_nmrih_fx_fext_override",
			Type 		= "Integer",
			Min 		= "-1",
			Max 		= "1",
		})
	
		panel:AddControl("Slider", {
			Label 	= "Melee Damage Multiplier",
			Command 	= "sv_tfa_nmrih_melee_multiplier",
			Type 		= "Float",
			Min 		= "0",
			Max 		= "5",
		})
		
		panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	
	end

	local function tfaNMRIHOptionClient(panel)
		--Here are whatever default categories you want.
		
		local tfaOptionNMRIHCL = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA NRMIH Settings Server"}
		
		tfaOptionNMRIHCL.Options["#Default"] = {
			cl_tfa_nmrih_fx_fext = "1"
		}
		
		panel:AddControl("ComboBox", tfaOptionNMRIHCL)
		
		panel:AddControl("CheckBox", {
			Label = "Enable Fire Extinguisher FX",
			Command = "cl_tfa_nmrih_fx_fext",
		})
		
		panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	
	end
	
	function tfaNMRIHAddOption()
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFANMRIHServer", "NMRIH Server", "", "", tfaNMRIHOptionServer)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFANMRIHClient", "NMRIH Client", "", "", tfaNMRIHOptionClient)
	end
	
	hook.Add("PopulateToolMenu", "tfaNMRIHAddOption", tfaNMRIHAddOption)
	
end

local flashlightvar = GetConVar("sv_tfa_nmrih_flashlight_required")

if flashlightvar == nil then
	flashlightvar = CreateConVar("sv_tfa_nmrih_flashlight_required", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Require flashlight to be held?")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_nmrih_fx_tnt") == nil then
	CreateConVar("sv_tfa_nmrih_fx_tnt", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable TNT FX, or use default? 0 = off, 1 = on")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_nmrih_fx_fext_override") == nil then
	CreateConVar("sv_tfa_nmrih_fx_fext_override", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Override fire extinguisher FX? -1 = leave to client, 0 = off, 1 = on")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_nmrih_melee_multiplier") == nil then
	CreateConVar("sv_tfa_nmrih_melee_multiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Melee damage multiplier")
	--print("Damage Multiplier con var created")
end
	
if GetConVar("cl_tfa_nmrih_fx_fext") == nil then
	CreateClientConVar("cl_tfa_nmrih_fx_fext", 1, true, true)
end

if SERVER then
	util.AddNetworkString( "NMRIHFlashlightToggle" )
	
	net.Receive("NMRIHFlashlightToggle",function(length,ply)
		if IsValid(ply) then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) then wep.IsOn = !wep.IsOn end
		end
	end)

	hook.Add("PlayerTick","FlashlightStuffTick",function(ply)
		if !flashlightvar or !flashlightvar:GetBool() then return end
		if !IsValid(ply) then return end
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		if ply:FlashlightIsOn() and ( wep:GetClass()!="tfa_nmrih_maglite" or !wep.IsOn ) then
			ply:Flashlight(false)
		end
	end)
end

hook.Add("PlayerBindPress","FlashlightStuff",function(ply,bind,pressed)
	if !CLIENT then return end
	if bind=="impulse 100" then
		if flashlightvar and flashlightvar:GetBool() then
			if !IsValid(ply) then return true end
			if !IsValid(ply:GetActiveWeapon()) then return true end
			if ply:GetActiveWeapon():GetClass()!="tfa_nmrih_maglite" then
				if ply:HasWeapon("tfa_nmrih_maglite") then
					ply:ConCommand("use tfa_nmrih_maglite")
				end
				return true
			end
			if pressed then
				net.Start("NMRIHFlashlightToggle")
				net.SendToServer()
			end
			return true
		else
			if !IsValid(ply) then return true end
			if !IsValid(ply:GetActiveWeapon()) then return true end
			if ply:GetActiveWeapon():GetClass()=="tfa_nmrih_maglite" then
				if pressed then
					net.Start("NMRIHFlashlightToggle")
					net.SendToServer()
				end
				return true
			end		
		end
	end
end)