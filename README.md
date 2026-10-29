# S.T.A.L.K.E.R.: Call of the Zone

**A multiplayer S.T.A.L.K.E.R.-inspired survival and role-playing gamemode for Garry's Mod, built with Lua and the [Helix framework](https://github.com/NebulousCloud/helix).**

[![Lua](https://img.shields.io/badge/language-Lua-2C2D72?logo=lua&logoColor=white)](https://www.lua.org/)
[![Garry's Mod](https://img.shields.io/badge/platform-Garry's%20Mod-1F75CB)](https://gmod.facepunch.com/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> **Project status:** This is a long-running community project and codebase, not a ready-to-run, fully supported server package. Some setup, troubleshooting, and additional game assets may be required. Support is not currently guaranteed.

## About

**Call of the Zone (COTZ)** aims to bring the atmosphere and progression of the S.T.A.L.K.E.R. series to multiplayer Garry's Mod. Its emphasis is on persistent characters, exploration, survival, and a world that can keep running with relatively little administrator intervention after initial setup.

COTZ extends Helix with a custom schema and a collection of gameplay plugins. The project contains original development alongside community contributions, integrated frameworks, and third-party code.

## Features

The repository includes systems for:

- **Survival and environmental hazards:** radiation, anomalies, emissions/blowouts, status effects, and survival mechanics.
- **Exploration and loot:** world item spawning, stashes, containers, and repeatable loot opportunities.
- **Persistent character progression:** character creation, inventory, equipment, progression, and other saved gameplay data.
- **Trading and interaction:** vendors, barter, dialogue, quests, and NPC-related systems.
- **Player tools and interface:** custom HUD, PDA, chat, encyclopedia, hotkeys, and other VGUI components.
- **Multiplayer world traversal:** cross-server map transfers and shared data mechanisms for multi-server deployments.
- **Server automation:** map presets, scheduled/event-driven systems, and first-time world population tools.

Features vary in maturity and may need configuration or external content to work as intended. See [`gamemodes/ix_cotz/plugins/`](gamemodes/ix_cotz/plugins/) for the actual implementations.

## Repository layout

```text
.
├── gamemodes/
│   ├── helix/                 # Bundled Helix framework
│   └── ix_cotz/               # Call of the Zone gamemode
│       ├── schema/            # Core schema, factions, items, interfaces
│       ├── plugins/           # Gameplay and server-management systems
│       ├── gamemode/          # Gamemode entry points
│       └── ix_cotz.txt        # Gamemode definition
├── lua/                       # Shared Garry's Mod Lua resources
├── archive/                   # Inactive plugins, item versions, and backup effects
├── addon.txt
└── LICENSE
```

See [Repository layout](docs/repository-layout.md) for file ownership and loading rules. The `archive/` directory contains inactive reference code and is included in Git clones only.

ZIP and tarball downloads omit development tools, tests, workflows, planning documents, and archived code. Clone the repository to get these files; downloads retain the runtime files, licenses, and setup and layout guides.

## Requirements

- **Garry's Mod** and a working multiplayer or dedicated server environment.
- **Helix**, included in this repository under `gamemodes/helix/`.
- **MySQL** and the [mySQLOO](https://github.com/FredyH/MySQLOO) module for the recommended database configuration, particularly for cross-server features.
- **Compatible maps, models, sounds, materials, weapons, and other assets** referenced by the schema. Not all required assets are necessarily included in this code repository; examine the schema and your server's content setup before deployment.

The gamemode definition references Steam Workshop item [`2290918731`](https://steamcommunity.com/sharedfiles/filedetails/?id=2290918731). Verify its contents and any additional asset dependencies for your own server.

## Installation and initial setup

These are **starting points for experienced Garry's Mod server administrators**, not a tested one-command installation process.

1. **Get the code.** Clone or download the repository:

   ```bash
   git clone https://github.com/fverne/cotz.git
   ```

2. **Place the files in your Garry's Mod installation.** The contents of `gamemodes/` should end up in your server's `garrysmod/gamemodes/` directory; the repository's `lua/` content belongs under `garrysmod/lua/`. Preserve the existing relative paths. For example:

   ```text
   garrysmod/
   ├── gamemodes/
   │   ├── helix/
   │   └── ix_cotz/
   └── lua/
       └── ...
   ```

3. **Configure MySQL.** Set up a MySQL database, install the appropriate version of mySQLOO for your Garry's Mod server, and configure the connection as required by the bundled Helix version. Although Helix supports SQLite by default, **some COTZ features—especially multi-server features—expect MySQL**.

4. **Install or mount required game content.** Provide the maps and other assets used by your deployment. Missing resources may cause invisible models, missing textures, errors, or incomplete functionality.

5. **Start a multiplayer session or dedicated server** using the `ix_cotz` gamemode. For local development, use a peer-to-peer multiplayer session rather than Garry's Mod singleplayer; the original project notes that singleplayer can be unreliable.

6. **Initialize a supported map.** On `rp_marsh_cs`, an administrator can run the Helix command:

   ```text
   /FTSRunFirstTimeSetup
   ```

   This uses the [`firsttimesetup`](gamemodes/ix_cotz/plugins/firsttimesetup/) plugin's map presets to populate entities, vendors, containers, and plugin data. **Run it only when you intend to initialize the world, once.** It changes persistent data and may duplicate or overwrite setup state if used in an existing deployment. Back up your database and saved data beforehand.

The first-time setup plugin also contains presets for `rp_waystation` and `rp_pripyat_remaster`. Check their files before using them with a specific map or modified installation.

For a new map, follow the [map setup guide](docs/map-setup.md). It covers building and exporting an FTS preset, configuring spawns and travel, plugin dependencies, and deployment checks.

Use the companion [map content design guide](https://github.com/fverne/cotz/blob/master/docs/map-content-design.md) to plan new town NPCs, loot, artifacts, jobs, progression, encounters, and exploration, including the implementation work that connects them.

## Multi-server configuration

COTZ contains cross-server travel and data-sharing plugins. If you plan to run multiple maps as separate servers:

1. Configure every server to use the appropriate shared MySQL setup.
2. Review [`simplecrossserver/sh_plugin.lua`](gamemodes/ix_cotz/plugins/simplecrossserver/sh_plugin.lua) for the default/home map and active-map settings.
3. **Replace the hard-coded server IP addresses** and review map names, arrival positions, and load-zone definitions in [`simplecrossserver/sh_definitions.lua`](gamemodes/ix_cotz/plugins/simplecrossserver/sh_definitions.lua). The addresses in the repository are examples from an earlier deployment; do not assume they remain valid.
4. Review the [`simplecrossserverdata`](gamemodes/ix_cotz/plugins/simplecrossserverdata/) plugin and any associated chat or network features your setup uses.
5. Test character persistence, transfer behavior, and failure/reconnection cases before opening the servers to players.

The default home map in the cross-server plugin is `rp_marsh_cs`. Multi-server deployment needs manual configuration; it should not be assumed to work out of the box.

## Development

COTZ uses Garry's Mod Lua and Helix's plugin/schema conventions. A useful starting point is:

- [`schema/sh_schema.lua`](gamemodes/ix_cotz/schema/sh_schema.lua) for schema metadata and shared initialization.
- [`schema/`](gamemodes/ix_cotz/schema/) for items, factions, hooks, and interface code.
- [`plugins/`](gamemodes/ix_cotz/plugins/) for self-contained gameplay systems.
- [Helix documentation](https://docs.gethelix.co/) for framework concepts and extension points.

Follow each file's `cl_`, `sh_`, and `sv_` conventions when changing client, shared, or server logic. Test changes in a multiplayer development environment; database, network, and state changes deserve particular care.

### Balancing spreadsheets

GitHub Actions can export item, weapon, mutant, and anomaly configuration into an
Excel workbook and turn supported spreadsheet edits into a Lua pull request.
See the [balancing workbook guide](https://github.com/fverne/cotz/blob/master/docs/balance/README.md) for export/import
instructions, validation rules, and coverage limitations.

### Contributing

Bug reports, fixes, and improvements are welcome through [GitHub Issues](https://github.com/fverne/cotz/issues) and [Pull Requests](https://github.com/fverne/cotz/pulls). For a useful report, include reproduction steps, the affected map or plugin, relevant console errors, and whether the problem occurs in multiplayer or on a dedicated server.

Please preserve existing author credits and make the origin and license of any newly imported code or assets clear.

## Credits and licensing

COTZ has been developed and maintained by **verne**, **gumlefar**, **cyanide**, **theabysm** and other contributors from the COTZ community. Individual plugins and integrated components may have their own credited authors.

The repository contains an [MIT license](LICENSE). **That does not automatically mean every bundled third-party framework, plugin, game asset, or piece of S.T.A.L.K.E.R.-related content is covered by the same license.** Review the licenses and attribution notices attached to individual components before redistribution.

S.T.A.L.K.E.R. is associated with GSC Game World. This is a community-made project and is not presented as an official S.T.A.L.K.E.R. release.

---
