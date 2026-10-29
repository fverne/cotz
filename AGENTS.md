# COTZ coding rules

Draft for review. Helix documentation takes priority over the GLua style guide, as requested by the user.
The item definition policy below also reflects an explicit user preference.
The remaining rules are proposed project defaults.

## Documentation and precedence

- Follow explicit user instructions first. Helix documentation always takes priority over the
  `glua-style` skill and the generic Lua rules below wherever they conflict.
- Consult the relevant [Helix documentation](https://docs.gethelix.co/) before implementing framework
  hooks, callbacks, registration, persistence, or loading. Preserve documented names, signatures,
  table structures, realms, and return contracts rather than adapting them to generic addon conventions.
- Check the bundled `gamemodes/helix/` implementation for version compatibility. If it differs from
  current documentation, identify the discrepancy and implement against the installed API;
  do not silently assume that a newer API exists or rewrite the framework to match it.

## Helix hooks and functions

- Define plugin hooks as `function PLUGIN:HookName(args)` and schema hooks as
  `function Schema:HookName(args)`, following the
  [plugin hook reference](https://docs.gethelix.co/hooks/plugin/).
  Helix dispatches these methods automatically; do not also register them with `hook.Add`.
  This applies to ordinary Garry's Mod hooks implemented by a Helix plugin too.
- Keep plugin-owned public functions on `PLUGIN` when appropriate, using `function PLUGIN:MethodName(...)`
  and `self:MethodName(...)` for instance-style calls. Use local functions for private helpers and existing
  `ix` libraries for shared APIs. Not every helper needs to become a plugin method.
- `PLUGIN` is a loader-provided table, not a permanent reference to the current plugin.
  Capture it with `local PLUGIN = PLUGIN` at file scope when callbacks need it later;
  capture `self` or the owning table when appropriate. Never resolve the global `PLUGIN` inside delayed work.
- In the bundled loader, function-valued plugin fields are cached as potential hooks during loading.
  Avoid helper names that collide with hook events, and define hooks before registration finishes.
  Do not assume a hook added after loading will enter that cache automatically.
- Preserve exact hook event names. Namespace identifiers only when explicitly using `hook.Add`,
  and namespace genuinely new custom events; never rename a documented hook to satisfy style rules.
- Before converting an existing `hook.Add` callback into a plugin or schema method, audit dispatch
  order and all competing handlers. The bundled dispatcher runs plugin methods, then `Schema` methods,
  then the original hook dispatcher (`hook.Add` callbacks and gamemode handling). A non-nil return can
  prevent later stages from running. Preserve intentional ordering; keep `hook.Add` where that stage
  is required, and document the reason. Do not perform blanket hook conversions.
- Follow each hook's documented return contract. In the bundled dispatcher, a non-nil first return
  stops dispatch, including `false`. Return nothing when allowing other handlers to continue,
  unless the specific API requires a value. Do not depend on ordering between plugins.
- Use the appropriate framework-owned tables, such as `ITEM`, `FACTION`, and `CLASS`, and their
  documented callbacks. Do not replace these with new addon globals or rename their fields for style.
- Follow [item action contracts](https://docs.gethelix.co/classes/item/): actions belong in `ITEM.functions`.
  `OnRun(item)` runs on the server; returning `false` keeps the item from being automatically removed.
  `OnCanRun(item)` runs on both realms and controls action availability. Keep authoritative validation
  on the server and do not apply generic hook return rules to these callbacks.
- Register Helix commands through [ix.command.Add](https://docs.gethelix.co/libraries/ix.command/),
  using its permission fields and typed `arguments`. Command `OnRun(self, client, ...)` differs from
  item action `OnRun(item)`; use the documented signature for each callback.
- Prefer [ix.util.Include and IncludeDir](https://docs.gethelix.co/libraries/ix.util/) where Helix owns
  loading. `ix.util.Include` handles realm prefixes and client distribution; call it from shared loading
  code so clients receive their files. Follow the bundled loader and COTZ's explicit include order.

## Item definitions and bases

- Treat item bases as shared behavior and fallback values, not the standard source of important
  item attributes. An item's definition should make its identity and gameplay tuning readable
  without opening the base, even when its values currently equal the base's defaults.
- Declare important attributes directly on each concrete item: name, descriptions, model, price,
  inventory dimensions, weight or weight coefficients, uses/quantity, and feature-specific effects,
  strengths, tiers, or outputs where applicable. Explicitly declare meaningful zero or false values too.
  Do not invent fields that the item's implementation does not use.
- Keep common methods, actions, validation, and calculations in the base. Inherit shared mechanics;
  keep item-specific configuration visible in the concrete item. Retain safe base fallbacks for missing
  values, but do not rely on them as the normal way to configure concrete items.
- Group definitions consistently: identity and descriptions; model; price, dimensions, and weight;
  gameplay parameters; presentation and feedback; then item-specific callbacks and actions.
  Use single blank lines between groups rather than explanatory section comments.
- Preserve each base's established field names and units. Distinguish per-use or per-round weight
  from fixed container weight, initial quantities from stack limits, and effect strength from duration.
  Do not introduce parallel fields or rename existing fields merely to standardize their appearance.
- Shared category markers and framework plumbing may remain inherited when they identify how the
  family works rather than determine an individual item's balance. Item-specific models, icons,
  sounds, equipment visuals, and action feedback belong with the item when applicable.
- Keep genuinely unique actions and effects on the concrete item. Reuse base behavior for common
  operations; do not copy whole methods just to change a configurable value.
- Keep definition defaults separate from saved instance state. Declare initial tuning in the item
  file and use existing data APIs for mutable state such as remaining uses, condition, or rolled weight.
- When extending an item family, inspect several established concrete items alongside their bases
  and consumers. Derive the applicable field set from those files rather than copying a recently
  generated item or treating any single legacy definition as a complete standard.
- Keep descriptions consistent with actual configured effects. When moving inherited values into
  item definitions, inspect effective runtime values first and preserve behavior unless retuning
  is explicitly part of the task. Do not change gameplay based only on descriptive text.

## Scope and approach

- Read `README.md`, `docs/repository-layout.md`, and the affected plugin's documentation before changing it.
- Inspect callers, loaders, and related definitions before choosing an implementation.
- Make the smallest coherent change that solves the actual problem. Avoid unrelated cleanup,
  speculative abstractions, new dependencies, and repository-wide formatting changes.
- Reuse existing Helix and COTZ APIs. Keep feature logic in its owning plugin or schema module.
- Prefer schema/plugin extension points over modifying bundled Helix or third-party frameworks.
  When a framework change is necessary, explain why and preserve its upstream conventions and credits.
- Preserve unrelated local changes. Do not commit, push, or publish unless the user requests it.

## Lua style

- Use the installed `glua-style` skill when writing, reviewing, or refactoring Lua.
  Apply it only where it does not conflict with Helix documentation or explicit user instructions.
- Use tabs, double-quoted strings, spaces around operators, and no semicolons.
- Use standard Lua operators and comments: `and`, `or`, `not`, `~=`, and `--`.
- Keep parentheses and square brackets tight. Target about 110 characters per line; do not exceed 120
  in new code unless an indivisible value requires it.
- Use camelCase for locals and local helpers, SCREAMING_SNAKE for constants, and PascalCase for new
  public methods. Preserve existing framework names and externally referenced APIs.
- Keep internal helpers and state local. Extend the existing feature namespace instead of adding globals.
- Use early returns and small, focused functions. Keep nesting to three levels where practical.
- Name meaningful tuning values. Keep balance data in definitions or configuration, separate from logic.
- Comment non-obvious intent, compatibility constraints, or workarounds. Do not narrate obvious code.
- Apply these conventions to new and substantially rewritten code; do not restyle unrelated legacy code.

## Loading and compatibility

- Respect `cl_`, `sh_`, and `sv_` realms and the actual Helix include order.
  Do not send server-only files with `AddCSLuaFile`.
- Verify custom include paths and registration order when adding or moving files.
  Do not assume that nested item folders load recursively.
- Treat plugin IDs, item IDs, entity classes, persistence keys, and network names as compatibility contracts.
  A filename or folder rename can change those contracts; inspect references and stored data first.
- Namespace explicit `hook.Add` identifiers, new custom hook events, and network messages,
  for example `cotz/feature/action`. Keep documented Helix hook method names unchanged.
  Preserve existing names unless all users and compatibility implications are handled.
- Follow the Helix hook and callback return contracts described above.
  Detours must preserve the original behavior outside the intended change.
- Keep `archive/` inactive. Review individual archived files before restoring any runtime code.

## Server authority and persistent state

- Keep money, inventories, rewards, progression, access checks, and gameplay outcomes authoritative on the server.
- Validate client requests against the current character, permissions, ownership, state, and allowed values.
  Rate-limit player-triggered network actions on the server; client debounce alone is insufficient.
- Prefer typed network fields and existing identifiers over transmitting whole tables.
  Register network messages once on the server and send state when it changes.
- Preserve existing saves and distinguish personal character state from account or global world state.
  Saved assignments must not silently reroll or reset after reconnects or definition changes.
- Make claims, purchases, and hand-ins safe against repeated requests and asynchronous callbacks.
  Check the actual inventory API's success behavior before consuming inputs or clearing pending rewards.
- Preserve recoverable pending rewards when inventories are full. Check character identity and entity
  validity again in delayed work when they can change before the callback runs.
- Plan explicit migrations for persistence changes. Never reset data or run first-time world setup
  as a routine validation step.

## Performance and error handling

- Avoid repeated entity scans, allocations, database work, and network sends in per-frame hooks.
- Cache reusable materials, fonts, and colors outside drawing loops. Handle screen-size changes for UI.
- Use squared distance checks where only proximity matters, and keyed lookups for repeated membership checks.
- Bound caches and queues that can grow with external input. Optimize measured or clearly identified hot paths.
- Do not hide errors with blanket `pcall` wrappers or silent fallbacks.
  Use protected calls only at a justified boundary and report caught failures.

## Verification and handoff

- Run checks relevant to the changed behavior. Add or update regression tests for substantive logic changes,
  especially persistence, rewards, permissions, and inventory edge cases.
- Existing Lua specs run from the repository root with `luatex --luaonly tests/<name>_spec.lua`.
  Follow the affected plugin's README for its relevant specs.
- Balance tooling tests use `python -m unittest discover -s docs/balance/tests -v` in an environment
  with `docs/balance/requirements.txt` installed. Do not assume a machine-specific virtualenv exists.
- Standalone tests use mocks and do not establish Garry's Mod runtime correctness.
  For realm, UI, networking, loading, or database changes, identify and perform relevant multiplayer
  checks when a development session is available; otherwise state what remains unverified.
- Update nearby documentation when behavior, configuration, loading paths, or balance policy changes.
- Before handing off, inspect the diff for unrelated edits, whitespace errors, and accidental secrets.
  Report what changed, what was checked, and any material limitations. Never claim an unrun test passed.
