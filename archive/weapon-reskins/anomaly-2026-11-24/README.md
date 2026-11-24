# Anomaly firearm backup

`files/` contains the 61 reskinned COTZ SWEPs and their 61 matching Helix item definitions from
`d31cc3ca`. Each file is stored at its original repository-relative path. The backup includes the
Anomaly models, reload timings, optics and inventory cameras as configured on November 24, 2026.
The models and sounds come from `cotz_general`. The materials come from `cotz_wepmats`.

The live test copies are in the **Anomaly Reskins** category. See the
[in-game testing instructions](../../../docs/anomaly-reskin.md) to try them alongside the legacy firearms.

Review any newer edits to the affected weapon and item definitions before copying the backup over
them. To restore all backed-up definitions, run this command from the repository root.

```sh
cp -a archive/weapon-reskins/anomaly-2026-11-24/files/. .
```

To restore one firearm, copy its SWEP and matching item file together to the same relative paths
in the repository. Restart the server and reconnect clients after copying. The attachment profiles
select the corresponding Anomaly placements when the backed-up models are active.
