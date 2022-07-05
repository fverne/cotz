local PLUGIN = PLUGIN

PLUGIN.name = "Noticeboard"
PLUGIN.author = "Vex + armdupe"
PLUGIN.desc = "A noticeboard for players to write on."

ix.util.Include("derma/cl_noticeboard.lua")

if (SERVER) then
	function PLUGIN:SaveData()
		local data = {}
		for k, v in ipairs(ents.FindByClass("ix_noticeboard")) do
			data[#data + 1] = {v:GetPos(), v:GetAngles()}
		end
		self:SetData(data)
	end

	function PLUGIN:LoadData()
		local data = self:GetData()
		if (data) then
			for k, v in ipairs(data) do
				local ent = ents.Create("ix_noticeboard")
				ent:SetPos(v[1])
				ent:SetAngles(v[2])
				ent:Spawn()
				ent:SetSolid(SOLID_VPHYSICS)
				ent:PhysicsInit(SOLID_VPHYSICS)

				local physObject = ent:GetPhysicsObject()

				if (physObject) then
					physObject:EnableMotion()
				end
			end
		end
	end

    local cooldown = 604800 -- 1 week

    function PLUGIN:NoticeWipeCheck()
        local nextWipe = cookie.GetNumber("ixNoticesTimeUntilWipe", 0)
        local time = os.time()

        if not (time < nextWipe) then
            print("Notices have been wiped! - " .. os.date("%Y/%m/%d - %H:%M:%S"))
            local notices = ix.data.Get("noticeBoardNotes") or {}
            table.remove(notices)
            ix.data.Set("noticeBoardNotes", {})
            cookie.Set("ixNoticesTimeUntilWipe", time + cooldown)
        end
    end

	netstream.Hook("noticeUpdateEntry", function(client, index, txt, id, tag)
		local notices = ix.data.Get("noticeBoardNotes") or {}

		if (!notices[index]) then
			table.insert(notices, {owner = id, label = tag, text = txt})
		else
			notices[index]["text"] = txt
		end

		ix.data.Set("noticeBoardNotes", notices)
	end)


	netstream.Hook("noticeRemoveEntry", function(client, index)
		local notices = ix.data.Get("noticeBoardNotes") or {}

		table.remove(notices, index)

		ix.data.Set("noticeBoardNotes", notices)
	end)

	function PLUGIN:OpenNoticeBoard(client)
		local notices = ix.data.Get("noticeBoardNotes") or {}

		PLUGIN:NoticeWipeCheck()
		
		netstream.Start(client, "openNoticeUI", notices)
	end
else
	netstream.Hook("openNoticeUI", function(notices)
		vgui.Create("noticeBoard"):populate(notices)
	end)
end