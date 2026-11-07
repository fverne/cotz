# Bundled MySQL query builder

CotZ's compatibility extension lives in
`gamemodes/ix_cotz/plugins/simplecrossserverdata/sv_mysql.lua`, loaded before the presence service.
It extends the existing query object's metatable and uses the original wrapper's execution methods.
Ordinary queries delegate to the original `Execute`, and single-string primary keys delegate to the
original `PrimaryKey`. Query construction and adapter execution retain their upstream behavior.
The bundled wrapper has one diagnostic change: database failure messages precede the SQL query,
so Garry's Mod log truncation cannot hide the reason behind a long character-save statement.
This lives in the wrapper because ordinary Helix saves use it directly, bypassing the extension.

The extension supplies structured joins, predicates, subqueries, database-time expressions and
composite keys so cross-server checks remain conditional database mutations. Feature code builds
query objects rather than SQL fragments. The SQLite type conversions retain the upstream wrapper's
credit and MIT notice in the extension file.

## Structured methods

| Method | Purpose |
| --- | --- |
| `Alias(name)` | Set the query source alias |
| `SelectColumn(column, alias)` | Project a qualified column, optionally renamed |
| `SelectAll(alias)` | Project every column from a source |
| `SelectValue(value, alias)` | Project a literal or structured expression |
| `Join(table, alias, condition, kind)` | Add an INNER/default or LEFT join |
| `WhereExpr(condition)` | Add a structured predicate to existing WHERE conditions |
| `InsertValue` / `UpdateValue` | Assign a literal or structured expression |
| `InsertFrom(selectQuery, columns)` | Insert a SELECT projection into specified destination columns |
| `PrimaryKey({columns})` | Define a composite key; a single string retains the original behavior |
| `Index(name, {columns})` | Define an index on a table-creation query |
| `OnError(callback)` | Receive database errors without changing the existing success callback contract |
| `Build()` | Generate the statement inside the wrapper, without executing it |

`mysql:Replace(table)` complements `Insert` and `InsertIgnore`. A `mysql:Select()` query with
`SelectValue` projections can select constants without a source table. A SELECT query object can
also be a derived source, e.g. `mysql:Select(innerQuery):Alias("actor")`. Preserve the inner `Limit(1)`
when it deliberately prevents MySQL from merging a permission snapshot into its UPDATE target.

Expression constructors are `mysql.Column`, `Now`, `Add`, `Coalesce`, `Case`, `Compare`, `All`, `Any`,
`Exists`, and `NotExists`. `Compare(column, operator, value)` treats a string on the left as a column
identifier, and ordinary strings on the right as escaped data. Use `Column` explicitly for a column
on the right. Operators, join kinds and structured identifiers are validated. `WhereExpr` rejects SQL
strings; there is no raw-expression constructor.

```lua
local query = mysql:Update("ix_squads_presence")
query:UpdateValue("expires", mysql.Add(mysql.Now(), 45))
query:Where("scope", Schema.folder)
query:Where("character_id", character:GetID())
query:Where("session", sessionToken)
query:OnError(function(failure)
	-- The wrapper already logs database failures; release the caller's pending operation here.
	FinishPending(nil, failure)
end)
query:Callback(function(rows, success, lastInsertID)
	FinishPending(rows)
end)
query:Execute()
```

`Now` uses the adapter's database clock. SQLite creates requested indexes separately and invokes the
DDL callback after those operations finish, including queued DDL. MySQL includes them in CREATE TABLE.
Existing-table behavior is unchanged: CREATE TABLE does not alter an already-present MySQL table.
Schema migrations that add an index to an existing table still need an explicit migration.

The original wrapper does not report MySQL failures to callbacks. It logs those failures; the
compatibility extension completes a stalled extended query through its timeout. SQLite database
errors are caught narrowly and forwarded to `OnError`; callback/programming errors are re-raised.
Ordinary queries retain upstream behavior. `Callback(rows, true, lastInsertID)` remains the success
contract. Extended queries retain once-only completion when a late callback arrives after timeout.

## Verification

When reporting a database failure, include the reason immediately after `MySQL Query Error!`
or `SQL Query Error!`, ahead of `Query:`. Older builds print it after the SQL, where long character
saves can cause it to be truncated. A failed character save also prevents hideout entry from
completing, since admission waits for its outside return point to be saved successfully.

```sh
luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/mysql_builder_spec.lua
luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/squads_crossserver_spec.lua
```

The builder spec checks legacy CRUD output, escaping, predicates, derived queries, adapter-specific
clock/import/index generation, queued DDL, identifier rejection, and MySQL callback contracts with a
mock driver, including error visibility for long character-save statements. The squad spec loads
this actual wrapper and executes its generated statements against
a temporary SQLite database through the Python bridge. These do not establish live MySQL contention
or Garry's Mod networking correctness.
