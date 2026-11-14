# PDA maps

Right-click a **Swamps Map USB** (`map_usb_swamps`) and choose **Add to Maps**.
This consumes the USB and adds the **Maps** tab when you next open the main menu.
Maps belong permanently to the character and require no PDA. Duplicate unlocks keep the USB.

Atlas sells the Swamps USB immediately for **1,000 rubles**, without a progression
unlock. It uses his normal personal supply stock/restocking. Existing placed Atlas
vendors receive it through the town stock reconciliation on load; no world setup is needed.

## Image configuration

In Helix configuration, under **PDA Maps**, edit **pdaMapSwampsURL**. The default is
the supplied Discord image URL. Use a direct HTTP/HTTPS image URL. Signed Discord
links can expire; replace the value with a current link or a permanent image host
if the image becomes unavailable. Changes apply the next time the map is opened.

Images download once per URL into the viewing client's DATA cache under
`helix/<schema>/pda/maps/` and are reused across menu opens and game restarts.
Changing the configured URL downloads the replacement; for an image replaced at the
same address, change its URL with a version query (for example, `?v=2`). Failed HTTP
requests are not cached and can be retried by reopening the map.

Cached images display in a DHTML image document, fit without changing
aspect ratio, and resize with the tab. Missing/invalid URLs show a message. Failed
image requests show an unavailable message. Lua execution is disabled in the viewer.
This is an image viewer, with no position markers or live navigation.

## Adding a map

Add an entry to `PLUGIN.maps` in `sh_maps.lua`, with a display `name` and `urlConfig`,
and register the corresponding string configuration with `ix.config.Add`. Add a concrete
item in the immediate `items/mapusb/` directory with its `mapID` matching that entry.
The `base_mapusb` base provides installation; keep identity, price, dimensions, weight,
map ID and presentation in the concrete item. Add vendor availability separately.

Character data uses `cotzMaps`, a set of unlocked map IDs. On character load,
legacy maps on PDAs in that character's inventory are copied into these unlocks.
Legacy device data is retained; no saved maps or unrelated data are deleted.
Installation validates the USB's presence in the current character's inventory
again on the server. Successful actions have a server cooldown.
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
progression; confirm the 1,000-ruble price and normal stock use. Unlock without a PDA,
try another inventory and a duplicate map, then reopen the main menu and inspect Maps.
Reconnect/restart and switch characters to verify personal persistence. Load a character
with legacy PDA maps and verify they are retained after removing the PDA. Check valid,
blank and broken image URLs, multiple maps, and resizing at narrow, 1080p, ultrawide and 4K resolutions.
