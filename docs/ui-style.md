# COTZ UI and HUD style

Use the squad menu, **unlocked** STALKERnet leaderboard/dossier, and equipment slots as the
visual references for new COTZ interfaces. The locked scoreboard/PDA shell is not the reference
for generic management windows. Keep established PDA artwork where an interface already uses it.

## Appearance

- Translucent charcoal backgrounds and darker cards, square corners and thin olive-grey borders.
- Warm off-white primary text, muted secondary labels, `alsina` titles, labels and metadata.
- Teal for interaction/selection, green for success/completion, amber for caution/work and muted
  red for danger. Preserve meaningful squad, presence and spawn-category colors.
- Plain section labels with thin dividers; consistent padding and compact controls.
- Read-only state uses labels/cards. Actions use buttons with visible hover and disabled states.
- Equipment interiors retain the inventory slot skin. Preserve icon aspect ratios and image caches.

`schema/libs/cl_cotzui.lua` provides `ix.cotzUI` for feature-owned frames, scrolling lists, wrapping
buttons, labels/cards, entries, combo boxes, menus, confirmations, string requests and world markers.
It is automatically distributed/included as a client schema library before gameplay plugins.
`Schema:LoadFonts` refreshes its fonts through the bundled Helix font/resolution lifecycle.
Existing reference panels keep their own layouts; the helper does not replace the global Derma skin.

The schema tooltip adds its frame padding outside the measured rows. Its content area must retain
the full measured width and height so wrapped item descriptions and the final property rows fit.
When checking tooltips in multiplayer, include a Lost Note with saved stash text and coordinates.

The Q-menu Items tab uses `ix.util.GetItemIcon` for centered, aspect-preserving item previews,
including custom images and cached model renders. Each entry resolves its material once when created;
painting reuses that material without further icon lookups or generation.
Left-click spawns an item; right-click gives it to you.

The reference scale is `Clamp(Min(ScrW()/1920, ScrH()/1080), 0.75, 2)`. Major windows use viewport
fractions and scaled maximum widths. Shared frames update their existing controls on resolution
changes. Use `SetHeight` for fixed-height inputs/footer controls inside them; wrapping actions size
to their content. Fill scroll panels dock after fixed footer controls. Descriptions, long names and
confirmation text must remain readable without hiding actions. Shared world markers use a dark
backing, a semantic border and viewport-clamped labels. Buff and debuff indicators retain their original
HUD presentation and are excluded from the shared UI styling.

## Branch coverage

The UI audit used `git diff master...HEAD`, including client code inside shared files:

| Surface | Treatment |
| --- | --- |
| Squad management, unlocked STALKERnet, equipment slots | Existing visual references retained |
| Tasks journal | Already uses the reference palette, cards, typography and scrolling |
| Hideout entrances, access/exit management, containers | Shared styled frames, labels and wrapping actions |
| Squad shop, treasury and transaction history | Shared controls; read-only summaries/history use labels |
| Purchase/donation/upgrade confirmations and price/withdrawal entry | Styled scrolling modal dialogs; existing action callbacks retained |
| Hideout template marker editor and validation messages | Styled inputs, dropdowns, footer action and message dialog |
| Administrator inventory picker | Styled responsive list with wrapping take actions |
| Field-work context menu and world marker | Shared menu and amber marker label |
| Spawn-point observer overlay | Shared marker labels; category colors/access retained |
| New squad compass labels | Scaled `alsina` type with a contrasting outline |
| Progression encyclopedia | Contact cards, warm text and muted metadata |
| Dialogue choices and dynamic task/reward lists | Original dialogue fonts and sizes; slim scrollbars, wrapping and inherited label sizing |
| Buff timers, bleeding and town-effect indicators | Original HUD presentation retained |

Moved item definitions, unchanged legacy interfaces and upstream Helix upgrade changes are not new
COTZ surfaces. Existing vendor stock/tooltips continue using the COTZ inventory/vendor presentation.
Visual changes preserve network names, permissions, cooldowns, saved state and gameplay tuning.

## Verification

Run `luatex --luaonly tests/cotz_ui_spec.lua` for shared window bounds at 1024×768, 1280×720,
1920×1080, ultrawide and 4K, resizing of existing controls, action wrapping, marker bounds,
confirmation cancellation and string-entry callbacks. Follow the owning plugin README for its
behavior specs. These checks use mocks and do not verify engine docking or rendering.

In a multiplayer client, inspect all rows above, including full shop/history lists, long descriptions,
keyboard input, modal focus/cancellation, container hand-ins, dropdowns, admin inventory refresh,
HUD visibility, bright/dark world backgrounds and live resolution changes. Confirm buttons and
footer actions remain reachable, and check that long text wraps without overlapping adjacent controls.
