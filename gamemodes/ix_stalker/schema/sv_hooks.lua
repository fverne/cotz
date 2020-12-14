
-- Here is where all of your serverside hooks should go.

function Schema:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	if (inventory) then		
		local items = {}
	
		if (character:GetFaction() == FACTION_LONERS) then
			items = {
				"kit_newchar",
				"documents4",
			}
		end
		
		local i = 1
		for k, v in pairs(items) do
			timer.Simple(i + k, function()
				inventory:Add(v)
			end)
		end
	end
end

-- this is in the suits plugin, but leaving it commented here as its nice to have if the plugin is removed
-- function Schema:EntityTakeDamage(target, dmg)
-- 	if (target:IsPlayer() and dmg:GetAttacker():IsPlayer()) then
-- 		return true
-- 	end
-- end

function Schema:PlayerSpray(client)
	return true
end

function Schema:PlayerShouldTaunt()
	return false
end

local deathSounds = {
Sound("stalkersound/die1.wav"),
Sound("stalkersound/die2.wav"),
Sound("stalkersound/die3.wav"),
Sound("stalkersound/die4.wav"),
}

function Schema:GetPlayerDeathSound(client)
	return table.Random(deathSounds)
end

local painSounds = {
Sound("stalkersound/pain1.wav"),
Sound("stalkersound/pain2.wav"),
Sound("stalkersound/pain3.wav"),
Sound("stalkersound/pain4.wav"),
Sound("stalkersound/pain5.wav"),
Sound("stalkersound/pain6.wav"),
Sound("stalkersound/pain7.wav"),
Sound("stalkersound/pain8.wav"),
Sound("stalkersound/pain9.wav"),
Sound("stalkersound/pain10.wav"),
Sound("stalkersound/pain11.wav"),
Sound("stalkersound/pain12.wav"),
Sound("stalkersound/pain13.wav"),
Sound("stalkersound/pain14.wav"),
}

function Schema:GetPlayerPainSound(client)
	return table.Random(painSounds)
end

function Schema:PlayerSpawnEffect(client, weapon, info)
	return client:IsAdmin() or client:GetCharacter():HasFlags("N")
end

function Schema:PostPlayerLoadout(client)
	if client:IsAdmin() then
		return false
	end
	client:SetCanZoom(false)
end

function Schema:Initialize()
	game.ConsoleCommand("net_maxfilesize 64\n");
	game.ConsoleCommand("sv_kickerrornum 0\n");

	game.ConsoleCommand("sv_allowupload 0\n");
	game.ConsoleCommand("sv_allowdownload 0\n");
	game.ConsoleCommand("sv_allowcslua 0\n");

end