# Current progression unlock ledger

> This snapshot predates the author-disabled catalogue suggestions. Do not use it to restore them.
> Regeneration is currently blocked by the dependency cycle documented in the town NPC README.

Generated from authoritative town definitions and their compiled purchase prerequisites.
Regenerate: `python3 docs/npc-overhaul/tools/progression_rewards.py --write`.
Verify: `python3 docs/npc-overhaul/tools/progression_rewards.py --check`.

**624 / 624 steps assigned; 624 have functional unlocks; 0 have TODO-only unlock plans;
421 have multiple assigned unlocks; 0 unassigned.**

Purchase access is local to the seller. Canonical owners define equipment tier dependencies, not shared shop access.
Medicine uses local earlier-tier prerequisites. Basic regional supplies do not require another map's progression.
Stock values are total bonuses above the future base capacity, not additive grants or automatic refills.
Default vendor quantities, prices and refill policy are outside this allocation pass.

TODO entries are authoring metadata only: no entitlement, menu, payout or system is implemented for them.
Their proposed terms require implementation and balance review before activation. Existing cash, gifts and
credits remain supplementary. Every active step has an implemented unlock; TODO plans alone
never satisfy unlock coverage. Each cosmetic finish remains appearance-only.

## Coverage by contact

| Contact | Steps | Functional coverage | Placeholder-only | Multiple unlocks |
| --- | ---: | ---: | ---: | ---: |
| arena-master | 0 | 0 | 0 | 0 |
| atlas | 22 | 22 | 0 | 13 |
| ballast | 22 | 22 | 0 | 12 |
| beanstalk | 24 | 24 | 0 | 13 |
| boss | 22 | 22 | 0 | 14 |
| brass | 24 | 24 | 0 | 23 |
| carbon | 22 | 22 | 0 | 16 |
| cleaner | 28 | 28 | 0 | 22 |
| egghead | 26 | 26 | 0 | 24 |
| gasket | 22 | 22 | 0 | 12 |
| haggler | 26 | 26 | 0 | 26 |
| intern | 24 | 24 | 0 | 18 |
| jitters | 26 | 26 | 0 | 15 |
| latch | 22 | 22 | 0 | 10 |
| ledger | 22 | 22 | 0 | 17 |
| mute | 24 | 24 | 0 | 14 |
| old-timer | 28 | 28 | 0 | 14 |
| quartermaster | 24 | 24 | 0 | 24 |
| smartass | 24 | 24 | 0 | 14 |
| spicy-lemon | 26 | 26 | 0 | 26 |
| spool | 22 | 22 | 0 | 15 |
| spoor | 22 | 22 | 0 | 13 |
| suture | 24 | 24 | 0 | 16 |
| technut | 28 | 28 | 0 | 3 |
| the-original | 24 | 24 | 0 | 24 |
| vesper | 24 | 24 | 0 | 14 |
| wake | 22 | 22 | 0 | 9 |

## Every progression step

| Contact | Step | Functional unlocks | TODO unlocks | Supplementary rewards |
| --- | --- | --- | --- | --- |
| atlas | AT01 | Purchase: backpack_sling; Purchase: binoculars_2; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: medic_antirad_1 | — | 275 rubles; Gift: drink_bottlewater (1) |
| atlas | AT02 | Purchase: compass | — | 450 rubles |
| atlas | AT03 | Stock: drink_bottlewaterdirty +1 total | — | 0 rubles |
| atlas | AT04 | Stock: medic_bandage_1 +1 total | — | 650 rubles |
| atlas | AT05 | Purchase: binoculars_1 | — | 575 rubles |
| atlas | AT06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| atlas | AT07 | Purchase: gpstracker | — | 0 rubles |
| atlas | AT08 | Stock: lowtiercookerfuel +1 total | Marsh survey trail | 1050 rubles |
| atlas | AT09 | Stock: backpack_sling +1 total | Record: Marsh flooded detours | 875 rubles |
| atlas | AT10 | Stock: drink_bottletea +1 total | Record: Garbage eastern approaches | 1250 rubles |
| atlas | AT11 | Stock: binoculars_1 +1 total | Record: Garbage western return route | 0 rubles |
| atlas | AT12 | Stock: binoculars_2 +1 total | Garbage overland detour | 1450 rubles; Gift: lowtiercookerfuel (1) |
| atlas | AT13 | Purchase: binoculars_4 | — | 1175 rubles |
| atlas | AT14 | Stock: food_can_beans +1 total | Record: Waystation shelter approaches | 1650 rubles |
| atlas | AT15 | Stock: binoculars_4 +1 total | Record: Pripyat survey approaches | 0 rubles |
| atlas | AT16 | Stock: compass +1 total | Record: Pripyat retreat planning | 1850 rubles |
| atlas | AT17 | Purchase: binoculars_3 | — | 1475 rubles |
| atlas | AT18 | Stock: food_raisins +1 total | Waystation survey approach | 2050 rubles; Gift: medic_bandage_1 (1) |
| atlas | AT19 | Stock: drink_bottlewaterdirty +2 total | Record: survey notebook comparison | 0 rubles |
| atlas | AT20 | Stock: drink_bottlewater +2 total | — | 2250 rubles |
| atlas | AT21 | Stock: lowtiercookerfuel +2 total | Record: seasonal route changes | 1775 rubles |
| atlas | AT22 | Purchase: backpack_tourist; Stock: medic_bandage_1 +2 total | — | 2450 rubles; Recognition: Atlas's trusted contact |
| ballast | BA01 | Purchase: backpack_duffle; Purchase: drink_bottletea; Purchase: drug_painkillers; Purchase: food_can_beans; Purchase: food_can_tushonka; Purchase: food_raisins | — | 275 rubles; Gift: drink_bottlewater (1) |
| ballast | BA02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| ballast | BA03 | Stock: lowtiercookerfuel +1 total | — | 0 rubles |
| ballast | BA04 | Stock: backpack_duffle +1 total | — | 650 rubles |
| ballast | BA05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| ballast | BA06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| ballast | BA07 | Stock: drug_painkillers +1 total | — | 0 rubles |
| ballast | BA08 | Stock: food_can_beans +1 total | — | 1050 rubles |
| ballast | BA09 | Stock: food_can_tushonka +1 total | Marsh supply landing | 875 rubles |
| ballast | BA10 | Stock: drink_bottlewaterdirty +2 total | — | 1250 rubles |
| ballast | BA11 | Stock: lowtiercookerfuel +2 total | Record: waterlogged cargo handling | 0 rubles |
| ballast | BA12 | Stock: backpack_duffle +2 total | Record: Marsh landing approaches | 1450 rubles; Gift: lowtiercookerfuel (1) |
| ballast | BA13 | Stock: drug_painkillers +2 total | Record: recovery load planning | 1175 rubles |
| ballast | BA14 | Stock: food_can_beans +2 total | abandoned boat landing | 1650 rubles |
| ballast | BA15 | Stock: food_can_tushonka +2 total | Record: abandoned boat register | 0 rubles |
| ballast | BA16 | Stock: drink_bottlewaterdirty +3 total | Record: shoreline hazard notes | 1850 rubles |
| ballast | BA17 | Stock: lowtiercookerfuel +3 total | Record: disputed freight records | 1475 rubles |
| ballast | BA18 | Stock: backpack_duffle +3 total | Waystation waterside approach | 2050 rubles; Gift: medic_bandage_1 (1) |
| ballast | BA19 | Stock: drug_painkillers +3 total | Record: Garbage cargo connections | 0 rubles |
| ballast | BA20 | Stock: drink_bottlewater +2 total | — | 2250 rubles |
| ballast | BA21 | Stock: food_can_beans +3 total | Record: Waystation cargo handover | 1775 rubles |
| ballast | BA22 | Stock: medic_bandage_1 +2 total | — | 2450 rubles; Recognition: Ballast's trusted contact |
| beanstalk | BN01 | Purchase: drink_bottletea; Purchase: drug_caffeine; Purchase: food_can_beans; Purchase: food_raisins; Purchase: geigercounter; Purchase: mask_cloth; Purchase: medic_medkit_1; Purchase: medic_psyheal_1; Purchase: suit_ssp99 | — | 275 rubles; Gift: drink_bottlewater (1) |
| beanstalk | BN02 | Purchase: medic_antirad_1 | — | 450 rubles |
| beanstalk | BN03 | Purchase: medic_psyheal_2 | — | 0 rubles |
| beanstalk | BN04 | Purchase: mask_halfmask | — | 650 rubles |
| beanstalk | BN05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| beanstalk | BN06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| beanstalk | BN07 | Purchase: mask_respirator; Purchase: medic_antipsychotic_1; Purchase: medic_stimpak_1 | — | 0 rubles |
| beanstalk | BN08 | Stock: drink_bottlewaterdirty +1 total | Restocking: environmental research colours | 1050 rubles |
| beanstalk | BN09 | Purchase: medic_antipsychotic_2 | — | 875 rubles |
| beanstalk | BN10 | Purchase: mask_gp5 | — | 1250 rubles |
| beanstalk | BN11 | Purchase: medic_stimpak_2 | — | 0 rubles |
| beanstalk | BN12 | Stock: medic_antirad_1 +1 total | Restocking: environmental research colours | 1450 rubles; Gift: lowtiercookerfuel (1) |
| beanstalk | BN13 | Purchase: mask_eo20; Purchase: medic_antipsychotic_3 | — | 1175 rubles |
| beanstalk | BN14 | Stock: drug_caffeine +1 total | — | 1650 rubles |
| beanstalk | BN15 | Purchase: mask_pmk3; Purchase: medic_stimpak_3 | — | 0 rubles |
| beanstalk | BN16 | Conversion: suit_nbc_anarchist | — | 1850 rubles |
| beanstalk | BN17 | Conversion: suit_nbc_authority | — | 1475 rubles |
| beanstalk | BN18 | Conversion: suit_nbc_fanatic; Purchase: mask_xm40 | — | 2050 rubles; Gift: medic_bandage_1 (1) |
| beanstalk | BN19 | Stock: food_can_beans +1 total | Holding the Site: environmental research colours | 0 rubles |
| beanstalk | BN20 | Stock: geigercounter +1 total | A full supply order: environmental research colours | 2250 rubles |
| beanstalk | BN21 | Purchase: mask_m40 | A Clean Comparison: environmental research colours | 1775 rubles |
| beanstalk | BN22 | Stock: mask_cloth +1 total | The Last Control: environmental research colours | 2450 rubles |
| beanstalk | BN23 | Stock: mask_eo20 +1 total | Findings Worth Keeping: environmental research colours | 0 rubles |
| beanstalk | BN24 | Purchase: mask_m50; Purchase: suit_nbc; Stock: medic_bandage_1 +2 total | — | 2650 rubles; Gift: lowtiercookerfuel (1); Recognition: Beanstalk's trusted contact |
| boss | BO01 | Purchase: accesscard_bunker; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_can_tushonka; Purchase: food_raisins; Purchase: g3a3; Purchase: lowtiercookerfuel; Purchase: medic_medkit_1; Purchase: suit_io7a | — | 275 rubles; Gift: 545x39 (1) |
| boss | BO02 | Stock: 556x45 +1 total | — | 450 rubles |
| boss | BO03 | Purchase: food_bread; Stock: drug_painkillers +1 total | — | 0 rubles |
| boss | BO04 | Purchase: 9a91 | — | 650 rubles |
| boss | BO05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| boss | BO06 | Purchase: suit_ps5m; Stock: 545x39 +1 total | Operational extraction passage | 850 rubles; Gift: 556x45 (1) |
| boss | BO07 | Purchase: rpk | — | 0 rubles |
| boss | BO08 | Stock: 9a91 +1 total | — | 1050 rubles |
| boss | BO09 | Stock: 545x39 +2 total | — | 875 rubles |
| boss | BO10 | Conversion: suit_io7a_anarchist; Purchase: dp28 | Operations field finish | 1250 rubles |
| boss | BO11 | Conversion: suit_io7a_authority; Purchase: suit_cs2 | — | 0 rubles |
| boss | BO12 | Conversion: suit_io7a_ecologist | — | 1450 rubles; Gift: medic_bandage_1 (1) |
| boss | BO13 | Conversion: suit_io7a_fanatic; Purchase: 9x39; Purchase: fnfal | — | 1175 rubles |
| boss | BO14 | Conversion: suit_io7a_looted; Conversion: suit_ps5m_anarchist | — | 1650 rubles |
| boss | BO15 | Conversion: suit_io7a_mercenary; Conversion: suit_ps5m_authority | — | 0 rubles |
| boss | BO16 | Conversion: suit_io7a_scavenger; Conversion: suit_ps5m_ecologist; Purchase: asval | — | 1850 rubles |
| boss | BO17 | Conversion: suit_berill_anarchist; Conversion: suit_ps5m_fanatic; Purchase: suit_berill | — | 1475 rubles |
| boss | BO18 | Conversion: suit_berill_authority; Conversion: suit_ps5m_mercenary | — | 2050 rubles; Gift: 556x45 (1) |
| boss | BO19 | Conversion: suit_berill_ecologist; Purchase: sr3m | — | 0 rubles |
| boss | BO20 | Conversion: suit_berill_looted; Stock: 545x39 +3 total | — | 2250 rubles |
| boss | BO21 | Conversion: suit_berill_mercenary | — | 1775 rubles |
| boss | BO22 | Conversion: suit_berill_scavenger; Purchase: pkm; Purchase: suit_cs3 | — | 2450 rubles; Recognition: Boss's trusted contact |
| brass | BR01 | Purchase: 762x25; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: lowtiercookerfuel | — | 275 rubles; Gift: 12gauge (1) |
| brass | BR02 | Purchase: 22lrap; Purchase: 22lrhp; Purchase: 762x25ap; Purchase: 762x25hp | — | 450 rubles |
| brass | BR03 | Purchase: 9x19; Purchase: 9x21; Purchase: food_bread | — | 0 rubles |
| brass | BR04 | Purchase: 9x18ap; Purchase: 9x18hp; Purchase: 9x19ap; Purchase: 9x19hp; Purchase: 9x21ap; Purchase: 9x21hp; Stock: 22lr +1 total | — | 650 rubles |
| brass | BR05 | Purchase: 45acp; Purchase: 57x28 | — | 575 rubles |
| brass | BR06 | Purchase: 45acpap; Purchase: 45acphp; Purchase: 57x28ap; Purchase: 57x28hp; Stock: 12gauge +1 total | — | 850 rubles; Gift: 9x18 (1) |
| brass | BR07 | Purchase: 357magnum; Purchase: 44magnum; Stock: 9x18 +1 total | — | 0 rubles |
| brass | BR08 | Purchase: 357magnumap; Purchase: 357magnumhp; Purchase: 44magnumap; Purchase: 44magnumhp; Stock: 9x19 +1 total | Standing exchange: 12gauge | 1050 rubles |
| brass | BR09 | Purchase: 545x39 | — | 875 rubles |
| brass | BR10 | Purchase: 12gaugedt; Purchase: 12gaugemg; Purchase: 12gaugesg; Purchase: 12gaugetr; Purchase: 545x39ap; Purchase: 545x39hp; Stock: medic_bandage_1 +1 total | Standing exchange: 22lr | 1250 rubles |
| brass | BR11 | Purchase: 556x45; Purchase: 762x39; Stock: 22lrap +1 total | — | 0 rubles |
| brass | BR12 | Purchase: 556x45ap; Purchase: 556x45hp; Purchase: 762x39ap; Purchase: 762x39hp; Stock: 12gaugedt +1 total | — | 1450 rubles; Gift: medic_bandage_1 (1) |
| brass | BR13 | Purchase: 45acp41; Purchase: 50ae | — | 1175 rubles |
| brass | BR14 | Purchase: 50aeap; Purchase: 50aehp; Stock: 357magnum +1 total | Standing exchange: 9x18 | 1650 rubles |
| brass | BR15 | Purchase: 9x39; Stock: 12gaugesg +1 total | — | 0 rubles |
| brass | BR16 | Purchase: 9x39ap; Purchase: 9x39hp | Standing exchange: 9x19 | 1850 rubles |
| brass | BR17 | Purchase: 500magnum; Purchase: 762x51; Stock: 22lrhp +1 total | — | 1475 rubles |
| brass | BR18 | Purchase: 500magnumap; Purchase: 500magnumhp; Purchase: 762x51ap; Purchase: 762x51hp; Stock: 762x25 +1 total | — | 2050 rubles; Gift: 9x18 (1) |
| brass | BR19 | Purchase: 338lapua; Purchase: 762x54; Stock: 762x25ap +1 total | Standing exchange: 545x39 | 0 rubles |
| brass | BR20 | Purchase: 338lapuaap; Purchase: 338lapuahp; Purchase: 762x54ap; Purchase: 762x54hp; Stock: 12gaugemg +1 total | Standing exchange: 556x45 | 2250 rubles |
| brass | BR21 | Purchase: 127x55; Purchase: 700nitro; Purchase: 93x64; Stock: 22lrap +2 total | — | 1775 rubles |
| brass | BR22 | Stock: 357magnumap +1 total | Standing exchange: 762x39 | 2450 rubles |
| brass | BR23 | Purchase: 145x114; Stock: 338lapua +1 total | Standing exchange: 762x54 | 0 rubles |
| brass | BR24 | Purchase: 145x114ap; Purchase: 145x114hp; Stock: 9x18 +2 total | — | 2650 rubles; Gift: medic_bandage_1 (1); Recognition: Brass's trusted contact |
| carbon | CA01 | Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: value_officepaper | — | 275 rubles; Gift: drink_bottlewater (1) |
| carbon | CA02 | Purchase: drug_caffeine; Purchase: value_tape_duct | — | 450 rubles |
| carbon | CA03 | Stock: drink_bottlewaterdirty +1 total | — | 0 rubles |
| carbon | CA04 | Stock: drug_caffeine +1 total | — | 650 rubles |
| carbon | CA05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| carbon | CA06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| carbon | CA07 | Stock: drink_bottletea +1 total | Record: Marsh maintenance chronology | 0 rubles |
| carbon | CA08 | Stock: food_can_beans +1 total | Record: Garbage facility ownership | 1050 rubles |
| carbon | CA09 | Stock: food_raisins +1 total | Record: Waystation freight chronology | 875 rubles |
| carbon | CA10 | Stock: drink_bottlewaterdirty +2 total | Record: Pripyat research chronology | 1250 rubles |
| carbon | CA11 | Stock: drug_caffeine +2 total | Record: expedition roster comparison | 0 rubles |
| carbon | CA12 | Stock: drink_bottletea +2 total | Record: equipment serial register | 1450 rubles; Gift: lowtiercookerfuel (1) |
| carbon | CA13 | Stock: food_can_beans +2 total | Record: contamination report comparison | 1175 rubles |
| carbon | CA14 | Stock: food_raisins +2 total | Record: power-network history | 1650 rubles |
| carbon | CA15 | Stock: drink_bottlewaterdirty +3 total | Record: missing shipment index | 0 rubles |
| carbon | CA16 | Stock: drug_caffeine +3 total | Record: facility shutdown records | 1850 rubles |
| carbon | CA17 | Stock: drink_bottletea +3 total | Record: archive provenance guide | 1475 rubles |
| carbon | CA18 | Stock: food_can_beans +3 total | Record: conflicting witness register | 2050 rubles; Gift: medic_bandage_1 (1) |
| carbon | CA19 | Stock: food_raisins +3 total | Record: technical document cross-reference | 0 rubles |
| carbon | CA20 | Stock: drink_bottlewater +2 total | — | 2250 rubles |
| carbon | CA21 | Stock: drink_bottlewaterdirty +4 total | Record: recovered map annotations | 1775 rubles |
| carbon | CA22 | Stock: medic_bandage_1 +2 total | — | 2450 rubles; Recognition: Carbon's trusted contact |
| cleaner | CL01 | Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: hidestasher_cleaningkit; Purchase: tundrasuppressor; personal storage access | — | 275 rubles; Gift: drink_bottlewater (1) |
| cleaner | CL02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| cleaner | CL03 | Purchase: 9x19; Purchase: makarov; Purchase: value_tape_duct | — | 0 rubles |
| cleaner | CL04 | Stock: lowtiercookerfuel +1 total | — | 650 rubles |
| cleaner | CL05 | Stock: 9x19 +1 total | — | 575 rubles |
| cleaner | CL06 | Purchase: fort12; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| cleaner | CL07 | Stock: medic_bandage_1 +1 total | — | 0 rubles |
| cleaner | CL08 | Stock: drink_bottlewater +2 total | Stored inventory width 3 | 1050 rubles |
| cleaner | CL09 | Stock: drink_bottletea +1 total | — | 875 rubles |
| cleaner | CL10 | Purchase: cobrasuppressor | Stored inventory height 3 | 1250 rubles |
| cleaner | CL11 | Stock: food_can_beans +1 total | Stored inventory width 4 | 0 rubles |
| cleaner | CL12 | Purchase: mp5k; Stock: food_raisins +1 total | Stored inventory height 4 | 1450 rubles; Gift: lowtiercookerfuel (1) |
| cleaner | CL13 | Stock: hidestasher_cleaningkit +1 total | Stored inventory width 5 | 1175 rubles |
| cleaner | CL14 | Carried capacity: +1 rows | — | 1650 rubles |
| cleaner | CL15 | Stock: tundrasuppressor +2 total | Stored inventory height 5 | 0 rubles |
| cleaner | CL16 | Stock: cobrasuppressor +1 total | Stored inventory width 6 | 1850 rubles |
| cleaner | CL17 | Stock: drink_bottlewater +3 total | Stored inventory height 6 | 1475 rubles |
| cleaner | CL18 | Stock: tundrasuppressor +1 total | Stored inventory width 7 | 2050 rubles; Gift: medic_bandage_1 (1) |
| cleaner | CL19 | Purchase: pbssuppressor | Stored inventory height 7 | 0 rubles |
| cleaner | CL20 | Stock: drink_bottlewaterdirty +2 total | Stored inventory width 8 | 2250 rubles |
| cleaner | CL21 | Stock: lowtiercookerfuel +2 total | Stored inventory height 8 | 1775 rubles |
| cleaner | CL22 | Stock: 9x19 +2 total | Stored inventory width 9 | 2450 rubles |
| cleaner | CL23 | Stock: pbssuppressor +1 total | Stored inventory width 10 | 0 rubles |
| cleaner | CL24 | Stock: drink_bottletea +2 total | Record: cache concealment | 2650 rubles; Gift: lowtiercookerfuel (1) |
| cleaner | CL25 | Stock: food_can_beans +2 total | Record: dead-drop inspection | 2000 rubles |
| cleaner | CL26 | Stock: food_raisins +2 total | Record: compromised stash recovery | 2850 rubles |
| cleaner | CL27 | Stock: hidestasher_cleaningkit +2 total | Record: secure packing | 0 rubles |
| cleaner | CL28 | Purchase: hidestasher_shovel; Purchase: sakersuppressor; Stock: medic_bandage_1 +2 total | — | 3000 rubles; Recognition: Cleaner's trusted contact |
| egghead | EG01 | Purchase: accesscard_laboratory; Purchase: artifact_bolt; Purchase: detectorecho; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: medic_psyheal_1; Purchase: suit_ssp99m | — | 275 rubles; Gift: drink_bottlewater (1) |
| egghead | EG02 | Purchase: artifact_bonecluster; Purchase: artifact_photo; Purchase: medic_antirad_1 | — | 450 rubles |
| egghead | EG03 | Purchase: artifact_droplet; Purchase: medic_psyheal_2 | — | 0 rubles |
| egghead | EG04 | Purchase: artifact_thorn | — | 650 rubles |
| egghead | EG05 | Purchase: artifact_slime; Purchase: artifact_sparkler | — | 575 rubles |
| egghead | EG06 | Purchase: artifact_grapes; Purchase: medic_antirad_2; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| egghead | EG07 | Purchase: artifact_mementomori; Purchase: medic_antipsychotic_1; Purchase: medic_stimpak_1 | — | 0 rubles |
| egghead | EG08 | Purchase: artifact_blowncap; Purchase: artifact_cell | — | 1050 rubles |
| egghead | EG09 | Purchase: artifact_urchin; Purchase: medic_antipsychotic_2 | — | 875 rubles |
| egghead | EG10 | Purchase: artifact_mycelia; Stock: medic_bandage_1 +1 total | — | 1250 rubles |
| egghead | EG11 | Purchase: artifact_battery; Purchase: artifact_flash; Purchase: medic_stimpak_2 | — | 0 rubles |
| egghead | EG12 | Purchase: artifact_slug | Restocking: artifact research colours | 1450 rubles; Gift: lowtiercookerfuel (1) |
| egghead | EG13 | Purchase: artifact_arachno; Purchase: artifact_dwarfgalaxy; Purchase: detectorbear; Purchase: medic_antipsychotic_3 | — | 1175 rubles |
| egghead | EG14 | Purchase: artifact_mica | Record: sample contamination | 1650 rubles |
| egghead | EG15 | Purchase: artifact_halo; Purchase: medic_stimpak_3 | — | 0 rubles |
| egghead | EG16 | Purchase: artifact_crystal; Purchase: artifact_eye | Record: detector comparison | 1850 rubles |
| egghead | EG17 | Purchase: artifact_mamasbeads | — | 1475 rubles |
| egghead | EG18 | Purchase: artifact_panacea | The Pripyat Baseline: artifact research colours | 2050 rubles; Gift: medic_bandage_1 (1) |
| egghead | EG19 | Purchase: artifact_gaia; Purchase: artifact_kolobok | — | 0 rubles |
| egghead | EG20 | Purchase: artifact_capacitor | Record: electrical anomaly notes | 2250 rubles |
| egghead | EG21 | Conversion: suit_seva_anarchist; Purchase: artifact_moonlight | — | 1775 rubles |
| egghead | EG22 | Conversion: suit_seva_authority; Purchase: artifact_compass; Purchase: artifact_gmamasbeads | — | 2450 rubles |
| egghead | EG23 | Conversion: suit_seva_ecologist; Purchase: artifact_moon | — | 0 rubles |
| egghead | EG24 | Conversion: suit_seva_fanatic; Purchase: artifact_flame | medic_psyheal_1 exchange | 2650 rubles; Gift: lowtiercookerfuel (1) |
| egghead | EG25 | Conversion: suit_seva_mercenary; Purchase: artifact_galaxy; Purchase: artifact_storm | — | 2000 rubles |
| egghead | EG26 | Purchase: artifact_midas; Purchase: detectorveles; Purchase: suit_seva; Stock: medic_bandage_1 +2 total | — | 2850 rubles; Recognition: Egghead's trusted contact |
| gasket | GK01 | Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: lowtiercookerfuel | — | 275 rubles; Gift: drink_bottlewater (1) |
| gasket | GK02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| gasket | GK03 | Stock: lowtiercookerfuel +1 total | — | 0 rubles |
| gasket | GK04 | Purchase: value_waterfilter | — | 650 rubles |
| gasket | GK05 | Stock: drink_bottletea +1 total | — | 575 rubles |
| gasket | GK06 | Purchase: flashlight; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| gasket | GK07 | Stock: drink_bottlewater +3 total | — | 0 rubles |
| gasket | GK08 | Purchase: value_kerosene | — | 1050 rubles |
| gasket | GK09 | Purchase: value_tape_duct | — | 875 rubles |
| gasket | GK10 | Stock: medic_bandage_1 +1 total | — | 1250 rubles |
| gasket | GK11 | Stock: food_can_beans +1 total | Standing exchange: lowtiercookerfuel | 0 rubles |
| gasket | GK12 | Stock: food_raisins +1 total | Standing exchange: value_waterfilter | 1450 rubles; Gift: lowtiercookerfuel (1) |
| gasket | GK13 | Stock: drink_bottlewaterdirty +3 total | Standing exchange: value_kerosene | 1175 rubles |
| gasket | GK14 | Stock: drink_bottlewaterdirty +2 total | Standing exchange: value_airfilter | 1650 rubles |
| gasket | GK15 | Stock: lowtiercookerfuel +2 total | Standing exchange: value_sparkplug | 0 rubles |
| gasket | GK16 | Purchase: headlamp | Standing exchange: value_battery | 1850 rubles |
| gasket | GK17 | Stock: drink_bottletea +2 total | Standing exchange: value_9vbattery | 1475 rubles |
| gasket | GK18 | Stock: flashlight +2 total | Standing exchange: value_tape_electric | 2050 rubles; Gift: medic_bandage_1 (1) |
| gasket | GK19 | Stock: food_can_beans +2 total | Standing exchange: value_dryfuel | 0 rubles |
| gasket | GK20 | Stock: headlamp +1 total | — | 2250 rubles |
| gasket | GK21 | Stock: food_raisins +2 total | Standing exchange: value_carbattery | 1775 rubles |
| gasket | GK22 | Stock: medic_bandage_1 +2 total | — | 2450 rubles; Recognition: Gasket's trusted contact |
| haggler | HG01 | Purchase: 762x25; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: nagantrev; Purchase: taurusragingbull | — | 275 rubles; Gift: drink_bottlewater (1) |
| haggler | HG02 | Purchase: g2contender; Purchase: tokarev | — | 450 rubles |
| haggler | HG03 | Purchase: 9x18; Purchase: 9x19; Purchase: m1917; Purchase: makarov | — | 0 rubles |
| haggler | HG04 | Purchase: brhp; Purchase: cz52 | lowtiercooker exchange | 650 rubles |
| haggler | HG05 | Purchase: 45acp; Purchase: beretta92; Purchase: fort12 | — | 575 rubles |
| haggler | HG06 | Purchase: c96; Purchase: c96carbine; Purchase: rugermk3; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| haggler | HG07 | Purchase: ppsh; Purchase: sten | — | 0 rubles |
| haggler | HG08 | Purchase: lugerp08; Purchase: obrezmalfunction; Purchase: p99 | — | 1050 rubles |
| haggler | HG09 | Purchase: 12gauge; Purchase: 545x39; Purchase: glock17; Purchase: mac11 | — | 875 rubles |
| haggler | HG10 | Purchase: kiparis; Purchase: skorpion | — | 1250 rubles |
| haggler | HG11 | Purchase: 762x39; Purchase: m1911; Purchase: mp34 | — | 0 rubles |
| haggler | HG12 | Purchase: glock18; Purchase: taurusjudge | brhp exchange | 1450 rubles; Gift: lowtiercookerfuel (1) |
| haggler | HG13 | Purchase: g2contender500; Purchase: m3supershort | — | 1175 rubles |
| haggler | HG14 | Purchase: 45acp41; Purchase: rugermini14; Purchase: stechaps; Purchase: uzi | — | 1650 rubles |
| haggler | HG15 | Purchase: mr96; Purchase: toz194 | — | 0 rubles |
| haggler | HG16 | Purchase: mp18; Purchase: mp5k; Purchase: saigasemi545 | — | 1850 rubles |
| haggler | HG17 | Purchase: kp31; Purchase: stoegerddshort | — | 1475 rubles |
| haggler | HG18 | Purchase: lax410; Purchase: sterling | — | 2050 rubles; Gift: medic_bandage_1 (1) |
| haggler | HG19 | Purchase: lax410s; Purchase: mp153 | — | 0 rubles |
| haggler | HG20 | Purchase: m3super90; Purchase: stoegerdd | c96carbine exchange | 2250 rubles |
| haggler | HG21 | Purchase: swmodel29; Purchase: swr8 | — | 1775 rubles |
| haggler | HG22 | Purchase: deagle; Purchase: ithaca37 | — | 2450 rubles |
| haggler | HG23 | Purchase: deagle44; Purchase: mateba | — | 0 rubles |
| haggler | HG24 | Purchase: fiveseven; Purchase: m1911chic | — | 2650 rubles; Gift: lowtiercookerfuel (1) |
| haggler | HG25 | Purchase: saiga12; Purchase: saiga410 | — | 2000 rubles |
| haggler | HG26 | Purchase: striker; Purchase: sw500 | — | 2850 rubles; Recognition: Haggler's trusted contact |
| intern | IN01 | Purchase: drink_bottletea; Purchase: drug_caffeine; Purchase: food_can_beans; Purchase: food_raisins; Purchase: gasanalyzer | — | 275 rubles; Gift: drink_bottlewater (1) |
| intern | IN02 | Purchase: medic_antirad_1 | — | 450 rubles |
| intern | IN03 | Purchase: medic_psyheal_1 | — | 0 rubles |
| intern | IN04 | Stock: drink_bottlewaterdirty +1 total | — | 650 rubles |
| intern | IN05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| intern | IN06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| intern | IN07 | Stock: gasanalyzer +1 total | Same Place Same Method: survey team colours | 0 rubles |
| intern | IN08 | Stock: drink_bottletea +1 total | Record: Marsh baseline readings | 1050 rubles |
| intern | IN09 | Stock: drug_caffeine +1 total | Record: Garbage baseline readings | 875 rubles |
| intern | IN10 | Stock: food_can_beans +1 total | The Senior's Notebook: survey team colours | 1250 rubles |
| intern | IN11 | Stock: food_raisins +1 total | Record: Pripyat comparative readings | 0 rubles |
| intern | IN12 | Stock: gasanalyzer +2 total | Record: sensor placement errors | 1450 rubles; Gift: lowtiercookerfuel (1) |
| intern | IN13 | Stock: medic_psyheal_1 +1 total | Ready for the Distance: survey team colours | 1175 rubles |
| intern | IN14 | Stock: medic_antirad_1 +1 total | Record: exposure log comparison | 1650 rubles |
| intern | IN15 | Computer access | — | 0 rubles |
| intern | IN16 | Stock: drink_bottlewater +2 total | Record: conflicting measurement review | 1850 rubles |
| intern | IN17 | Stock: drink_bottlewaterdirty +2 total | Without Missing Pages: survey team colours | 1475 rubles |
| intern | IN18 | Stock: gasanalyzer +3 total | Record: instrument failure signatures | 2050 rubles; Gift: medic_bandage_1 (1) |
| intern | IN19 | Stock: drink_bottletea +2 total | Record: return survey protocol | 0 rubles |
| intern | IN20 | Stock: drug_caffeine +2 total | Building the reserve: survey team colours | 2250 rubles |
| intern | IN21 | Stock: food_can_beans +2 total | Record: late-expedition sensor drift | 1775 rubles |
| intern | IN22 | Stock: food_raisins +2 total | Record: research-team handover protocol | 2450 rubles |
| intern | IN23 | Stock: gasanalyzer +4 total | Put My Name on It: survey team colours | 0 rubles |
| intern | IN24 | Purchase: geigercounter; Stock: medic_bandage_1 +2 total | — | 2650 rubles; Gift: lowtiercookerfuel (1); Recognition: Intern's trusted contact |
| jitters | JT01 | Purchase: drink_bottletea; Purchase: drug_mints; Purchase: food_can_beans; Purchase: food_raisins; Purchase: medic_antipsychotic_1; Purchase: medic_medkit_1; Purchase: medic_psyheal_1 | — | 275 rubles; Gift: medic_bandage_1 (1) |
| jitters | JT02 | Purchase: medic_antirad_1 | — | 450 rubles |
| jitters | JT03 | Purchase: drug_painkillers; Purchase: food_bread | — | 0 rubles |
| jitters | JT04 | Stock: drug_painkillers +1 total | Standing exchange: medic_bandage_1 | 650 rubles |
| jitters | JT05 | Purchase: medic_bandage_2 | — | 575 rubles |
| jitters | JT06 | Stock: medic_bandage_1 +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| jitters | JT07 | Stock: medic_antirad_1 +1 total | Standing exchange: drug_painkillers | 0 rubles |
| jitters | JT08 | treatment discount: 5% | — | 1050 rubles |
| jitters | JT09 | Stock: medic_medkit_1 +1 total | Standing exchange: medic_medkit_1 | 875 rubles |
| jitters | JT10 | Stock: drink_bottletea +1 total | Standing exchange: medic_antirad_1 | 1250 rubles |
| jitters | JT11 | Purchase: medic_medkit_2 | — | 0 rubles |
| jitters | JT12 | Stock: drink_bottlewater +1 total | Standing exchange: medic_bandage_2 | 1450 rubles; Gift: medic_bandage_1 (1) |
| jitters | JT13 | Purchase: drug_adrenaline; Purchase: medic_bandage_3 | — | 1175 rubles |
| jitters | JT14 | Stock: food_raisins +1 total | Standing exchange: medic_medkit_2 | 1650 rubles |
| jitters | JT15 | Purchase: medic_medkit_3 | — | 0 rubles |
| jitters | JT16 | Stock: drug_mints +1 total | Standing exchange: medic_bandage_3 | 1850 rubles |
| jitters | JT17 | Purchase: medic_medkit_4 | — | 1475 rubles |
| jitters | JT18 | Stock: medic_bandage_1 +2 total | Standing exchange: medic_medkit_3 | 2050 rubles; Gift: medic_bandage_1 (1) |
| jitters | JT19 | Purchase: medic_medkit_5 | — | 0 rubles |
| jitters | JT20 | Purchase: drug_morphine | Standing exchange: medic_antirad_2 | 2250 rubles |
| jitters | JT21 | Purchase: medic_antirad_2 | — | 1775 rubles |
| jitters | JT22 | Stock: drink_bottlewaterdirty +1 total | Standing exchange: medic_medkit_4 | 2450 rubles |
| jitters | JT23 | Purchase: medic_medkit_6 | — | 0 rubles |
| jitters | JT24 | treatment discount: 10% | — | 2650 rubles; Gift: medic_bandage_1 (1) |
| jitters | JT25 | Stock: food_can_beans +1 total | Standing exchange: medic_medkit_5 | 2000 rubles |
| jitters | JT26 | Purchase: miscaid_swampbrew | Standing exchange: medic_medkit_6 | 2850 rubles; Recognition: Jitters's trusted contact |
| latch | LA01 | Purchase: attachment_steelplate_1; Purchase: crowbar; Purchase: drink_bottletea; Purchase: drug_painkillers; Purchase: food_can_beans; Purchase: food_can_tushonka; Purchase: food_raisins; Purchase: sharpening_stone; Purchase: value_tape_duct | — | 275 rubles; Gift: drink_bottlewater (1) |
| latch | LA02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| latch | LA03 | Stock: lowtiercookerfuel +1 total | — | 0 rubles |
| latch | LA04 | Stock: medic_bandage_1 +1 total | — | 650 rubles |
| latch | LA05 | Stock: attachment_steelplate_1 +1 total | — | 575 rubles |
| latch | LA06 | Purchase: bat; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| latch | LA07 | Stock: food_raisins +1 total | — | 0 rubles |
| latch | LA08 | Carried capacity: +1 weight | — | 1050 rubles |
| latch | LA09 | Stock: sharpening_stone +1 total | — | 875 rubles |
| latch | LA10 | Stock: bat +1 total | — | 1250 rubles |
| latch | LA11 | Purchase: attachment_steelplate_2; Purchase: sledgehammer | Standing exchange: sharpening_stone | 0 rubles |
| latch | LA12 | Stock: crowbar +1 total | Standing exchange: fireaxe | 1450 rubles; Gift: lowtiercookerfuel (1) |
| latch | LA13 | Stock: drink_bottletea +1 total | — | 1175 rubles |
| latch | LA14 | Carried capacity: +1 weight | — | 1650 rubles |
| latch | LA15 | Stock: drug_painkillers +1 total | Standing exchange: lax410s | 0 rubles |
| latch | LA16 | Stock: drink_bottlewaterdirty +2 total | Standing exchange: stoegerddshort | 1850 rubles |
| latch | LA17 | Purchase: fireaxe | Standing exchange: m3supershort | 1475 rubles |
| latch | LA18 | Stock: food_can_beans +1 total | Standing exchange: fubar | 2050 rubles; 500 repair credit at 'Technut' |
| latch | LA19 | Stock: food_can_tushonka +1 total | Standing exchange: sharpening_stone_fine | 0 rubles |
| latch | LA20 | Stock: drink_bottlewater +2 total | — | 2250 rubles |
| latch | LA21 | Stock: medic_bandage_1 +2 total | — | 1775 rubles |
| latch | LA22 | Carried capacity: +1 weight; Purchase: attachment_steelplate_3; Purchase: fubar | — | 2450 rubles; Recognition: Latch's trusted contact |
| ledger | LE01 | Purchase: backpack_sling; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_can_tushonka; Purchase: food_raisins | — | 275 rubles; Gift: drink_bottlewater (1) |
| ledger | LE02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| ledger | LE03 | Purchase: food_bread; Stock: lowtiercookerfuel +1 total | — | 0 rubles |
| ledger | LE04 | Stock: backpack_sling +1 total | — | 650 rubles |
| ledger | LE05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| ledger | LE06 | Stock: lowtiercookerfuel +3 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| ledger | LE07 | Stock: medic_bandage_1 +3 total | settlement freight corridor | 0 rubles |
| ledger | LE08 | Stock: drink_bottletea +1 total | Standing exchange: food_bread | 1050 rubles |
| ledger | LE09 | Stock: food_can_beans +1 total | Standing exchange: drink_bottlewater | 875 rubles |
| ledger | LE10 | Stock: food_can_tushonka +1 total | Standing exchange: lowtiercookerfuel | 1250 rubles |
| ledger | LE11 | Stock: food_raisins +1 total | recovered consignment corridor | 0 rubles |
| ledger | LE12 | Stock: drink_bottlewaterdirty +2 total | Standing exchange: medic_bandage_1 | 1450 rubles; Gift: lowtiercookerfuel (1) |
| ledger | LE13 | Stock: lowtiercookerfuel +2 total | Standing exchange: food_raisins | 1175 rubles |
| ledger | LE14 | Stock: backpack_sling +2 total | Standing exchange: drink_bottletea | 1650 rubles |
| ledger | LE15 | Stock: backpack_sling +3 total | remote cache corridor | 0 rubles |
| ledger | LE16 | Stock: drink_bottletea +2 total | Standing exchange: food_can_tushonka | 1850 rubles |
| ledger | LE17 | Stock: food_can_beans +2 total | Standing exchange: food_nuts_2 | 1475 rubles |
| ledger | LE18 | Stock: food_can_tushonka +2 total | Standing exchange: food_mre_russia | 2050 rubles; Gift: medic_bandage_1 (1) |
| ledger | LE19 | Stock: food_raisins +2 total | expedition freight corridor | 0 rubles |
| ledger | LE20 | Stock: drink_bottletea +3 total | — | 2250 rubles |
| ledger | LE21 | Stock: drink_bottlewaterdirty +3 total | Standing exchange: food_mre_ukraine | 1775 rubles |
| ledger | LE22 | Purchase: backpack_tourist; Stock: drink_bottlewater +1 total | — | 2450 rubles; Recognition: Ledger's trusted contact |
| mute | MU01 | Purchase: drink_bottletea; Purchase: drug_caffeine; Purchase: food_can_beans; Purchase: food_raisins; Purchase: pda; Purchase: quest_flashdrive | — | 275 rubles; Gift: drink_bottlewater (1) |
| mute | MU02 | Purchase: value_capacitors | — | 450 rubles |
| mute | MU03 | Stock: drink_bottlewaterdirty +1 total | — | 0 rubles |
| mute | MU04 | Purchase: value_tape_electric | — | 650 rubles |
| mute | MU05 | Purchase: value_9vbattery | — | 575 rubles |
| mute | MU06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| mute | MU07 | Purchase: value_radio_repeater | — | 0 rubles |
| mute | MU08 | Stock: medic_bandage_1 +1 total | — | 1050 rubles |
| mute | MU09 | emission warnings | — | 875 rubles |
| mute | MU10 | Stock: pda +1 total | Record: repeater identification | 1250 rubles |
| mute | MU11 | Stock: drink_bottletea +1 total | Record: coverage gap register | 0 rubles |
| mute | MU12 | Stock: drug_caffeine +1 total | Record: message authentication | 1450 rubles; Gift: lowtiercookerfuel (1) |
| mute | MU13 | Stock: food_can_beans +1 total | Record: lost operator records | 1175 rubles |
| mute | MU14 | Stock: food_raisins +1 total | Record: battery budgeting | 1650 rubles |
| mute | MU15 | event broadcasts | — | 0 rubles |
| mute | MU16 | Stock: pda +2 total | Record: interference signatures | 1850 rubles |
| mute | MU17 | Stock: quest_flashdrive +1 total | Record: relay outage reports | 1475 rubles |
| mute | MU18 | Stock: drink_bottlewaterdirty +2 total | Record: emergency signal protocol | 2050 rubles; Gift: medic_bandage_1 (1) |
| mute | MU19 | Stock: pda +3 total | Record: regional network comparison | 0 rubles |
| mute | MU20 | Stock: drink_bottletea +2 total | Record: intrusion incident records | 2250 rubles |
| mute | MU21 | Stock: drug_caffeine +2 total | Record: Pripyat signal notes | 1775 rubles |
| mute | MU22 | Stock: food_can_beans +2 total | Record: operator handover procedure | 2450 rubles |
| mute | MU23 | Stock: food_raisins +2 total | Record: offline network recovery | 0 rubles |
| mute | MU24 | Stock: medic_bandage_1 +2 total | — | 2650 rubles; Gift: lowtiercookerfuel (1); Recognition: Mute's trusted contact |
| old-timer | OT01 | Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: hatchet; Purchase: knife2; Purchase: lowtiercookerfuel; Purchase: sharpening_stone; Purchase: toz106; Purchase: toz34 | — | 275 rubles; Gift: medic_bandage_1 (1) |
| old-timer | OT02 | Stock: 22lr +1 total | — | 450 rubles |
| old-timer | OT03 | Purchase: toz34short | — | 0 rubles |
| old-timer | OT04 | Stock: 9x18 +1 total | — | 650 rubles |
| old-timer | OT05 | Stock: drink_bottlewaterdirty +1 total | — | 575 rubles |
| old-timer | OT06 | Purchase: toz66short; Stock: medic_bandage_1 +1 total | — | 850 rubles; Gift: 12gauge (1) |
| old-timer | OT07 | Stock: 12gauge +1 total | — | 0 rubles |
| old-timer | OT08 | Carried capacity: +1 weight; Purchase: w9422 | — | 1050 rubles |
| old-timer | OT09 | Stock: 22lr +2 total | — | 875 rubles |
| old-timer | OT10 | Stock: drink_bottletea +1 total | — | 1250 rubles |
| old-timer | OT11 | Purchase: ij600 | — | 0 rubles |
| old-timer | OT12 | Stock: drink_bottlewater +1 total | — | 1450 rubles; Gift: food_bread (1) |
| old-timer | OT13 | Purchase: mp27 | — | 1175 rubles |
| old-timer | OT14 | Stock: food_can_beans +1 total | — | 1650 rubles |
| old-timer | OT15 | Purchase: 45acp41; Purchase: knife3 | — | 0 rubles |
| old-timer | OT16 | Carried capacity: +1 weight; Purchase: ruger1022 | — | 1850 rubles |
| old-timer | OT17 | Stock: food_raisins +1 total | — | 1475 rubles |
| old-timer | OT18 | Purchase: sks; Purchase: toz66 | — | 2050 rubles; Gift: 12gauge (1) |
| old-timer | OT19 | Stock: hatchet +1 total | — | 0 rubles |
| old-timer | OT20 | Stock: 12gauge +2 total | — | 2250 rubles |
| old-timer | OT21 | Purchase: m1887 | Record: quarry signs | 1775 rubles |
| old-timer | OT22 | Purchase: 762x54; Stock: lowtiercookerfuel +1 total | Record: safe retreat planning | 2450 rubles |
| old-timer | OT23 | Purchase: mossberg500 | Record: wounded mutant trails | 0 rubles |
| old-timer | OT24 | Stock: knife2 +1 total | Record: night hunting | 2650 rubles; Gift: food_bread (1) |
| old-timer | OT25 | Stock: knife3 +1 total | Record: companion expedition notes | 2000 rubles |
| old-timer | OT26 | Purchase: rem870ae | Record: carcass handling | 2850 rubles |
| old-timer | OT27 | Stock: ij600 +1 total | Record: Pripyat return preparation | 0 rubles |
| old-timer | OT28 | Purchase: knife4; Purchase: sharpening_stone_fine; Purchase: toz34special; Stock: 12gauge +3 total | — | 3000 rubles; Recognition: Old Timer's trusted contact |
| quartermaster | QM01 | Purchase: 762x25; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: lowtiercookerfuel; Purchase: medic_medkit_1 | — | 275 rubles; Gift: 545x39 (1) |
| quartermaster | QM02 | Purchase: 22lrap; Purchase: 22lrhp; Purchase: 762x25ap; Purchase: 762x25hp; Purchase: medic_antirad_1; Purchase: mp40 | — | 450 rubles |
| quartermaster | QM03 | Purchase: 9x19; Purchase: 9x21; Purchase: drug_painkillers; Purchase: food_bread; Purchase: mp9a1 | — | 0 rubles |
| quartermaster | QM04 | Purchase: 9x18ap; Purchase: 9x18hp; Purchase: 9x19ap; Purchase: 9x19hp; Purchase: 9x21ap; Purchase: 9x21hp; Purchase: aks74u; Purchase: helm_steel_arab; Purchase: helm_steel_ger; Purchase: helm_tanker; Purchase: suit_skat10 | — | 650 rubles |
| quartermaster | QM05 | Purchase: 45acp; Purchase: 57x28; Purchase: kobra; Purchase: mp5 | — | 575 rubles |
| quartermaster | QM06 | Purchase: 45acpap; Purchase: 45acphp; Purchase: 57x28ap; Purchase: 57x28hp; Purchase: helm_steel_rus; Purchase: microt1; Stock: 22lr +1 total | — | 850 rubles; Gift: 556x45 (1) |
| quartermaster | QM07 | Purchase: 357magnum; Purchase: 44magnum; Purchase: aimpoint; Purchase: gepardpdw; Purchase: headwear_riot; Purchase: pp2000 | — | 0 rubles |
| quartermaster | QM08 | Purchase: 357magnumap; Purchase: 357magnumhp; Purchase: 44magnumap; Purchase: 44magnumhp; Purchase: ump45 | — | 1050 rubles |
| quartermaster | QM09 | Purchase: 545x39; Purchase: ak74; Purchase: eotech; Purchase: helm_operator_rus_2 | — | 875 rubles |
| quartermaster | QM10 | Purchase: 12gaugedt; Purchase: 12gaugemg; Purchase: 12gaugesg; Purchase: 12gaugetr; Purchase: 545x39ap; Purchase: 545x39hp; Purchase: headwear_cs1; Purchase: pp19 | — | 1250 rubles |
| quartermaster | QM11 | Purchase: 556x45; Purchase: 762x39; Purchase: medic_medkit_2; Purchase: pp1901vityaz | — | 0 rubles |
| quartermaster | QM12 | Purchase: 556x45ap; Purchase: 556x45hp; Purchase: 762x39ap; Purchase: 762x39hp; Purchase: ar159mm; Purchase: headwear_cs2 | — | 1450 rubles; Gift: medic_bandage_1 (1) |
| quartermaster | QM13 | Purchase: 45acp41; Purchase: 50ae; Purchase: helm_operator_rus_1; Purchase: m1928; Purchase: sr2 | — | 1175 rubles |
| quartermaster | QM14 | Purchase: 50aeap; Purchase: 50aehp; Purchase: p90 | — | 1650 rubles |
| quartermaster | QM15 | Purchase: 9x39; Purchase: akm; Purchase: headwear_screen; Purchase: m16a4; Purchase: medic_medkit_3 | — | 0 rubles |
| quartermaster | QM16 | Purchase: 9x39ap; Purchase: 9x39hp; Purchase: headwear_cs4; Purchase: lr300 | — | 1850 rubles |
| quartermaster | QM17 | Purchase: 500magnum; Purchase: 762x51; Purchase: famas; Purchase: medic_medkit_4 | — | 1475 rubles |
| quartermaster | QM18 | Purchase: 500magnumap; Purchase: 500magnumhp; Purchase: 762x51ap; Purchase: 762x51hp; Purchase: aek971; Purchase: helm_sphere08; Purchase: sg552 | — | 2050 rubles; Gift: 556x45 (1) |
| quartermaster | QM19 | Conversion: suit_skat9_anarchist; Purchase: 338lapua; Purchase: 762x54; Purchase: helm_sphere12; Purchase: l85; Purchase: medic_medkit_5 | — | 0 rubles |
| quartermaster | QM20 | Conversion: suit_skat10_anarchist; Conversion: suit_skat9_authority; Purchase: 338lapuaap; Purchase: 338lapuahp; Purchase: 762x54ap; Purchase: 762x54hp; Purchase: g36c; Purchase: rk95 | — | 2250 rubles |
| quartermaster | QM21 | Conversion: suit_skat10_authority; Conversion: suit_skat9_ecologist; Purchase: 127x55; Purchase: 700nitro; Purchase: 93x64; Purchase: aug; Purchase: helm_operator_nato | — | 1775 rubles |
| quartermaster | QM22 | Conversion: suit_skat10_ecologist; Conversion: suit_skat9_fanatic; Purchase: f2000; Purchase: headwear_pracs | — | 2450 rubles |
| quartermaster | QM23 | Conversion: suit_skat10_looted; Conversion: suit_skat9_looted; Purchase: 145x114; Purchase: an94k; Purchase: hk416; Purchase: medic_medkit_6 | — | 0 rubles |
| quartermaster | QM24 | Conversion: suit_skat10_mercenary; Conversion: suit_skat9_scavenger; Purchase: 145x114ap; Purchase: 145x114hp; Purchase: ak12; Purchase: headwear_psz12; Purchase: suit_skat9 | — | 2650 rubles; Gift: medic_bandage_1 (1); Recognition: Quartermaster's trusted contact |
| smartass | SM01 | Purchase: dataextractor; Purchase: drink_bottletea; Purchase: drink_energydrink_2; Purchase: drug_caffeine; Purchase: food_can_beans; Purchase: food_raisins; Purchase: sv98; Purchase: trg42 | — | 275 rubles; Gift: drink_bottlewater (1) |
| smartass | SM02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| smartass | SM03 | Stock: drug_caffeine +1 total | — | 0 rubles |
| smartass | SM04 | Stock: dataextractor +1 total | — | 650 rubles |
| smartass | SM05 | Stock: sv98 +1 total | — | 575 rubles |
| smartass | SM06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| smartass | SM07 | Purchase: m14 | — | 0 rubles |
| smartass | SM08 | Stock: dataextractor +2 total | — | 1050 rubles |
| smartass | SM09 | Stock: m14 +1 total | — | 875 rubles |
| smartass | SM10 | Purchase: cmore | — | 1250 rubles |
| smartass | SM11 | Stock: medic_bandage_1 +1 total | — | 0 rubles |
| smartass | SM12 | Stock: dataextractor +3 total | Record: computer type identification | 1450 rubles; Gift: lowtiercookerfuel (1) |
| smartass | SM13 | Purchase: svd | Record: flash drive provenance | 1175 rubles |
| smartass | SM14 | Stock: drink_bottletea +1 total | Record: data integrity checks | 1650 rubles |
| smartass | SM15 | Purchase: pso1 | Record: terminal power failures | 0 rubles |
| smartass | SM16 | Stock: drink_energydrink_2 +1 total | Record: archive access protocol | 1850 rubles |
| smartass | SM17 | Stock: drug_caffeine +2 total | Record: cross-system file comparison | 1475 rubles |
| smartass | SM18 | Purchase: shortdot; Purchase: vss | Record: damaged media handling | 2050 rubles; Gift: medic_bandage_1 (1) |
| smartass | SM19 | Stock: pso1 +1 total | Record: field extraction precautions | 0 rubles |
| smartass | SM20 | Purchase: quest_computeraccess; Stock: food_can_beans +1 total | Record: research workstation records | 2250 rubles |
| smartass | SM21 | Purchase: acog | Record: log timestamp comparison | 1775 rubles |
| smartass | SM22 | Stock: food_raisins +1 total | Record: Pripyat terminal reports | 2450 rubles |
| smartass | SM23 | Stock: shortdot +1 total | Record: forged file identification | 0 rubles |
| smartass | SM24 | Purchase: l115; Purchase: nightforce; Stock: medic_bandage_1 +2 total | — | 2650 rubles; Gift: lowtiercookerfuel (1); Recognition: Smartass's trusted contact |
| spicy-lemon | SL01 | Purchase: drug_caffeine; Purchase: food_burger; Purchase: food_oldmeat; Purchase: meal_human; Purchase: meat_human; Purchase: medic_bandage_1; Purchase: waterflask | — | 275 rubles; Gift: drink_bottlewater (1) |
| spicy-lemon | SL02 | Purchase: drink_milkold; Purchase: meal_tushkano; Purchase: meat_tushkano | — | 450 rubles |
| spicy-lemon | SL03 | Purchase: food_bread; Purchase: food_can_corn | — | 0 rubles |
| spicy-lemon | SL04 | Purchase: food_can_beans; Purchase: food_can_chilibeans; Purchase: food_sausage_1; Purchase: meal_blinddog; Purchase: meat_blinddog | Flesh expedition meal | 650 rubles |
| spicy-lemon | SL05 | Purchase: drink_canbeer_2; Purchase: drink_canbeer_3; Purchase: meal_flesh; Purchase: meat_boar | — | 575 rubles |
| spicy-lemon | SL06 | Purchase: drink_canbeer_1; Purchase: food_can_tomato; Purchase: meal_boar; Purchase: meat_tark; Stock: drink_bottlewaterdirty +1 total | — | 850 rubles; Gift: food_bread (1) |
| spicy-lemon | SL07 | Purchase: drink_bottlebeer_4; Purchase: food_sausage_2 | — | 0 rubles |
| spicy-lemon | SL08 | Purchase: drink_canbeer_4; Purchase: food_can_tuna; Purchase: meal_cat; Purchase: meat_spider | Boar expedition meal | 1050 rubles |
| spicy-lemon | SL09 | Purchase: drink_canbeer_6; Purchase: food_nuts_1; Purchase: lowtiercookerfuel; Purchase: meal_spider; Purchase: meat_cat | — | 875 rubles |
| spicy-lemon | SL10 | Purchase: drink_bottlebeer_3; Purchase: food_can_olive; Purchase: food_can_tushonka; Purchase: meal_pseudodog; Purchase: meat_flesh | — | 1250 rubles |
| spicy-lemon | SL11 | Purchase: food_cheese_1; Purchase: food_nuts_2 | — | 0 rubles |
| spicy-lemon | SL12 | Purchase: drink_canwater; Purchase: drink_energydrink_4; Purchase: meal_sprig; Purchase: meat_sprig | Blinddog expedition meal | 1450 rubles; Gift: lowtiercookerfuel (1) |
| spicy-lemon | SL13 | Purchase: drink_bottlebeer_6; Purchase: food_can_sprats; Purchase: food_cheese_2; Purchase: meal_tark; Purchase: meat_pseudodog | — | 1175 rubles |
| spicy-lemon | SL14 | Purchase: drink_canbeer_5; Purchase: drink_energydrink_2; Purchase: meal_burer; Purchase: meat_karlik | — | 1650 rubles |
| spicy-lemon | SL15 | Purchase: drink_bottlebeer_2; Purchase: drink_milk; Purchase: meal_snork; Purchase: meat_burer | — | 0 rubles |
| spicy-lemon | SL16 | Purchase: drink_bottlebeer_5; Purchase: drink_energydrink_1 | Pseudodog expedition meal | 1850 rubles |
| spicy-lemon | SL17 | Purchase: drink_bottlebeer_1; Purchase: food_cheese_3; Purchase: food_raisins; Purchase: meal_bloodsucker; Purchase: meat_bloodsucker | — | 1475 rubles |
| spicy-lemon | SL18 | Purchase: drink_energydrink_5; Purchase: drink_energydrink_6; Purchase: hightiercooker; Purchase: meal_karlik; Purchase: meat_snork | — | 2050 rubles; Gift: food_bread (1) |
| spicy-lemon | SL19 | Purchase: drink_bottletea; Purchase: drink_moonshine; Purchase: meal_bear; Purchase: meat_vareshka | — | 0 rubles |
| spicy-lemon | SL20 | Purchase: drink_energydrink_3; Purchase: drink_orangejuice; Purchase: drink_vodka_2 | Bloodsucker expedition meal | 2250 rubles |
| spicy-lemon | SL21 | Purchase: drink_vodka_1; Purchase: food_chocolate; Purchase: meal_controller; Purchase: meat_chimera | — | 1775 rubles |
| spicy-lemon | SL22 | Purchase: drink_vodka_3; Purchase: drink_wine; Purchase: meal_vareshka; Purchase: meat_hellhound | — | 2450 rubles |
| spicy-lemon | SL23 | Purchase: drink_vodka_4; Purchase: drink_vodka_6; Purchase: food_mre_ukraine; Purchase: meal_hellhound; Purchase: meat_bear | — | 0 rubles |
| spicy-lemon | SL24 | Purchase: food_mre_russia; Purchase: food_mre_usa | Chimera expedition meal | 2650 rubles; Gift: lowtiercookerfuel (1) |
| spicy-lemon | SL25 | Purchase: drink_spirit_1; Purchase: drink_vodka_5; Purchase: meal_chimera; Purchase: meat_controller | — | 2000 rubles |
| spicy-lemon | SL26 | Purchase: drink_spirit_2; Purchase: drink_spirit_3; Purchase: lowtiercooker; Purchase: meal_pseudogiant; Purchase: meat_pseudogiant | — | 2850 rubles; Recognition: Spicy Lemon's trusted contact |
| spool | SO01 | Purchase: drink_bottletea; Purchase: drug_caffeine; Purchase: food_can_beans; Purchase: food_raisins; Purchase: rfreceiver; Purchase: value_9vbattery; Purchase: walkman | — | 275 rubles; Gift: drink_bottlewater (1) |
| spool | SO02 | Purchase: value_tape_electric | — | 450 rubles |
| spool | SO03 | Purchase: value_capacitors | — | 0 rubles |
| spool | SO04 | Purchase: value_radio_repeater | — | 650 rubles |
| spool | SO05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| spool | SO06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| spool | SO07 | Stock: drink_bottlewaterdirty +1 total | Record: operator call-sign register | 0 rubles |
| spool | SO08 | Purchase: cassette_bandits; Purchase: cassette_barman; Purchase: cassette_firelake; Purchase: cassette_freedom; Purchase: cassette_merc; Purchase: cassette_standart; Purchase: cassette_true; Purchase: cassette_wickedrabbit; Stock: cassette_standart +1 total | Record: Marsh relay bearings | 1050 rubles |
| spool | SO09 | Stock: drink_bottletea +1 total | Record: Garbage relay bearings | 875 rubles |
| spool | SO10 | Stock: drug_caffeine +1 total | Record: Waystation relay bearings | 1250 rubles |
| spool | SO11 | Stock: food_can_beans +1 total | Record: Pripyat transmission bearings | 0 rubles |
| spool | SO12 | Stock: food_raisins +1 total | Record: failed station chronology | 1450 rubles; Gift: lowtiercookerfuel (1) |
| spool | SO13 | Stock: rfreceiver +1 total | Record: missing operator recordings | 1175 rubles |
| spool | SO14 | Stock: walkman +1 total | Record: signal triangulation procedure | 1650 rubles |
| spool | SO15 | Stock: drink_bottlewaterdirty +2 total | Record: antenna maintenance records | 0 rubles |
| spool | SO16 | Stock: cassette_standart +2 total | Record: interference comparison | 1850 rubles |
| spool | SO17 | Stock: drink_bottletea +2 total | Record: emergency listening protocol | 1475 rubles |
| spool | SO18 | Stock: drug_caffeine +2 total | Record: expedition radio checks | 2050 rubles; Gift: medic_bandage_1 (1) |
| spool | SO19 | Stock: food_can_beans +2 total | Record: recording provenance | 0 rubles |
| spool | SO20 | Stock: drink_bottlewater +2 total | — | 2250 rubles |
| spool | SO21 | Stock: food_raisins +2 total | Record: unidentified voice register | 1775 rubles |
| spool | SO22 | Stock: medic_bandage_1 +2 total | — | 2450 rubles; Recognition: Spool's trusted contact |
| spoor | SP01 | Purchase: binoculars_2; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: lowtiercookerfuel; Purchase: machete; Purchase: pso1; Purchase: sako85varmint; Purchase: sharpening_stone; Purchase: sharpening_stone_fine | — | 275 rubles; Gift: 12gauge (1) |
| spoor | SP02 | Purchase: 22lrap; Purchase: 22lrhp; Stock: 22lr +1 total | — | 450 rubles |
| spoor | SP03 | Purchase: food_bread; Purchase: obrez | Record: blind dog feeding grounds | 0 rubles |
| spoor | SP04 | Stock: drink_bottlewater +1 total | Record: boar escape routes | 650 rubles |
| spoor | SP05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| spoor | SP06 | Purchase: sako85nato; Stock: 12gauge +1 total | — | 850 rubles; Gift: 22lr (1) |
| spoor | SP07 | Stock: 22lrap +1 total | — | 0 rubles |
| spoor | SP08 | Purchase: w1895 | — | 1050 rubles |
| spoor | SP09 | Purchase: 12gaugedt; Purchase: 12gaugemg; Purchase: 12gaugesg; Purchase: 12gaugetr; Stock: 22lrhp +1 total | — | 875 rubles |
| spoor | SP10 | Purchase: w9422357 | — | 1250 rubles |
| spoor | SP11 | Stock: 12gaugedt +1 total | — | 0 rubles |
| spoor | SP12 | Stock: 22lr +2 total | — | 1450 rubles; Gift: drink_bottlewater (1) |
| spoor | SP13 | Purchase: saigasemi | — | 1175 rubles |
| spoor | SP14 | Stock: 22lrap +2 total | — | 1650 rubles |
| spoor | SP15 | Purchase: 762x51; Purchase: mosin | Record: flesh herd signs | 0 rubles |
| spoor | SP16 | Purchase: 762x51ap; Purchase: 762x51hp; Stock: 22lrap +3 total | Record: predator displacement | 1850 rubles |
| spoor | SP17 | Purchase: 338lapua; Purchase: 762x54; Purchase: lax44 | — | 1475 rubles |
| spoor | SP18 | Purchase: 338lapuaap; Purchase: 338lapuahp; Purchase: 762x54ap; Purchase: 762x54hp; Stock: binoculars_2 +1 total | — | 2050 rubles; Gift: 22lr (1) |
| spoor | SP19 | Stock: 338lapua +1 total | — | 0 rubles |
| spoor | SP20 | Purchase: sako85; Stock: 12gauge +2 total | — | 2250 rubles |
| spoor | SP21 | Stock: 338lapuaap +1 total | Record: bloodsucker warning signs | 1775 rubles |
| spoor | SP22 | Purchase: acog; Purchase: binoculars_1; Purchase: svt40; Stock: 22lr +3 total | — | 2450 rubles; Recognition: Spoor's trusted contact |
| suture | SU01 | Purchase: attachment_ceramicplate_1; Purchase: backpack_sling; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: suit_anorak; Purchase: suit_trenchcoat_brown | — | 275 rubles; Gift: drink_bottlewater (1) |
| suture | SU02 | Purchase: value_tape_duct | — | 450 rubles |
| suture | SU03 | Purchase: backpack_tbag | — | 0 rubles |
| suture | SU04 | Purchase: attachment_fabric_1; Purchase: backpack_tourist | Restocking: outfitter colours | 650 rubles |
| suture | SU05 | Stock: drink_bottlewaterdirty +1 total | — | 575 rubles |
| suture | SU06 | Purchase: backpack_takedown_1; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| suture | SU07 | Conversion: suit_anorak_anarchist; Purchase: suit_mailjacket | — | 0 rubles |
| suture | SU08 | Conversion: suit_anorak_authority; Purchase: attachment_ceramicplate_2; Purchase: backpack_takedown_2 | backpack_sling exchange | 1050 rubles |
| suture | SU09 | Conversion: suit_anorak_ecologist; Conversion: suit_mailjacket_anarchist; Purchase: backpack_mbss | — | 875 rubles |
| suture | SU10 | Conversion: suit_anorak_mercenary; Conversion: suit_mailjacket_authority | — | 1250 rubles |
| suture | SU11 | Conversion: suit_anorak_scavenger; Conversion: suit_mailjacket_ecologist; Conversion: suit_sunrise_anarchist; Purchase: attachment_fabric_2; Purchase: backpack_vkbo | — | 0 rubles |
| suture | SU12 | Conversion: suit_mailjacket_mercenary; Conversion: suit_sunrise_authority | — | 1450 rubles; Gift: lowtiercookerfuel (1) |
| suture | SU13 | Conversion: suit_mailjacket_scavenger; Conversion: suit_sunrise_fanatic; Purchase: backpack_pilgrim; Purchase: suit_trenchcoat_black; Purchase: suit_trenchcoat_green | — | 1175 rubles |
| suture | SU14 | Conversion: suit_sunrise_looted; Purchase: attachment_kevlar_1; Purchase: backpack_scavbackpack | — | 1650 rubles |
| suture | SU15 | Conversion: suit_sunrise_mercenary | — | 0 rubles |
| suture | SU16 | Conversion: suit_sunrise_scavenger; Purchase: backpack_1 | backpack_vkbo exchange | 1850 rubles |
| suture | SU17 | Purchase: attachment_carbonfibre; Purchase: backpack_3 | — | 1475 rubles |
| suture | SU18 | Purchase: suit_sunrise | — | 2050 rubles; Gift: medic_bandage_1 (1) |
| suture | SU19 | Purchase: backpack_2 | — | 0 rubles |
| suture | SU20 | Stock: attachment_fabric_1 +1 total | — | 2250 rubles |
| suture | SU21 | Purchase: attachment_ceramicplate_3; Purchase: backpack_1_large | — | 1775 rubles |
| suture | SU22 | Purchase: backpack_3_large | backpack_1_large exchange | 2450 rubles |
| suture | SU23 | Stock: medic_bandage_1 +1 total | — | 0 rubles |
| suture | SU24 | Carried capacity: +1 rows; Purchase: attachment_kevlar_2; Purchase: backpack_2_large; Purchase: suit_cs1; Purchase: suit_trenchcoat_tan | — | 2650 rubles; Gift: lowtiercookerfuel (1); Recognition: Suture's trusted contact |
| technut | TN01 | Purchase: attachment_aluframe; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: foregrip | — | 275 rubles; Gift: drink_bottlewater (1) |
| technut | TN02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| technut | TN03 | Stock: lowtiercookerfuel +1 total | — | 0 rubles |
| technut | TN04 | Stock: medic_bandage_1 +1 total | — | 650 rubles |
| technut | TN05 | Stock: attachment_aluframe +1 total | — | 575 rubles |
| technut | TN06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| technut | TN07 | Stock: drink_bottlewater +2 total | — | 0 rubles |
| technut | TN08 | Stock: drink_bottletea +1 total | — | 1050 rubles |
| technut | TN09 | Stock: food_can_beans +1 total | — | 875 rubles |
| technut | TN10 | Stock: food_raisins +1 total | Latch's Find: workshop procedure | 1250 rubles |
| technut | TN11 | Conversion: suit_cs1_ecologist; repair discount: 5% | — | 0 rubles |
| technut | TN12 | Conversion: suit_cs1_scavenger | — | 1450 rubles; Gift: lowtiercookerfuel (1) |
| technut | TN13 | existing suit painting | — | 1175 rubles |
| technut | TN14 | Stock: foregrip +1 total | — | 1650 rubles |
| technut | TN15 | Conversion: suit_cs2_ecologist | — | 0 rubles |
| technut | TN16 | Conversion: suit_cs2_scavenger | — | 1850 rubles |
| technut | TN17 | Stock: drink_bottlewaterdirty +2 total | — | 1475 rubles |
| technut | TN18 | Conversion: suit_cs3_ecologist | — | 2050 rubles; Gift: medic_bandage_1 (1) |
| technut | TN19 | Stock: lowtiercookerfuel +2 total | — | 0 rubles |
| technut | TN20 | Stock: medic_bandage_1 +2 total | — | 2250 rubles |
| technut | TN21 | Stock: attachment_aluframe +2 total | — | 1775 rubles |
| technut | TN22 | Stock: drink_bottlewater +3 total | — | 2450 rubles |
| technut | TN23 | Stock: drink_bottletea +2 total | — | 0 rubles |
| technut | TN24 | Stock: food_can_beans +2 total | — | 2650 rubles; 500 repair credit at 'Technut' |
| technut | TN25 | repair discount: 10% | — | 2000 rubles |
| technut | TN26 | Stock: food_raisins +2 total | — | 2850 rubles |
| technut | TN27 | Stock: foregrip +2 total | — | 0 rubles |
| technut | TN28 | Purchase: attachment_steelframe | — | 3000 rubles; Recognition: Technut's trusted contact |
| the-original | OR01 | Purchase: diecup; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_can_tushonka; Purchase: food_raisins; Purchase: guitar; Purchase: hide_tushkano; Purchase: part_tushkano | — | 275 rubles; Gift: drink_bottlewater (1) |
| the-original | OR02 | Purchase: hide_blinddog; Purchase: part_blinddog; Purchase: part_zombie_1 | — | 450 rubles |
| the-original | OR03 | Purchase: part_boar; Stock: medic_bandage_1 +1 total | — | 0 rubles |
| the-original | OR04 | Purchase: hide_flesh; Purchase: part_zombie_2 | — | 650 rubles |
| the-original | OR05 | Purchase: hide_boar; Purchase: part_flesh; Purchase: part_tark | — | 575 rubles |
| the-original | OR06 | Purchase: hide_pseudodog; Purchase: part_spider; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| the-original | OR07 | Purchase: hide_tark; Purchase: part_cat | — | 0 rubles |
| the-original | OR08 | Purchase: part_pseudodog; Purchase: part_snork_1 | medic_bandage_1 exchange | 1050 rubles |
| the-original | OR09 | Purchase: 12gauge; Purchase: hide_cat; Purchase: part_sprig | Record: unusual tissue handling | 875 rubles |
| the-original | OR10 | Purchase: hide_bloodsucker; Purchase: part_izlom | Record: predator adaptation notes | 1250 rubles |
| the-original | OR11 | Purchase: hide_spider; Purchase: part_hellhound; Purchase: part_snork_2 | Record: early expedition testimony | 0 rubles |
| the-original | OR12 | Purchase: part_bloodsucker | Record: mutant habitat comparison | 1450 rubles; Gift: lowtiercookerfuel (1) |
| the-original | OR13 | Purchase: hide_vareshka; Purchase: part_burer_1 | Record: old encounter account | 1175 rubles |
| the-original | OR14 | Purchase: hide_chimera; Purchase: part_karlik_1; Purchase: part_skeleton | lowtiercookerfuel exchange | 1650 rubles |
| the-original | OR15 | Purchase: hide_sprig; Purchase: part_psydog | Record: field kitchen safety | 0 rubles |
| the-original | OR16 | Purchase: hide_bear; Purchase: part_swampcontroller_1 | Record: survival equipment improvisation | 1850 rubles |
| the-original | OR17 | Purchase: part_chimera; Purchase: part_karlik_2 | Record: conflicting expedition stories | 1475 rubles |
| the-original | OR18 | Purchase: hide_karlik; Purchase: part_controller_1 | Record: rare mutation observations | 2050 rubles; Gift: medic_bandage_1 (1) |
| the-original | OR19 | Purchase: hide_swampcontroller; Purchase: part_vareshka | Record: Pripyat specimen comparison | 0 rubles |
| the-original | OR20 | Purchase: hide_burer; Purchase: part_bear; Purchase: part_swampcontroller_2 | medic_antirad_1 exchange | 2250 rubles |
| the-original | OR21 | Purchase: hide_controller; Purchase: part_burer_2 | Record: specimen transport contamination | 1775 rubles |
| the-original | OR22 | Purchase: part_controller_2 | Record: mutant seasonal displacement | 2450 rubles |
| the-original | OR23 | Purchase: hide_electrocontroller; Purchase: part_electrocontroller_2; Purchase: part_pseudogiant | Record: early camp equipment accounts | 0 rubles |
| the-original | OR24 | Purchase: harmonica; Purchase: hide_pseudogiant; Purchase: part_electrocontroller_1; Stock: medic_bandage_1 +2 total | — | 2650 rubles; Gift: lowtiercookerfuel (1); Recognition: The Original's trusted contact |
| vesper | VE01 | Purchase: anomalydetector; Purchase: detectorecho; Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_raisins; Purchase: medic_medkit_1; Purchase: suit_wind | — | 275 rubles; Gift: drink_bottlewater (1) |
| vesper | VE02 | Stock: drink_bottlewaterdirty +1 total | — | 450 rubles |
| vesper | VE03 | Purchase: medic_antirad_1 | — | 0 rubles |
| vesper | VE04 | Stock: lowtiercookerfuel +1 total | — | 650 rubles |
| vesper | VE05 | Stock: medic_bandage_1 +1 total | — | 575 rubles |
| vesper | VE06 | Purchase: medic_antirad_2; Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| vesper | VE07 | Stock: anomalydetector +1 total | Record: field boundary observations | 0 rubles |
| vesper | VE08 | Stock: medic_antirad_2 +1 total | Record: detector preparation | 1050 rubles |
| vesper | VE09 | Stock: detectorecho +1 total | Record: Marsh anomaly comparison | 875 rubles |
| vesper | VE10 | Stock: drink_bottlewater +2 total | Record: Garbage anomaly comparison | 1250 rubles |
| vesper | VE11 | Stock: drink_bottletea +1 total | — | 0 rubles |
| vesper | VE12 | Stock: food_can_beans +1 total | Record: Waystation anomaly comparison | 1450 rubles; Gift: lowtiercookerfuel (1) |
| vesper | VE13 | Conversion: suit_wind_anarchist; Purchase: detectorbear | — | 1175 rubles |
| vesper | VE14 | Conversion: suit_wind_authority | — | 1650 rubles |
| vesper | VE15 | Conversion: suit_wind_fanatic | — | 0 rubles |
| vesper | VE16 | Conversion: suit_wind_looted | — | 1850 rubles |
| vesper | VE17 | Stock: food_raisins +1 total | Record: Pripyat anomaly comparison | 1475 rubles |
| vesper | VE18 | Stock: medic_antirad_1 +1 total | Record: weather and visibility | 2050 rubles; Gift: medic_bandage_1 (1) |
| vesper | VE19 | Stock: detectorbear +1 total | — | 0 rubles |
| vesper | VE20 | Stock: medic_medkit_1 +1 total | Record: survey withdrawal criteria | 2250 rubles |
| vesper | VE21 | Stock: suit_wind +1 total | — | 1775 rubles |
| vesper | VE22 | Stock: drink_bottlewaterdirty +2 total | Record: protective equipment checklist | 2450 rubles |
| vesper | VE23 | Stock: lowtiercookerfuel +2 total | Record: artifact recovery notes | 0 rubles |
| vesper | VE24 | Purchase: detectorveles; Stock: medic_bandage_1 +2 total | — | 2650 rubles; Gift: lowtiercookerfuel (1); Recognition: Vesper's trusted contact |
| wake | WA01 | Purchase: drink_bottletea; Purchase: food_can_beans; Purchase: food_can_tushonka; Purchase: food_raisins; Purchase: medic_medkit_1 | — | 275 rubles; Gift: drink_bottlewater (1) |
| wake | WA02 | Purchase: medic_antirad_1 | — | 450 rubles |
| wake | WA03 | Purchase: drug_painkillers | — | 0 rubles |
| wake | WA04 | Purchase: backpack_sanitar; Stock: medic_bandage_1 +1 total | — | 650 rubles |
| wake | WA05 | Purchase: medic_bandage_2 | — | 575 rubles |
| wake | WA06 | Stock: drink_bottlewater +1 total | — | 850 rubles; Gift: medic_bandage_1 (1) |
| wake | WA07 | Stock: drink_bottlewaterdirty +1 total | Bring Back What You Can: standing exchange | 0 rubles |
| wake | WA08 | Stock: medic_antirad_1 +1 total | Record: personal effects identification | 1050 rubles |
| wake | WA09 | Stock: backpack_sanitar +1 total | Record: failed convoy account | 875 rubles |
| wake | WA10 | Stock: drink_bottletea +1 total | Atlas' Missing Mark: standing exchange | 1250 rubles |
| wake | WA11 | Purchase: medic_medkit_2 | — | 0 rubles |
| wake | WA12 | Stock: drug_painkillers +1 total | Record: Garbage recovery approaches | 1450 rubles; Gift: lowtiercookerfuel (1) |
| wake | WA13 | Purchase: medic_bandage_3 | — | 1175 rubles |
| wake | WA14 | Stock: food_can_beans +1 total | Record: Pripyat recovery approaches | 1650 rubles |
| wake | WA15 | Purchase: medic_medkit_3 | — | 0 rubles |
| wake | WA16 | Stock: food_can_tushonka +1 total | Building the reserve: standing exchange | 1850 rubles |
| wake | WA17 | Purchase: medic_medkit_4 | — | 1475 rubles |
| wake | WA18 | Stock: medic_bandage_1 +2 total | — | 2050 rubles; Gift: medic_bandage_1 (1) |
| wake | WA19 | Purchase: medic_medkit_5 | — | 0 rubles |
| wake | WA20 | Stock: drink_bottlewater +2 total | — | 2250 rubles |
| wake | WA21 | Purchase: medic_antirad_2 | — | 1775 rubles |
| wake | WA22 | Purchase: medic_medkit_6 | — | 2450 rubles; Recognition: Wake's trusted contact |

## Purchase catalogue

| Item | Seller | Local milestone | Canonical tier owner |
| --- | --- | --- | --- |
| backpack_sling | atlas | AT01 | suture |
| backpack_tourist | atlas | AT22 | suture |
| binoculars_1 | atlas | AT05 | atlas |
| binoculars_2 | atlas | AT01 | atlas |
| binoculars_3 | atlas | AT17 | atlas |
| binoculars_4 | atlas | AT13 | atlas |
| compass | atlas | AT02 | atlas |
| drink_bottletea | atlas | AT01 | atlas |
| food_can_beans | atlas | AT01 | atlas |
| food_raisins | atlas | AT01 | atlas |
| gpstracker | atlas | AT07 | local |
| medic_antirad_1 | atlas | AT01 | beanstalk |
| backpack_duffle | ballast | BA01 | ballast |
| drink_bottletea | ballast | BA01 | atlas |
| drug_painkillers | ballast | BA01 | jitters |
| food_can_beans | ballast | BA01 | atlas |
| food_can_tushonka | ballast | BA01 | ballast |
| food_raisins | ballast | BA01 | atlas |
| drink_bottletea | beanstalk | BN01 | atlas |
| drug_caffeine | beanstalk | BN01 | beanstalk |
| food_can_beans | beanstalk | BN01 | atlas |
| food_raisins | beanstalk | BN01 | atlas |
| geigercounter | beanstalk | BN01 | beanstalk |
| mask_cloth | beanstalk | BN01 | beanstalk |
| mask_eo20 | beanstalk | BN13 | beanstalk |
| mask_gp5 | beanstalk | BN10 | beanstalk |
| mask_halfmask | beanstalk | BN04 | beanstalk |
| mask_m40 | beanstalk | BN21 | beanstalk |
| mask_m50 | beanstalk | BN24 | beanstalk |
| mask_pmk3 | beanstalk | BN15 | beanstalk |
| mask_respirator | beanstalk | BN07 | beanstalk |
| mask_xm40 | beanstalk | BN18 | beanstalk |
| medic_antipsychotic_1 | beanstalk | BN07 | beanstalk |
| medic_antipsychotic_2 | beanstalk | BN09 | beanstalk |
| medic_antipsychotic_3 | beanstalk | BN13 | beanstalk |
| medic_antirad_1 | beanstalk | BN02 | beanstalk |
| medic_medkit_1 | beanstalk | BN01 | jitters |
| medic_psyheal_1 | beanstalk | BN01 | beanstalk |
| medic_psyheal_2 | beanstalk | BN03 | beanstalk |
| medic_stimpak_1 | beanstalk | BN07 | beanstalk |
| medic_stimpak_2 | beanstalk | BN11 | beanstalk |
| medic_stimpak_3 | beanstalk | BN15 | beanstalk |
| suit_nbc | beanstalk | BN24 | beanstalk |
| suit_ssp99 | beanstalk | BN01 | beanstalk |
| 9a91 | boss | BO04 | local |
| 9x39 | boss | BO13 | brass |
| accesscard_bunker | boss | BO01 | local |
| asval | boss | BO16 | local |
| dp28 | boss | BO10 | local |
| drink_bottletea | boss | BO01 | atlas |
| fnfal | boss | BO13 | local |
| food_bread | boss | BO03 | ledger |
| food_can_beans | boss | BO01 | atlas |
| food_can_tushonka | boss | BO01 | ballast |
| food_raisins | boss | BO01 | atlas |
| g3a3 | boss | BO01 | local |
| lowtiercookerfuel | boss | BO01 | gasket |
| medic_medkit_1 | boss | BO01 | jitters |
| pkm | boss | BO22 | local |
| rpk | boss | BO07 | local |
| sr3m | boss | BO19 | local |
| suit_berill | boss | BO17 | boss |
| suit_cs2 | boss | BO11 | boss |
| suit_cs3 | boss | BO22 | boss |
| suit_io7a | boss | BO01 | boss |
| suit_ps5m | boss | BO06 | boss |
| 127x55 | brass | BR21 | brass |
| 12gaugedt | brass | BR10 | brass |
| 12gaugemg | brass | BR10 | brass |
| 12gaugesg | brass | BR10 | brass |
| 12gaugetr | brass | BR10 | brass |
| 145x114 | brass | BR23 | brass |
| 145x114ap | brass | BR24 | brass |
| 145x114hp | brass | BR24 | brass |
| 22lrap | brass | BR02 | brass |
| 22lrhp | brass | BR02 | brass |
| 338lapua | brass | BR19 | brass |
| 338lapuaap | brass | BR20 | brass |
| 338lapuahp | brass | BR20 | brass |
| 357magnum | brass | BR07 | brass |
| 357magnumap | brass | BR08 | brass |
| 357magnumhp | brass | BR08 | brass |
| 44magnum | brass | BR07 | brass |
| 44magnumap | brass | BR08 | brass |
| 44magnumhp | brass | BR08 | brass |
| 45acp | brass | BR05 | brass |
| 45acp41 | brass | BR13 | brass |
| 45acpap | brass | BR06 | brass |
| 45acphp | brass | BR06 | brass |
| 500magnum | brass | BR17 | brass |
| 500magnumap | brass | BR18 | brass |
| 500magnumhp | brass | BR18 | brass |
| 50ae | brass | BR13 | brass |
| 50aeap | brass | BR14 | brass |
| 50aehp | brass | BR14 | brass |
| 545x39 | brass | BR09 | brass |
| 545x39ap | brass | BR10 | brass |
| 545x39hp | brass | BR10 | brass |
| 556x45 | brass | BR11 | brass |
| 556x45ap | brass | BR12 | brass |
| 556x45hp | brass | BR12 | brass |
| 57x28 | brass | BR05 | brass |
| 57x28ap | brass | BR06 | brass |
| 57x28hp | brass | BR06 | brass |
| 700nitro | brass | BR21 | brass |
| 762x25 | brass | BR01 | brass |
| 762x25ap | brass | BR02 | brass |
| 762x25hp | brass | BR02 | brass |
| 762x39 | brass | BR11 | brass |
| 762x39ap | brass | BR12 | brass |
| 762x39hp | brass | BR12 | brass |
| 762x51 | brass | BR17 | brass |
| 762x51ap | brass | BR18 | brass |
| 762x51hp | brass | BR18 | brass |
| 762x54 | brass | BR19 | brass |
| 762x54ap | brass | BR20 | brass |
| 762x54hp | brass | BR20 | brass |
| 93x64 | brass | BR21 | brass |
| 9x18ap | brass | BR04 | brass |
| 9x18hp | brass | BR04 | brass |
| 9x19 | brass | BR03 | brass |
| 9x19ap | brass | BR04 | brass |
| 9x19hp | brass | BR04 | brass |
| 9x21 | brass | BR03 | brass |
| 9x21ap | brass | BR04 | brass |
| 9x21hp | brass | BR04 | brass |
| 9x39 | brass | BR15 | brass |
| 9x39ap | brass | BR16 | brass |
| 9x39hp | brass | BR16 | brass |
| drink_bottletea | brass | BR01 | atlas |
| food_bread | brass | BR03 | ledger |
| food_can_beans | brass | BR01 | atlas |
| food_raisins | brass | BR01 | atlas |
| lowtiercookerfuel | brass | BR01 | gasket |
| drink_bottletea | carbon | CA01 | atlas |
| drug_caffeine | carbon | CA02 | beanstalk |
| food_can_beans | carbon | CA01 | atlas |
| food_raisins | carbon | CA01 | atlas |
| value_officepaper | carbon | CA01 | local |
| value_tape_duct | carbon | CA02 | carbon |
| 9x19 | cleaner | CL03 | brass |
| cobrasuppressor | cleaner | CL10 | local |
| drink_bottletea | cleaner | CL01 | atlas |
| food_can_beans | cleaner | CL01 | atlas |
| food_raisins | cleaner | CL01 | atlas |
| fort12 | cleaner | CL06 | haggler |
| hidestasher_cleaningkit | cleaner | CL01 | cleaner |
| hidestasher_shovel | cleaner | CL28 | cleaner |
| makarov | cleaner | CL03 | haggler |
| mp5k | cleaner | CL12 | haggler |
| pbssuppressor | cleaner | CL19 | local |
| sakersuppressor | cleaner | CL28 | local |
| tundrasuppressor | cleaner | CL01 | local |
| value_tape_duct | cleaner | CL03 | carbon |
| accesscard_laboratory | egghead | EG01 | local |
| artifact_arachno | egghead | EG13 | local |
| artifact_battery | egghead | EG11 | local |
| artifact_blowncap | egghead | EG08 | local |
| artifact_bolt | egghead | EG01 | local |
| artifact_bonecluster | egghead | EG02 | local |
| artifact_capacitor | egghead | EG20 | local |
| artifact_cell | egghead | EG08 | local |
| artifact_compass | egghead | EG22 | local |
| artifact_crystal | egghead | EG16 | local |
| artifact_droplet | egghead | EG03 | local |
| artifact_dwarfgalaxy | egghead | EG13 | local |
| artifact_eye | egghead | EG16 | local |
| artifact_flame | egghead | EG24 | local |
| artifact_flash | egghead | EG11 | local |
| artifact_gaia | egghead | EG19 | local |
| artifact_galaxy | egghead | EG25 | local |
| artifact_gmamasbeads | egghead | EG22 | local |
| artifact_grapes | egghead | EG06 | local |
| artifact_halo | egghead | EG15 | local |
| artifact_kolobok | egghead | EG19 | local |
| artifact_mamasbeads | egghead | EG17 | local |
| artifact_mementomori | egghead | EG07 | local |
| artifact_mica | egghead | EG14 | local |
| artifact_midas | egghead | EG26 | local |
| artifact_moon | egghead | EG23 | local |
| artifact_moonlight | egghead | EG21 | local |
| artifact_mycelia | egghead | EG10 | local |
| artifact_panacea | egghead | EG18 | local |
| artifact_photo | egghead | EG02 | local |
| artifact_slime | egghead | EG05 | local |
| artifact_slug | egghead | EG12 | local |
| artifact_sparkler | egghead | EG05 | local |
| artifact_storm | egghead | EG25 | local |
| artifact_thorn | egghead | EG04 | local |
| artifact_urchin | egghead | EG09 | local |
| detectorbear | egghead | EG13 | egghead |
| detectorecho | egghead | EG01 | egghead |
| detectorveles | egghead | EG26 | egghead |
| drink_bottletea | egghead | EG01 | atlas |
| food_can_beans | egghead | EG01 | atlas |
| food_raisins | egghead | EG01 | atlas |
| medic_antipsychotic_1 | egghead | EG07 | beanstalk |
| medic_antipsychotic_2 | egghead | EG09 | beanstalk |
| medic_antipsychotic_3 | egghead | EG13 | beanstalk |
| medic_antirad_1 | egghead | EG02 | beanstalk |
| medic_antirad_2 | egghead | EG06 | jitters |
| medic_psyheal_1 | egghead | EG01 | beanstalk |
| medic_psyheal_2 | egghead | EG03 | beanstalk |
| medic_stimpak_1 | egghead | EG07 | beanstalk |
| medic_stimpak_2 | egghead | EG11 | beanstalk |
| medic_stimpak_3 | egghead | EG15 | beanstalk |
| suit_seva | egghead | EG26 | egghead |
| suit_ssp99m | egghead | EG01 | egghead |
| drink_bottletea | gasket | GK01 | atlas |
| flashlight | gasket | GK06 | local |
| food_can_beans | gasket | GK01 | atlas |
| food_raisins | gasket | GK01 | atlas |
| headlamp | gasket | GK16 | gasket |
| lowtiercookerfuel | gasket | GK01 | gasket |
| value_kerosene | gasket | GK08 | local |
| value_tape_duct | gasket | GK09 | carbon |
| value_waterfilter | gasket | GK04 | local |
| 12gauge | haggler | HG09 | haggler |
| 45acp | haggler | HG05 | brass |
| 45acp41 | haggler | HG14 | brass |
| 545x39 | haggler | HG09 | brass |
| 762x25 | haggler | HG01 | brass |
| 762x39 | haggler | HG11 | brass |
| 9x18 | haggler | HG03 | local |
| 9x19 | haggler | HG03 | brass |
| beretta92 | haggler | HG05 | local |
| brhp | haggler | HG04 | local |
| c96 | haggler | HG06 | local |
| c96carbine | haggler | HG06 | local |
| cz52 | haggler | HG04 | local |
| deagle | haggler | HG22 | local |
| deagle44 | haggler | HG23 | local |
| drink_bottletea | haggler | HG01 | atlas |
| fiveseven | haggler | HG24 | local |
| food_can_beans | haggler | HG01 | atlas |
| food_raisins | haggler | HG01 | atlas |
| fort12 | haggler | HG05 | haggler |
| g2contender | haggler | HG02 | local |
| g2contender500 | haggler | HG13 | local |
| glock17 | haggler | HG09 | local |
| glock18 | haggler | HG12 | local |
| ithaca37 | haggler | HG22 | local |
| kiparis | haggler | HG10 | local |
| kp31 | haggler | HG17 | local |
| lax410 | haggler | HG18 | local |
| lax410s | haggler | HG19 | local |
| lugerp08 | haggler | HG08 | local |
| m1911 | haggler | HG11 | local |
| m1911chic | haggler | HG24 | local |
| m1917 | haggler | HG03 | local |
| m3super90 | haggler | HG20 | local |
| m3supershort | haggler | HG13 | local |
| mac11 | haggler | HG09 | local |
| makarov | haggler | HG03 | haggler |
| mateba | haggler | HG23 | local |
| mp153 | haggler | HG19 | local |
| mp18 | haggler | HG16 | local |
| mp34 | haggler | HG11 | local |
| mp5k | haggler | HG16 | haggler |
| mr96 | haggler | HG15 | local |
| nagantrev | haggler | HG01 | local |
| obrezmalfunction | haggler | HG08 | local |
| p99 | haggler | HG08 | local |
| ppsh | haggler | HG07 | local |
| rugermini14 | haggler | HG14 | local |
| rugermk3 | haggler | HG06 | local |
| saiga12 | haggler | HG25 | local |
| saiga410 | haggler | HG25 | local |
| saigasemi545 | haggler | HG16 | local |
| skorpion | haggler | HG10 | local |
| stechaps | haggler | HG14 | local |
| sten | haggler | HG07 | local |
| sterling | haggler | HG18 | local |
| stoegerdd | haggler | HG20 | local |
| stoegerddshort | haggler | HG17 | local |
| striker | haggler | HG26 | local |
| sw500 | haggler | HG26 | haggler |
| swmodel29 | haggler | HG21 | local |
| swr8 | haggler | HG21 | local |
| taurusjudge | haggler | HG12 | local |
| taurusragingbull | haggler | HG01 | haggler |
| tokarev | haggler | HG02 | local |
| toz194 | haggler | HG15 | local |
| uzi | haggler | HG14 | local |
| drink_bottletea | intern | IN01 | atlas |
| drug_caffeine | intern | IN01 | beanstalk |
| food_can_beans | intern | IN01 | atlas |
| food_raisins | intern | IN01 | atlas |
| gasanalyzer | intern | IN01 | local |
| geigercounter | intern | IN24 | beanstalk |
| medic_antirad_1 | intern | IN02 | beanstalk |
| medic_psyheal_1 | intern | IN03 | beanstalk |
| drink_bottletea | jitters | JT01 | atlas |
| drug_adrenaline | jitters | JT13 | jitters |
| drug_mints | jitters | JT01 | local |
| drug_morphine | jitters | JT20 | local |
| drug_painkillers | jitters | JT03 | jitters |
| food_bread | jitters | JT03 | ledger |
| food_can_beans | jitters | JT01 | atlas |
| food_raisins | jitters | JT01 | atlas |
| medic_antipsychotic_1 | jitters | JT01 | beanstalk |
| medic_antirad_1 | jitters | JT02 | beanstalk |
| medic_antirad_2 | jitters | JT21 | jitters |
| medic_bandage_2 | jitters | JT05 | jitters |
| medic_bandage_3 | jitters | JT13 | jitters |
| medic_medkit_1 | jitters | JT01 | jitters |
| medic_medkit_2 | jitters | JT11 | jitters |
| medic_medkit_3 | jitters | JT15 | jitters |
| medic_medkit_4 | jitters | JT17 | jitters |
| medic_medkit_5 | jitters | JT19 | jitters |
| medic_medkit_6 | jitters | JT23 | jitters |
| medic_psyheal_1 | jitters | JT01 | beanstalk |
| miscaid_swampbrew | jitters | JT26 | local |
| attachment_steelplate_1 | latch | LA01 | local |
| attachment_steelplate_2 | latch | LA11 | local |
| attachment_steelplate_3 | latch | LA22 | local |
| bat | latch | LA06 | local |
| crowbar | latch | LA01 | local |
| drink_bottletea | latch | LA01 | atlas |
| drug_painkillers | latch | LA01 | jitters |
| fireaxe | latch | LA17 | local |
| food_can_beans | latch | LA01 | atlas |
| food_can_tushonka | latch | LA01 | ballast |
| food_raisins | latch | LA01 | atlas |
| fubar | latch | LA22 | local |
| sharpening_stone | latch | LA01 | old-timer |
| sledgehammer | latch | LA11 | local |
| value_tape_duct | latch | LA01 | carbon |
| backpack_sling | ledger | LE01 | suture |
| backpack_tourist | ledger | LE22 | suture |
| drink_bottletea | ledger | LE01 | atlas |
| food_bread | ledger | LE03 | ledger |
| food_can_beans | ledger | LE01 | atlas |
| food_can_tushonka | ledger | LE01 | ballast |
| food_raisins | ledger | LE01 | atlas |
| drink_bottletea | mute | MU01 | atlas |
| drug_caffeine | mute | MU01 | beanstalk |
| food_can_beans | mute | MU01 | atlas |
| food_raisins | mute | MU01 | atlas |
| pda | mute | MU01 | local |
| quest_flashdrive | mute | MU01 | local |
| value_9vbattery | mute | MU05 | mute |
| value_capacitors | mute | MU02 | mute |
| value_radio_repeater | mute | MU07 | mute |
| value_tape_electric | mute | MU04 | mute |
| 45acp41 | old-timer | OT15 | brass |
| 762x54 | old-timer | OT22 | brass |
| drink_bottletea | old-timer | OT01 | atlas |
| food_can_beans | old-timer | OT01 | atlas |
| food_raisins | old-timer | OT01 | atlas |
| hatchet | old-timer | OT01 | old-timer |
| ij600 | old-timer | OT11 | local |
| knife2 | old-timer | OT01 | old-timer |
| knife3 | old-timer | OT15 | old-timer |
| knife4 | old-timer | OT28 | old-timer |
| lowtiercookerfuel | old-timer | OT01 | gasket |
| m1887 | old-timer | OT21 | local |
| mossberg500 | old-timer | OT23 | local |
| mp27 | old-timer | OT13 | local |
| rem870ae | old-timer | OT26 | local |
| ruger1022 | old-timer | OT16 | local |
| sharpening_stone | old-timer | OT01 | old-timer |
| sharpening_stone_fine | old-timer | OT28 | old-timer |
| sks | old-timer | OT18 | local |
| toz106 | old-timer | OT01 | local |
| toz34 | old-timer | OT01 | old-timer |
| toz34short | old-timer | OT03 | local |
| toz34special | old-timer | OT28 | local |
| toz66 | old-timer | OT18 | local |
| toz66short | old-timer | OT06 | local |
| w9422 | old-timer | OT08 | local |
| 127x55 | quartermaster | QM21 | brass |
| 12gaugedt | quartermaster | QM10 | brass |
| 12gaugemg | quartermaster | QM10 | brass |
| 12gaugesg | quartermaster | QM10 | brass |
| 12gaugetr | quartermaster | QM10 | brass |
| 145x114 | quartermaster | QM23 | brass |
| 145x114ap | quartermaster | QM24 | brass |
| 145x114hp | quartermaster | QM24 | brass |
| 22lrap | quartermaster | QM02 | brass |
| 22lrhp | quartermaster | QM02 | brass |
| 338lapua | quartermaster | QM19 | brass |
| 338lapuaap | quartermaster | QM20 | brass |
| 338lapuahp | quartermaster | QM20 | brass |
| 357magnum | quartermaster | QM07 | brass |
| 357magnumap | quartermaster | QM08 | brass |
| 357magnumhp | quartermaster | QM08 | brass |
| 44magnum | quartermaster | QM07 | brass |
| 44magnumap | quartermaster | QM08 | brass |
| 44magnumhp | quartermaster | QM08 | brass |
| 45acp | quartermaster | QM05 | brass |
| 45acp41 | quartermaster | QM13 | brass |
| 45acpap | quartermaster | QM06 | brass |
| 45acphp | quartermaster | QM06 | brass |
| 500magnum | quartermaster | QM17 | brass |
| 500magnumap | quartermaster | QM18 | brass |
| 500magnumhp | quartermaster | QM18 | brass |
| 50ae | quartermaster | QM13 | brass |
| 50aeap | quartermaster | QM14 | brass |
| 50aehp | quartermaster | QM14 | brass |
| 545x39 | quartermaster | QM09 | brass |
| 545x39ap | quartermaster | QM10 | brass |
| 545x39hp | quartermaster | QM10 | brass |
| 556x45 | quartermaster | QM11 | brass |
| 556x45ap | quartermaster | QM12 | brass |
| 556x45hp | quartermaster | QM12 | brass |
| 57x28 | quartermaster | QM05 | brass |
| 57x28ap | quartermaster | QM06 | brass |
| 57x28hp | quartermaster | QM06 | brass |
| 700nitro | quartermaster | QM21 | brass |
| 762x25 | quartermaster | QM01 | brass |
| 762x25ap | quartermaster | QM02 | brass |
| 762x25hp | quartermaster | QM02 | brass |
| 762x39 | quartermaster | QM11 | brass |
| 762x39ap | quartermaster | QM12 | brass |
| 762x39hp | quartermaster | QM12 | brass |
| 762x51 | quartermaster | QM17 | brass |
| 762x51ap | quartermaster | QM18 | brass |
| 762x51hp | quartermaster | QM18 | brass |
| 762x54 | quartermaster | QM19 | brass |
| 762x54ap | quartermaster | QM20 | brass |
| 762x54hp | quartermaster | QM20 | brass |
| 93x64 | quartermaster | QM21 | brass |
| 9x18ap | quartermaster | QM04 | brass |
| 9x18hp | quartermaster | QM04 | brass |
| 9x19 | quartermaster | QM03 | brass |
| 9x19ap | quartermaster | QM04 | brass |
| 9x19hp | quartermaster | QM04 | brass |
| 9x21 | quartermaster | QM03 | brass |
| 9x21ap | quartermaster | QM04 | brass |
| 9x21hp | quartermaster | QM04 | brass |
| 9x39 | quartermaster | QM15 | brass |
| 9x39ap | quartermaster | QM16 | brass |
| 9x39hp | quartermaster | QM16 | brass |
| aek971 | quartermaster | QM18 | local |
| aimpoint | quartermaster | QM07 | local |
| ak12 | quartermaster | QM24 | local |
| ak74 | quartermaster | QM09 | local |
| akm | quartermaster | QM15 | local |
| aks74u | quartermaster | QM04 | local |
| an94k | quartermaster | QM23 | local |
| ar159mm | quartermaster | QM12 | local |
| aug | quartermaster | QM21 | local |
| drink_bottletea | quartermaster | QM01 | atlas |
| drug_painkillers | quartermaster | QM03 | jitters |
| eotech | quartermaster | QM09 | local |
| f2000 | quartermaster | QM22 | local |
| famas | quartermaster | QM17 | local |
| food_bread | quartermaster | QM03 | ledger |
| food_can_beans | quartermaster | QM01 | atlas |
| food_raisins | quartermaster | QM01 | atlas |
| g36c | quartermaster | QM20 | local |
| gepardpdw | quartermaster | QM07 | local |
| headwear_cs1 | quartermaster | QM10 | quartermaster |
| headwear_cs2 | quartermaster | QM12 | quartermaster |
| headwear_cs4 | quartermaster | QM16 | quartermaster |
| headwear_pracs | quartermaster | QM22 | quartermaster |
| headwear_psz12 | quartermaster | QM24 | quartermaster |
| headwear_riot | quartermaster | QM07 | quartermaster |
| headwear_screen | quartermaster | QM15 | quartermaster |
| helm_operator_nato | quartermaster | QM21 | quartermaster |
| helm_operator_rus_1 | quartermaster | QM13 | quartermaster |
| helm_operator_rus_2 | quartermaster | QM09 | quartermaster |
| helm_sphere08 | quartermaster | QM18 | quartermaster |
| helm_sphere12 | quartermaster | QM19 | quartermaster |
| helm_steel_arab | quartermaster | QM04 | quartermaster |
| helm_steel_ger | quartermaster | QM04 | quartermaster |
| helm_steel_rus | quartermaster | QM06 | quartermaster |
| helm_tanker | quartermaster | QM04 | quartermaster |
| hk416 | quartermaster | QM23 | local |
| kobra | quartermaster | QM05 | local |
| l85 | quartermaster | QM19 | local |
| lowtiercookerfuel | quartermaster | QM01 | gasket |
| lr300 | quartermaster | QM16 | local |
| m16a4 | quartermaster | QM15 | local |
| m1928 | quartermaster | QM13 | local |
| medic_antirad_1 | quartermaster | QM02 | beanstalk |
| medic_medkit_1 | quartermaster | QM01 | jitters |
| medic_medkit_2 | quartermaster | QM11 | jitters |
| medic_medkit_3 | quartermaster | QM15 | jitters |
| medic_medkit_4 | quartermaster | QM17 | jitters |
| medic_medkit_5 | quartermaster | QM19 | jitters |
| medic_medkit_6 | quartermaster | QM23 | jitters |
| microt1 | quartermaster | QM06 | local |
| mp40 | quartermaster | QM02 | local |
| mp5 | quartermaster | QM05 | local |
| mp9a1 | quartermaster | QM03 | local |
| p90 | quartermaster | QM14 | local |
| pp19 | quartermaster | QM10 | local |
| pp1901vityaz | quartermaster | QM11 | local |
| pp2000 | quartermaster | QM07 | local |
| rk95 | quartermaster | QM20 | local |
| sg552 | quartermaster | QM18 | local |
| sr2 | quartermaster | QM13 | local |
| suit_skat10 | quartermaster | QM04 | quartermaster |
| suit_skat9 | quartermaster | QM24 | quartermaster |
| ump45 | quartermaster | QM08 | local |
| acog | smartass | SM21 | smartass |
| cmore | smartass | SM10 | local |
| dataextractor | smartass | SM01 | local |
| drink_bottletea | smartass | SM01 | atlas |
| drink_energydrink_2 | smartass | SM01 | smartass |
| drug_caffeine | smartass | SM01 | beanstalk |
| food_can_beans | smartass | SM01 | atlas |
| food_raisins | smartass | SM01 | atlas |
| l115 | smartass | SM24 | local |
| m14 | smartass | SM07 | local |
| nightforce | smartass | SM24 | local |
| pso1 | smartass | SM15 | smartass |
| quest_computeraccess | smartass | SM20 | local |
| shortdot | smartass | SM18 | local |
| sv98 | smartass | SM01 | smartass |
| svd | smartass | SM13 | local |
| trg42 | smartass | SM01 | local |
| vss | smartass | SM18 | local |
| drink_bottlebeer_1 | spicy-lemon | SL17 | local |
| drink_bottlebeer_2 | spicy-lemon | SL15 | local |
| drink_bottlebeer_3 | spicy-lemon | SL10 | local |
| drink_bottlebeer_4 | spicy-lemon | SL07 | local |
| drink_bottlebeer_5 | spicy-lemon | SL16 | local |
| drink_bottlebeer_6 | spicy-lemon | SL13 | local |
| drink_bottletea | spicy-lemon | SL19 | atlas |
| drink_canbeer_1 | spicy-lemon | SL06 | local |
| drink_canbeer_2 | spicy-lemon | SL05 | local |
| drink_canbeer_3 | spicy-lemon | SL05 | local |
| drink_canbeer_4 | spicy-lemon | SL08 | local |
| drink_canbeer_5 | spicy-lemon | SL14 | local |
| drink_canbeer_6 | spicy-lemon | SL09 | local |
| drink_canwater | spicy-lemon | SL12 | local |
| drink_energydrink_1 | spicy-lemon | SL16 | local |
| drink_energydrink_2 | spicy-lemon | SL14 | smartass |
| drink_energydrink_3 | spicy-lemon | SL20 | local |
| drink_energydrink_4 | spicy-lemon | SL12 | local |
| drink_energydrink_5 | spicy-lemon | SL18 | local |
| drink_energydrink_6 | spicy-lemon | SL18 | local |
| drink_milk | spicy-lemon | SL15 | local |
| drink_milkold | spicy-lemon | SL02 | local |
| drink_moonshine | spicy-lemon | SL19 | local |
| drink_orangejuice | spicy-lemon | SL20 | local |
| drink_spirit_1 | spicy-lemon | SL25 | local |
| drink_spirit_2 | spicy-lemon | SL26 | local |
| drink_spirit_3 | spicy-lemon | SL26 | local |
| drink_vodka_1 | spicy-lemon | SL21 | local |
| drink_vodka_2 | spicy-lemon | SL20 | local |
| drink_vodka_3 | spicy-lemon | SL22 | local |
| drink_vodka_4 | spicy-lemon | SL23 | local |
| drink_vodka_5 | spicy-lemon | SL25 | local |
| drink_vodka_6 | spicy-lemon | SL23 | local |
| drink_wine | spicy-lemon | SL22 | local |
| drug_caffeine | spicy-lemon | SL01 | beanstalk |
| food_bread | spicy-lemon | SL03 | ledger |
| food_burger | spicy-lemon | SL01 | local |
| food_can_beans | spicy-lemon | SL04 | atlas |
| food_can_chilibeans | spicy-lemon | SL04 | local |
| food_can_corn | spicy-lemon | SL03 | local |
| food_can_olive | spicy-lemon | SL10 | local |
| food_can_sprats | spicy-lemon | SL13 | local |
| food_can_tomato | spicy-lemon | SL06 | local |
| food_can_tuna | spicy-lemon | SL08 | local |
| food_can_tushonka | spicy-lemon | SL10 | ballast |
| food_cheese_1 | spicy-lemon | SL11 | local |
| food_cheese_2 | spicy-lemon | SL13 | local |
| food_cheese_3 | spicy-lemon | SL17 | local |
| food_chocolate | spicy-lemon | SL21 | local |
| food_mre_russia | spicy-lemon | SL24 | local |
| food_mre_ukraine | spicy-lemon | SL23 | local |
| food_mre_usa | spicy-lemon | SL24 | local |
| food_nuts_1 | spicy-lemon | SL09 | local |
| food_nuts_2 | spicy-lemon | SL11 | local |
| food_oldmeat | spicy-lemon | SL01 | local |
| food_raisins | spicy-lemon | SL17 | atlas |
| food_sausage_1 | spicy-lemon | SL04 | local |
| food_sausage_2 | spicy-lemon | SL07 | local |
| hightiercooker | spicy-lemon | SL18 | local |
| lowtiercooker | spicy-lemon | SL26 | spicy-lemon |
| lowtiercookerfuel | spicy-lemon | SL09 | gasket |
| meal_bear | spicy-lemon | SL19 | local |
| meal_blinddog | spicy-lemon | SL04 | local |
| meal_bloodsucker | spicy-lemon | SL17 | local |
| meal_boar | spicy-lemon | SL06 | local |
| meal_burer | spicy-lemon | SL14 | local |
| meal_cat | spicy-lemon | SL08 | local |
| meal_chimera | spicy-lemon | SL25 | local |
| meal_controller | spicy-lemon | SL21 | local |
| meal_flesh | spicy-lemon | SL05 | local |
| meal_hellhound | spicy-lemon | SL23 | local |
| meal_human | spicy-lemon | SL01 | local |
| meal_karlik | spicy-lemon | SL18 | local |
| meal_pseudodog | spicy-lemon | SL10 | local |
| meal_pseudogiant | spicy-lemon | SL26 | local |
| meal_snork | spicy-lemon | SL15 | local |
| meal_spider | spicy-lemon | SL09 | local |
| meal_sprig | spicy-lemon | SL12 | local |
| meal_tark | spicy-lemon | SL13 | local |
| meal_tushkano | spicy-lemon | SL02 | local |
| meal_vareshka | spicy-lemon | SL22 | local |
| meat_bear | spicy-lemon | SL23 | local |
| meat_blinddog | spicy-lemon | SL04 | local |
| meat_bloodsucker | spicy-lemon | SL17 | local |
| meat_boar | spicy-lemon | SL05 | local |
| meat_burer | spicy-lemon | SL15 | local |
| meat_cat | spicy-lemon | SL09 | local |
| meat_chimera | spicy-lemon | SL21 | local |
| meat_controller | spicy-lemon | SL25 | local |
| meat_flesh | spicy-lemon | SL10 | local |
| meat_hellhound | spicy-lemon | SL22 | local |
| meat_human | spicy-lemon | SL01 | local |
| meat_karlik | spicy-lemon | SL14 | local |
| meat_pseudodog | spicy-lemon | SL13 | local |
| meat_pseudogiant | spicy-lemon | SL26 | local |
| meat_snork | spicy-lemon | SL18 | local |
| meat_spider | spicy-lemon | SL08 | local |
| meat_sprig | spicy-lemon | SL12 | local |
| meat_tark | spicy-lemon | SL06 | local |
| meat_tushkano | spicy-lemon | SL02 | local |
| meat_vareshka | spicy-lemon | SL19 | local |
| medic_bandage_1 | spicy-lemon | SL01 | local |
| waterflask | spicy-lemon | SL01 | local |
| cassette_bandits | spool | SO08 | local |
| cassette_barman | spool | SO08 | local |
| cassette_firelake | spool | SO08 | local |
| cassette_freedom | spool | SO08 | local |
| cassette_merc | spool | SO08 | local |
| cassette_standart | spool | SO08 | local |
| cassette_true | spool | SO08 | local |
| cassette_wickedrabbit | spool | SO08 | local |
| drink_bottletea | spool | SO01 | atlas |
| drug_caffeine | spool | SO01 | beanstalk |
| food_can_beans | spool | SO01 | atlas |
| food_raisins | spool | SO01 | atlas |
| rfreceiver | spool | SO01 | local |
| value_9vbattery | spool | SO01 | mute |
| value_capacitors | spool | SO03 | mute |
| value_radio_repeater | spool | SO04 | mute |
| value_tape_electric | spool | SO02 | mute |
| walkman | spool | SO01 | local |
| 12gaugedt | spoor | SP09 | brass |
| 12gaugemg | spoor | SP09 | brass |
| 12gaugesg | spoor | SP09 | brass |
| 12gaugetr | spoor | SP09 | brass |
| 22lrap | spoor | SP02 | brass |
| 22lrhp | spoor | SP02 | brass |
| 338lapua | spoor | SP17 | brass |
| 338lapuaap | spoor | SP18 | brass |
| 338lapuahp | spoor | SP18 | brass |
| 762x51 | spoor | SP15 | brass |
| 762x51ap | spoor | SP16 | brass |
| 762x51hp | spoor | SP16 | brass |
| 762x54 | spoor | SP17 | brass |
| 762x54ap | spoor | SP18 | brass |
| 762x54hp | spoor | SP18 | brass |
| acog | spoor | SP22 | smartass |
| binoculars_1 | spoor | SP22 | atlas |
| binoculars_2 | spoor | SP01 | atlas |
| drink_bottletea | spoor | SP01 | atlas |
| food_bread | spoor | SP03 | ledger |
| food_can_beans | spoor | SP01 | atlas |
| food_raisins | spoor | SP01 | atlas |
| lax44 | spoor | SP17 | local |
| lowtiercookerfuel | spoor | SP01 | gasket |
| machete | spoor | SP01 | local |
| mosin | spoor | SP15 | local |
| obrez | spoor | SP03 | local |
| pso1 | spoor | SP01 | smartass |
| saigasemi | spoor | SP13 | local |
| sako85 | spoor | SP20 | local |
| sako85nato | spoor | SP06 | local |
| sako85varmint | spoor | SP01 | local |
| sharpening_stone | spoor | SP01 | old-timer |
| sharpening_stone_fine | spoor | SP01 | old-timer |
| svt40 | spoor | SP22 | local |
| w1895 | spoor | SP08 | local |
| w9422357 | spoor | SP10 | local |
| attachment_carbonfibre | suture | SU17 | local |
| attachment_ceramicplate_1 | suture | SU01 | local |
| attachment_ceramicplate_2 | suture | SU08 | local |
| attachment_ceramicplate_3 | suture | SU21 | local |
| attachment_fabric_1 | suture | SU04 | local |
| attachment_fabric_2 | suture | SU11 | local |
| attachment_kevlar_1 | suture | SU14 | local |
| attachment_kevlar_2 | suture | SU24 | local |
| backpack_1 | suture | SU16 | suture |
| backpack_1_large | suture | SU21 | suture |
| backpack_2 | suture | SU19 | suture |
| backpack_2_large | suture | SU24 | suture |
| backpack_3 | suture | SU17 | suture |
| backpack_3_large | suture | SU22 | suture |
| backpack_mbss | suture | SU09 | suture |
| backpack_pilgrim | suture | SU13 | suture |
| backpack_scavbackpack | suture | SU14 | suture |
| backpack_sling | suture | SU01 | suture |
| backpack_takedown_1 | suture | SU06 | suture |
| backpack_takedown_2 | suture | SU08 | suture |
| backpack_tbag | suture | SU03 | suture |
| backpack_tourist | suture | SU04 | suture |
| backpack_vkbo | suture | SU11 | suture |
| drink_bottletea | suture | SU01 | atlas |
| food_can_beans | suture | SU01 | atlas |
| food_raisins | suture | SU01 | atlas |
| suit_anorak | suture | SU01 | suture |
| suit_cs1 | suture | SU24 | suture |
| suit_mailjacket | suture | SU07 | suture |
| suit_sunrise | suture | SU18 | suture |
| suit_trenchcoat_black | suture | SU13 | suture |
| suit_trenchcoat_brown | suture | SU01 | local |
| suit_trenchcoat_green | suture | SU13 | local |
| suit_trenchcoat_tan | suture | SU24 | local |
| value_tape_duct | suture | SU02 | carbon |
| attachment_aluframe | technut | TN01 | local |
| attachment_steelframe | technut | TN28 | local |
| drink_bottletea | technut | TN01 | atlas |
| food_can_beans | technut | TN01 | atlas |
| food_raisins | technut | TN01 | atlas |
| foregrip | technut | TN01 | local |
| 12gauge | the-original | OR09 | haggler |
| diecup | the-original | OR01 | local |
| drink_bottletea | the-original | OR01 | atlas |
| food_can_beans | the-original | OR01 | atlas |
| food_can_tushonka | the-original | OR01 | ballast |
| food_raisins | the-original | OR01 | atlas |
| guitar | the-original | OR01 | local |
| harmonica | the-original | OR24 | local |
| hide_bear | the-original | OR16 | local |
| hide_blinddog | the-original | OR02 | local |
| hide_bloodsucker | the-original | OR10 | local |
| hide_boar | the-original | OR05 | local |
| hide_burer | the-original | OR20 | local |
| hide_cat | the-original | OR09 | local |
| hide_chimera | the-original | OR14 | local |
| hide_controller | the-original | OR21 | local |
| hide_electrocontroller | the-original | OR23 | local |
| hide_flesh | the-original | OR04 | local |
| hide_karlik | the-original | OR18 | local |
| hide_pseudodog | the-original | OR06 | local |
| hide_pseudogiant | the-original | OR24 | local |
| hide_spider | the-original | OR11 | local |
| hide_sprig | the-original | OR15 | local |
| hide_swampcontroller | the-original | OR19 | local |
| hide_tark | the-original | OR07 | local |
| hide_tushkano | the-original | OR01 | local |
| hide_vareshka | the-original | OR13 | local |
| part_bear | the-original | OR20 | local |
| part_blinddog | the-original | OR02 | local |
| part_bloodsucker | the-original | OR12 | local |
| part_boar | the-original | OR03 | local |
| part_burer_1 | the-original | OR13 | local |
| part_burer_2 | the-original | OR21 | local |
| part_cat | the-original | OR07 | local |
| part_chimera | the-original | OR17 | local |
| part_controller_1 | the-original | OR18 | local |
| part_controller_2 | the-original | OR22 | local |
| part_electrocontroller_1 | the-original | OR24 | local |
| part_electrocontroller_2 | the-original | OR23 | local |
| part_flesh | the-original | OR05 | local |
| part_hellhound | the-original | OR11 | local |
| part_izlom | the-original | OR10 | local |
| part_karlik_1 | the-original | OR14 | local |
| part_karlik_2 | the-original | OR17 | local |
| part_pseudodog | the-original | OR08 | local |
| part_pseudogiant | the-original | OR23 | local |
| part_psydog | the-original | OR15 | local |
| part_skeleton | the-original | OR14 | local |
| part_snork_1 | the-original | OR08 | local |
| part_snork_2 | the-original | OR11 | local |
| part_spider | the-original | OR06 | local |
| part_sprig | the-original | OR09 | local |
| part_swampcontroller_1 | the-original | OR16 | local |
| part_swampcontroller_2 | the-original | OR20 | local |
| part_tark | the-original | OR05 | local |
| part_tushkano | the-original | OR01 | local |
| part_vareshka | the-original | OR19 | local |
| part_zombie_1 | the-original | OR02 | local |
| part_zombie_2 | the-original | OR04 | local |
| anomalydetector | vesper | VE01 | vesper |
| detectorbear | vesper | VE13 | egghead |
| detectorecho | vesper | VE01 | egghead |
| detectorveles | vesper | VE24 | egghead |
| drink_bottletea | vesper | VE01 | atlas |
| food_can_beans | vesper | VE01 | atlas |
| food_raisins | vesper | VE01 | atlas |
| medic_antirad_1 | vesper | VE03 | beanstalk |
| medic_antirad_2 | vesper | VE06 | jitters |
| medic_medkit_1 | vesper | VE01 | jitters |
| suit_wind | vesper | VE01 | vesper |
| backpack_sanitar | wake | WA04 | wake |
| drink_bottletea | wake | WA01 | atlas |
| drug_painkillers | wake | WA03 | jitters |
| food_can_beans | wake | WA01 | atlas |
| food_can_tushonka | wake | WA01 | ballast |
| food_raisins | wake | WA01 | atlas |
| medic_antirad_1 | wake | WA02 | beanstalk |
| medic_antirad_2 | wake | WA21 | jitters |
| medic_bandage_2 | wake | WA05 | jitters |
| medic_bandage_3 | wake | WA13 | jitters |
| medic_medkit_1 | wake | WA01 | jitters |
| medic_medkit_2 | wake | WA11 | jitters |
| medic_medkit_3 | wake | WA15 | jitters |
| medic_medkit_4 | wake | WA17 | jitters |
| medic_medkit_5 | wake | WA19 | jitters |
| medic_medkit_6 | wake | WA22 | jitters |

## Suit conversion unlocks

Both canonical base-suit and exact variant milestones are required.

| Variant | Contact | Milestone | Base suit |
| --- | --- | --- | --- |
| suit_anorak_anarchist | suture | SU07 | suit_anorak |
| suit_anorak_authority | suture | SU08 | suit_anorak |
| suit_anorak_ecologist | suture | SU09 | suit_anorak |
| suit_anorak_mercenary | suture | SU10 | suit_anorak |
| suit_anorak_scavenger | suture | SU11 | suit_anorak |
| suit_berill_anarchist | boss | BO17 | suit_berill |
| suit_berill_authority | boss | BO18 | suit_berill |
| suit_berill_ecologist | boss | BO19 | suit_berill |
| suit_berill_looted | boss | BO20 | suit_berill |
| suit_berill_mercenary | boss | BO21 | suit_berill |
| suit_berill_scavenger | boss | BO22 | suit_berill |
| suit_cs1_ecologist | technut | TN11 | suit_cs1 |
| suit_cs1_scavenger | technut | TN12 | suit_cs1 |
| suit_cs2_ecologist | technut | TN15 | suit_cs2 |
| suit_cs2_scavenger | technut | TN16 | suit_cs2 |
| suit_cs3_ecologist | technut | TN18 | suit_cs3 |
| suit_io7a_anarchist | boss | BO10 | suit_io7a |
| suit_io7a_authority | boss | BO11 | suit_io7a |
| suit_io7a_ecologist | boss | BO12 | suit_io7a |
| suit_io7a_fanatic | boss | BO13 | suit_io7a |
| suit_io7a_looted | boss | BO14 | suit_io7a |
| suit_io7a_mercenary | boss | BO15 | suit_io7a |
| suit_io7a_scavenger | boss | BO16 | suit_io7a |
| suit_mailjacket_anarchist | suture | SU09 | suit_mailjacket |
| suit_mailjacket_authority | suture | SU10 | suit_mailjacket |
| suit_mailjacket_ecologist | suture | SU11 | suit_mailjacket |
| suit_mailjacket_mercenary | suture | SU12 | suit_mailjacket |
| suit_mailjacket_scavenger | suture | SU13 | suit_mailjacket |
| suit_nbc_anarchist | beanstalk | BN16 | suit_nbc |
| suit_nbc_authority | beanstalk | BN17 | suit_nbc |
| suit_nbc_fanatic | beanstalk | BN18 | suit_nbc |
| suit_ps5m_anarchist | boss | BO14 | suit_ps5m |
| suit_ps5m_authority | boss | BO15 | suit_ps5m |
| suit_ps5m_ecologist | boss | BO16 | suit_ps5m |
| suit_ps5m_fanatic | boss | BO17 | suit_ps5m |
| suit_ps5m_mercenary | boss | BO18 | suit_ps5m |
| suit_seva_anarchist | egghead | EG21 | suit_seva |
| suit_seva_authority | egghead | EG22 | suit_seva |
| suit_seva_ecologist | egghead | EG23 | suit_seva |
| suit_seva_fanatic | egghead | EG24 | suit_seva |
| suit_seva_mercenary | egghead | EG25 | suit_seva |
| suit_skat10_anarchist | quartermaster | QM20 | suit_skat10 |
| suit_skat10_authority | quartermaster | QM21 | suit_skat10 |
| suit_skat10_ecologist | quartermaster | QM22 | suit_skat10 |
| suit_skat10_looted | quartermaster | QM23 | suit_skat10 |
| suit_skat10_mercenary | quartermaster | QM24 | suit_skat10 |
| suit_skat9_anarchist | quartermaster | QM19 | suit_skat9 |
| suit_skat9_authority | quartermaster | QM20 | suit_skat9 |
| suit_skat9_ecologist | quartermaster | QM21 | suit_skat9 |
| suit_skat9_fanatic | quartermaster | QM22 | suit_skat9 |
| suit_skat9_looted | quartermaster | QM23 | suit_skat9 |
| suit_skat9_scavenger | quartermaster | QM24 | suit_skat9 |
| suit_sunrise_anarchist | suture | SU11 | suit_sunrise |
| suit_sunrise_authority | suture | SU12 | suit_sunrise |
| suit_sunrise_fanatic | suture | SU13 | suit_sunrise |
| suit_sunrise_looted | suture | SU14 | suit_sunrise |
| suit_sunrise_mercenary | suture | SU15 | suit_sunrise |
| suit_sunrise_scavenger | suture | SU16 | suit_sunrise |
| suit_wind_anarchist | vesper | VE13 | suit_wind |
| suit_wind_authority | vesper | VE14 | suit_wind |
| suit_wind_fanatic | vesper | VE15 | suit_wind |
| suit_wind_looted | vesper | VE16 | suit_wind |

## Unimplemented unlock terms

Every entry has an adjacent TODO in its contact definition.

| ID | Kind | Intended effect | Proposed terms |
| --- | --- | --- | --- |
| atlas/AT08/future | passage | Optional Marsh–Garbage shortcut via Marsh survey trail; author distinct safe endpoints and permissions. | {"destination": "Garbage", "origin": "Marsh", "route": "Marsh survey trail"} |
| atlas/AT09/future | information | Persistent practical reference covering Marsh flooded detours; author actionable guidance tied to verified mechanics and locations. | {"topic": "Marsh flooded detours"} |
| atlas/AT10/future | information | Persistent practical reference covering Garbage eastern approaches; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage eastern approaches"} |
| atlas/AT11/future | information | Persistent practical reference covering Garbage western return route; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage western return route"} |
| atlas/AT12/future | passage | Optional Marsh–Garbage shortcut via Garbage overland detour; author distinct safe endpoints and permissions. | {"destination": "Garbage", "origin": "Marsh", "route": "Garbage overland detour"} |
| atlas/AT14/future | information | Persistent practical reference covering Waystation shelter approaches; author actionable guidance tied to verified mechanics and locations. | {"topic": "Waystation shelter approaches"} |
| atlas/AT15/future | information | Persistent practical reference covering Pripyat survey approaches; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat survey approaches"} |
| atlas/AT16/future | information | Persistent practical reference covering Pripyat retreat planning; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat retreat planning"} |
| atlas/AT18/future | passage | Optional Marsh–Garbage shortcut via Waystation survey approach; author distinct safe endpoints and permissions. | {"destination": "Garbage", "origin": "Marsh", "route": "Waystation survey approach"} |
| atlas/AT19/future | information | Persistent practical reference covering survey notebook comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "survey notebook comparison"} |
| atlas/AT21/future | information | Persistent practical reference covering seasonal route changes; author actionable guidance tied to verified mechanics and locations. | {"topic": "seasonal route changes"} |
| ballast/BA09/future | passage | Optional Marsh–Waystation shortcut via Marsh supply landing; author distinct safe endpoints and permissions. | {"destination": "Waystation", "origin": "Marsh", "route": "Marsh supply landing"} |
| ballast/BA11/future | information | Persistent reference on waterlogged cargo handling; author actionable guidance tied to verified mechanics and locations. | {"topic": "waterlogged cargo handling"} |
| ballast/BA12/future | information | Persistent reference on Marsh landing approaches; author actionable guidance tied to verified mechanics and locations. | {"topic": "Marsh landing approaches"} |
| ballast/BA13/future | information | Persistent reference on recovery load planning; author actionable guidance tied to verified mechanics and locations. | {"topic": "recovery load planning"} |
| ballast/BA14/future | passage | Optional Marsh–Waystation shortcut via abandoned boat landing; author distinct safe endpoints and permissions. | {"destination": "Waystation", "origin": "Marsh", "route": "abandoned boat landing"} |
| ballast/BA15/future | information | Persistent reference on abandoned boat register; author actionable guidance tied to verified mechanics and locations. | {"topic": "abandoned boat register"} |
| ballast/BA16/future | information | Persistent reference on shoreline hazard notes; author actionable guidance tied to verified mechanics and locations. | {"topic": "shoreline hazard notes"} |
| ballast/BA17/future | information | Persistent reference on disputed freight records; author actionable guidance tied to verified mechanics and locations. | {"topic": "disputed freight records"} |
| ballast/BA18/future | passage | Optional Marsh–Waystation shortcut via Waystation waterside approach; author distinct safe endpoints and permissions. | {"destination": "Waystation", "origin": "Marsh", "route": "Waystation waterside approach"} |
| ballast/BA19/future | information | Persistent reference on Garbage cargo connections; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage cargo connections"} |
| ballast/BA21/future | information | Persistent reference on Waystation cargo handover; author actionable guidance tied to verified mechanics and locations. | {"topic": "Waystation cargo handover"} |
| beanstalk/BN08/future | cosmetic | Apply environmental research colours to suit_anorak; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_anorak", "finish": "beanstalk-bn08"} |
| beanstalk/BN12/future | cosmetic | Apply environmental research colours to suit_mailjacket; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_mailjacket", "finish": "beanstalk-bn12"} |
| beanstalk/BN19/future | cosmetic | Apply environmental research colours to suit_sunrise; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_sunrise", "finish": "beanstalk-bn19"} |
| beanstalk/BN20/future | cosmetic | Apply environmental research colours to suit_io7a; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_io7a", "finish": "beanstalk-bn20"} |
| beanstalk/BN21/future | cosmetic | Apply environmental research colours to suit_cs1; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_cs1", "finish": "beanstalk-bn21"} |
| beanstalk/BN22/future | cosmetic | Apply environmental research colours to suit_ps5m; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_ps5m", "finish": "beanstalk-bn22"} |
| beanstalk/BN23/future | cosmetic | Apply environmental research colours to suit_nbc; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_nbc", "finish": "beanstalk-bn23"} |
| boss/BO06/future | passage | Optional Waystation–Pripyat operational passage; author endpoints and server permissions. | {"destination": "Pripyat", "origin": "Waystation", "route": "operations-extraction"} |
| boss/BO10/future | cosmetic | Apply an operations finish to the IO7a; appearance only, without suit variant stat changes. | {"baseSuit": "suit_io7a", "finish": "operations-field"} |
| brass/BR08/future | supplyExchange | Permanent offer for 12gauge; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 1}], "outputs": [{"item": "12gauge", "quantity": 1}]} |
| brass/BR10/future | supplyExchange | Permanent offer for 22lr; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 1}], "outputs": [{"item": "22lr", "quantity": 1}]} |
| brass/BR14/future | supplyExchange | Permanent offer for 9x18; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 1}], "outputs": [{"item": "9x18", "quantity": 1}]} |
| brass/BR16/future | supplyExchange | Permanent offer for 9x19; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 2}], "outputs": [{"item": "9x19", "quantity": 1}]} |
| brass/BR19/future | supplyExchange | Permanent offer for 545x39; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 2}], "outputs": [{"item": "545x39", "quantity": 1}]} |
| brass/BR20/future | supplyExchange | Permanent offer for 556x45; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 2}], "outputs": [{"item": "556x45", "quantity": 1}]} |
| brass/BR22/future | supplyExchange | Permanent offer for 762x39; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 3}], "outputs": [{"item": "762x39", "quantity": 1}]} |
| brass/BR23/future | supplyExchange | Permanent offer for 762x54; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 3}], "outputs": [{"item": "762x54", "quantity": 1}]} |
| carbon/CA07/future | information | Persistent practical reference covering Marsh maintenance chronology; author actionable guidance tied to verified mechanics and locations. | {"topic": "Marsh maintenance chronology"} |
| carbon/CA08/future | information | Persistent practical reference covering Garbage facility ownership; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage facility ownership"} |
| carbon/CA09/future | information | Persistent practical reference covering Waystation freight chronology; author actionable guidance tied to verified mechanics and locations. | {"topic": "Waystation freight chronology"} |
| carbon/CA10/future | information | Persistent practical reference covering Pripyat research chronology; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat research chronology"} |
| carbon/CA11/future | information | Persistent practical reference covering expedition roster comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "expedition roster comparison"} |
| carbon/CA12/future | information | Persistent practical reference covering equipment serial register; author actionable guidance tied to verified mechanics and locations. | {"topic": "equipment serial register"} |
| carbon/CA13/future | information | Persistent practical reference covering contamination report comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "contamination report comparison"} |
| carbon/CA14/future | information | Persistent practical reference covering power-network history; author actionable guidance tied to verified mechanics and locations. | {"topic": "power-network history"} |
| carbon/CA15/future | information | Persistent practical reference covering missing shipment index; author actionable guidance tied to verified mechanics and locations. | {"topic": "missing shipment index"} |
| carbon/CA16/future | information | Persistent practical reference covering facility shutdown records; author actionable guidance tied to verified mechanics and locations. | {"topic": "facility shutdown records"} |
| carbon/CA17/future | information | Persistent practical reference covering archive provenance guide; author actionable guidance tied to verified mechanics and locations. | {"topic": "archive provenance guide"} |
| carbon/CA18/future | information | Persistent practical reference covering conflicting witness register; author actionable guidance tied to verified mechanics and locations. | {"topic": "conflicting witness register"} |
| carbon/CA19/future | information | Persistent practical reference covering technical document cross-reference; author actionable guidance tied to verified mechanics and locations. | {"topic": "technical document cross-reference"} |
| carbon/CA21/future | information | Persistent practical reference covering recovered map annotations; author actionable guidance tied to verified mechanics and locations. | {"topic": "recovered map annotations"} |
| cleaner/CL08/future | storage | Unlock stored inventory width 3; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 3} |
| cleaner/CL10/future | storage | Unlock stored inventory height 3; preserve purchased space and contents, respect server dimension caps. | {"dimension": "height", "target": 3} |
| cleaner/CL11/future | storage | Unlock stored inventory width 4; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 4} |
| cleaner/CL12/future | storage | Unlock stored inventory height 4; preserve purchased space and contents, respect server dimension caps. | {"dimension": "height", "target": 4} |
| cleaner/CL13/future | storage | Unlock stored inventory width 5; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 5} |
| cleaner/CL15/future | storage | Unlock stored inventory height 5; preserve purchased space and contents, respect server dimension caps. | {"dimension": "height", "target": 5} |
| cleaner/CL16/future | storage | Unlock stored inventory width 6; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 6} |
| cleaner/CL17/future | storage | Unlock stored inventory height 6; preserve purchased space and contents, respect server dimension caps. | {"dimension": "height", "target": 6} |
| cleaner/CL18/future | storage | Unlock stored inventory width 7; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 7} |
| cleaner/CL19/future | storage | Unlock stored inventory height 7; preserve purchased space and contents, respect server dimension caps. | {"dimension": "height", "target": 7} |
| cleaner/CL20/future | storage | Unlock stored inventory width 8; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 8} |
| cleaner/CL21/future | storage | Unlock stored inventory height 8; preserve purchased space and contents, respect server dimension caps. | {"dimension": "height", "target": 8} |
| cleaner/CL22/future | storage | Unlock stored inventory width 9; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 9} |
| cleaner/CL23/future | storage | Unlock stored inventory width 10; preserve purchased space and contents, respect server dimension caps. | {"dimension": "width", "target": 10} |
| cleaner/CL24/future | information | Persistent practical guide to cache concealment; author verified instructions before activation. | {"topic": "cache concealment"} |
| cleaner/CL25/future | information | Persistent practical guide to dead-drop inspection; author verified instructions before activation. | {"topic": "dead-drop inspection"} |
| cleaner/CL26/future | information | Persistent practical guide to compromised stash recovery; author verified instructions before activation. | {"topic": "compromised stash recovery"} |
| cleaner/CL27/future | information | Persistent practical guide to secure packing; author verified instructions before activation. | {"topic": "secure packing"} |
| egghead/EG12/future | cosmetic | Apply artifact research colours to suit_anorak; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_anorak", "finish": "egghead-eg12"} |
| egghead/EG14/future | information | Persistent practical reference covering sample contamination; author actionable guidance tied to verified mechanics and locations. | {"topic": "sample contamination"} |
| egghead/EG16/future | information | Persistent practical reference covering detector comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "detector comparison"} |
| egghead/EG18/future | cosmetic | Apply artifact research colours to suit_io7a; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_io7a", "finish": "egghead-eg18"} |
| egghead/EG20/future | information | Persistent practical reference covering electrical anomaly notes; author actionable guidance tied to verified mechanics and locations. | {"topic": "electrical anomaly notes"} |
| egghead/EG24/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_capacitors", "quantity": 3}, {"item": "value_9vbattery", "quantity": 2}], "outputs": [{"item": "medic_psyheal_1", "quantity": 1}]} |
| gasket/GK11/future | supplyExchange | Permanent offer for lowtiercookerfuel; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 1}], "outputs": [{"item": "lowtiercookerfuel", "quantity": 1}]} |
| gasket/GK12/future | supplyExchange | Permanent offer for value_waterfilter; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 1}], "outputs": [{"item": "value_waterfilter", "quantity": 1}]} |
| gasket/GK13/future | supplyExchange | Permanent offer for value_kerosene; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 1}], "outputs": [{"item": "value_kerosene", "quantity": 1}]} |
| gasket/GK14/future | supplyExchange | Permanent offer for value_airfilter; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 2}], "outputs": [{"item": "value_airfilter", "quantity": 1}]} |
| gasket/GK15/future | supplyExchange | Permanent offer for value_sparkplug; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 2}], "outputs": [{"item": "value_sparkplug", "quantity": 1}]} |
| gasket/GK16/future | supplyExchange | Permanent offer for value_battery; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 2}], "outputs": [{"item": "value_battery", "quantity": 1}]} |
| gasket/GK17/future | supplyExchange | Permanent offer for value_9vbattery; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 3}], "outputs": [{"item": "value_9vbattery", "quantity": 1}]} |
| gasket/GK18/future | supplyExchange | Permanent offer for value_tape_electric; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 3}], "outputs": [{"item": "value_tape_electric", "quantity": 1}]} |
| gasket/GK19/future | supplyExchange | Permanent offer for value_dryfuel; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 3}], "outputs": [{"item": "value_dryfuel", "quantity": 1}]} |
| gasket/GK21/future | supplyExchange | Permanent offer for value_carbattery; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_kerosene", "quantity": 4}], "outputs": [{"item": "value_carbattery", "quantity": 1}]} |
| haggler/HG04/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 2}, {"item": "value_bolts", "quantity": 4}], "outputs": [{"item": "lowtiercooker", "quantity": 1}]} |
| haggler/HG12/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 2}, {"item": "value_bolts", "quantity": 4}], "outputs": [{"item": "brhp", "quantity": 1}]} |
| haggler/HG20/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 2}, {"item": "value_bolts", "quantity": 4}], "outputs": [{"item": "c96carbine", "quantity": 1}]} |
| intern/IN07/future | cosmetic | Apply survey team colours to suit_anorak; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_anorak", "finish": "intern-in07"} |
| intern/IN08/future | information | Persistent practical reference covering Marsh baseline readings; author actionable guidance tied to verified mechanics and locations. | {"topic": "Marsh baseline readings"} |
| intern/IN09/future | information | Persistent practical reference covering Garbage baseline readings; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage baseline readings"} |
| intern/IN10/future | cosmetic | Apply survey team colours to suit_io7a; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_io7a", "finish": "intern-in10"} |
| intern/IN11/future | information | Persistent practical reference covering Pripyat comparative readings; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat comparative readings"} |
| intern/IN12/future | information | Persistent practical reference covering sensor placement errors; author actionable guidance tied to verified mechanics and locations. | {"topic": "sensor placement errors"} |
| intern/IN13/future | cosmetic | Apply survey team colours to suit_nbc; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_nbc", "finish": "intern-in13"} |
| intern/IN14/future | information | Persistent practical reference covering exposure log comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "exposure log comparison"} |
| intern/IN16/future | information | Persistent practical reference covering conflicting measurement review; author actionable guidance tied to verified mechanics and locations. | {"topic": "conflicting measurement review"} |
| intern/IN17/future | cosmetic | Apply survey team colours to suit_mailjacket; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_mailjacket", "finish": "intern-in17"} |
| intern/IN18/future | information | Persistent practical reference covering instrument failure signatures; author actionable guidance tied to verified mechanics and locations. | {"topic": "instrument failure signatures"} |
| intern/IN19/future | information | Persistent practical reference covering return survey protocol; author actionable guidance tied to verified mechanics and locations. | {"topic": "return survey protocol"} |
| intern/IN20/future | cosmetic | Apply survey team colours to suit_cs1; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_cs1", "finish": "intern-in20"} |
| intern/IN21/future | information | Persistent practical reference covering late-expedition sensor drift; author actionable guidance tied to verified mechanics and locations. | {"topic": "late-expedition sensor drift"} |
| intern/IN22/future | information | Persistent practical reference covering research-team handover protocol; author actionable guidance tied to verified mechanics and locations. | {"topic": "research-team handover protocol"} |
| intern/IN23/future | cosmetic | Apply survey team colours to suit_seva; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_seva", "finish": "intern-in23"} |
| jitters/JT04/future | supplyExchange | Permanent offer for medic_bandage_1; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 1}], "outputs": [{"item": "medic_bandage_1", "quantity": 1}]} |
| jitters/JT07/future | supplyExchange | Permanent offer for drug_painkillers; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 1}], "outputs": [{"item": "drug_painkillers", "quantity": 1}]} |
| jitters/JT09/future | supplyExchange | Permanent offer for medic_medkit_1; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 1}], "outputs": [{"item": "medic_medkit_1", "quantity": 1}]} |
| jitters/JT10/future | supplyExchange | Permanent offer for medic_antirad_1; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 2}], "outputs": [{"item": "medic_antirad_1", "quantity": 1}]} |
| jitters/JT12/future | supplyExchange | Permanent offer for medic_bandage_2; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 2}], "outputs": [{"item": "medic_bandage_2", "quantity": 1}]} |
| jitters/JT14/future | supplyExchange | Permanent offer for medic_medkit_2; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 2}], "outputs": [{"item": "medic_medkit_2", "quantity": 1}]} |
| jitters/JT16/future | supplyExchange | Permanent offer for medic_bandage_3; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 3}], "outputs": [{"item": "medic_bandage_3", "quantity": 1}]} |
| jitters/JT18/future | supplyExchange | Permanent offer for medic_medkit_3; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 3}], "outputs": [{"item": "medic_medkit_3", "quantity": 1}]} |
| jitters/JT20/future | supplyExchange | Permanent offer for medic_antirad_2; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 3}], "outputs": [{"item": "medic_antirad_2", "quantity": 1}]} |
| jitters/JT22/future | supplyExchange | Permanent offer for medic_medkit_4; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 4}], "outputs": [{"item": "medic_medkit_4", "quantity": 1}]} |
| jitters/JT25/future | supplyExchange | Permanent offer for medic_medkit_5; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 4}], "outputs": [{"item": "medic_medkit_5", "quantity": 1}]} |
| jitters/JT26/future | supplyExchange | Permanent offer for medic_medkit_6; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 4}], "outputs": [{"item": "medic_medkit_6", "quantity": 1}]} |
| latch/LA11/future | barter | Permanent offer for sharpening_stone; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_bolts", "quantity": 1}, {"item": "value_screws", "quantity": 2}], "outputs": [{"item": "sharpening_stone", "quantity": 1}]} |
| latch/LA12/future | barter | Permanent offer for fireaxe; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_bolts", "quantity": 1}, {"item": "value_screws", "quantity": 3}], "outputs": [{"item": "fireaxe", "quantity": 1}]} |
| latch/LA15/future | barter | Permanent offer for lax410s; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_bolts", "quantity": 1}, {"item": "value_screws", "quantity": 4}], "outputs": [{"item": "lax410s", "quantity": 1}]} |
| latch/LA16/future | barter | Permanent offer for stoegerddshort; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_bolts", "quantity": 2}, {"item": "value_screws", "quantity": 5}], "outputs": [{"item": "stoegerddshort", "quantity": 1}]} |
| latch/LA17/future | barter | Permanent offer for m3supershort; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_bolts", "quantity": 2}, {"item": "value_screws", "quantity": 6}], "outputs": [{"item": "m3supershort", "quantity": 1}]} |
| latch/LA18/future | barter | Permanent offer for fubar; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_bolts", "quantity": 2}, {"item": "value_screws", "quantity": 7}], "outputs": [{"item": "fubar", "quantity": 1}]} |
| latch/LA19/future | barter | Permanent offer for sharpening_stone_fine; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_bolts", "quantity": 3}, {"item": "value_screws", "quantity": 8}], "outputs": [{"item": "sharpening_stone_fine", "quantity": 1}]} |
| ledger/LE07/future | passage | Optional Waystation–Garbage shortcut via settlement freight corridor; author distinct safe endpoints and permissions. | {"destination": "Garbage", "origin": "Waystation", "route": "settlement freight corridor"} |
| ledger/LE08/future | supplyExchange | Permanent offer for food_bread; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 1}], "outputs": [{"item": "food_bread", "quantity": 1}]} |
| ledger/LE09/future | supplyExchange | Permanent offer for drink_bottlewater; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 1}], "outputs": [{"item": "drink_bottlewater", "quantity": 1}]} |
| ledger/LE10/future | supplyExchange | Permanent offer for lowtiercookerfuel; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 2}], "outputs": [{"item": "lowtiercookerfuel", "quantity": 1}]} |
| ledger/LE11/future | passage | Optional Waystation–Garbage shortcut via recovered consignment corridor; author distinct safe endpoints and permissions. | {"destination": "Garbage", "origin": "Waystation", "route": "recovered consignment corridor"} |
| ledger/LE12/future | supplyExchange | Permanent offer for medic_bandage_1; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 2}], "outputs": [{"item": "medic_bandage_1", "quantity": 1}]} |
| ledger/LE13/future | supplyExchange | Permanent offer for food_raisins; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 3}], "outputs": [{"item": "food_raisins", "quantity": 1}]} |
| ledger/LE14/future | supplyExchange | Permanent offer for drink_bottletea; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 3}], "outputs": [{"item": "drink_bottletea", "quantity": 1}]} |
| ledger/LE15/future | passage | Optional Waystation–Garbage shortcut via remote cache corridor; author distinct safe endpoints and permissions. | {"destination": "Garbage", "origin": "Waystation", "route": "remote cache corridor"} |
| ledger/LE16/future | supplyExchange | Permanent offer for food_can_tushonka; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 4}], "outputs": [{"item": "food_can_tushonka", "quantity": 1}]} |
| ledger/LE17/future | supplyExchange | Permanent offer for food_nuts_2; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 4}], "outputs": [{"item": "food_nuts_2", "quantity": 1}]} |
| ledger/LE18/future | supplyExchange | Permanent offer for food_mre_russia; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 4}], "outputs": [{"item": "food_mre_russia", "quantity": 1}]} |
| ledger/LE19/future | passage | Optional Waystation–Garbage shortcut via expedition freight corridor; author distinct safe endpoints and permissions. | {"destination": "Garbage", "origin": "Waystation", "route": "expedition freight corridor"} |
| ledger/LE21/future | supplyExchange | Permanent offer for food_mre_ukraine; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_officepaper", "quantity": 5}], "outputs": [{"item": "food_mre_ukraine", "quantity": 1}]} |
| mute/MU10/future | information | Persistent reference on repeater identification; author actionable guidance tied to verified mechanics and locations. | {"topic": "repeater identification"} |
| mute/MU11/future | information | Persistent reference on coverage gap register; author actionable guidance tied to verified mechanics and locations. | {"topic": "coverage gap register"} |
| mute/MU12/future | information | Persistent reference on message authentication; author actionable guidance tied to verified mechanics and locations. | {"topic": "message authentication"} |
| mute/MU13/future | information | Persistent reference on lost operator records; author actionable guidance tied to verified mechanics and locations. | {"topic": "lost operator records"} |
| mute/MU14/future | information | Persistent reference on battery budgeting; author actionable guidance tied to verified mechanics and locations. | {"topic": "battery budgeting"} |
| mute/MU16/future | information | Persistent reference on interference signatures; author actionable guidance tied to verified mechanics and locations. | {"topic": "interference signatures"} |
| mute/MU17/future | information | Persistent reference on relay outage reports; author actionable guidance tied to verified mechanics and locations. | {"topic": "relay outage reports"} |
| mute/MU18/future | information | Persistent reference on emergency signal protocol; author actionable guidance tied to verified mechanics and locations. | {"topic": "emergency signal protocol"} |
| mute/MU19/future | information | Persistent reference on regional network comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "regional network comparison"} |
| mute/MU20/future | information | Persistent reference on intrusion incident records; author actionable guidance tied to verified mechanics and locations. | {"topic": "intrusion incident records"} |
| mute/MU21/future | information | Persistent reference on Pripyat signal notes; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat signal notes"} |
| mute/MU22/future | information | Persistent reference on operator handover procedure; author actionable guidance tied to verified mechanics and locations. | {"topic": "operator handover procedure"} |
| mute/MU23/future | information | Persistent reference on offline network recovery; author actionable guidance tied to verified mechanics and locations. | {"topic": "offline network recovery"} |
| old-timer/OT21/future | information | Persistent reference on quarry signs; author actionable guidance tied to verified mechanics and locations. | {"topic": "quarry signs"} |
| old-timer/OT22/future | information | Persistent reference on safe retreat planning; author actionable guidance tied to verified mechanics and locations. | {"topic": "safe retreat planning"} |
| old-timer/OT23/future | information | Persistent reference on wounded mutant trails; author actionable guidance tied to verified mechanics and locations. | {"topic": "wounded mutant trails"} |
| old-timer/OT24/future | information | Persistent reference on night hunting; author actionable guidance tied to verified mechanics and locations. | {"topic": "night hunting"} |
| old-timer/OT25/future | information | Persistent reference on companion expedition notes; author actionable guidance tied to verified mechanics and locations. | {"topic": "companion expedition notes"} |
| old-timer/OT26/future | information | Persistent reference on carcass handling; author actionable guidance tied to verified mechanics and locations. | {"topic": "carcass handling"} |
| old-timer/OT27/future | information | Persistent reference on Pripyat return preparation; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat return preparation"} |
| smartass/SM12/future | information | Persistent reference on computer type identification; author actionable guidance tied to verified mechanics and locations. | {"topic": "computer type identification"} |
| smartass/SM13/future | information | Persistent reference on flash drive provenance; author actionable guidance tied to verified mechanics and locations. | {"topic": "flash drive provenance"} |
| smartass/SM14/future | information | Persistent reference on data integrity checks; author actionable guidance tied to verified mechanics and locations. | {"topic": "data integrity checks"} |
| smartass/SM15/future | information | Persistent reference on terminal power failures; author actionable guidance tied to verified mechanics and locations. | {"topic": "terminal power failures"} |
| smartass/SM16/future | information | Persistent reference on archive access protocol; author actionable guidance tied to verified mechanics and locations. | {"topic": "archive access protocol"} |
| smartass/SM17/future | information | Persistent reference on cross-system file comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "cross-system file comparison"} |
| smartass/SM18/future | information | Persistent reference on damaged media handling; author actionable guidance tied to verified mechanics and locations. | {"topic": "damaged media handling"} |
| smartass/SM19/future | information | Persistent reference on field extraction precautions; author actionable guidance tied to verified mechanics and locations. | {"topic": "field extraction precautions"} |
| smartass/SM20/future | information | Persistent reference on research workstation records; author actionable guidance tied to verified mechanics and locations. | {"topic": "research workstation records"} |
| smartass/SM21/future | information | Persistent reference on log timestamp comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "log timestamp comparison"} |
| smartass/SM22/future | information | Persistent reference on Pripyat terminal reports; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat terminal reports"} |
| smartass/SM23/future | information | Persistent reference on forged file identification; author actionable guidance tied to verified mechanics and locations. | {"topic": "forged file identification"} |
| spicy-lemon/SL04/future | recipe | Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer. | {"fuel": {"item": "lowtiercookerfuel", "quantity": 1}, "inputs": [{"item": "meat_flesh", "quantity": 1}, {"item": "food_bread", "quantity": 1}], "output": {"item": "meal_flesh", "quantity": 1}} |
| spicy-lemon/SL08/future | recipe | Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer. | {"fuel": {"item": "lowtiercookerfuel", "quantity": 1}, "inputs": [{"item": "meat_boar", "quantity": 1}, {"item": "food_can_beans", "quantity": 1}], "output": {"item": "meal_boar", "quantity": 1}} |
| spicy-lemon/SL12/future | recipe | Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer. | {"fuel": {"item": "lowtiercookerfuel", "quantity": 1}, "inputs": [{"item": "meat_blinddog", "quantity": 1}, {"item": "food_can_tomato", "quantity": 1}], "output": {"item": "meal_blinddog", "quantity": 1}} |
| spicy-lemon/SL16/future | recipe | Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer. | {"fuel": {"item": "lowtiercookerfuel", "quantity": 1}, "inputs": [{"item": "meat_pseudodog", "quantity": 1}, {"item": "food_can_corn", "quantity": 1}], "output": {"item": "meal_pseudodog", "quantity": 1}} |
| spicy-lemon/SL20/future | recipe | Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer. | {"fuel": {"item": "lowtiercookerfuel", "quantity": 1}, "inputs": [{"item": "meat_bloodsucker", "quantity": 1}, {"item": "food_can_chilibeans", "quantity": 1}], "output": {"item": "meal_bloodsucker", "quantity": 1}} |
| spicy-lemon/SL24/future | recipe | Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer. | {"fuel": {"item": "lowtiercookerfuel", "quantity": 1}, "inputs": [{"item": "meat_chimera", "quantity": 1}, {"item": "food_can_tushonka", "quantity": 1}], "output": {"item": "meal_chimera", "quantity": 1}} |
| spool/SO07/future | information | Persistent reference on operator call-sign register; author actionable guidance tied to verified mechanics and locations. | {"topic": "operator call-sign register"} |
| spool/SO08/future | information | Persistent reference on Marsh relay bearings; author actionable guidance tied to verified mechanics and locations. | {"topic": "Marsh relay bearings"} |
| spool/SO09/future | information | Persistent reference on Garbage relay bearings; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage relay bearings"} |
| spool/SO10/future | information | Persistent reference on Waystation relay bearings; author actionable guidance tied to verified mechanics and locations. | {"topic": "Waystation relay bearings"} |
| spool/SO11/future | information | Persistent reference on Pripyat transmission bearings; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat transmission bearings"} |
| spool/SO12/future | information | Persistent reference on failed station chronology; author actionable guidance tied to verified mechanics and locations. | {"topic": "failed station chronology"} |
| spool/SO13/future | information | Persistent reference on missing operator recordings; author actionable guidance tied to verified mechanics and locations. | {"topic": "missing operator recordings"} |
| spool/SO14/future | information | Persistent reference on signal triangulation procedure; author actionable guidance tied to verified mechanics and locations. | {"topic": "signal triangulation procedure"} |
| spool/SO15/future | information | Persistent reference on antenna maintenance records; author actionable guidance tied to verified mechanics and locations. | {"topic": "antenna maintenance records"} |
| spool/SO16/future | information | Persistent reference on interference comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "interference comparison"} |
| spool/SO17/future | information | Persistent reference on emergency listening protocol; author actionable guidance tied to verified mechanics and locations. | {"topic": "emergency listening protocol"} |
| spool/SO18/future | information | Persistent reference on expedition radio checks; author actionable guidance tied to verified mechanics and locations. | {"topic": "expedition radio checks"} |
| spool/SO19/future | information | Persistent reference on recording provenance; author actionable guidance tied to verified mechanics and locations. | {"topic": "recording provenance"} |
| spool/SO21/future | information | Persistent reference on unidentified voice register; author actionable guidance tied to verified mechanics and locations. | {"topic": "unidentified voice register"} |
| spoor/SP03/future | information | Persistent practical reference covering blind dog feeding grounds; author actionable guidance tied to verified mechanics and locations. | {"topic": "blind dog feeding grounds"} |
| spoor/SP04/future | information | Persistent practical reference covering boar escape routes; author actionable guidance tied to verified mechanics and locations. | {"topic": "boar escape routes"} |
| spoor/SP15/future | information | Persistent practical reference covering flesh herd signs; author actionable guidance tied to verified mechanics and locations. | {"topic": "flesh herd signs"} |
| spoor/SP16/future | information | Persistent practical reference covering predator displacement; author actionable guidance tied to verified mechanics and locations. | {"topic": "predator displacement"} |
| spoor/SP21/future | information | Persistent practical reference covering bloodsucker warning signs; author actionable guidance tied to verified mechanics and locations. | {"topic": "bloodsucker warning signs"} |
| suture/SU04/future | cosmetic | Apply outfitter colours to suit_anorak; appearance only, with no gameplay variant changes. | {"baseSuit": "suit_anorak", "finish": "suture-su04"} |
| suture/SU08/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 3}, {"item": "value_bolts", "quantity": 2}], "outputs": [{"item": "backpack_sling", "quantity": 1}]} |
| suture/SU16/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 3}, {"item": "value_bolts", "quantity": 2}], "outputs": [{"item": "backpack_vkbo", "quantity": 1}]} |
| suture/SU22/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "value_tape_duct", "quantity": 3}, {"item": "value_bolts", "quantity": 2}], "outputs": [{"item": "backpack_1_large", "quantity": 1}]} |
| technut/TN10/future | information | Persistent workshop procedure guidance for Latch's Find; author specific, actionable checks before activation. | {} |
| the-original/OR08/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "part_blinddog", "quantity": 2}, {"item": "value_tape_duct", "quantity": 1}], "outputs": [{"item": "medic_bandage_1", "quantity": 1}]} |
| the-original/OR09/future | information | Persistent practical reference covering unusual tissue handling; author actionable guidance tied to verified mechanics and locations. | {"topic": "unusual tissue handling"} |
| the-original/OR10/future | information | Persistent practical reference covering predator adaptation notes; author actionable guidance tied to verified mechanics and locations. | {"topic": "predator adaptation notes"} |
| the-original/OR11/future | information | Persistent practical reference covering early expedition testimony; author actionable guidance tied to verified mechanics and locations. | {"topic": "early expedition testimony"} |
| the-original/OR12/future | information | Persistent practical reference covering mutant habitat comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "mutant habitat comparison"} |
| the-original/OR13/future | information | Persistent practical reference covering old encounter account; author actionable guidance tied to verified mechanics and locations. | {"topic": "old encounter account"} |
| the-original/OR14/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "part_boar", "quantity": 2}, {"item": "value_tape_duct", "quantity": 1}], "outputs": [{"item": "lowtiercookerfuel", "quantity": 1}]} |
| the-original/OR15/future | information | Persistent practical reference covering field kitchen safety; author actionable guidance tied to verified mechanics and locations. | {"topic": "field kitchen safety"} |
| the-original/OR16/future | information | Persistent practical reference covering survival equipment improvisation; author actionable guidance tied to verified mechanics and locations. | {"topic": "survival equipment improvisation"} |
| the-original/OR17/future | information | Persistent practical reference covering conflicting expedition stories; author actionable guidance tied to verified mechanics and locations. | {"topic": "conflicting expedition stories"} |
| the-original/OR18/future | information | Persistent practical reference covering rare mutation observations; author actionable guidance tied to verified mechanics and locations. | {"topic": "rare mutation observations"} |
| the-original/OR19/future | information | Persistent practical reference covering Pripyat specimen comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat specimen comparison"} |
| the-original/OR20/future | barter | Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value. | {"inputs": [{"item": "part_bloodsucker", "quantity": 2}, {"item": "value_tape_duct", "quantity": 1}], "outputs": [{"item": "medic_antirad_1", "quantity": 1}]} |
| the-original/OR21/future | information | Persistent field reference on specimen transport contamination; author practical, verified guidance. | {"topic": "specimen transport contamination"} |
| the-original/OR22/future | information | Persistent field reference on mutant seasonal displacement; author practical, verified guidance. | {"topic": "mutant seasonal displacement"} |
| the-original/OR23/future | information | Persistent field reference on early camp equipment accounts; author practical, verified guidance. | {"topic": "early camp equipment accounts"} |
| vesper/VE07/future | information | Persistent practical reference covering field boundary observations; author actionable guidance tied to verified mechanics and locations. | {"topic": "field boundary observations"} |
| vesper/VE08/future | information | Persistent practical reference covering detector preparation; author actionable guidance tied to verified mechanics and locations. | {"topic": "detector preparation"} |
| vesper/VE09/future | information | Persistent practical reference covering Marsh anomaly comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "Marsh anomaly comparison"} |
| vesper/VE10/future | information | Persistent practical reference covering Garbage anomaly comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage anomaly comparison"} |
| vesper/VE12/future | information | Persistent practical reference covering Waystation anomaly comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "Waystation anomaly comparison"} |
| vesper/VE17/future | information | Persistent practical reference covering Pripyat anomaly comparison; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat anomaly comparison"} |
| vesper/VE18/future | information | Persistent practical reference covering weather and visibility; author actionable guidance tied to verified mechanics and locations. | {"topic": "weather and visibility"} |
| vesper/VE20/future | information | Persistent practical reference covering survey withdrawal criteria; author actionable guidance tied to verified mechanics and locations. | {"topic": "survey withdrawal criteria"} |
| vesper/VE22/future | information | Persistent practical reference covering protective equipment checklist; author actionable guidance tied to verified mechanics and locations. | {"topic": "protective equipment checklist"} |
| vesper/VE23/future | information | Persistent practical reference covering artifact recovery notes; author actionable guidance tied to verified mechanics and locations. | {"topic": "artifact recovery notes"} |
| wake/WA07/future | supplyExchange | Unlock a repeatable exchange for medic_bandage_1; consume specified inputs on every exchange. | {"inputs": [{"item": "value_tape_duct", "quantity": 1}], "outputs": [{"item": "medic_bandage_1", "quantity": 1}]} |
| wake/WA08/future | information | Persistent practical reference covering personal effects identification; author actionable guidance tied to verified mechanics and locations. | {"topic": "personal effects identification"} |
| wake/WA09/future | information | Persistent practical reference covering failed convoy account; author actionable guidance tied to verified mechanics and locations. | {"topic": "failed convoy account"} |
| wake/WA10/future | supplyExchange | Unlock a repeatable exchange for medic_bandage_1; consume specified inputs on every exchange. | {"inputs": [{"item": "value_tape_duct", "quantity": 2}], "outputs": [{"item": "medic_bandage_1", "quantity": 1}]} |
| wake/WA12/future | information | Persistent practical reference covering Garbage recovery approaches; author actionable guidance tied to verified mechanics and locations. | {"topic": "Garbage recovery approaches"} |
| wake/WA14/future | information | Persistent practical reference covering Pripyat recovery approaches; author actionable guidance tied to verified mechanics and locations. | {"topic": "Pripyat recovery approaches"} |
| wake/WA16/future | supplyExchange | Unlock a repeatable exchange for medic_bandage_1; consume specified inputs on every exchange. | {"inputs": [{"item": "value_tape_duct", "quantity": 3}], "outputs": [{"item": "medic_bandage_1", "quantity": 1}]} |
