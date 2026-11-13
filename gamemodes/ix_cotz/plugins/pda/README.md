# PDA maps

Equip a PDA, then right-click a **Swamps Map USB** (`map_usb_swamps`) and choose
**Insert into PDA**. Installation consumes the USB and adds the **Maps** tab when
you next open the PDA menu. Maps belong to the physical PDA: they survive reconnects
and travel with that item if transferred. Another PDA starts with its own map collection.
Removing the PDA from your belt hides the tab. Duplicate installations keep the USB.

Atlas sells the Swamps USB immediately for **1,000 rubles**, without a progression
unlock. It uses his normal personal supply stock/restocking. Existing placed Atlas
vendors receive it through the town stock reconciliation on load; no world setup is needed.

## Image configuration

In Helix configuration, under **PDA Maps**, edit **pdaMapSwampsURL**. The default is
the supplied Discord image URL. Use a direct HTTP/HTTPS image URL. Signed Discord
links can expire; replace the value with a current link or a permanent image host
if the image becomes unavailable. Changes apply the next time the map is opened.

Images load on the viewing client in a DHTML image document, fit without changing
aspect ratio, and resize with the tab. Missing/invalid URLs show a message. Failed
image requests show an unavailable message. Lua execution is disabled in the viewer.
This is an image viewer, with no position markers or live navigation.

## Adding a map

Add an entry to `PLUGIN.maps` in `sh_maps.lua`, with a display `name` and `urlConfig`,
and register the corresponding string configuration with `ix.config.Add`. Add a concrete
item in the immediate `items/mapusb/` directory with its `mapID` matching that entry.
The `base_mapusb` base provides installation; keep identity, price, dimensions, weight,
map ID and presentation in the concrete item. Add vendor availability separately.

PDA item data uses the new additive `cotzMaps` key, a set of installed map IDs. Existing
PDAs start without maps; existing character, PDA identity and stock history are retained.
Installation validates the USB's presence in the current character's inventory and
the equipped PDA again on the server. Repeated successful actions have a server cooldown.
No new client-to-server network endpoint is added.

## Verification

From the repository root:

```sh
luatex --luaonly tests/pda_maps_spec.lua
luatex --luaonly tests/town_vendor_buying_spec.lua
luatex --luaonly tests/vendor_stock_spec.lua
luatex --luaonly tests/item_descriptions_spec.lua
```

Standalone mocks do not establish engine rendering, replication or database durability.
In multiplayer, buy a USB from a fresh and an existing Atlas vendor before doing any
progression; confirm the 1,000-ruble price and normal stock use. Try installing without
a PDA, from another inventory, with a detached PDA, and with a duplicate map. Install
successfully, reopen the menu and inspect Maps. Reconnect/restart, switch characters,
and transfer the detached PDA to verify the maps follow only that device. Check valid,
blank and broken image URLs, switching between multiple installed maps, and resizing
at narrow, 1080p, ultrawide and 4K resolutions.
