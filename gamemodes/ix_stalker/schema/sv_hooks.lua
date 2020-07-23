
-- Here is where all of your serverside hooks should go.

function Schema:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	if (inventory) then		
		local items = {}
	
		if (character:GetFaction() == FACTION_LONERS) then
			items = {
				"oldmeat",
				"waterdirty",
			}
		end
		
		local i = 1
		for k, v in pairs(items) do
			timer.Simple(i + k, function()
				inventory:Add(v)
			end)
		end
	end

	local avatars = {}
	avatars = {
		"propic/loner/loner1",
		"propic/loner/loner100",
		"propic/loner/loner11",
		"propic/loner/loner12",
		"propic/loner/loner13",
		"propic/loner/loner14",
		"propic/loner/loner16",
		"propic/loner/loner17",
		"propic/loner/loner3",
		"propic/loner/loner43",
		"propic/loner/loner47",
		"propic/loner/loner53",
		"propic/loner/loner54",
		"propic/loner/loner55",
		"propic/loner/loner56",
		"propic/loner/loner57",
		"propic/loner/loner58",
		"propic/loner/loner59",
		"propic/loner/loner60",
		"propic/loner/loner62",
		"propic/loner/loner63",
		"propic/loner/loner68",
		"propic/loner/loner69",
		"propic/loner/loner7",
		"propic/loner/loner79",
		"propic/loner/loner8",
		"propic/loner/loner80",
		"propic/loner/loner81",
		"propic/loner/loner83",
		"propic/loner/loner84",
		"propic/loner/loner85",
		"propic/loner/loner86",
		"propic/loner/loner87",
		"propic/loner/loner90",
		"propic/loner/loner96",
		"propic/loner/loner97",
		"propic/loner/loner98",
	}
	character:SetPdaavatar(table.Random(avatars))
end

function Schema:EntityTakeDamage(target, dmg)
	if (target:IsPlayer() and dmg:GetAttacker():IsPlayer()) then
		return true
	end
end

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

netstream.Hook("qurReq", function(client, time, bResponse)
	if (client.nutQueReqs and client.nutQueReqs[time]) then
		client.nutQueReqs[time](bResponse)
		client.nutQueReqs[time] = nil
	end
end)