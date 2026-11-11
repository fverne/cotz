ix.characterNetwork = ix.characterNetwork or {}

local MESSAGE = "cotz/character/snapshot"
local CHUNK_BYTES = 60000

if SERVER then
	util.AddNetworkString(MESSAGE)

	local function sendPayload(receiver, payload)
		-- pON is bundled with Helix and preserves numeric keys, vectors, angles and entities.
		local encoded = util.Compress(pon.encode(payload))

		-- Reliable messages are ordered. Send each complete snapshot synchronously so chunks cannot interleave.
		for offset = 1, #encoded, CHUNK_BYTES do
			local chunk = encoded:sub(offset, offset + CHUNK_BYTES - 1)

			net.Start(MESSAGE)
			net.WriteBool(offset == 1)
			net.WriteBool(offset + #chunk > #encoded)
			net.WriteUInt(#chunk, 16)
			net.WriteData(chunk, #chunk)
			net.Send(receiver)
		end
	end

	function ix.characterNetwork.SendInfo(character, data, receiver)
		sendPayload(receiver, {
			id = character:GetID(),
			playerIndex = character.player:EntIndex(),
			vars = data,
		})
	end

	function ix.characterNetwork.SendVar(character, key, value, receiver)
		sendPayload(receiver, {id = character:GetID(), key = key, value = value})
	end
else
	local chunks

	net.Receive(MESSAGE, function()
		local first = net.ReadBool()
		local last = net.ReadBool()
		local length = net.ReadUInt(16)
		local chunk = net.ReadData(length)

		if first then
			chunks = {}
		end

		assert(chunks, "Character snapshot received without its first chunk")
		chunks[#chunks + 1] = chunk

		if not last then return end

		local encoded = table.concat(chunks)
		chunks = nil
		local payload = pon.decode(assert(util.Decompress(encoded), "Unable to decompress character snapshot"))

		if payload.key then
			local character = ix.char.loaded[payload.id]

			-- Match ixCharacterVarChanged: updates for characters not yet synchronized are ignored.
			if character then
				character.vars[payload.key] = payload.value
			end
		else
			ix.char.loaded[payload.id] = ix.char.New(payload.vars, payload.id, payload.playerIndex)
		end
	end)
end
