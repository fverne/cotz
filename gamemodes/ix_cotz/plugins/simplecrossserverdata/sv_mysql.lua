--[[
	mysql - 1.0.3
	A simple MySQL wrapper for Garry's Mod.

	Alexander Grist-Hucker
	http://www.alexgrist.com


	The MIT License (MIT)

	Copyright (c) 2014 Alex Grist-Hucker

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
--]]

-- Extends Alexander Grist-Hucker's bundled mysql wrapper without modifying Helix files.
-- The SQLite type conversions mirror that wrapper (MIT; Copyright (c) 2014 Alexander Grist-Hucker).
if (mysql.cotzStructuredQueries) then return end
mysql.cotzStructuredQueries = true

local QUERY_CLASS = getmetatable(mysql:Select("ix_characters"))
local originalExecute = QUERY_CLASS.Execute
local originalPrimaryKey = QUERY_CLASS.PrimaryKey

function QUERY_CLASS:PrimaryKey(key)
	if (istable(key)) then
		self.primaryKeys = key
		self.structured = true
	else
		originalPrimaryKey(self, key)
	end
end

local function ApplyQueryReplacements(_, definition)
	for _, replacement in ipairs({{"UNSIGNED ", ""}, {"NOT NULL AUTO_INCREMENT", ""},
		{"AUTO_INCREMENT", ""}, {"INT%(%d*%)", "INTEGER"}, {"INT ", "INTEGER"}}) do
		definition = definition:gsub(replacement[1], replacement[2])
	end

	return definition
end

-- Structured query support for schema extensions. Existing CRUD methods and return contracts remain unchanged.
local function quoteIdentifier(value)
	assert(isstring(value) and value:match("^[%a_][%w_%.]*$")
		and not value:find("..", 1, true) and value:sub(-1) ~= ".", "invalid database identifier")
	local parts = {}
	for part in value:gmatch("[^%.]+") do parts[#parts + 1] = "`" .. part .. "`" end

	return table.concat(parts, ".")
end

local function expression(kind, values)
	values = values or {}
	values.mysqlExpression = kind

	return values
end

function mysql.Column(name) return expression("column", {name = name}) end
function mysql.Now() return expression("clock") end
function mysql.Add(left, right) return expression("add", {left = left, right = right}) end
function mysql.Coalesce(value, fallback) return expression("coalesce", {value = value, fallback = fallback}) end
function mysql.Case(condition, yes, no) return expression("case", {condition = condition, yes = yes, no = no}) end
function mysql.Compare(column, operator, value)
	local operators = {["="] = true, ["<>"] = true, ["<"] = true, ["<="] = true, [">"] = true, [">="] = true}
	assert(operators[operator], "invalid comparison operator")

	return expression("compare", {left = isstring(column) and mysql.Column(column) or column,
		operator = operator, right = value})
end
function mysql.All(...) return expression("all", {...}) end
function mysql.Any(...) return expression("any", {...}) end
function mysql.Exists(query) return expression("exists", {query = query}) end
function mysql.NotExists(query) return expression("notExists", {query = query}) end

local buildStructured
local function renderValue(value)
	if (not istable(value) or not value.mysqlExpression) then
		return "'" .. mysql:Escape(tostring(value)) .. "'"
	end

	local kind = value.mysqlExpression
	if (kind == "column") then return quoteIdentifier(value.name) end
	if (kind == "clock") then
		return mysql.module == "sqlite" and "CAST(strftime('%s', 'now') AS INTEGER)" or "UNIX_TIMESTAMP()"
	end
	if (kind == "add") then return "(" .. renderValue(value.left) .. " + " .. renderValue(value.right) .. ")" end
	if (kind == "coalesce") then
		return "COALESCE(" .. renderValue(value.value) .. ", " .. renderValue(value.fallback) .. ")"
	end
	if (kind == "case") then
		return "CASE WHEN " .. renderValue(value.condition) .. " THEN " .. renderValue(value.yes)
			.. " ELSE " .. renderValue(value.no) .. " END"
	end
	if (kind == "compare") then
		return renderValue(value.left) .. " " .. value.operator .. " " .. renderValue(value.right)
	end
	if (kind == "all" or kind == "any") then
		local parts = {}
		for _, child in ipairs(value) do parts[#parts + 1] = renderValue(child) end
		assert(#parts > 0, "empty condition group")

		return "(" .. table.concat(parts, kind == "all" and " AND " or " OR ") .. ")"
	end
	if (kind == "exists" or kind == "notExists") then
		assert(value.query.queryType:lower() == "select", "subquery must be a SELECT")
		return (kind == "exists" and "EXISTS (" or "NOT EXISTS (") .. buildStructured(value.query) .. ")"
	end
	error("unknown database expression: " .. tostring(kind))
end

function QUERY_CLASS:Alias(name)
	quoteIdentifier(name)
	self.alias = name
	self.structured = true
	return self
end

function QUERY_CLASS:SelectColumn(column, alias)
	return self:SelectValue(mysql.Column(column), alias)
end

function QUERY_CLASS:SelectAll(alias)
	self.structured = true
	self.selectExpressions = self.selectExpressions or {}
	table.insert(self.selectExpressions, {wildcard = alias or false})
	return self
end

function QUERY_CLASS:SelectValue(value, alias)
	if (alias) then quoteIdentifier(alias) end
	self.structured = true
	self.selectExpressions = self.selectExpressions or {}
	table.insert(self.selectExpressions, {value = value, alias = alias})
	return self
end

function QUERY_CLASS:WhereExpr(condition)
	assert(istable(condition) and condition.mysqlExpression, "expected a structured condition")
	self.structured = true
	table.insert(self.whereList, condition)
	return self
end

function QUERY_CLASS:Join(tableName, alias, condition, kind)
	assert(kind == nil or kind == "LEFT" or kind == "INNER", "invalid join kind")
	self.structured = true
	self.joins = self.joins or {}
	table.insert(self.joins, {tableName = tableName, alias = alias, condition = condition, kind = kind or "INNER"})
	return self
end

function QUERY_CLASS:UpdateValue(column, value)
	self.structured = true
	table.insert(self.updateList, {quoteIdentifier(column), value, expression = true})
	return self
end

function QUERY_CLASS:InsertValue(column, value)
	self.structured = true
	table.insert(self.insertList, {quoteIdentifier(column), value, expression = true})
	return self
end

function QUERY_CLASS:InsertFrom(query, columns)
	assert(query.queryType:lower() == "select", "insert source must be a SELECT")
	self.structured = true
	self.insertSource, self.insertColumns = query, columns
	return self
end

function QUERY_CLASS:Index(name, columns)
	quoteIdentifier(name)
	self.structured = true
	self.indexes = self.indexes or {}
	table.insert(self.indexes, {name = name, columns = columns})
	return self
end

function QUERY_CLASS:OnError(callback)
	self.errorCallback = callback
	return self
end

local function identifiers(columns)
	local result = {}
	for _, name in ipairs(columns) do result[#result + 1] = quoteIdentifier(name) end

	return table.concat(result, ", ")
end

local function renderSource(tableName, alias)
	if (istable(tableName)) then assert(tableName.queryType:lower() == "select", "source must be a SELECT") end
	local source = istable(tableName) and ("(" .. buildStructured(tableName) .. ")") or quoteIdentifier(tableName)
	return source .. (alias and (" AS " .. quoteIdentifier(alias)) or "")
end

local function renderWhere(query)
	local parts = {}
	for _, condition in ipairs(query.whereList) do
		parts[#parts + 1] = istable(condition) and renderValue(condition) or condition
	end

	return #parts > 0 and (" WHERE " .. table.concat(parts, " AND ")) or ""
end

buildStructured = function(query)
	local kind = query.queryType:lower()
	local source = query.tableName and renderSource(query.tableName, query.alias)
	if (kind == "select") then
		local columns = {}
		for _, column in ipairs(query.selectList) do columns[#columns + 1] = column end
		for _, column in ipairs(query.selectExpressions or {}) do
			local value = column.wildcard ~= nil and (column.wildcard and
				(quoteIdentifier(column.wildcard) .. ".*") or "*") or renderValue(column.value)
			columns[#columns + 1] = value .. (column.alias and (" AS " .. quoteIdentifier(column.alias)) or "")
		end
		local result = "SELECT " .. (#columns > 0 and table.concat(columns, ", ") or "*")
		if (source) then result = result .. " FROM " .. source end
		for _, join in ipairs(query.joins or {}) do
			result = result .. " " .. join.kind .. " JOIN " .. renderSource(join.tableName, join.alias)
				.. " ON " .. renderValue(join.condition)
		end
		result = result .. renderWhere(query)
		if (#query.orderByList > 0) then result = result .. " ORDER BY " .. table.concat(query.orderByList, ", ") end
		if (isnumber(query.limit)) then result = result .. " LIMIT " .. query.limit end
		if (isnumber(query.offset)) then result = result .. " OFFSET " .. query.offset end
		return result
	end
	if (kind == "update") then
		local values = {}
		for _, pair in ipairs(query.updateList) do
			values[#values + 1] = pair[1] .. " = " .. (pair.expression and renderValue(pair[2]) or pair[2])
		end
		assert(#values > 0, "empty UPDATE")
		local result = "UPDATE " .. source .. " SET " .. table.concat(values, ", ") .. renderWhere(query)
		if (isnumber(query.offset)) then result = result .. " OFFSET " .. query.offset end
		return result
	end
	if (kind == "delete") then
		local result = "DELETE FROM " .. source .. renderWhere(query)
		if (isnumber(query.limit)) then result = result .. " LIMIT " .. query.limit end
		return result
	end
	if (kind == "insert" or kind == "insert ignore" or kind == "replace") then
		local prefix = kind == "replace" and "REPLACE INTO" or (kind == "insert ignore" and
			(mysql.module == "sqlite" and "INSERT OR IGNORE INTO" or "INSERT IGNORE INTO") or "INSERT INTO")
		if (query.insertSource) then
			return prefix .. " " .. source .. " (" .. identifiers(query.insertColumns) .. ") "
				.. buildStructured(query.insertSource)
		end
		local columns, values = {}, {}
		for _, pair in ipairs(query.insertList) do
			columns[#columns + 1] = pair[1]
			values[#values + 1] = pair.expression and renderValue(pair[2]) or pair[2]
		end
		assert(#columns > 0, "empty INSERT")
		return prefix .. " " .. source .. " (" .. table.concat(columns, ", ") .. ") VALUES ("
			.. table.concat(values, ", ") .. ")"
	end
	if (kind == "create") then
		local columns = {}
		for _, pair in ipairs(query.createList) do
			columns[#columns + 1] = pair[1] .. " " .. (mysql.module == "sqlite" and
				ApplyQueryReplacements("Create", pair[2]) or pair[2])
		end
		if (query.primaryKeys) then columns[#columns + 1] = "PRIMARY KEY (" .. identifiers(query.primaryKeys) .. ")"
		elseif (query.primaryKey) then columns[#columns + 1] = "PRIMARY KEY (" .. query.primaryKey .. ")" end
		if (mysql.module ~= "sqlite") then
			for _, index in ipairs(query.indexes or {}) do
				columns[#columns + 1] = "INDEX " .. quoteIdentifier(index.name) .. " (" .. identifiers(index.columns) .. ")"
			end
		end
		return "CREATE TABLE IF NOT EXISTS " .. source .. " (" .. table.concat(columns, ", ") .. ")"
	end
	error("unsupported structured query type: " .. kind)
end

function QUERY_CLASS:Build()
	return buildStructured(self)
end

function mysql:Replace(tableName)
	local query = QUERY_CLASS:New(tableName, "REPLACE")
	query.structured = true
	return query
end

-- The upstream wrapper reports MySQL errors without completing callbacks. Keep the timeout
-- at this boundary; SQLite raises database errors, which are caught narrowly and forwarded.
local function executeStatement(statement, callback, failureCallback, queued)
	local finished = false
	local function success(...)
		if (finished) then return end
		finished = true
		if (callback) then callback(...) end
	end
	local function fail(failure)
		if (finished) then return end
		finished = true
		if (failureCallback) then failureCallback(failure) else ErrorNoHalt(failure .. "\n") end
	end
	if (timer) then timer.Simple(15, function() fail("database query timed out") end) end
	if (queued) then return mysql:Queue(statement, success) end
	if (mysql.module ~= "sqlite") then return mysql:RawQuery(statement, success) end
	local ok, failure = pcall(mysql.RawQuery, mysql, statement, success)
	if (not ok) then
		if (tostring(failure):find("[mysql] SQL Query Error", 1, true)) then
			ErrorNoHalt(failure .. "\n")
			fail(failure)
		else
			error(failure)
		end
	end
end

function QUERY_CLASS:Execute(bQueueQuery)
	if (not self.structured and not self.errorCallback and not istable(self.tableName)) then
		return originalExecute(self, bQueueQuery)
	end
	local queryString = self:Build()
	local indexes = mysql.module == "sqlite" and self.queryType:lower() == "create" and self.indexes
	if (not indexes or #indexes == 0) then
		return executeStatement(queryString, self.callback, self.errorCallback, bQueueQuery)
	end
	local index = 0
	local function nextIndex(rows, status, lastID)
		index = index + 1
		local definition = indexes[index]
		if (not definition) then
			if (self.callback) then self.callback(rows, status, lastID) end
			return
		end
		local statement = "CREATE INDEX IF NOT EXISTS " .. quoteIdentifier(definition.name)
			.. " ON " .. quoteIdentifier(self.tableName) .. " (" .. identifiers(definition.columns) .. ")"
		executeStatement(statement, nextIndex, self.errorCallback)
	end
	return executeStatement(queryString, nextIndex, self.errorCallback, bQueueQuery)
end
