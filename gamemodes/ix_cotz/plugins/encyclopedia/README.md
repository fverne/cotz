# Encyclopedia and Tutorial

The PDA's Encyclopedia contains Readme, Keybinds, and Tutorial. Tutorial is always
available manually through **Tab → Encyclopedia → Tutorial**, without requiring a PDA item.

## Editing the guide

Edit `PLUGIN.tutorialSections` in `cl_tutorial.lua`. Each entry has a title, body text,
image material path, and caption. Keep instructions consistent with current gameplay.

An empty `image` displays a labeled screenshot placeholder. To replace it, install a
material in your distributed content and set, for example,
`image = "cotz/tutorial/inventory.png"` (relative to `materials/`). Change the caption
to describe the screenshot. Missing/error materials retain the placeholder. Images
are loaded when the category is populated, fit inside the available area without
stretching, and resize with the panel. No external image URLs are fetched.

## Configuration

Helix configuration → Tutorial → `tutorialPopupEnabled` (default: `true`) controls
automatic opening. Disabling it also cancels a deferred popup. Manual access remains
available. Pending eligibility is preserved, so enabling it again allows unseen
tutorials to open on the next character load.

## First opening and persistence

The server adds `cotzTutorialPending = true` to the creation payload's character data,
so eligibility is stored in the original character INSERT. Existing characters with
no marker do not auto-open Tutorial. New characters created by returning players do.
There is no migration or account-level flag.

`PlayerLoadedCharacter` sends `cotz/tutorial/open` with the character's 32-bit ID.
The client waits for its active character, character menu removal, intro completion,
game UI closure, and menu suppression to clear before opening the existing PDA.
It selects the named `help` tab and the `tutorial` category. Normal PDA controls and
closing behavior remain in effect. The character-creation plugin's client method
`IsIntroActive()` covers the intro prompt, playback, and final Enter screen.

After a subsequent UI tick confirms the category is visible, the client sends
`cotz/tutorial/shown` with the same character ID. The server checks active character,
ownership, issued request, pending state, and a 0.5-second per-player cooldown before
clearing the flag and saving. Display counts as shown; scrolling or completing the
guide is not required. Requests interrupted by character switching or closing during
opening retain eligibility for the next load. Only one client opening timer exists.

## Verification

From the repository root:

```sh
luatex --luaonly tests/tutorial_spec.lua
luatex --luaonly tests/cotz_ui_spec.lua
luatex --luaonly tests/progression_menu_spec.lua
luatex --luaonly tests/character_menu_spec.lua
```

Standalone checks use mocks and cannot establish engine docking, rendering, network
delivery, or database durability. In a multiplayer development session verify:

- Create a character with the intro accepted, declined, and disabled, including on a
  map where the intro is unavailable. Tutorial opens after all blocking screens close.
- Reconnect and reload after viewing it: no automatic reopening. New characters open
  it once; pre-existing characters only have manual access.
- Disconnect or change character before Tutorial appears; reload the eligible character
  and confirm it still opens. Try repeated acknowledgements and other character IDs.
- Reopen Tutorial manually, navigate to other PDA tabs, and close the PDA normally.
- Inspect all sections, wrapping, placeholders, valid/missing screenshot materials,
  and live resizing at narrow, 1080p, ultrawide, and 4K resolutions/font scales.
