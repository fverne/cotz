#!/usr/bin/env python3
"""Run server-method regression tests without a GMod process.

Uses the system Lua shared library. Translates GLua operators/continue only;
the Lua plugin methods themselves are executed, with small engine/Helix mocks.
"""
import ctypes
import ctypes.util
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[4]
HERE = Path(__file__).resolve().parent
TOKEN = re.compile(
    r'--\[(=*)\[.*?\]\1\]|--[^\n]*|\[(=*)\[.*?\]\2\]|'
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
        ROOT / "ix_cotz/plugins/advdupeint/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/revive/items/sh_revivesyringe.lua",
        ROOT / "ix_cotz/plugins/spawnsaver.lua",
        ROOT / "ix_cotz/plugins/personalstorage/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/passiveregeneration.lua",
        ROOT / "ix_cotz/plugins/psyhealth.lua",
        ROOT / "ix_cotz/plugins/radiation/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/suits/sh_plugin.lua",
        ROOT / "ix_cotz/plugins/dialogue/dialogue/sh_owlnpc.lua",
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
    lua.run((HERE / "safezone_storage_cases.lua").read_text(), "safezone and personal storage cases")
    lua.run((ROOT / "ix_cotz/plugins/hideouts/sh_commands.lua").read_text(), "hideout commands")
    lua.run('''Test("every hideout command is admin-only", function()
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


if __name__ == "__main__":
    main()
