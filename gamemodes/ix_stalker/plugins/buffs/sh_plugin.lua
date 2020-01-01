local PLUGIN = PLUGIN
PLUGIN.name = "Buffs and Debuffs"
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1)"
PLUGIN.desc = "Sometimes, You get sick or high. DrunkyBlur by Spy."
PLUGIN.buffs = {}

/*
if !nut.plugin.list["_oldplugins-fix"] then
	print("[Buffs Plugin] _oldplugins-fix Plugin is not found!")
	print("Download from GitHub: https://github.com/tltneon/nsplugins\n")
	return
end*/

local playerMeta = FindMetaTable("Player")

ix.util.Include("sh_buffs.lua")
ix.util.Include("sh_buffhooks.lua")
ix.util.Include("cl_hud.lua")

-- player:GetBuffs()
-- returns table
-- This function gets one's all buffs.
function playerMeta:GetBuffs()
	return self:GetNetVar( "buffs" ) or {}
end

-- player:AddBuff( string [Buff's unique name] )
-- returns table or boolean( false )
-- This function allows you handle buffs
function playerMeta:HasBuff( strBuff )
	if self:GetNetVar( "buffs" ) != nil then
		return ( self:GetNetVar( "buffs" )[ strBuff ] )
	else
		return false
	end
end

function PLUGIN:GetBuff( strBuff )
	return self.buffs[str]
end

if (SERVER) then
	-- player:AddBuff( string [Buff's unique name], integer [Buff's Duration Time], table [Parameters] )
	-- This function allows you to add some buffs to player.
	function playerMeta:AddBuff( strBuff, intDuration, parameter ) 
		if intDuration < 0 then intDuration = 1000000 end
		local tblBuffs = self:GetNetVar( "buffs" ) or {}
		local tblBuffInfo = PLUGIN:GetBuff(strBuff)
		if tblBuffInfo and tblBuffInfo.onbuffed then
			if !self:HasBuff( strBuff ) then
				tblBuffInfo.onbuffed( self, parameter )
			end
		end
		tblBuffs[ strBuff ] = { CurTime() + intDuration, parameter }
		hook.Call( "OnBuffed", GAMEMODE, strBuff, intDuration, parameter )
		self:SetNetVar( "buffs", tblBuffs )
	end
	
	-- player:RemoveBuff( string [Buff's unique name], table [Parameters] )
	-- This function allows you to add some buffs to player.
	function playerMeta:RemoveBuff( strBuff, parameter ) -- perma
		local tblBuffs = self:GetNetVar( "buffs" ) or {}
			local tblBuffInfo = PLUGIN:GetBuff(strBuff)
			if tblBuffInfo and tblBuffInfo.ondebuffed then
				tblBuffInfo.ondebuffed( self, parameter )
			end
			tblBuffs[ strBuff ] = nil
			hook.Call( "OnDebuffed", GAMEMODE, strBuff, intDuration, parameter )
		self:SetNetVar( "buffs", tblBuffs )
	end
	
	-- player:PlayerSpawn( player player )
	-- This hook wipes every buffs on your character.
	-- I suggest you do not touch this function unless you know what you're doing.
	function PLUGIN:PlayerSpawn( player )
		player:SetNetVar( "buffs", {} )
	end

	-- player:Think( )
	-- This hook handles every player's buff effect.
	-- I suggest you do not touch this function unless you know what you're doing.
	function PLUGIN:Think()
		for k, v in pairs ( player.GetAll() ) do
			if !( v:IsValid() and v:Alive() ) then continue end 
			local tblBuffs = v:GetNetVar( "buffs" ) or {}
			for name, dat in pairs( tblBuffs ) do
				local tblBuffInfo = self.buffs[ name ]
				if tblBuffInfo and tblBuffInfo.func then
					tblBuffInfo.func( v, dat[2] )
				end
				if dat[1] < CurTime() then
					v:RemoveBuff( name )
				end
			end
		end
	end

else

	function PLUGIN:Think()
		for k, v in pairs ( player.GetAll() ) do
			if !( v:IsValid() and v:Alive() ) then continue end 
			local tblBuffs = v:GetNetVar( "buffs" ) or {}
			for name, dat in pairs( tblBuffs ) do
				local tblBuffInfo = self.buffs[ name ]
				if tblBuffInfo and tblBuffInfo.cl_func then
					tblBuffInfo.cl_func( v, dat[2] )
				end
			end
		end
	end

end