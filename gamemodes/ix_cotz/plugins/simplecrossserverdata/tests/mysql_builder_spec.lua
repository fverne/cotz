-- Run from the addon root: luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/mysql_builder_spec.lua
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
function isstring(value) return type(value) == "string" end
function istable(value) return type(value) == "table" end
function isnumber(value) return type(value) == "number" end
local errors = {}
function ErrorNoHalt(value) errors[#errors + 1] = value end
sql = {SQLStr = function(value, bare)
	local escaped = tostring(value):gsub("'", "''")
	return bare and escaped or ("'" .. escaped .. "'")
end}
local file = assert(io.open("gamemodes/helix/gamemode/core/libs/thirdparty/sv_mysql.lua"))
local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
file:close()
assert(load(source))()
dofile("gamemodes/ix_cotz/plugins/simplecrossserverdata/sv_mysql.lua")
mysql.module = "sqlite"
local function normalize(value) return value:gsub("%s+", " "):match("^%s*(.-)%s*$") end
local legacy = mysql:Select("characters")
legacy:Select("name")
legacy:Where("name", "O'Brien")
legacy:WhereIn("id", {1, 2})
legacy:OrderByAsc("id")
legacy:Limit(2)
legacy:Offset(1)
check(normalize(legacy:Build()) == "SELECT `name` FROM `characters` WHERE `name` = 'O''Brien' "
	.. "AND `id` IN ('1', '2') ORDER BY `id` ASC LIMIT 2 OFFSET 1", "legacy SELECT syntax is preserved")
local insert = mysql:Insert("characters")
insert:Insert("name", "O'Brien")
check(insert:Build() == "INSERT INTO `characters` (`name`) VALUES ('O''Brien')", "legacy INSERT escapes values")
local update = mysql:Update("characters")
update:Update("name", "New")
update:Where("id", 1)
check(normalize(update:Build()) == "UPDATE `characters` SET `name` = 'New' WHERE `id` = '1'",
	"legacy UPDATE syntax is preserved")
local create = mysql:Create("legacy")
create:Create("id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
create:PrimaryKey("id")
check(create:Build():find("`id` INTEGER", 1, true), "legacy SQLite type conversion is preserved")
local query = mysql:Select("presence"):Alias("p")
query:SelectAll("p")
query:SelectColumn("s.name", "squad_name")
query:Join("state", "s", mysql.All(mysql.Compare("s.id", "=", mysql.Column("p.squad_id")),
	mysql.Compare("s.active", "=", 1)), "LEFT")
query:WhereExpr(mysql.Any(mysql.Compare("p.expires", ">", mysql.Now()), mysql.Compare("p.session", "=", "token")))
local built = query:Build()
check(built:find("`p`.*", 1, true) and built:find("`s`.`name` AS `squad_name`", 1, true),
	"qualified projection aliases are quoted separately")
check(built:find("LEFT JOIN `state` AS `s`", 1, true), "joins are compiled by the wrapper")
check(built:find(" OR ", 1, true) and built:find("strftime", 1, true), "grouped conditions use database time")
mysql.module = "mysqloo"
check(query:Build():find("UNIX_TIMESTAMP()", 1, true), "the same time expression supports MySQL")
mysql.module = "sqlite"
local target = mysql:Update("members")
target:UpdateValue("revision", mysql.Add(mysql.Column("revision"), 1))
target:UpdateValue("name", "UNIX_TIMESTAMP()")
local actor = mysql:Select("members")
actor:Where("id", 1)
actor:Limit(1)
local proof = mysql:Select(actor):Alias("actor")
proof:SelectValue(1)
proof:WhereExpr(mysql.Compare("actor.rank", ">=", 2))
target:WhereExpr(mysql.Exists(proof))
local statement = target:Build()
check(statement:find("`revision` + '1'", 1, true), "increments are structured expressions")
check(statement:find("`name` = 'UNIX_TIMESTAMP()'", 1, true), "plain strings cannot become expressions")
check(statement:find("LIMIT 1) AS `actor`", 1, true), "permission subqueries retain materialization boundaries")
local selection = mysql:Select("characters")
selection:SelectValue("scope")
selection:SelectColumn("id")
selection:SelectValue(mysql.Coalesce(mysql.Column("squad_id"), "NULL"))
selection:SelectValue(mysql.Case(mysql.Compare("officer", "=", 1), 1, 0))
local migration = mysql:InsertIgnore("members")
migration:InsertFrom(selection, {"scope", "id", "squad_id", "rank"})
check(migration:Build():find("INSERT OR IGNORE INTO", 1, true), "SQLite import retains insert-if-missing")
check(migration:Build():find("COALESCE", 1, true) and migration:Build():find("CASE WHEN", 1, true),
	"migration defaults are expressed structurally")
mysql.module = "mysqloo"
check(migration:Build():find("INSERT IGNORE INTO", 1, true), "MySQL import uses its native insert-if-missing")
mysql.module = "sqlite"
local composite = mysql:Create("members")
composite:Create("scope", "VARCHAR(64)")
composite:Create("id", "INTEGER")
composite:PrimaryKey({"scope", "id"})
composite:Index("members_scope", {"scope"})
check(composite:Build():find("PRIMARY KEY (`scope`, `id`)", 1, true), "composite primary keys are supported")
check(not composite:Build():find("INDEX", 1, true), "SQLite index creation is separate from table creation")
mysql.module = "mysqloo"
check(composite:Build():find("INDEX `members_scope` (`scope`)", 1, true), "MySQL indexes belong in table creation")
mysql.module = "sqlite"
local rawQuery = mysql.RawQuery
local emitted, complete = {}, false
mysql.RawQuery = function(_, sqlText, callback)
	emitted[#emitted + 1] = sqlText
	if callback then callback({}, true, 0) end
end
composite:Callback(function() complete = true end)
composite:Execute()
check(#emitted == 2 and complete, "DDL callbacks wait for SQLite index creation")
check(emitted[2]:find("CREATE INDEX IF NOT EXISTS", 1, true), "SQLite indexes are created idempotently")
emitted, complete = {}, false
composite:Execute(true)
check(#emitted == 0, "queued DDL does not execute immediately")
mysql:Think()
check(#emitted == 2 and complete, "queued DDL preserves index creation and its final callback")
mysql.RawQuery = rawQuery
local ok = pcall(function() mysql.Compare("id", "OR 1=1", 1) end)
check(not ok, "comparison operators cannot inject statements")
ok = pcall(function()
	local invalid = mysql:Select("members"):Alias("m")
	invalid:SelectColumn("id; DROP TABLE members")
	invalid:Build()
end)
check(not ok, "structured identifiers cannot contain statements")
ok = pcall(function() mysql:Select("members"):WhereExpr("id = 1") end)
check(not ok, "condition methods reject raw SQL fragments")
local driverQuery = {setOption = function() end, lastInsert = function() return 42 end}
local driverFailure, callbackID
mysqloo = {OPTION_NAMED_FIELDS = 1}
mysql.module = "mysqloo"
mysql.connection = {query = function() return driverQuery end,
	escape = function(_, value) return value:gsub("'", "''") end}
driverQuery.start = function(self) self.onError(self, "simulated failure") end
local errorQuery = mysql:Select("members")
errorQuery:OnError(function(value) driverFailure = value end)
errorQuery:Execute()
check(driverFailure == nil and #errors == 1, "upstream MySQL errors are logged; stalled completion uses timeout")
driverQuery.start = function(self) self.onSuccess(self, {{id = "1"}}) end
errorQuery:Callback(function(rows, status, lastID) callbackID = status and lastID end)
errorQuery:Execute()
check(callbackID == 42, "existing MySQL success callback arguments are preserved")
print("mysql builder: " .. checks .. " checks passed")
