# CW attachment placement

In a local COTZ development game, equip the target weapon and run
`cotz_attachment_placement [reference_class]` in the client console. Omit the class
to move a slot using the equipped weapon's own hand-placed offsets. To borrow offsets
from a similar weapon, pass its SWEP class. For example, equip the AKS-74U and run
`cotz_attachment_placement cw_ak74`.

1. Choose the anchor attachment and its slot. The position fields start at the
   anchor's authored X (forward), Y (right), and Z (up) relative to its viewmodel bone.
2. Edit the anchor position. Each compatible attachment receives its hand-placed
   positional difference from the reference anchor. Select each attachment in the
   preview list to inspect its fit on the equipped weapon.
3. Click **Copy Lua positions**. Update the matching `pos` values in the target
   weapon's `SWEP.AttachmentModelsVM` table, or paste the assignments immediately
   after that table in its client block. Close the editor to clear the preview.

The AK-74's Micro T-1 and Aimpoint use different model origins. The Aimpoint's
reference difference from the Micro T-1 is `Vector(5.6, -0.247, -5.84)`.
Moving the Micro T-1 therefore keeps that difference instead of stacking both
model origins at the same coordinates.

The editor handles individual CW first-person models within one attachment slot.
Choose a reference with similarly oriented bones and comparable model scales, and
check each fit when copying between weapon classes. The editor matches attachment
IDs and model paths, requires matching anchor angles, and skips multi-part models
and entries on separate bones. Bone names may differ across weapons. The output
contains position values only. Sight adjustment ranges, alternate positions,
aim alignment, and third-person models are authored separately.
