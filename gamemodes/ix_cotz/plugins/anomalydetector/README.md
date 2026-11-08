# Anomaly detector

The existing `ixhasanomdetector` netvar controls detection; equipping and power toggling retain their
item behavior. Only the server scans and emits the existing positional beep. Clients no longer scan
for other players' detectors or emit duplicate local beeps.

Each enabled wearer's nearest `anom`-prefixed entity is refreshed every 0.2 seconds within the existing
512-unit scan radius. Beeps remain restricted to distances below 400 units and use distance / 400
seconds, with a 0.1-second minimum interval at very close range. Beep timing is independent of scan
timing. Between scans, distance to the cached entity is checked so moving away silences it immediately.
Removed cached entities are ignored. Turning off clears the cache; turning on triggers a fresh scan.
New or closer anomalies can take up to one scan interval to be selected.

Run from the repository root:

```sh
luatex --luaonly tests/anomaly_detector_spec.lua
luatex --luaonly tests/device_power_spec.lua
```

In multiplayer, check two wearers independently, nearby listeners, power toggling, entering/leaving
range, removal of the nearest anomaly, and point-blank beep cadence. Verify that clients hear one
server-emitted beep per wearer and no client Lua errors occur. See the
[field effect checks](../anomalycontroller/README.md) for visual performance verification.
