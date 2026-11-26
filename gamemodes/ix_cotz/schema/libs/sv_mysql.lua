-- COTZ override of the bundled Helix mysql:RawQuery (gamemodes/helix/gamemode/core/libs/thirdparty/sv_mysql.lua).
-- Identical to upstream except that query errors print the error text before the query. Garry's Mod truncates
-- long messages, and a long character-save query otherwise pushes the actual failure out of view.

function mysql:RawQuery(query, callback, flags, ...)
	if self.module == "mysqloo" then
		local queryObj = self.connection:query(query)

		queryObj:setOption(mysqloo.OPTION_NAMED_FIELDS)

		queryObj.onSuccess = function(_, result)
			if callback then
				local bStatus, value = pcall(callback, result, true, tonumber(queryObj:lastInsert()))

				if not bStatus then
					error(string.format("[mysql] MySQL Callback Error!\n%s\n", value))
				end
			end
		end

		queryObj.onError = function(_, errorText)
			ErrorNoHalt(string.format("[mysql] MySQL Query Error!\n%s\nQuery: %s\n", errorText, query))
		end

		queryObj:start()
	elseif self.module == "sqlite" then
		local result = sql.Query(query)

		if result == false then
			error(string.format("[mysql] SQL Query Error!\n%s\nQuery: %s\n", sql.LastError(), query))
		elseif callback then
			local bStatus, value = pcall(callback, result, true, tonumber(sql.QueryValue("SELECT last_insert_rowid()")))

			if not bStatus then
				error(string.format("[mysql] SQL Callback Error!\n%s\n", value))
			end
		end
	else
		ErrorNoHalt(string.format("[mysql] Unsupported module \"%s\"!\n", self.module))
	end
end
