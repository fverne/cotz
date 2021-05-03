local PLUGIN = PLUGIN

PLUGIN.name = "Simple Cross Server"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Allows for basic cross server interaction."

PLUGIN.loadpoints = PLUGIN.loadpoints or {}
PLUGIN.mapdata = PLUGIN.mapdata or {}
PLUGIN.homemap = "rp_marsh_cs_cotz_v2"

local DEBUGSETUP = true
local checktime = 0

ix.util.Include("sh_definitions.lua")

function PLUGIN:CanPlayerUseCharacter(client, char)
	local curmap = char:GetData("curmap", self.homemap)

	if client:IsAdmin() then
		return true
	end

	if curmap == nil then
		curmap = game.GetMap()
	end

	if (curmap != game.GetMap() ) then
		return false, "Character not in this map. Try another server."
	end
end

do
	if DEBUGSETUP == true then
		ix.command.Add("loadzoneadd", {
			superAdminOnly = true,
			arguments = {
				ix.type.string,
				ix.type.string,
			},
			OnRun = function(self, client, map, loadzone)
				local trace = client:GetEyeTraceNoCursor()
				local hitpos = trace.HitPos + trace.HitNormal*5

				local mapdata = PLUGIN.mapdata

				if mapdata[map] != nil then
					if mapdata[map].loadzones[loadzone] != nil then
						table.insert( PLUGIN.loadpoints, { hitpos, map, loadzone })
						client:Notify( "You added a link to ".. map .. "'s "..loadzone.." zone." )
					else
						client:Notify("Invalid zone")
					end
				else
					client:Notify("Invalid map")
				end
			end
		})

		ix.command.Add("loadzoneremove", {
			superAdminOnly = true,
			arguments = {
				ix.type.string,
			},
			OnRun = function(self, client, range)
				local trace = client:GetEyeTraceNoCursor()
				local hitpos = trace.HitPos + trace.HitNormal*5
				local range = range or 128
				local mt = 0
				for k, v in pairs( PLUGIN.loadpoints ) do
					local distance = v[1]:Distance( hitpos )
					if distance <= tonumber(range) then
						PLUGIN.loadpoints[k] = nil
						mt = mt + 1
					end
				end
				client:Notify( mt .. " load zones has been removed.")
			end
		})
	end
end


function PLUGIN:Think()
	if checktime < CurTime() then
		checktime = CurTime() + 3

		for k, v in pairs(player.GetAll()) do
			for j, c in pairs(self.loadpoints) do
				if v:GetPos():Distance(c[1]) < 128 then
					if !v.inmenu then
						v.inmenu = true
						v:requestQuery("Move Zones", "Do you wish to move to "..self.mapdata[c[2]].name.."?\n"..self.mapdata[c[2]].loadzones[c[3]].desc,
						function(response)
							print(response)

							if response then
								v.inmenu = nil
								self:RedirectPlayer(v,c[2],c[3])
							else
								timer.Simple(6, function() v.inmenu = nil end)
							end
						end)
					end
				end
			end
		end
	end
end

--[[
nut.command.add("gotomap", {
	adminOnly = true,
	syntax = "[string map] [string loadzone]",
	onRun = function(client, arguments)
		
		local map = arguments[1]
		local loadzone = arguments[2]

		local character = client:getChar()

		local mapdata = PLUGIN.mapdata

		--sanity check
		if mapdata[map] != nil then
			if mapdata[map].loadzones[loadzone] != nil then

				local position = character:getData("pos")

				position[map] = {
					pos = mapdata[map].loadzones[loadzone].pos,
					ang = mapdata[map].loadzones[loadzone].ang
				}

				character:setData("pos", position)
				character:setData("curmap", map)
			else
				client:notify("Invalid zone")
			end
		else
			client:notify("Invalid map")
		end
	end
})
--]]

ix.command.Add("gotomap", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		bit.bor(ix.type.string, ix.type.optional),
	},
	OnRun = function(self, client, map, loadzone)

		PLUGIN:RedirectPlayer(client,map,loadzone)

	end
})

ix.command.Add("chargotomap", {
	adminOnly = true,
	arguments = {
			ix.type.string,
			ix.type.string,
			bit.bor(ix.type.string, ix.type.optional),
	},	
	OnRun = function(self, client, char, map, loadzone)
		local char =  ix.command.FindPlayer(client, char)

		PLUGIN:RedirectPlayer(char,map,loadzone)

	end
})

local playerMeta = FindMetaTable("Player")

function PLUGIN:RedirectPlayer(client, map, loadzone)
	local character = client:GetCharacter()

	local mapdata = self.mapdata

	--sanity check
	if mapdata[map] != nil then
		local tempip = mapdata[map].serverip
		if mapdata[map].loadzones[loadzone] != nil then
			
			local position = character:GetData("pos",{})

			position[map] = {
				pos = mapdata[map].loadzones[loadzone].pos,
				ang = mapdata[map].loadzones[loadzone].ang
			}

			character:SetData("pos", position)
			character:SetData("curmap", map)

			--client:SendLua("RunConsoleCommand('connect', '".. tempip .."')")
			client:Notify(character:GetName().." has been sent to "..map)
			client:SendLua("LocalPlayer():ConCommand('connect ".. tempip .."')")
		else
			character:SetData("curmap", map)
			client:Notify(character:GetName().." has been sent to "..map)
			client:SendLua("LocalPlayer():ConCommand('connect ".. tempip .."')")		
		end
	else
		client:Notify("Invalid map")
	end
end

/*
function PLUGIN:ShouldMenuButtonShow(buttonid)
	if buttonid == "create" then
		if game.GetMap() == self.homemap then
			return true
		else
			return false
		end
	end
end*/

function PLUGIN:LoadData()
	self.loadpoints = self:GetData() or {}
end

function PLUGIN:SaveData()
	self:SetData(self.loadpoints)
end

/*
hook.Add("HUDPaint", "nut_DrawLoadZones", function()
	if (LocalPlayer():getChar()) then
		for k, v in pairs(PLUGIN.loadpoints) do
			if LocalPlayer():GetPos():Distance(v[1]) > 512 then return end
			local Pos = v[1]:ToScreen()
			draw.RoundedBox(0, Pos.x, Pos.y, 10, 40, Color(100, 200, 100))
			draw.RoundedBox(0, Pos.x - 15, Pos.y + 15, 40, 10, Color(100, 200, 100))

			draw.SimpleText("Move to "..v[2], "ReviveText", Pos.x, Pos.y - 20, Color(249, 255, 239), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end)