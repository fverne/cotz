/*
	PermaProps
	Created by Entoros, June 2010
	Facepunch: http://www.facepunch.com/member.php?u=180808
	Modified By Malboro 28 / 12 / 2012
	
	Ideas:
		Make permaprops cleanup-able
		
	Errors:
		Errors on die

	Remake:
		By Malboro the 28/12/2012
*/

TOOL.Category		=	"Props Tool"
TOOL.Name			=	"PermaProps"
TOOL.Command		=	nil
TOOL.ConfigName		=	""

if CLIENT then
	language.Add("Tool.permaprops.name", "PermaProps")
	language.Add("Tool.permaprops.desc", "Save a props permanently")
	language.Add("Tool.permaprops.0", "LeftClick: Add RightClick: Remove Reload: Update")

	surface.CreateFont("PermaPropsToolScreenFont", { font = "Arial", size = 40, weight = 1000, antialias = true, additive = false })
	surface.CreateFont("PermaPropsToolScreenSubFont", { font = "Arial", size = 30, weight = 1000, antialias = true, additive = false })
end

function TOOL:LeftClick(trace)

	if CLIENT then return true end

	local ent = trace.Entity
	local ply = self:GetOwner()

	if not PermaProps then ply:ChatPrint( "ERROR: Lib not found" ) return end
	
	if !PermaProps.HasPermission( ply, "Save") then return end

	if not ent:IsValid() then ply:ChatPrint( "That is not a valid entity !" ) return end
	if ent:IsPlayer() then ply:ChatPrint( "That is a player !" ) return end
	if ent.PermaProps then ply:ChatPrint( "That entity is already permanent !" ) return end

	local content = PermaProps.PPGetEntTable(ent)
	if not content then return end

	local max = tonumber(sql.QueryValue("SELECT MAX(id) FROM permaprops;"))
	if not max then max = 1 else max = max + 1 end

	local new_ent = PermaProps.PPEntityFromTable(content, max)
	if !new_ent or !new_ent:IsValid() then return end
	
	local phys = new_ent:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:EnableMotion(false)
	end

	PermaProps.SparksEffect( ent )

	PermaProps.SQL.Query("INSERT INTO permaprops (id, map, content) VALUES(NULL, ".. sql.SQLStr(game.GetMap()) ..", ".. sql.SQLStr(util.TableToJSON(content)) ..");")
	ply:ChatPrint("You saved " .. ent:GetClass() .. " with model ".. ent:GetModel() .. " to the database.")

	ent:Remove()

	return true

end

function TOOL:RightClick(trace)

	if CLIENT then return true end

	local ent = trace.Entity
	local ply = self:GetOwner()

	if not PermaProps then ply:ChatPrint( "ERROR: Lib not found" ) return end

	if !PermaProps.HasPermission( ply, "Delete") then return end

	if not ent:IsValid() then ply:ChatPrint( "That is not a valid entity !" ) return end
	if ent:IsPlayer() then ply:ChatPrint( "That is a player !" ) return end
	if not ent.PermaProps then ply:ChatPrint( "That is not a PermaProp !" ) return end
	if not ent.PermaProps_ID then ply:ChatPrint( "ERROR: ID not found" ) return end

	PermaProps.SQL.Query("DELETE FROM permaprops WHERE id = ".. ent.PermaProps_ID ..";")

	ply:ChatPrint("You erased " .. ent:GetClass() .. " with a model of " .. ent:GetModel() .. " from the database.")

	ent:Remove()

	return true

end

function TOOL:Reload(trace)

	if CLIENT then return true end

	if not PermaProps then self:GetOwner():ChatPrint( "ERROR: Lib not found" ) return end

	if (not trace.Entity:IsValid() and PermaProps.HasPermission( self:GetOwner(), "Update")) then self:GetOwner():ChatPrint( "You have reload all PermaProps !" ) PermaProps.ReloadPermaProps() return false end

	if trace.Entity.PermaProps then

		local ent = trace.Entity
		local ply = self:GetOwner()

		if !PermaProps.HasPermission( ply, "Update") then return end

		if ent:IsPlayer() then ply:ChatPrint( "That is a player !" ) return end
		
		local content = PermaProps.PPGetEntTable(ent)
		if not content then return end

		PermaProps.SQL.Query("UPDATE permaprops set content = ".. sql.SQLStr(util.TableToJSON(content)) .." WHERE id = ".. ent.PermaProps_ID .." AND map = ".. sql.SQLStr(game.GetMap()) .. ";")

		local new_ent = PermaProps.PPEntityFromTable(content, ent.PermaProps_ID)
		if !new_ent or !new_ent:IsValid() then return end

		PermaProps.SparksEffect( ent )

		ply:ChatPrint("You updated the " .. ent:GetClass() .. " in the database.")

		ent:Remove()

		local phys = new_ent:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:Wake()
			phys:EnableGravity( false )
			phys:EnableDrag( false )
			phys:EnableMotion(false)
		end
			
	else

		return false

	end

	return true

end

function TOOL.BuildCPanel(panel)

	panel:AddControl("Header",{Text = "PermaProps", Description = "PermaProps\n\nSaves entities across map changes\n"})
	panel:AddControl("Button",{Label = "Open Configuration Menu", Command = "pp_cfg_open"})

end

function TOOL:DrawToolScreen(width, height)

	if SERVER then return end

	surface.SetDrawColor(17, 148, 240, 255)
	surface.DrawRect(0, 0, 256, 256)

	surface.SetFont("PermaPropsToolScreenFont")
	local w, h = surface.GetTextSize(" ")
	surface.SetFont("PermaPropsToolScreenSubFont")
	local w2, h2 = surface.GetTextSize(" ")

	draw.SimpleText("PermaProps", "PermaPropsToolScreenFont", 128, 100, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)
	draw.SimpleText("By Malboro", "PermaPropsToolScreenSubFont", 128, 128 + (h + h2) / 2 - 4, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)

end