# Item writing references

[Writing guide](../writing-guide.md) · [Reference index](README.md) · [Dialogue collection](dialogue.md)

The four external examples use editorial paraphrases, not source quotations or proposed COTZ descriptions.
Their files and IDs were checked at the recorded commits. The final section preserves the
[approved COTZ draft direction](#approved-cotz-item-drafts). Read the guide's continuity rules before
applying any technique. The two GAMMA files are supplied by the bundled **G.A.M.M.A. Massive Text
Overhaul Project — SageDaHerb and Dr.Pr1nkos** in Grokitach's GAMMA repository. That identifies the
contributing text component; the original authorship of each underlying passage was not independently
established. Do not credit all bundled prose solely to GAMMA's maintainer.

## GAMMA-01 — Jury-rigged exoskeleton power supply

- Source: [verified source file](https://github.com/Grokitach/Stalker_GAMMA/blob/ab0f743af42a3b3b0b0ee853b3676f5189f7f0d0/G.A.M.M.A/modpack_addons/287-%20G.A.M.M.A.%20Massive%20Text%20Overhaul%20Project%20-%20SageDaHerb%20and%20Dr.Pr1nkos/gamedata/configs/text/eng/st_items_devices_exo.xml).
- File: `G.A.M.M.A/modpack_addons/287- G.A.M.M.A. Massive Text Overhaul Project - SageDaHerb and Dr.Pr1nkos/gamedata/configs/text/eng/st_items_devices_exo.xml`.
- String ID: `st_itm_exo_psu_descr`.
- Revision: `ab0f743af42a3b3b0b0ee853b3676f5189f7f0d0` (repository commit; checked 2026-11-05).

**Context:** Equipment description in the Massive Text Overhaul's exoskeleton device strings. The source
separates an immediate function/use explanation from a paragraph about construction and field limitations.

**Paraphrase:** A crude, light auxiliary supply offers only a small capacity improvement. Its poor
efficiency is placed against the short deployments and return-to-base charging expected of exoskeletons.

**What COTZ can learn:** A limitation becomes understandable through manufacture and intended use,
rather than a bare claim that the item is inferior. Long text can explain why a useful object still
disappoints its owner. Preserve COTZ's actual power, weight, and attachment behavior; this passage does
not establish a COTZ charging system, drag-and-drop action, or exoskeleton deployment doctrine.

## GAMMA-02 — Carbon steel plates

- Source: [verified source file](https://github.com/Grokitach/Stalker_GAMMA/blob/ab0f743af42a3b3b0b0ee853b3676f5189f7f0d0/G.A.M.M.A/modpack_addons/287-%20G.A.M.M.A.%20Massive%20Text%20Overhaul%20Project%20-%20SageDaHerb%20and%20Dr.Pr1nkos/gamedata/configs/text/eng/st_items_attachments.xml).
- File: `G.A.M.M.A/modpack_addons/287- G.A.M.M.A. Massive Text Overhaul Project - SageDaHerb and Dr.Pr1nkos/gamedata/configs/text/eng/st_items_attachments.xml`.
- String ID: `st_af_plates_descr`.
- Revision: `ab0f743af42a3b3b0b0ee853b3676f5189f7f0d0` (repository commit; checked 2026-11-05).

**Context:** Protective attachment description in the same credited overhaul, in a separate equipment file.
The entry combines construction, protective purpose, encumbrance, and a source-game properties block.

**Paraphrase:** Shaped, heat-treated steel offers ballistic protection at the cost of substantial weight
and restricted movement; the description also associates the plates with military use.

**What COTZ can learn:** Relate material choice to a concrete compromise. For COTZ, select details
appropriate to the specific plate's wear, construction, and effective tuning instead of giving every
tier the same sales pitch. Do not copy protection classes, body coverage, movement penalties, or repair
benefits. The source's torso-focused prose and broader properties block also show why flavour must be
checked against actual consumers rather than used as a mechanical specification.

## DA-ITEM-01 — Bread and circulation

- Source: [verified source file](https://github.com/Appuruu/dead-air-english-translation/blob/d61323cc7b1a77fb53bd51e2dc06166f3dfb9004/gamedata/configs/text/eng/st_items_equipment.xml).
- File: `gamedata/configs/text/eng/st_items_equipment.xml`.
- String ID: `st_bread_descr`.
- Revision: `d61323cc7b1a77fb53bd51e2dc06166f3dfb9004` (repository commit; checked 2026-11-05).

**Context:** Food description in Appuruu's Dead Air English translation. Its
[project index](https://github.com/Appuruu/dead-air-english-translation/blob/d61323cc7b1a77fb53bd51e2dc06166f3dfb9004/README.md)
labels the equipment file translated. This is an English translation source, not proof of original wording.

**Paraphrase:** Ordinary fresh bread becomes a valued rarity through a supply route: soldiers exchange
provisions for loot and supplies.

**What COTZ can learn:** An everyday object can disclose an economy without becoming a history lecture.
The interesting addition is how people obtain and value it, beyond identifying edible bread. A COTZ
description may use an established supply relationship or a clearly marked proposal; the military route,
scarcity, food safety, and trade terms here do not establish COTZ facts.

## DA-ITEM-02 — Crystal and competing interests

- Source: [verified source file](https://github.com/Appuruu/dead-air-english-translation/blob/d61323cc7b1a77fb53bd51e2dc06166f3dfb9004/gamedata/configs/text/eng/st_items_artefacts.xml).
- File: `gamedata/configs/text/eng/st_items_artefacts.xml`.
- String ID: `st_af_cristall_descr`.
- Revision: `d61323cc7b1a77fb53bd51e2dc06166f3dfb9004` (repository commit; checked 2026-11-05).

**Context:** Artifact description in the same Dead Air English translation; the project index labels the
artifact file translated. The original Russian and the described effects were not independently verified.

**Paraphrase:** Crystal is described through useful and hazardous effects, an unexplained chemical
interaction, and demand from jewellers for its attractive inner material.

**What COTZ can learn:** An artifact can matter to different people for different reasons. Observed
properties, incomplete explanations, and commercial interest can coexist. Choose only the useful
detail for the COTZ object rather than reproduce the source's lengthy catalogue. Its medical claims,
radiation distribution, acid interactions, and market demand are source fiction, not COTZ behavior.

## Verified local grounding

When an external file is unavailable, the entries above remain checked local paraphrases. For current
COTZ context, inspect the actual [Bread definition](../../gamemodes/ix_cotz/schema/items/consumables/sh_food_bread.lua)
and [Well Worn Steel Plate definition](../../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_steelplate_1.lua),
their bases and effect consumers. These local files were inspected for this starter collection; read
them again before drafting because they can change. They establish existing prose/configuration,
not a blanket requirement to imitate every sentence. Bread's current text does not establish the
Dead Air military supply route. Preserve current mechanics and label any proposed new provenance.

## Approved COTZ item drafts

These original drafts were presented to the user and accepted as the writing direction on
**2026-11-05**, then applied in the subsequent authorised catalogue pass. The wording below preserves
the approved examples; it introduces no gameplay features. All four items were introduced after the
agreed `1aa477d9` cutoff. Check their current definitions, base chains and consumers again before
future revisions; acceptance of the style does not replace mechanical review.

### Awl

Definition: [value_awl](../../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_awl.lua).

**Description:** A wooden-handled awl for piercing leather and heavy cloth.

**Longdesc:** The awl's steel point makes stitch holes in material too tough for a needle alone. Its
rounded wooden handle sits against the palm, allowing steady pressure without much room to work. A
simple tool associated with bootmaking, harness work and the less glamorous business of keeping straps
attached to bags.

### CPU Cooling Fan

Definition: [value_pcpart_cpufan](../../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pcpart_cpufan.lua).

**Description:** A computer processor cooler consisting of a small fan and metal heatsink.

**Longdesc:** The fan forces air between the heatsink's closely spaced fins, carrying heat away from
the processor beneath it. Dust has packed into those narrow passages. Removed from a computer, the
cooler is a surprisingly bulky assembly beside the small chip it was built to keep cool.

### Folded Aramid Fabric

Definition: [value_fabric_aramid](../../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_fabric_aramid.lua).

**Description:** A folded length of tan aramid cloth used in protective textiles.

**Longdesc:** Aramid fabric supplies strong fibres without the weight of a solid metal panel.
Protective garments use it in carefully arranged layers; this folded length is unfinished textile
stock. The dense weave and stiff folds distinguish it from the softer cloth used for ordinary clothing
and suit linings.

### Flight Log Folder

Definition: [value_air_journal](../../gamemodes/ix_cotz/schema/items/quests/sh_value_air_journal.lua).

**Description:** A blue folder holding flight records and loose log sheets.

**Longdesc:** Flight logs record departures, destinations, crew details and remarks that might
otherwise disappear with the people involved. Several sheets protrude from this folder's cover,
making the bundle awkward to keep in order. Dates and aircraft identifiers could connect its entries,
though the folder alone offers no assurance that every page is still present.
