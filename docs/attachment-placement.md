# CW attachment placement

Equip the target weapon in a local COTZ development game and run
`cotz_attachment_placement [reference_class]` in the client console. For example,
equip the standard TOZ-34, run `cotz_attachment_placement cw_ak74`, and select
the Micro T-1 as the anchor.
The target needs one placed model in the desired slot. The reference needs that
same model in a slot with the same name.

1. Select the shared attachment as the anchor. Its authored X, Y, and Z values
   correspond to forward, right, and up relative to the target viewmodel bone.
2. Adjust the anchor if needed. The editor transfers the reference models'
   positions relative to the anchor, including the new models' orientation and
   scale. Cycle through the preview list to check the fit of each model.
3. Click **Copy Lua placements**. Paste the model assignments after
   `SWEP.AttachmentModelsVM` in the client block. Paste the slot assignments
   after `SWEP.Attachments` in shared code, or add those IDs to the slot's list.
   For an installable COTZ item, also add the IDs to its `ITEM.validAttachments`
   and enable `ITEM.canAttach`.

Omit the reference class to move existing models as a group using the target's
own authored offsets. The editor covers individual first-person models on the
anchor's bone and requires a uniform scale ratio between the two anchors.
Check aim alignment, alternate positions, rail requirements, and third-person
models separately.

For new setups, use the PSO-1 only on weapons with a compatible dovetail.
Keep the existing PSO-1 configurations on the Mosin, SVT-40, and Obrez
Malfunction. Set
`SWEP.HasDovetailMount = true` when importing a new PSO-1 entry onto a verified
dovetail model. A PSO-1 mounts directly to that dovetail. For rail-mounted optics
on a dovetail weapon without a rail, author an `md_rail` entry using
`models/wystan/attachments/akrailmount.mdl` and enable `SWEP.SightWithRail`.
Use the model's existing rail or rail bodygroup where present.
