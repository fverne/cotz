ix.progression = ix.progression or {}

function ix.progression.SetProgression(progid, amount)
	if (ix.plugin.list["progression"].progressiondefinitions[progid]) then
		ix.plugin.list["progression"].progressionstatus[progid] = amount
	end
end

function ix.progression.GetProgression(progid)
	if (ix.plugin.list["progression"].progressiondefinitions[progid]) then
		return ix.plugin.list["progression"].progressionstatus[progid]
	end
end

function ix.progression.AddProgession(progid, amount)
	ix.progression.SetProgression(progid, ix.progression.GetProgression(progid) + amount)
end

function ix.progression.RemoveProgression(progid, amount)
  ix.progression.AddProgression(progid, -amount)
end