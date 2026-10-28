# Helix upgrade implementation notes

Applied against upstream [bb8bf86988b980d576419597ae6b966ee939e409](https://github.com/NebulousCloud/helix/commit/bb8bf86988b980d576419597ae6b966ee939e409).

The upgrade is on `feature/helixupdate`, based on `origin/dev` (`65e5bd5f17a39c6b16680909db0ba3dbfdb44e56`). The branch tracks `origin/dev`. The progression-overhaul commits are not part of its ancestry after the dev base. No progression or personal-stock migration/revert is applied to saved data.

The original [proposal](helix-upgrade-plan.md) was prepared against the progression branch. This document and the [test checklist](helix-upgrade-tests.md) describe the final dev-compatible implementation.

## Result

- Refreshed all 200 Helix upstream files, preserving local database configuration.
- Preserved the inventory, icon material, UI/skin, chatbox, container, item entity, equipment/hands, stamina/weight, PAC, observer and weapon-selection fixes.
- Resolved the advanced vendor files from `origin/dev`, then reapplied only the relevant Helix fixes: collision initialization on spawn/restore/template/editor model changes, unknown item/instance guards, stock-disable payload handling, server purchase mode/access checks and the vendor hook argument.
- Retained dev’s shared stock, restocking, stock multiplier, existing Sherpa behavior, instance-based sale pricing, vendor UI columns and network protocol. No `ix.vendorStock`, new progression purchase/access API or personal stock persistence is introduced.
- The vendor template definitions, client vendor panel and other vendor support files remain exactly as on dev. The new personal-stock library and progression-overhaul code are absent.
- Replaced overhaul-specific tests with dev-compatible regression checks. No extra schema inventory metatable override is needed; the framework compatibility fixes already preserve recursive bag behavior.
- Dev’s existing progression functionality remains as it was. This change excludes the newer progression overhaul rather than deleting systems already present on dev.

## Framework deviations from the pinned upstream commit

These are intentional compatibility patches, rather than an unmodified upstream checkout. Future updates should reapply/review them:

- `gamemode/core/meta/sh_inventory.lua`: unique-item iterator, reserved-slot handling and preserved recursive search/sync/diagnostic traversal.
- `gamemode/core/libs/thirdparty/cl_ikon.lua`: optional trailing material parameter and per-request material reset.
- The following retain recursive `GetItems()` loops where upstream switched to non-recursive cell iteration:
  - `gamemode/core/derma/cl_inventory.lua`.
  - `gamemode/core/hooks/sh_hooks.lua`.
  - `gamemode/core/hooks/sv_hooks.lua`.
  - `gamemode/core/libs/sh_storage.lua`.
  - `gamemode/items/base/sh_bags.lua`.
  - `gamemode/items/base/sh_outfit.lua`.
  - `gamemode/items/base/sh_pacoutfit.lua`.
  - `gamemode/items/base/sh_weapons.lua`.
  - `plugins/logging.lua`.
  - `plugins/pac.lua`.
  - `plugins/vendor/sh_plugin.lua`.
- `gamemode/core/libs/sh_log.lua`: removed an extra trailing blank line so the diff passes whitespace checks.

All remaining upstream files match the pinned source byte for byte. Local-only `helix.yml` is preserved and excluded from this manifest. No upstream source file was deleted.

## Verification on the dev-based upgrade

- `luatex --luaonly tests/helix_upgrade_spec.lua`: **36 passed**.
- `luatex --luaonly tests/helix_vendor_trade_spec.lua`: **20 passed**, exercising the actual purchase handler and shared stock methods with engine stand-ins.
- Lexically adapted GLua syntax compilation and Git whitespace checks pass. These are not native Garry's Mod tests.
- Checked the final diff against `origin/dev` to ensure progression definitions, jobs and vendor support files are unchanged and the personal-stock library is absent.

The earlier personal-stock/progression suite results belong to the original progression-based implementation and do not apply to this branch. No game server, database or saved data was started or modified. No remote branch was pushed.

## Backup and history

`codex/helixupdate-before-rebase` preserves the entire original progression-based upgrade at commit `be7dc85c`. The existing `feature/progression-overhaul` branch is unchanged.

The earlier source archive remains at `/tmp/cotz-helix-upgrade-backup/gamemodes-before.tar.gz`; it contains the pre-upgrade progression-based source, not the dev-based source. Preserve it elsewhere if needed because `/tmp` is temporary. Git history and the backup branch provide the appropriate reference points for this branch move.
