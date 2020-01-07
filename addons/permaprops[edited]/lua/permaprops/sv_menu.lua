/*
   ____          _          _   ____          __  __       _ _                     
  / ___|___   __| | ___  __| | | __ ) _   _  |  \/  | __ _| | |__   ___  _ __ ___  
 | |   / _ \ / _` |/ _ \/ _` | |  _ \| | | | | |\/| |/ _` | | '_ \ / _ \| '__/ _ \ 
 | |__| (_) | (_| |  __/ (_| | | |_) | |_| | | |  | | (_| | | |_) | (_) | | | (_) |
  \____\___/ \__,_|\___|\__,_| |____/ \__, | |_|  |_|\__,_|_|_.__/ \___/|_|  \___/ 
                                      |___/                                        
*/

util.AddNetworkString("pp_open_menu")
util.AddNetworkString("pp_info_send")

local function PermissionLoad()

	if not PermaProps then PermaProps = {} end
	if not PermaProps.Permissions then PermaProps.Permissions = {} end

	PermaProps.Permissions["superadmin"] = { Physgun = true, Tool = true, Property = true, Save = true, Delete = true, Update = true, Menu = true, Permissions = true, Inherits = "admin", Custom = true }
	PermaProps.Permissions["admin"] = { Physgun = false, Tool = false, Property = false, Save = true, Delete = true, Update = true, Menu = true, Permissions = false, Inherits = "user", Custom = true }
	PermaProps.Permissions["user"] = { Physgun = false, Tool = false, Property = false, Save = false, Delete = false, Update = false, Menu = false, Permissions = false, Inherits = "user", Custom = true }

	if CAMI then

		for k, v in pairs(CAMI.GetUsergroups()) do

			if k == "superadmin" or k == "admin" or k == "user" then continue end

			PermaProps.Permissions[k] = { Physgun = false, Tool = false, Property = false, Save = false, Delete = false, Update = false, Menu = false, Permissions = false, Inherits = v.Inherits, Custom = false }

		end
		
	end

	if file.Exists( "permaprops_config.txt", "DATA" ) then
 		file.Delete( "permaprops_config.txt" )
	end

	if file.Exists( "permaprops_permissions.txt", "DATA" ) then
 		
 		local content = file.Read("permaprops_permissions.txt", "DATA")
 		local tablecontent = util.JSONToTable( content )

 		for k, v in pairs(tablecontent) do
 			
 			if PermaProps.Permissions[k] == nil then

 				tablecontent[k] = nil

 			end

 		end

 		table.Merge(PermaProps.Permissions, ( tablecontent or {} ))

	end

end
PermissionLoad()

local function PermissionSave()

	file.Write( "permaprops_permissions.txt", util.TableToJSON(PermaProps.Permissions) ) 

end

local function pp_open_menu( ply )

	if !PermaProps.HasPermission( ply, "Menu") then ply:ChatPrint("Access denied !") return end

	local SendTable = {}
	local Data_PropsList = sql.Query( "SELECT * FROM permaprops WHERE map = ".. sql.SQLStr(game.GetMap()) .. ";" )

	if Data_PropsList and #Data_PropsList < 200 then
	
		for k, v in pairs( Data_PropsList ) do

			local data = util.JSONToTable(v.content)

			SendTable[v.id] = {Model = data.Model, Class = data.Class, Pos = data.Pos, Angle = data.Angle}

		end

	elseif Data_PropsList and #Data_PropsList > 200 then -- Too much props dude :'(

		for i = 1, 199 do
			
			local data = util.JSONToTable(Data_PropsList[i].content)

			SendTable[Data_PropsList[i].id] = {Model = data.Model, Class = data.Class, Pos = data.Pos, Angle = data.Angle}

		end

	end

	local Content = {}
	Content.MProps = tonumber(sql.QueryValue("SELECT COUNT(*) FROM permaprops WHERE map = ".. sql.SQLStr(game.GetMap()) .. ";"))
	Content.TProps = tonumber(sql.QueryValue("SELECT COUNT(*) FROM permaprops;"))

	Content.PropsList = SendTable
	Content.Permissions = PermaProps.Permissions

	local Data = util.TableToJSON( Content )
	local Compressed = util.Compress( Data )

	net.Start( "pp_open_menu" )
	net.WriteFloat( Compressed:len() )
	net.WriteData( Compressed, Compressed:len() )
	net.Send( ply )

end
concommand.Add("pp_cfg_open", pp_open_menu)

local function pp_info_send( um, ply )

	if !PermaProps.HasPermission( ply, "Menu") then ply:ChatPrint("Access denied !") return end

	local Content = net.ReadTable()

	if Content["CMD"] == "DEL" then

		Content["Val"] = tonumber(Content["Val"])

		if Content["Val"] != nil and Content["Val"] <= 0 then return end

		sql.Query("DELETE FROM permaprops WHERE id = ".. sql.SQLStr(Content["Val"]) .. ";")

		for k, v in pairs(ents.GetAll()) do
			
			if v.PermaProps_ID == Content["Val"] then

				ply:ChatPrint("You erased " .. v:GetClass() .. " with a model of " .. v:GetModel() .. " from the database.")
				v:Remove()
				break

			end

		end

	elseif Content["CMD"] == "VAR" then

		if PermaProps.Permissions[Content["Name"]] == nil or PermaProps.Permissions[Content["Name"]][Content["Data"]] == nil  then return end
		if !isbool(Content["Val"]) then return end

		if Content["Name"] == "superadmin" and  ( Content["Data"] == "Custom" or Content["Data"] == "Permissions" or Content["Data"] == "Menu" ) then return end

		if !PermaProps.HasPermission( ply, "Permissions") then ply:ChatPrint("Access denied !") return end

		PermaProps.Permissions[Content["Name"]][Content["Data"]] = Content["Val"]

		PermissionSave()

	elseif Content["CMD"] == "DEL_MAP" then

		sql.Query( "DELETE FROM permaprops WHERE map = ".. sql.SQLStr(game.GetMap()) .. ";" )
		PermaProps.ReloadPermaProps()

		ply:ChatPrint("You erased all props from the map !")

	elseif Content["CMD"] == "DEL_ALL" then

		sql.Query( "DELETE FROM permaprops;" )
		PermaProps.ReloadPermaProps()

		ply:ChatPrint("You erased all props !")

	elseif Content["CMD"] == "CLR_MAP" then

		for k, v in pairs( ents.GetAll() ) do

			if v.PermaProps == true then

				v:Remove()

			end

		end

		ply:ChatPrint("You have removed all props !")

	end

end
net.Receive("pp_info_send", pp_info_send)