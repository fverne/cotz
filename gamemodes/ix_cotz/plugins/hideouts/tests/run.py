#!/usr/bin/env python3
"""Run server-method regression tests without a GMod process.

Uses the system Lua shared library. Translates GLua operators/continue only;
the Lua plugin methods themselves are executed, with small engine/Helix mocks.
"""
import ctypes
import ctypes.util
from pathlib import Path
import re
import sqlite3

ROOT = Path(__file__).resolve().parents[4]
HERE = Path(__file__).resolve().parent
TOKEN = re.compile(
    r'--\[(=*)\[.*?\]\1\]|--[^\n]*|/\*.*?\*/|//[^\n]*|\[(=*)\[.*?\]\2\]|'
    r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|'
    r'\b[A-Za-z_]\w*\b|!=|&&|\|\||!|.',
    re.DOTALL,
)


def translate(source):
    output, stack = [], []
    count = 0
    for match in TOKEN.finditer(source):
        token = match.group()
        if token in ("for", "while"):
            count += 1
            stack.append({"kind": token, "label": f"continue_{count}", "waiting": True})
        elif token in ("if", "function", "repeat"):
            stack.append({"kind": token})
        elif token == "do":
            if stack and stack[-1].get("waiting"):
                stack[-1]["waiting"] = False
                token = "do do"
            else:
                stack.append({"kind": "do"})
        elif token == "end":
            block = stack.pop()
            if "label" in block:
                token = f'end ::{block["label"]}:: end'
        elif token == "until":
            stack.pop()
        elif token == "continue":
            block = next(b for b in reversed(stack) if "label" in b)
            token = f'goto {block["label"]}'
        elif token.startswith("/*"):
            token = "--[[" + token[2:-2] + "]]"
        elif token.startswith("//"):
            token = "--" + token[2:]
        else:
            token = {"!=": "~=", "!": "not ", "&&": " and ", "||": " or "}.get(token, token)
        output.append(token)
    return "".join(output)


class Lua:
    def __init__(self):
        self.lib = ctypes.CDLL(ctypes.util.find_library("lua5.4") or ctypes.util.find_library("lua5.2"))
        self.lib.luaL_newstate.restype = ctypes.c_void_p
        self.state = self.lib.luaL_newstate()
        self.lib.luaL_openlibs.argtypes = [ctypes.c_void_p]
        self.lib.luaL_openlibs(self.state)
        self.lib.luaL_loadbufferx.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_size_t, ctypes.c_char_p, ctypes.c_char_p]
        self.lib.lua_pcallk.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_longlong, ctypes.c_void_p]
        self.lib.lua_tolstring.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_void_p]
        self.lib.lua_tolstring.restype = ctypes.c_char_p
        self.lib.lua_settop.argtypes = [ctypes.c_void_p, ctypes.c_int]

    def attach_sqlite(self):
        self.database = sqlite3.connect(":memory:", isolation_level=None)
        self.lib.lua_pushboolean.argtypes = [ctypes.c_void_p, ctypes.c_int]
        self.lib.lua_pushinteger.argtypes = [ctypes.c_void_p, ctypes.c_longlong]
        self.lib.lua_pushlstring.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_size_t]
        self.lib.lua_pushnil.argtypes = [ctypes.c_void_p]
        self.lib.lua_createtable.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_int]
        self.lib.lua_setfield.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_char_p]
        self.lib.lua_rawseti.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_longlong]
        self.lib.lua_setglobal.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
        callback_type = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_void_p)
        self.lib.lua_pushcclosure.argtypes = [ctypes.c_void_p, callback_type, ctypes.c_int]

        def push(state, value):
            if value is None:
                self.lib.lua_pushnil(state)
            elif isinstance(value, int):
                self.lib.lua_pushinteger(state, value)
            else:
                encoded = str(value).encode()
                self.lib.lua_pushlstring(state, encoded, len(encoded))

        def query(state):
            statement = self.lib.lua_tolstring(state, 1, None).decode()
            try:
                cursor = self.database.execute(statement)
                if cursor.description is None:
                    self.lib.lua_pushnil(state)
                else:
                    rows = cursor.fetchall()
                    self.lib.lua_createtable(state, len(rows), 0)
                    for index, row in enumerate(rows, 1):
                        self.lib.lua_createtable(state, 0, len(row))
                        for column, value in zip(cursor.description, row):
                            push(state, value)
                            self.lib.lua_setfield(state, -2, column[0].encode())
                        self.lib.lua_rawseti(state, -2, index)
            except sqlite3.Error as failure:
                push(state, str(failure))
                self.lib.lua_setglobal(state, b"PythonSqlError")
                self.lib.lua_pushboolean(state, 0)
            return 1

        self.sqlite_callback = callback_type(query)
        self.lib.lua_pushcclosure(self.state, self.sqlite_callback, 0)
        self.lib.lua_setglobal(self.state, b"PythonSqlQuery")

    def run(self, source, name, execute=True):
        code = translate(source).encode()
        status = self.lib.luaL_loadbufferx(self.state, code, len(code), name.encode(), None)
        if not status and execute:
            status = self.lib.lua_pcallk(self.state, 0, 0, 0, 0, None)
        if status:
            error = self.lib.lua_tolstring(self.state, -1, None).decode()
            raise AssertionError(error)
        self.lib.lua_settop(self.state, 0)


def main():
    lua = Lua()
    paths = list((ROOT / "ix_cotz/plugins/hideouts").rglob("*.lua"))
    paths += [
        ROOT / "ix_cotz/schema/libs/sh_savedtravel.lua",
        ROOT / "ix_cotz/schema/items/artifacts/sh_artifact_compass.lua",
        ROOT / "ix_cotz/schema/items/artifacts/sh_artifact_moon.lua",
        ROOT / "ix_cotz/schema/items/artifacts/sh_artifact_photo.lua",
        ROOT / "ix_cotz/plugins/propprotect.lua",
        ROOT / "ix_cotz/plugins/simplecrossserver/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/spawnsavercheckpoint/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/spawnsavercheckpoint/entities/entities/ix_spawnsaver.lua",
        ROOT / "ix_cotz/plugins/squads/sv_crossserver.lua",
        ROOT / "ix_cotz/plugins/advdupeint/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/revive/items/sh_revivesyringe.lua",
        ROOT / "ix_cotz/plugins/spawnsaver.lua",
        ROOT / "ix_cotz/plugins/personalstorage/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/passiveregeneration.lua",
        ROOT / "ix_cotz/plugins/psyhealth.lua",
        ROOT / "ix_cotz/plugins/radiation/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/suits/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/dialogue/dialogue/sh_owlnpc.lua",
        ROOT / "ix_cotz/plugins/townnpcs/libs/sv_services.lua",
        ROOT / "ix_cotz/plugins/saveitems.lua",
        ROOT / "ix_cotz/schema/libs/sh_item.lua",
        ROOT / "ix_cotz/schema/meta/sh_item.lua",
        ROOT / "ix_cotz/schema/meta/sh_inventory.lua",
        ROOT / "helix/plugins/saveitems.lua",
        ROOT / "helix/plugins/spawnsaver.lua",
        ROOT / "helix/gamemode/core/libs/sh_item.lua",
        ROOT / "helix/gamemode/core/meta/sh_item.lua",
        ROOT / "helix/gamemode/core/meta/sh_inventory.lua",
    ]
    for path in paths:
        if path.parent != HERE:
            lua.run(path.read_text(encoding="utf-8-sig"), str(path), execute=False)
    print(f"Syntax checked {len([p for p in paths if p.parent != HERE])} GLua files.")
    lua.run((HERE / "regression.lua").read_text(), "regression setup")
    lua.run('duplicator = {RegisterEntityModifier = function(name, callback) '
            'TEST_MARKER_MODIFIER = callback end}; util.AddNetworkString = function() end; '
            'net = {Receive = function() end}', "marker engine boundaries")
    for file in ("sh_definitions.lua", "sh_markers.lua", "sv_markers.lua"):
        lua.run((ROOT / "ix_cotz/plugins/hideouts" / file).read_text(), file)
    for file in ("sv_repository.lua", "sv_instances.lua", "sv_hooks.lua"):
        lua.run((ROOT / "ix_cotz/plugins/hideouts" / file).read_text(), file)
    lua.run((HERE / "cases.lua").read_text(), "hideouts cases")
    lua.run("ix.meta = {inventory = {}, item = {}}; hook = {Run = function(name, ...) if PLUGIN[name] then return PLUGIN[name](PLUGIN, ...) end end}", "core setup")
    for file in ("sh_inventory.lua", "sh_item.lua"):
        lua.run((ROOT / "helix/gamemode/core/meta" / file).read_text(), file)
    for file in ("sh_inventory.lua", "sh_item.lua"):
        lua.run((ROOT / "ix_cotz/schema/meta" / file).read_text(), file)
    lua.run((ROOT / "ix_cotz/schema/libs/sh_item.lua").read_text(), "schema item library")
    lua.run((HERE / "core_cases.lua").read_text(), "schema integration cases")
    lua.run("hideoutPlugin = PLUGIN; PLUGIN = {}", "personal storage setup")
    lua.run((ROOT / "ix_cotz/plugins/personalstorage/sh_plugin.lua").read_text(), "personal storage plugin")
    lua.run("personalPlugin = PLUGIN; PLUGIN = {}", "regeneration setup")
    lua.run((ROOT / "ix_cotz/plugins/passiveregeneration.lua").read_text(), "passive regeneration plugin")
    lua.run("regenerationPlugin = PLUGIN; PLUGIN = hideoutPlugin", "restore hideouts")
    lua.run('''PLUGIN = {settings = {actionInterval = 0},
        CanInteract = function() return true end,
        HasService = function() return true end}''', "town storage setup")
    lua.run((ROOT / "ix_cotz/plugins/townnpcs/libs/sv_services.lua").read_text(), "town services")
    lua.run("townPlugin = PLUGIN; PLUGIN = hideoutPlugin", "restore hideouts after town services")
    lua.run((HERE / "safezone_storage_cases.lua").read_text(), "safezone and personal storage cases")
    lua.run((ROOT / "ix_cotz/plugins/hideouts/sh_commands.lua").read_text(), "hideout commands")
    lua.run('''Test("hideout chat commands remain administrator-only", function()
        assert(TEST_COMMANDS.HideoutEnter and TEST_COMMANDS.HideoutLegacyStorage)
        for name, command in pairs(TEST_COMMANDS) do assert(command.adminOnly == true, name) end
    end)
    ix.command.Add = TEST_COMMAND_ADD''', "command access flags")
    lua.run("hideoutPlugin = PLUGIN; PLUGIN = {}", "schema saver setup")
    lua.run((ROOT / "ix_cotz/plugins/spawnsaver.lua").read_text(), "schema spawn saver")
    lua.run("schemaSaver = PLUGIN; PLUGIN = hideoutPlugin", "schema saver restore")
    lua.run('''Test("schema Spawn Saver persists the outside return point", function()
        Reset()
        local instance = NewInstance()
        local client = NewClient(1)
        client.position = instance.origin
        instance.occupants[client] = {character = 1, returnPoint = {Vector(10000, 0, 8), Angle(), "testmap"}}
        PLUGIN.members[client] = instance.id
        schemaSaver:CharacterPreSave(client:GetCharacter())
        assert(client:GetCharacter():GetData("pos")[1].x == 10000)
    end)''', "schema saver cases")
    lua.run("PLUGIN = {}; SERVER = true", "advdupe setup")
    lua.run((ROOT / "ix_cotz/plugins/advdupeint/sh_plugin.lua").read_text(), "advdupe plugin")
    lua.run((HERE / "advdupe_cases.lua").read_text(), "advdupe cases")
    lua.attach_sqlite()
    lua.run((HERE / "features_setup.lua").read_text(), "feature engine boundaries")
    for path in (
        "helix/gamemode/core/libs/thirdparty/sv_mysql.lua",
        "ix_cotz/plugins/simplecrossserverdata/sv_mysql.lua",
        "helix/gamemode/core/libs/sh_inventory.lua",
    ):
        lua.run((ROOT / path).read_text(), path)
    lua.run('mysql.module = "sqlite"', "SQLite adapter")
    for file in ("sh_definitions.lua", "sv_operations.lua", "sv_access.lua", "sv_containers.lua",
                 "sv_trading.lua", "sh_building.lua", "sv_travel.lua", "sh_management.lua", "sv_menus.lua"):
        lua.run((ROOT / "ix_cotz/plugins/hideouts" / file).read_text(), file)
    lua.run((HERE / "features_cases.lua").read_text(), "hideout feature cases")
    lua.run((HERE / "menus_cases.lua").read_text(), "hideout menu cases")
    lua.run('ENT = {}; AddCSLuaFile = function() end', "marker entity setup")
    lua.run((ROOT / "ix_cotz/plugins/hideouts/entities/entities/ix_hideout_marker.lua").read_text(),
            "marker entity")
    lua.run('TEST_MARKER_ENTITY = ENT; ENT = nil', "marker entity capture")
    lua.run((HERE / "markers_cases.lua").read_text(), "hideout marker cases")


if __name__ == "__main__":
    main()
