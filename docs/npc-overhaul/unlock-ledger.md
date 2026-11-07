# Current progression unlock ledger

Generated from authoritative town definitions and their compiled purchase prerequisites.
Regenerate: `python3 docs/npc-overhaul/tools/progression_rewards.py --write`.
Verify: `python3 docs/npc-overhaul/tools/progression_rewards.py --check`.

**600 active steps; 502 have functional unlocks; 38 have TODO-only unlock plans;
312 have multiple assigned unlocks; 60 have no assigned unlock.**

Purchase access is local to the seller. Canonical owners define equipment tier dependencies, not shared shop access.
Medicine uses local earlier-tier prerequisites. The approved plan has no starting sale supplies.
Stock values are total bonuses above the future base capacity, not additive grants or automatic refills.
Default vendor quantities, prices and refill policy are outside this allocation pass.

TODO entries are authoring metadata only: no entitlement, menu, payout or system is implemented for them.
Their proposed terms require implementation and balance review before activation. Existing cash and
service credits remain available; progression item gifts are disabled. Each active step grants an implemented unlock or completion cash.
TODO plans alone never satisfy reward coverage. Empty steps are reported without restoring excluded items. Each cosmetic finish remains appearance-only.

## Validation findings

This is a current-definition snapshot generated with `--write --allow-invalid`.
The runtime configuration has unresolved errors; `--check` remains strict.

- Progression cycle: cotz/town/spoor/SP07; remaining graph-dependent checks could not run

## Coverage by contact

| Contact | Steps | Functional coverage | Placeholder-only | Multiple unlocks |
| --- | ---: | ---: | ---: | ---: |
| arena-master | 0 | 0 | 0 | 0 |
| atlas | 22 | 19 | 0 | 13 |
| ballast | 22 | 22 | 0 | 15 |
| beanstalk | 24 | 24 | 0 | 22 |
| boss | 22 | 15 | 1 | 4 |
| brass | 24 | 24 | 0 | 17 |
| carbon | 22 | 15 | 3 | 12 |
| cleaner | 28 | 28 | 0 | 23 |
| egghead | 26 | 11 | 6 | 2 |
| gasket | 22 | 16 | 4 | 6 |
| haggler | 26 | 26 | 0 | 20 |
| intern | 24 | 23 | 1 | 20 |
| jitters | 26 | 22 | 1 | 16 |
| latch | 22 | 18 | 1 | 8 |
| ledger | 22 | 22 | 0 | 18 |
| mute | 24 | 8 | 10 | 4 |
| old-timer | 28 | 23 | 2 | 9 |
| quartermaster | 24 | 24 | 0 | 13 |
| smartass | 24 | 19 | 2 | 13 |
| spicy-lemon | 26 | 26 | 0 | 17 |
| spool | 22 | 20 | 1 | 15 |
| spoor | 22 | 22 | 0 | 12 |
| suture | 24 | 15 | 3 | 5 |
| technut | 28 | 25 | 0 | 4 |
| the-original | 0 | 0 | 0 | 0 |
| vesper | 24 | 18 | 3 | 14 |
| wake | 22 | 17 | 0 | 10 |

## Every progression step

| Contact | Step | Functional unlocks | TODO unlocks | Supplementary rewards |
| --- | --- | --- | --- | --- |
| atlas | AT01 | Purchase: backpack_sling; Purchase: binoculars_2; Purchase: geigercounter | — | 275 rubles |
| atlas | AT02 | — | — | 450 rubles |
| atlas | AT03 | Stock: geigercounter +1 total | — | 0 rubles |
| atlas | AT04 | Stock: backpack_sling +1 total | — | 650 rubles |
| atlas | AT05 | — | — | 575 rubles |
| atlas | AT06 | Purchase: backpack_duffle | — | 850 rubles |
| atlas | AT07 | Stock: backpack_duffle +1 total | — | 0 rubles |
| atlas | AT08 | Purchase: binoculars_1; Purchase: compass | Marsh survey trail | 1050 rubles |
| atlas | AT09 | Stock: compass +1 total | Record: Marsh flooded detours | 875 rubles |
| atlas | AT10 | Stock: binoculars_2 +1 total | Record: Garbage eastern approaches | 1250 rubles |
| atlas | AT11 | Purchase: backpack_sanitar; Stock: backpack_sanitar +1 total | Record: Garbage western return route | 0 rubles |
| atlas | AT12 | Stock: binoculars_1 +1 total | Garbage overland detour | 1450 rubles |
| atlas | AT13 | — | — | 1175 rubles |
| atlas | AT14 | Stock: geigercounter +2 total | Record: Waystation shelter approaches | 1650 rubles |
| atlas | AT15 | Purchase: anomalydetector; Purchase: binoculars_4; Stock: anomalydetector +1 total | Record: Pripyat survey approaches | 0 rubles |
| atlas | AT16 | Stock: binoculars_4 +1 total | Record: Pripyat retreat planning | 1850 rubles |
| atlas | AT17 | Purchase: backpack_tbag | — | 1475 rubles |
| atlas | AT18 | Stock: backpack_tbag +1 total | Waystation survey approach | 2050 rubles |
| atlas | AT19 | Stock: compass +2 total | Record: survey notebook comparison | 0 rubles |
| atlas | AT20 | Stock: backpack_duffle +2 total | — | 2250 rubles |
| atlas | AT21 | Stock: backpack_sanitar +2 total | Record: seasonal route changes | 1775 rubles |
| atlas | AT22 | Purchase: backpack_tourist; Purchase: binoculars_3; Purchase: gpstracker | — | 2450 rubles; Recognition: Atlas's trusted contact |
| ballast | BA01 | Purchase: drink_canbeer_2 | — | 275 rubles |
| ballast | BA02 | Purchase: drink_canbeer_1; Purchase: drink_canbeer_3 | — | 450 rubles |
| ballast | BA03 | Purchase: drink_bottlebeer_4; Stock: drink_canbeer_2 +1 total | — | 0 rubles |
| ballast | BA04 | Purchase: drink_canbeer_4 | — | 650 rubles |
| ballast | BA05 | Purchase: drink_bottlebeer_3; Purchase: drink_canbeer_6 | — | 575 rubles |
| ballast | BA06 | Purchase: drink_bottlebeer_6 | — | 850 rubles |
| ballast | BA07 | Purchase: drink_bottlebeer_2; Purchase: drink_canbeer_5; Stock: drink_canbeer_3 +1 total | — | 0 rubles |
| ballast | BA08 | Purchase: drink_bottlebeer_5 | — | 1050 rubles |
| ballast | BA09 | Purchase: drink_bottlebeer_1; Purchase: drink_moonshine | Marsh supply landing | 875 rubles |
| ballast | BA10 | Purchase: hidestasher_cutlery | — | 1250 rubles |
| ballast | BA11 | Purchase: crowbar; Purchase: drink_vodka_2; Stock: drink_canbeer_1 +1 total | Record: waterlogged cargo handling | 0 rubles |
| ballast | BA12 | Hideout storage access; Purchase: drink_vodka_1 | Record: Marsh landing approaches | 1450 rubles |
| ballast | BA13 | Purchase: bat | Record: recovery load planning | 1175 rubles |
| ballast | BA14 | Purchase: drink_vodka_3; Purchase: drink_wine | abandoned boat landing | 1650 rubles |
| ballast | BA15 | Purchase: drink_vodka_6; Stock: drink_bottlebeer_4 +1 total | Record: abandoned boat register | 0 rubles |
| ballast | BA16 | Purchase: drink_vodka_4; Purchase: sledgehammer | Record: shoreline hazard notes | 1850 rubles |
| ballast | BA17 | Purchase: fireaxe | Record: disputed freight records | 1475 rubles |
| ballast | BA18 | Purchase: hidestasher_cleaningkit | Waystation waterside approach | 2050 rubles |
| ballast | BA19 | Purchase: drink_spirit_1; Purchase: drink_vodka_5; Stock: drink_canbeer_4 +1 total | Record: Garbage cargo connections | 0 rubles |
| ballast | BA20 | Purchase: drink_spirit_2 | — | 2250 rubles |
| ballast | BA21 | Purchase: drink_spirit_3; Purchase: fubar | Record: Waystation cargo handover | 1775 rubles |
| ballast | BA22 | Purchase: hidestasher_shovel | — | 2450 rubles; Recognition: Ballast's trusted contact |
| beanstalk | BN01 | Purchase: 762x25; Purchase: 9x19; Purchase: suit_ssp99 | — | 275 rubles |
| beanstalk | BN02 | Purchase: 45acp; Purchase: 762x25hp; Purchase: 9x19hp | — | 450 rubles |
| beanstalk | BN03 | Purchase: 22lr; Purchase: 45acphp; Purchase: 762x25ap; Purchase: 9x19ap; Stock: 22lr +1 total | — | 0 rubles |
| beanstalk | BN04 | Purchase: 22lrhp; Purchase: 45acpap; Purchase: 545x39 | — | 650 rubles |
| beanstalk | BN05 | Purchase: 22lrap; Purchase: 545x39hp | — | 575 rubles |
| beanstalk | BN06 | Purchase: 545x39ap | — | 850 rubles |
| beanstalk | BN07 | Purchase: 762x39; Stock: 22lrap +1 total | — | 0 rubles |
| beanstalk | BN08 | Purchase: 556x45; Purchase: 762x39hp | Restocking: environmental research colours | 1050 rubles |
| beanstalk | BN09 | Purchase: 556x45hp; Purchase: 762x39ap; Purchase: 9x18 | — | 875 rubles |
| beanstalk | BN10 | Purchase: 556x45ap; Purchase: 762x54; Purchase: 9x18hp | — | 1250 rubles |
| beanstalk | BN11 | Purchase: 357magnum; Purchase: 762x54hp; Purchase: 9x18ap; Stock: 22lrhp +1 total | — | 0 rubles |
| beanstalk | BN12 | Purchase: 357magnumhp; Purchase: 762x54ap; Purchase: 9x39 | Restocking: environmental research colours | 1450 rubles |
| beanstalk | BN13 | Purchase: 357magnumap; Purchase: 44magnum; Purchase: 9x39hp; Purchase: suit_ssp99m | — | 1175 rubles |
| beanstalk | BN14 | Purchase: 44magnumhp; Purchase: 9x21; Purchase: 9x39ap | — | 1650 rubles |
| beanstalk | BN15 | Purchase: 44magnumap; Purchase: 762x51; Purchase: 9x21hp; Stock: 762x25 +1 total | — | 0 rubles |
| beanstalk | BN16 | Purchase: 500magnum; Purchase: 762x51hp; Purchase: 9x21ap | — | 1850 rubles |
| beanstalk | BN17 | Purchase: 338lapua; Purchase: 500magnumhp; Purchase: 762x51ap | — | 1475 rubles |
| beanstalk | BN18 | Purchase: 338lapuahp; Purchase: 500magnumap; Purchase: 50ae | — | 2050 rubles |
| beanstalk | BN19 | Purchase: 338lapuaap; Purchase: 50aehp; Purchase: 57x28; Stock: 762x25ap +1 total | Holding the Site: environmental research colours | 0 rubles |
| beanstalk | BN20 | Purchase: 127x55; Purchase: 50aeap; Purchase: 57x28hp | A full supply order: environmental research colours | 2250 rubles |
| beanstalk | BN21 | Purchase: 57x28ap | A Clean Comparison: environmental research colours | 1775 rubles |
| beanstalk | BN22 | Purchase: 93x64; Stock: 762x25hp +1 total | The Last Control: environmental research colours | 2450 rubles |
| beanstalk | BN23 | Stock: 9x18 +1 total | Findings Worth Keeping: environmental research colours | 0 rubles |
| beanstalk | BN24 | Purchase: suit_seva | — | 2650 rubles; Recognition: Beanstalk's trusted contact |
| boss | BO01 | Purchase: detectorecho; Purchase: helm_operator_rus_1; Purchase: mask_pmk3 | — | 275 rubles |
| boss | BO02 | Stock: detectorecho +1 total | — | 450 rubles |
| boss | BO03 | Stock: mask_pmk3 +1 total | — | 0 rubles |
| boss | BO04 | — | — | 650 rubles |
| boss | BO05 | Purchase: headwear_screen | — | 575 rubles |
| boss | BO06 | Stock: headwear_screen +1 total | Operational extraction passage | 850 rubles |
| boss | BO07 | Stock: helm_operator_rus_1 +1 total | — | 0 rubles |
| boss | BO08 | Purchase: mask_xm40 | — | 1050 rubles |
| boss | BO09 | Purchase: headwear_cs4 | — | 875 rubles |
| boss | BO10 | — | Operations field finish | 1250 rubles |
| boss | BO11 | Stock: headwear_cs4 +1 total | — | 0 rubles |
| boss | BO12 | — | — | 1450 rubles |
| boss | BO13 | — | — | 1175 rubles |
| boss | BO14 | Purchase: helm_sphere08 | — | 1650 rubles |
| boss | BO15 | Purchase: mask_m40; Stock: helm_sphere08 +1 total | — | 0 rubles |
| boss | BO16 | — | — | 1850 rubles |
| boss | BO17 | — | — | 1475 rubles |
| boss | BO18 | Purchase: helm_sphere12 | — | 2050 rubles |
| boss | BO19 | Stock: mask_xm40 +1 total | — | 0 rubles |
| boss | BO20 | Stock: helm_sphere12 +1 total | — | 2250 rubles |
| boss | BO21 | — | — | 1775 rubles |
| boss | BO22 | Purchase: helm_operator_nato; Purchase: mask_m50 | — | 2450 rubles; Recognition: Boss's trusted contact |
| brass | BR01 | Purchase: 762x25; Purchase: 9x19 | — | 275 rubles |
| brass | BR02 | Purchase: 45acp; Purchase: 762x25hp; Purchase: 9x19hp | — | 450 rubles |
| brass | BR03 | Purchase: 45acphp; Purchase: 762x25ap; Purchase: 9x19ap; Stock: 762x25 +1 total | — | 0 rubles |
| brass | BR04 | Purchase: 45acpap; Purchase: 545x39 | — | 650 rubles |
| brass | BR05 | Purchase: 545x39hp | — | 575 rubles |
| brass | BR06 | Purchase: 545x39ap | — | 850 rubles |
| brass | BR07 | Purchase: 762x39; Stock: 762x25ap +1 total | — | 0 rubles |
| brass | BR08 | Purchase: 762x39hp | Standing exchange: 12gauge | 1050 rubles |
| brass | BR09 | Purchase: 762x39ap; Purchase: 9x18 | — | 875 rubles |
| brass | BR10 | Purchase: 762x54; Purchase: 9x18hp | Standing exchange: 22lr | 1250 rubles |
| brass | BR11 | Purchase: 762x54hp; Purchase: 9x18ap; Stock: 762x25hp +1 total | — | 0 rubles |
| brass | BR12 | Purchase: 762x54ap | — | 1450 rubles |
| brass | BR13 | Purchase: 44magnum | — | 1175 rubles |
| brass | BR14 | Purchase: 44magnumhp; Purchase: 9x21 | Standing exchange: 9x18 | 1650 rubles |
| brass | BR15 | Purchase: 44magnumap; Purchase: 9x21hp; Stock: 9x18 +1 total | — | 0 rubles |
| brass | BR16 | Purchase: 9x21ap | Standing exchange: 9x19 | 1850 rubles |
| brass | BR17 | Stock: 9x18ap +1 total | — | 1475 rubles |
| brass | BR18 | Purchase: 50ae; Stock: 9x18hp +1 total | — | 2050 rubles |
| brass | BR19 | Purchase: 50aehp; Purchase: 57x28; Stock: 9x19 +1 total | Standing exchange: 545x39 | 0 rubles |
| brass | BR20 | Purchase: 50aeap; Purchase: 57x28hp | Standing exchange: 556x45 | 2250 rubles |
| brass | BR21 | Purchase: 57x28ap | — | 1775 rubles |
| brass | BR22 | Stock: 9x19ap +1 total | Standing exchange: 762x39 | 2450 rubles |
| brass | BR23 | Stock: 9x19hp +1 total | Standing exchange: 762x54 | 0 rubles |
| brass | BR24 | Stock: 9x21 +1 total | — | 2650 rubles; Recognition: Brass's trusted contact |
| carbon | CA01 | Purchase: headwear_pracs | — | 275 rubles |
| carbon | CA02 | — | — | 450 rubles |
| carbon | CA03 | Stock: headwear_pracs +1 total | — | 0 rubles |
| carbon | CA04 | Stock: headwear_pracs +2 total | — | 650 rubles |
| carbon | CA05 | — | — | 575 rubles |
| carbon | CA06 | — | — | 850 rubles |
| carbon | CA07 | Stock: headwear_pracs +3 total | Record: Marsh maintenance chronology | 0 rubles |
| carbon | CA08 | Purchase: attachment_aluframe | Record: Garbage facility ownership | 1050 rubles |
| carbon | CA09 | Stock: attachment_aluframe +1 total | Record: Waystation freight chronology | 875 rubles |
| carbon | CA10 | Stock: attachment_aluframe +2 total | Record: Pripyat research chronology | 1250 rubles |
| carbon | CA11 | Stock: attachment_aluframe +3 total | Record: expedition roster comparison | 0 rubles |
| carbon | CA12 | Purchase: accesscard_bunker | Record: equipment serial register | 1450 rubles |
| carbon | CA13 | Stock: accesscard_bunker +1 total | Record: contamination report comparison | 1175 rubles |
| carbon | CA14 | Stock: accesscard_bunker +2 total | Record: power-network history | 1650 rubles |
| carbon | CA15 | Purchase: attachment_carbonfibre; Stock: attachment_carbonfibre +1 total | Record: missing shipment index | 0 rubles |
| carbon | CA16 | Stock: attachment_carbonfibre +2 total | Record: facility shutdown records | 1850 rubles |
| carbon | CA17 | — | Record: archive provenance guide | 1475 rubles |
| carbon | CA18 | — | Record: conflicting witness register | 2050 rubles |
| carbon | CA19 | Stock: accesscard_bunker +3 total | Record: technical document cross-reference | 0 rubles |
| carbon | CA20 | — | — | 2250 rubles |
| carbon | CA21 | — | Record: recovered map annotations | 1775 rubles |
| carbon | CA22 | Purchase: attachment_steelframe; Purchase: headwear_psz12 | — | 2450 rubles; Recognition: Carbon's trusted contact |
| cleaner | CL01 | Purchase: sten | — | 275 rubles |
| cleaner | CL02 | Purchase: ppsh | — | 450 rubles |
| cleaner | CL03 | Purchase: mac11; Stock: sten +1 total | — | 0 rubles |
| cleaner | CL04 | Purchase: kiparis; Purchase: skorpion | — | 650 rubles |
| cleaner | CL05 | Purchase: mp34 | — | 575 rubles |
| cleaner | CL06 | Purchase: glock18 | — | 850 rubles |
| cleaner | CL07 | Purchase: mp40; Stock: ppsh +1 total | — | 0 rubles |
| cleaner | CL08 | Purchase: stechaps | Stored inventory width 3 | 1050 rubles |
| cleaner | CL09 | Purchase: mp18; Purchase: uzi | — | 875 rubles |
| cleaner | CL10 | Purchase: mp5k | Stored inventory height 3 | 1250 rubles |
| cleaner | CL11 | Purchase: kp31; Stock: mac11 +1 total | Stored inventory width 4 | 0 rubles |
| cleaner | CL12 | Purchase: sterling | Stored inventory height 4 | 1450 rubles |
| cleaner | CL13 | Purchase: mp9a1 | Stored inventory width 5 | 1175 rubles |
| cleaner | CL14 | Carried capacity: +1 rows; Purchase: aks74u | — | 1650 rubles |
| cleaner | CL15 | Purchase: deagle; Purchase: mp5; Stock: skorpion +1 total | Stored inventory height 5 | 0 rubles |
| cleaner | CL16 | Purchase: deagle44 | Stored inventory width 6 | 1850 rubles |
| cleaner | CL17 | Purchase: pp2000 | Stored inventory height 6 | 1475 rubles |
| cleaner | CL18 | Purchase: gepardpdw | Stored inventory width 7 | 2050 rubles |
| cleaner | CL19 | Purchase: ump45; Stock: kiparis +1 total | Stored inventory height 7 | 0 rubles |
| cleaner | CL20 | Purchase: ak74; Purchase: pp19 | Stored inventory width 8 | 2250 rubles |
| cleaner | CL21 | Purchase: saigasemi545 | Stored inventory height 8 | 1775 rubles |
| cleaner | CL22 | Purchase: fiveseven | Stored inventory width 9 | 2450 rubles |
| cleaner | CL23 | Purchase: pp1901vityaz; Stock: mp34 +1 total | Stored inventory width 10 | 0 rubles |
| cleaner | CL24 | Purchase: ar159mm | Record: cache concealment | 2650 rubles |
| cleaner | CL25 | Purchase: m1928; Purchase: sr2 | Record: dead-drop inspection | 2000 rubles |
| cleaner | CL26 | Purchase: p90 | Record: compromised stash recovery | 2850 rubles |
| cleaner | CL27 | Purchase: akm; Stock: glock18 +1 total | Record: secure packing | 0 rubles |
| cleaner | CL28 | Purchase: m1911chic | — | 3000 rubles; Recognition: Cleaner's trusted contact |
| egghead | EG01 | Purchase: detectorbear; Purchase: medic_antipsychotic_3; Purchase: medic_bandage_3; Purchase: medic_medkit_5; Purchase: medic_psyheal_2; Purchase: medic_stimpak_1 | — | 275 rubles |
| egghead | EG02 | — | — | 450 rubles |
| egghead | EG03 | Stock: medic_bandage_3 +1 total | — | 0 rubles |
| egghead | EG04 | — | — | 650 rubles |
| egghead | EG05 | — | — | 575 rubles |
| egghead | EG06 | Stock: medic_stimpak_1 +1 total | — | 850 rubles |
| egghead | EG07 | Stock: medic_psyheal_2 +1 total | — | 0 rubles |
| egghead | EG08 | — | — | 1050 rubles |
| egghead | EG09 | — | — | 875 rubles |
| egghead | EG10 | Stock: medic_medkit_5 +1 total | — | 1250 rubles |
| egghead | EG11 | Stock: medic_antipsychotic_3 +1 total | — | 0 rubles |
| egghead | EG12 | — | Restocking: artifact research colours | 1450 rubles |
| egghead | EG13 | Purchase: medic_stimpak_2 | — | 1175 rubles |
| egghead | EG14 | — | Record: sample contamination | 1650 rubles |
| egghead | EG15 | Stock: medic_stimpak_2 +1 total | — | 0 rubles |
| egghead | EG16 | — | Record: detector comparison | 1850 rubles |
| egghead | EG17 | — | — | 1475 rubles |
| egghead | EG18 | — | The Pripyat Baseline: artifact research colours | 2050 rubles |
| egghead | EG19 | Stock: detectorbear +1 total | — | 0 rubles |
| egghead | EG20 | — | Record: electrical anomaly notes | 2250 rubles |
| egghead | EG21 | — | — | 1775 rubles |
| egghead | EG22 | — | — | 2450 rubles |
| egghead | EG23 | Stock: medic_bandage_3 +2 total | — | 0 rubles |
| egghead | EG24 | — | medic_psyheal_1 exchange | 2650 rubles |
| egghead | EG25 | — | — | 2000 rubles |
| egghead | EG26 | Purchase: detectorveles; Purchase: medic_medkit_6; Purchase: medic_stimpak_3 | — | 2850 rubles; Recognition: Egghead's trusted contact |
| gasket | GK01 | Purchase: flashlight | — | 275 rubles |
| gasket | GK02 | Stock: flashlight +1 total | — | 450 rubles |
| gasket | GK03 | Stock: flashlight +2 total | — | 0 rubles |
| gasket | GK04 | — | — | 650 rubles |
| gasket | GK05 | Purchase: lowtiercookerfuel | — | 575 rubles |
| gasket | GK06 | Stock: lowtiercookerfuel +1 total | — | 850 rubles |
| gasket | GK07 | Stock: lowtiercookerfuel +2 total | — | 0 rubles |
| gasket | GK08 | — | — | 1050 rubles |
| gasket | GK09 | Purchase: headlamp | — | 875 rubles |
| gasket | GK10 | Stock: headlamp +1 total | — | 1250 rubles |
| gasket | GK11 | Stock: headlamp +2 total | Standing exchange: lowtiercookerfuel | 0 rubles |
| gasket | GK12 | — | Standing exchange: value_waterfilter | 1450 rubles |
| gasket | GK13 | — | Standing exchange: value_kerosene | 1175 rubles |
| gasket | GK14 | Purchase: hightiercooker | Standing exchange: value_airfilter | 1650 rubles |
| gasket | GK15 | Stock: hightiercooker +1 total | Standing exchange: value_sparkplug | 0 rubles |
| gasket | GK16 | — | Standing exchange: value_battery | 1850 rubles |
| gasket | GK17 | Stock: hightiercooker +2 total | Standing exchange: value_9vbattery | 1475 rubles |
| gasket | GK18 | Purchase: lowtiercooker | Standing exchange: value_tape_electric | 2050 rubles |
| gasket | GK19 | Stock: lowtiercooker +1 total | Standing exchange: value_dryfuel | 0 rubles |
| gasket | GK20 | Stock: lowtiercooker +2 total | — | 2250 rubles |
| gasket | GK21 | — | Standing exchange: value_carbattery | 1775 rubles |
| gasket | GK22 | Purchase: value_kerosene | — | 2450 rubles; Recognition: Gasket's trusted contact |
| haggler | HG01 | Purchase: 762x25; Purchase: nagantrev | — | 275 rubles |
| haggler | HG02 | Purchase: 9x19; Purchase: g2contender; Purchase: tokarev | — | 450 rubles |
| haggler | HG03 | Purchase: 45acp; Purchase: m1917; Stock: nagantrev +1 total | — | 0 rubles |
| haggler | HG04 | Purchase: 22lr; Purchase: brhp; Purchase: makarov | lowtiercooker exchange | 650 rubles |
| haggler | HG05 | Purchase: cz52 | — | 575 rubles |
| haggler | HG06 | Purchase: fort12 | — | 850 rubles |
| haggler | HG07 | Purchase: 45acp41; Purchase: beretta92; Purchase: rugermk3; Stock: 22lr +1 total | — | 0 rubles |
| haggler | HG08 | Purchase: 762x39; Purchase: c96 | — | 1050 rubles |
| haggler | HG09 | Purchase: 556x45; Purchase: lugerp08; Purchase: p99 | — | 875 rubles |
| haggler | HG10 | Purchase: 9x18; Purchase: sako85varmint | — | 1250 rubles |
| haggler | HG11 | Purchase: 762x54; Purchase: glock17; Purchase: w9422; Stock: 762x25 +1 total | — | 0 rubles |
| haggler | HG12 | Purchase: 357magnum; Purchase: m1911 | brhp exchange | 1450 rubles |
| haggler | HG13 | Purchase: c96carbine; Purchase: ruger1022 | — | 1175 rubles |
| haggler | HG14 | Purchase: 44magnum; Purchase: taurusjudge | — | 1650 rubles |
| haggler | HG15 | Purchase: obrez; Stock: 45acp41 +1 total | — | 0 rubles |
| haggler | HG16 | Purchase: 762x51; Purchase: g2contender500; Purchase: obrezmalfunction | — | 1850 rubles |
| haggler | HG17 | Purchase: 500magnum; Purchase: mr96 | — | 1475 rubles |
| haggler | HG18 | Purchase: swmodel29; Purchase: swr8 | — | 2050 rubles |
| haggler | HG19 | Purchase: rugermini14; Stock: 9x18 +1 total | — | 0 rubles |
| haggler | HG20 | Purchase: sako85nato; Purchase: sks | c96carbine exchange | 2250 rubles |
| haggler | HG21 | Purchase: taurusragingbull | — | 1775 rubles |
| haggler | HG22 | Purchase: mateba | — | 2450 rubles |
| haggler | HG23 | Purchase: sw500; Purchase: w1895; Stock: g2contender +1 total | — | 0 rubles |
| haggler | HG24 | Purchase: w9422357 | — | 2650 rubles |
| haggler | HG25 | Purchase: lax44; Purchase: mosin | — | 2000 rubles |
| haggler | HG26 | Purchase: sako85 | — | 2850 rubles; Recognition: Haggler's trusted contact |
| intern | IN01 | Purchase: 545x39 | — | 275 rubles |
| intern | IN02 | Purchase: 545x39hp | — | 450 rubles |
| intern | IN03 | Purchase: 545x39ap; Purchase: 762x39; Stock: 545x39 +1 total | — | 0 rubles |
| intern | IN04 | Purchase: 556x45; Purchase: 762x39hp | — | 650 rubles |
| intern | IN05 | Purchase: 556x45hp; Purchase: 762x39ap | — | 575 rubles |
| intern | IN06 | Purchase: 556x45ap; Purchase: 762x54 | — | 850 rubles |
| intern | IN07 | Purchase: 762x54hp; Stock: 545x39ap +1 total | Same Place Same Method: survey team colours | 0 rubles |
| intern | IN08 | Purchase: 762x54ap; Purchase: 9x39 | Record: Marsh baseline readings | 1050 rubles |
| intern | IN09 | Purchase: 9x39hp | Record: Garbage baseline readings | 875 rubles |
| intern | IN10 | Purchase: 9x39ap | The Senior's Notebook: survey team colours | 1250 rubles |
| intern | IN11 | Purchase: 762x51; Stock: 545x39hp +1 total | Record: Pripyat comparative readings | 0 rubles |
| intern | IN12 | Purchase: 762x51hp | Record: sensor placement errors | 1450 rubles |
| intern | IN13 | Purchase: 338lapua; Purchase: 762x51ap | Ready for the Distance: survey team colours | 1175 rubles |
| intern | IN14 | Purchase: 338lapuahp | Record: exposure log comparison | 1650 rubles |
| intern | IN15 | Computer access; Purchase: 338lapuaap; Stock: 556x45 +1 total | — | 0 rubles |
| intern | IN16 | Stock: 556x45ap +1 total | Record: conflicting measurement review | 1850 rubles |
| intern | IN17 | Stock: 556x45hp +1 total | Without Missing Pages: survey team colours | 1475 rubles |
| intern | IN18 | — | Record: instrument failure signatures | 2050 rubles |
| intern | IN19 | Stock: 762x39 +1 total | Record: return survey protocol | 0 rubles |
| intern | IN20 | Stock: 762x39ap +1 total | Building the reserve: survey team colours | 2250 rubles |
| intern | IN21 | Stock: 762x39hp +1 total | Record: late-expedition sensor drift | 1775 rubles |
| intern | IN22 | Stock: 9x39 +1 total | Record: research-team handover protocol | 2450 rubles |
| intern | IN23 | Stock: 9x39ap +1 total | Put My Name on It: survey team colours | 0 rubles |
| intern | IN24 | Purchase: accesscard_laboratory | — | 2650 rubles; Recognition: Intern's trusted contact |
| jitters | JT01 | Purchase: drug_cigarette_1; Purchase: medic_antirad_1; Purchase: medic_bandage_1; Purchase: medic_medkit_1 | — | 275 rubles |
| jitters | JT02 | — | — | 450 rubles |
| jitters | JT03 | Purchase: drug_cigarette_2; Stock: medic_bandage_1 +1 total | — | 0 rubles |
| jitters | JT04 | Stock: drug_cigarette_1 +1 total | Standing exchange: medic_bandage_1 | 650 rubles |
| jitters | JT05 | — | — | 575 rubles |
| jitters | JT06 | Purchase: drug_mints | — | 850 rubles |
| jitters | JT07 | Stock: drug_cigarette_2 +1 total | Standing exchange: drug_painkillers | 0 rubles |
| jitters | JT08 | treatment discount: 5% | — | 1050 rubles |
| jitters | JT09 | Purchase: drug_cigarette_3 | Standing exchange: medic_medkit_1 | 875 rubles |
| jitters | JT10 | Stock: drug_mints +1 total | Standing exchange: medic_antirad_1 | 1250 rubles |
| jitters | JT11 | Purchase: drug_painkillers; Stock: drug_cigarette_3 +1 total | — | 0 rubles |
| jitters | JT12 | Stock: drug_painkillers +1 total | Standing exchange: medic_bandage_2 | 1450 rubles |
| jitters | JT13 | Purchase: drug_cigarette_5 | — | 1175 rubles |
| jitters | JT14 | Stock: medic_medkit_1 +1 total | Standing exchange: medic_medkit_2 | 1650 rubles |
| jitters | JT15 | Stock: drug_cigarette_5 +1 total | — | 0 rubles |
| jitters | JT16 | Purchase: drug_cigarette_4 | Standing exchange: medic_bandage_3 | 1850 rubles |
| jitters | JT17 | — | — | 1475 rubles |
| jitters | JT18 | Stock: drug_cigarette_4 +1 total | Standing exchange: medic_medkit_3 | 2050 rubles |
| jitters | JT19 | Purchase: drug_cigar; Stock: medic_antirad_1 +1 total | — | 0 rubles |
| jitters | JT20 | — | Standing exchange: medic_antirad_2 | 2250 rubles |
| jitters | JT21 | Purchase: drug_cigarette_6 | — | 1775 rubles |
| jitters | JT22 | Stock: drug_cigar +1 total | Standing exchange: medic_medkit_4 | 2450 rubles |
| jitters | JT23 | Purchase: drug_tobacco_1; Stock: drug_cigarette_6 +1 total | — | 0 rubles |
| jitters | JT24 | treatment discount: 10% | — | 2650 rubles |
| jitters | JT25 | Stock: drug_tobacco_1 +1 total | Standing exchange: medic_medkit_5 | 2000 rubles |
| jitters | JT26 | Purchase: drug_tobacco_2; Purchase: medic_medkit_2 | Standing exchange: medic_medkit_6 | 2850 rubles; Recognition: Jitters's trusted contact |
| latch | LA01 | Purchase: attachment_ceramicplate_1; Purchase: mask_cloth | — | 275 rubles |
| latch | LA02 | Stock: mask_cloth +1 total | — | 450 rubles |
| latch | LA03 | Stock: attachment_ceramicplate_1 +1 total | — | 0 rubles |
| latch | LA04 | Stock: mask_cloth +2 total | — | 650 rubles |
| latch | LA05 | Stock: attachment_ceramicplate_1 +2 total | — | 575 rubles |
| latch | LA06 | Purchase: mask_halfmask | — | 850 rubles |
| latch | LA07 | Stock: mask_halfmask +1 total | — | 0 rubles |
| latch | LA08 | Carried capacity: +1 weight | — | 1050 rubles |
| latch | LA09 | Stock: mask_halfmask +2 total | — | 875 rubles |
| latch | LA10 | — | — | 1250 rubles |
| latch | LA11 | Purchase: attachment_steelplate_1; Purchase: mask_respirator; Stock: attachment_steelplate_1 +1 total | Standing exchange: sharpening_stone | 0 rubles |
| latch | LA12 | Stock: mask_respirator +1 total | Standing exchange: fireaxe | 1450 rubles |
| latch | LA13 | Stock: attachment_steelplate_1 +2 total | — | 1175 rubles |
| latch | LA14 | Carried capacity: +1 weight | — | 1650 rubles |
| latch | LA15 | Stock: mask_respirator +2 total | Standing exchange: lax410s | 0 rubles |
| latch | LA16 | — | Standing exchange: stoegerddshort | 1850 rubles |
| latch | LA17 | Purchase: mask_gp5 | Standing exchange: m3supershort | 1475 rubles |
| latch | LA18 | Stock: mask_gp5 +1 total | Standing exchange: fubar | 2050 rubles; 500 repair credit at 'Technut' |
| latch | LA19 | Stock: mask_gp5 +2 total | Standing exchange: sharpening_stone_fine | 0 rubles |
| latch | LA20 | — | — | 2250 rubles |
| latch | LA21 | — | — | 1775 rubles |
| latch | LA22 | Carried capacity: +1 weight; Purchase: attachment_fabric_1; Purchase: mask_eo20 | — | 2450 rubles; Recognition: Latch's trusted contact |
| ledger | LE01 | Purchase: backpack_1; Purchase: trijiconrmr | — | 275 rubles |
| ledger | LE02 | Stock: backpack_1 +1 total | — | 450 rubles |
| ledger | LE03 | Purchase: kobra; Stock: trijiconrmr +1 total | — | 0 rubles |
| ledger | LE04 | Purchase: microt1 | — | 650 rubles |
| ledger | LE05 | Purchase: backpack_3; Purchase: eotech | — | 575 rubles |
| ledger | LE06 | Stock: backpack_3 +1 total | — | 850 rubles |
| ledger | LE07 | Purchase: cmore; Stock: kobra +1 total | settlement freight corridor | 0 rubles |
| ledger | LE08 | Stock: microt1 +1 total | Standing exchange: food_bread | 1050 rubles |
| ledger | LE09 | Purchase: backpack_2; Purchase: tundrasuppressor | Standing exchange: drink_bottlewater | 875 rubles |
| ledger | LE10 | Purchase: cobrasuppressor | Standing exchange: lowtiercookerfuel | 1250 rubles |
| ledger | LE11 | Purchase: aimpoint; Stock: backpack_2 +1 total | recovered consignment corridor | 0 rubles |
| ledger | LE12 | Stock: eotech +1 total | Standing exchange: medic_bandage_1 | 1450 rubles |
| ledger | LE13 | Purchase: kingarmsmr | Standing exchange: food_raisins | 1175 rubles |
| ledger | LE14 | Purchase: backpack_1_large | Standing exchange: drink_bottletea | 1650 rubles |
| ledger | LE15 | Purchase: pso1; Stock: cmore +1 total | remote cache corridor | 0 rubles |
| ledger | LE16 | Purchase: shortdot | Standing exchange: food_can_tushonka | 1850 rubles |
| ledger | LE17 | Purchase: pbssuppressor | Standing exchange: food_nuts_2 | 1475 rubles |
| ledger | LE18 | Purchase: backpack_3_large | Standing exchange: food_mre_russia | 2050 rubles |
| ledger | LE19 | Purchase: acog; Stock: tundrasuppressor +1 total | expedition freight corridor | 0 rubles |
| ledger | LE20 | Stock: cobrasuppressor +1 total | — | 2250 rubles |
| ledger | LE21 | Purchase: sakersuppressor | Standing exchange: food_mre_ukraine | 1775 rubles |
| ledger | LE22 | Purchase: backpack_2_large; Purchase: nightforce | — | 2450 rubles; Recognition: Ledger's trusted contact |
| mute | MU01 | STALKERnet search | — | 275 rubles |
| mute | MU02 | — | — | 450 rubles |
| mute | MU03 | STALKERnet squad filter | — | 0 rubles |
| mute | MU04 | — | — | 650 rubles |
| mute | MU05 | — | — | 575 rubles |
| mute | MU06 | — | — | 850 rubles |
| mute | MU07 | STALKERnet ranks and reputation | — | 0 rubles |
| mute | MU08 | — | — | 1050 rubles |
| mute | MU09 | emission warnings | — | 875 rubles |
| mute | MU10 | — | Record: repeater identification | 1250 rubles |
| mute | MU11 | STALKERnet activity counters | Record: coverage gap register | 0 rubles |
| mute | MU12 | — | Record: message authentication | 1450 rubles |
| mute | MU13 | — | Record: lost operator records | 1175 rubles |
| mute | MU14 | — | Record: battery budgeting | 1650 rubles |
| mute | MU15 | STALKERnet location tracking; event broadcasts | — | 0 rubles |
| mute | MU16 | — | Record: interference signatures | 1850 rubles |
| mute | MU17 | — | Record: relay outage reports | 1475 rubles |
| mute | MU18 | — | Record: emergency signal protocol | 2050 rubles |
| mute | MU19 | STALKERnet cross-map directory | Record: regional network comparison | 0 rubles |
| mute | MU20 | — | Record: intrusion incident records | 2250 rubles |
| mute | MU21 | — | Record: Pripyat signal notes | 1775 rubles |
| mute | MU22 | — | Record: operator handover procedure | 2450 rubles |
| mute | MU23 | STALKERnet full career dossier | Record: offline network recovery | 0 rubles |
| mute | MU24 | — | — | 2650 rubles; Recognition: Mute's trusted contact |
| old-timer | OT01 | Purchase: helm_tanker; Purchase: knife2; Purchase: sharpening_stone | — | 275 rubles |
| old-timer | OT02 | Stock: sharpening_stone +1 total | — | 450 rubles |
| old-timer | OT03 | Stock: helm_tanker +1 total | — | 0 rubles |
| old-timer | OT04 | Stock: knife2 +1 total | — | 650 rubles |
| old-timer | OT05 | Stock: sharpening_stone +2 total | — | 575 rubles |
| old-timer | OT06 | Stock: helm_tanker +2 total | — | 850 rubles |
| old-timer | OT07 | Stock: knife2 +2 total | — | 0 rubles |
| old-timer | OT08 | Carried capacity: +1 weight | — | 1050 rubles |
| old-timer | OT09 | — | — | 875 rubles |
| old-timer | OT10 | Purchase: helm_steel_arab; Purchase: sharpening_stone_fine | — | 1250 rubles |
| old-timer | OT11 | Stock: sharpening_stone_fine +1 total | — | 0 rubles |
| old-timer | OT12 | Stock: helm_steel_arab +1 total | — | 1450 rubles |
| old-timer | OT13 | — | — | 1175 rubles |
| old-timer | OT14 | Purchase: knife3 | — | 1650 rubles |
| old-timer | OT15 | Stock: knife3 +1 total | — | 0 rubles |
| old-timer | OT16 | Carried capacity: +1 weight | — | 1850 rubles |
| old-timer | OT17 | Stock: sharpening_stone_fine +2 total | — | 1475 rubles |
| old-timer | OT18 | — | — | 2050 rubles |
| old-timer | OT19 | Purchase: hatchet; Purchase: helm_steel_ger; Stock: hatchet +1 total | — | 0 rubles |
| old-timer | OT20 | Stock: helm_steel_ger +1 total | — | 2250 rubles |
| old-timer | OT21 | — | Record: quarry signs | 1775 rubles |
| old-timer | OT22 | Stock: hatchet +2 total | Record: safe retreat planning | 2450 rubles |
| old-timer | OT23 | Stock: helm_steel_arab +2 total | Record: wounded mutant trails | 0 rubles |
| old-timer | OT24 | Stock: helm_steel_ger +2 total | Record: night hunting | 2650 rubles |
| old-timer | OT25 | Stock: knife3 +2 total | Record: companion expedition notes | 2000 rubles |
| old-timer | OT26 | — | Record: carcass handling | 2850 rubles |
| old-timer | OT27 | Stock: sharpening_stone +3 total | Record: Pripyat return preparation | 0 rubles |
| old-timer | OT28 | Purchase: helm_steel_rus; Purchase: knife4; Purchase: machete | — | 3000 rubles; Recognition: Old Timer's trusted contact |
| quartermaster | QM01 | Purchase: 545x39; Purchase: m16a4 | — | 275 rubles |
| quartermaster | QM02 | Purchase: saigasemi | — | 450 rubles |
| quartermaster | QM03 | Purchase: 762x39; Purchase: famas; Purchase: lr300; Stock: 545x39 +1 total | — | 0 rubles |
| quartermaster | QM04 | Purchase: 556x45; Purchase: sg552 | — | 650 rubles |
| quartermaster | QM05 | Purchase: aek971 | — | 575 rubles |
| quartermaster | QM06 | Purchase: 762x54; Purchase: l85 | — | 850 rubles |
| quartermaster | QM07 | Purchase: g36c; Stock: 556x45 +1 total | — | 0 rubles |
| quartermaster | QM08 | Purchase: 9x39; Purchase: aug; Purchase: rk95 | — | 1050 rubles |
| quartermaster | QM09 | Purchase: f2000 | — | 875 rubles |
| quartermaster | QM10 | Purchase: an94k | — | 1250 rubles |
| quartermaster | QM11 | Purchase: 762x51; Purchase: hk416; Stock: 762x39 +1 total | — | 0 rubles |
| quartermaster | QM12 | Purchase: ak12 | — | 1450 rubles |
| quartermaster | QM13 | Purchase: 338lapua; Purchase: svt40; Purchase: trg42 | — | 1175 rubles |
| quartermaster | QM14 | Purchase: g3a3 | — | 1650 rubles |
| quartermaster | QM15 | Purchase: 9a91; Stock: 9x39 +1 total | — | 0 rubles |
| quartermaster | QM16 | Purchase: rpk | — | 1850 rubles |
| quartermaster | QM17 | Purchase: dp28; Purchase: fnfal | — | 1475 rubles |
| quartermaster | QM18 | Purchase: m14 | — | 2050 rubles |
| quartermaster | QM19 | Purchase: sv98; Stock: 762x51 +1 total | — | 0 rubles |
| quartermaster | QM20 | Purchase: asval | — | 2250 rubles |
| quartermaster | QM21 | Purchase: svd | — | 1775 rubles |
| quartermaster | QM22 | Purchase: sr3m; Purchase: vss | — | 2450 rubles |
| quartermaster | QM23 | Purchase: pkm; Stock: 762x54 +1 total | — | 0 rubles |
| quartermaster | QM24 | Purchase: l115 | — | 2650 rubles; Recognition: Quartermaster's trusted contact |
| smartass | SM01 | Purchase: food_mre_ukraine; Purchase: medic_antipsychotic_1; Purchase: medic_antirad_2; Purchase: medic_bandage_2; Purchase: medic_medkit_3; Purchase: medic_psyheal_1 | — | 275 rubles |
| smartass | SM02 | Stock: medic_bandage_2 +1 total | — | 450 rubles |
| smartass | SM03 | Stock: medic_antipsychotic_1 +1 total | — | 0 rubles |
| smartass | SM04 | — | — | 650 rubles |
| smartass | SM05 | Stock: food_mre_ukraine +1 total | — | 575 rubles |
| smartass | SM06 | Stock: medic_psyheal_1 +1 total | — | 850 rubles |
| smartass | SM07 | Purchase: food_mre_russia; Stock: food_mre_russia +1 total | — | 0 rubles |
| smartass | SM08 | — | — | 1050 rubles |
| smartass | SM09 | Stock: medic_medkit_3 +1 total | — | 875 rubles |
| smartass | SM10 | — | — | 1250 rubles |
| smartass | SM11 | Stock: medic_antirad_2 +1 total | — | 0 rubles |
| smartass | SM12 | — | Record: computer type identification | 1450 rubles |
| smartass | SM13 | Purchase: drug_adrenaline | Record: flash drive provenance | 1175 rubles |
| smartass | SM14 | Stock: drug_adrenaline +1 total | Record: data integrity checks | 1650 rubles |
| smartass | SM15 | Stock: medic_bandage_2 +2 total | Record: terminal power failures | 0 rubles |
| smartass | SM16 | Stock: medic_antipsychotic_1 +2 total | Record: archive access protocol | 1850 rubles |
| smartass | SM17 | Stock: food_mre_ukraine +2 total | Record: cross-system file comparison | 1475 rubles |
| smartass | SM18 | Purchase: food_mre_usa | Record: damaged media handling | 2050 rubles |
| smartass | SM19 | Stock: food_mre_usa +1 total | Record: field extraction precautions | 0 rubles |
| smartass | SM20 | Stock: medic_psyheal_1 +2 total | Record: research workstation records | 2250 rubles |
| smartass | SM21 | — | Record: log timestamp comparison | 1775 rubles |
| smartass | SM22 | Stock: food_mre_russia +2 total | Record: Pripyat terminal reports | 2450 rubles |
| smartass | SM23 | Stock: medic_medkit_3 +2 total | Record: forged file identification | 0 rubles |
| smartass | SM24 | Purchase: drug_glucose; Purchase: medic_antipsychotic_2; Purchase: medic_medkit_4 | — | 2650 rubles; Recognition: Smartass's trusted contact |
| spicy-lemon | SL01 | Purchase: food_burger | — | 275 rubles |
| spicy-lemon | SL02 | Purchase: food_oldmeat | — | 450 rubles |
| spicy-lemon | SL03 | Purchase: drink_bottlewaterdirty; Purchase: drink_milkold; Stock: food_burger +1 total | — | 0 rubles |
| spicy-lemon | SL04 | Purchase: food_bread | Flesh expedition meal | 650 rubles |
| spicy-lemon | SL05 | Purchase: food_can_corn | — | 575 rubles |
| spicy-lemon | SL06 | Purchase: food_can_beans; Purchase: food_can_chilibeans | — | 850 rubles |
| spicy-lemon | SL07 | Purchase: food_sausage_1; Stock: food_oldmeat +1 total | — | 0 rubles |
| spicy-lemon | SL08 | Purchase: food_can_tomato | Boar expedition meal | 1050 rubles |
| spicy-lemon | SL09 | Purchase: food_sausage_2 | — | 875 rubles |
| spicy-lemon | SL10 | Purchase: drink_bottlewater; Purchase: food_can_tuna | — | 1250 rubles |
| spicy-lemon | SL11 | Purchase: food_nuts_1; Stock: drink_milkold +1 total | — | 0 rubles |
| spicy-lemon | SL12 | Purchase: food_can_olive | Blinddog expedition meal | 1450 rubles |
| spicy-lemon | SL13 | Purchase: food_can_tushonka; Purchase: food_cheese_1 | — | 1175 rubles |
| spicy-lemon | SL14 | Purchase: food_nuts_2 | — | 1650 rubles |
| spicy-lemon | SL15 | Purchase: drink_canwater; Stock: drink_bottlewaterdirty +1 total | — | 0 rubles |
| spicy-lemon | SL16 | Purchase: drink_energydrink_4 | Pseudodog expedition meal | 1850 rubles |
| spicy-lemon | SL17 | Purchase: food_can_sprats; Purchase: food_cheese_2 | — | 1475 rubles |
| spicy-lemon | SL18 | Purchase: drink_energydrink_2 | — | 2050 rubles |
| spicy-lemon | SL19 | Purchase: drink_milk; Stock: food_bread +1 total | — | 0 rubles |
| spicy-lemon | SL20 | Purchase: drink_energydrink_1 | Bloodsucker expedition meal | 2250 rubles |
| spicy-lemon | SL21 | Purchase: food_cheese_3; Purchase: food_raisins | — | 1775 rubles |
| spicy-lemon | SL22 | Purchase: drink_energydrink_5 | — | 2450 rubles |
| spicy-lemon | SL23 | Purchase: drink_energydrink_6; Stock: food_can_corn +1 total | — | 0 rubles |
| spicy-lemon | SL24 | Purchase: drink_bottletea; Purchase: drink_orangejuice | Chimera expedition meal | 2650 rubles |
| spicy-lemon | SL25 | Purchase: drink_energydrink_3 | — | 2000 rubles |
| spicy-lemon | SL26 | Purchase: food_chocolate | — | 2850 rubles; Recognition: Spicy Lemon's trusted contact |
| spool | SO01 | Purchase: backpack_takedown_1; Purchase: cassette_true | — | 275 rubles |
| spool | SO02 | — | — | 450 rubles |
| spool | SO03 | Stock: backpack_takedown_1 +1 total | — | 0 rubles |
| spool | SO04 | Purchase: cassette_wickedrabbit | — | 650 rubles |
| spool | SO05 | Purchase: backpack_takedown_2 | — | 575 rubles |
| spool | SO06 | Purchase: cassette_standart | — | 850 rubles |
| spool | SO07 | Stock: backpack_takedown_2 +1 total | Record: operator call-sign register | 0 rubles |
| spool | SO08 | Stock: cassette_true +1 total | Record: Marsh relay bearings | 1050 rubles |
| spool | SO09 | Purchase: backpack_mbss; Purchase: cassette_freedom | Record: Garbage relay bearings | 875 rubles |
| spool | SO10 | Stock: backpack_mbss +1 total | Record: Waystation relay bearings | 1250 rubles |
| spool | SO11 | Purchase: cassette_firelake; Stock: cassette_wickedrabbit +1 total | Record: Pripyat transmission bearings | 0 rubles |
| spool | SO12 | Stock: cassette_standart +1 total | Record: failed station chronology | 1450 rubles |
| spool | SO13 | — | Record: missing operator recordings | 1175 rubles |
| spool | SO14 | Purchase: backpack_vkbo; Purchase: cassette_bandits | Record: signal triangulation procedure | 1650 rubles |
| spool | SO15 | Stock: backpack_vkbo +1 total | Record: antenna maintenance records | 0 rubles |
| spool | SO16 | Stock: cassette_freedom +1 total | Record: interference comparison | 1850 rubles |
| spool | SO17 | Purchase: cassette_barman | Record: emergency listening protocol | 1475 rubles |
| spool | SO18 | Purchase: backpack_pilgrim | Record: expedition radio checks | 2050 rubles |
| spool | SO19 | Purchase: cassette_merc; Stock: backpack_pilgrim +1 total | Record: recording provenance | 0 rubles |
| spool | SO20 | Stock: cassette_firelake +1 total | — | 2250 rubles |
| spool | SO21 | Stock: cassette_bandits +1 total | Record: unidentified voice register | 1775 rubles |
| spool | SO22 | Purchase: backpack_scavbackpack; Purchase: walkman | — | 2450 rubles; Recognition: Spool's trusted contact |
| spoor | SP01 | Purchase: 12gauge; Purchase: 45acp41; Purchase: headwear_riot; Purchase: toz106 | — | 275 rubles |
| spoor | SP02 | Purchase: 12gaugedt; Purchase: 12gaugemg; Purchase: 12gaugesg; Purchase: 12gaugetr; Purchase: toz34short | — | 450 rubles |
| spoor | SP03 | Purchase: toz66short; Stock: 12gaugedt +1 total | Record: blind dog feeding grounds | 0 rubles |
| spoor | SP04 | Purchase: ij600 | Record: boar escape routes | 650 rubles |
| spoor | SP05 | Purchase: mp27 | — | 575 rubles |
| spoor | SP06 | Purchase: m3supershort | — | 850 rubles |
| spoor | SP07 | Purchase: toz34; Stock: 45acp41 +1 total | — | 0 rubles |
| spoor | SP08 | Purchase: helm_operator_rus_2; Purchase: toz66 | — | 1050 rubles |
| spoor | SP09 | Purchase: toz194 | — | 875 rubles |
| spoor | SP10 | Purchase: m1887 | — | 1250 rubles |
| spoor | SP11 | Purchase: mossberg500; Purchase: stoegerddshort; Stock: 12gaugesg +1 total | — | 0 rubles |
| spoor | SP12 | Purchase: lax410 | — | 1450 rubles |
| spoor | SP13 | Purchase: lax410s | — | 1175 rubles |
| spoor | SP14 | Purchase: mp153 | — | 1650 rubles |
| spoor | SP15 | Purchase: headwear_cs1; Purchase: m3super90; Stock: 12gaugemg +1 total | Record: flesh herd signs | 0 rubles |
| spoor | SP16 | Purchase: stoegerdd | Record: predator displacement | 1850 rubles |
| spoor | SP17 | Purchase: ithaca37 | — | 1475 rubles |
| spoor | SP18 | Purchase: rem870ae | — | 2050 rubles |
| spoor | SP19 | Purchase: saiga12; Stock: 12gaugetr +1 total | — | 0 rubles |
| spoor | SP20 | Purchase: saiga410 | — | 2250 rubles |
| spoor | SP21 | Purchase: toz34special | Record: bloodsucker warning signs | 1775 rubles |
| spoor | SP22 | Purchase: headwear_cs2; Purchase: striker | — | 2450 rubles; Recognition: Spoor's trusted contact |
| suture | SU01 | Purchase: attachment_steelplate_2; Purchase: suit_io7a | — | 275 rubles |
| suture | SU02 | — | — | 450 rubles |
| suture | SU03 | Stock: attachment_steelplate_2 +1 total | — | 0 rubles |
| suture | SU04 | — | Restocking: outfitter colours | 650 rubles |
| suture | SU05 | Purchase: attachment_ceramicplate_2 | — | 575 rubles |
| suture | SU06 | Stock: attachment_ceramicplate_2 +1 total | — | 850 rubles |
| suture | SU07 | Purchase: suit_ps5m; Stock: suit_io7a +1 total | — | 0 rubles |
| suture | SU08 | — | backpack_sling exchange | 1050 rubles |
| suture | SU09 | Purchase: attachment_fabric_2 | — | 875 rubles |
| suture | SU10 | — | — | 1250 rubles |
| suture | SU11 | Stock: attachment_fabric_2 +1 total | — | 0 rubles |
| suture | SU12 | — | — | 1450 rubles |
| suture | SU13 | Purchase: attachment_kevlar_1; Purchase: suit_berill | — | 1175 rubles |
| suture | SU14 | — | — | 1650 rubles |
| suture | SU15 | Stock: attachment_kevlar_1 +1 total | — | 0 rubles |
| suture | SU16 | Purchase: attachment_steelplate_3 | backpack_vkbo exchange | 1850 rubles |
| suture | SU17 | — | — | 1475 rubles |
| suture | SU18 | Purchase: suit_skat10 | — | 2050 rubles |
| suture | SU19 | Stock: attachment_steelplate_3 +1 total | — | 0 rubles |
| suture | SU20 | Purchase: attachment_ceramicplate_3 | — | 2250 rubles |
| suture | SU21 | — | — | 1775 rubles |
| suture | SU22 | — | backpack_1_large exchange | 2450 rubles |
| suture | SU23 | Stock: attachment_ceramicplate_3 +1 total | — | 0 rubles |
| suture | SU24 | Carried capacity: +1 rows; Purchase: attachment_kevlar_2; Purchase: suit_skat9 | — | 2650 rubles; Recognition: Suture's trusted contact |
| technut | TN01 | Purchase: suit_anorak | — | 275 rubles |
| technut | TN02 | Stock: suit_anorak +1 total | — | 450 rubles |
| technut | TN03 | Stock: suit_anorak +2 total | — | 0 rubles |
| technut | TN04 | Purchase: suit_mailjacket | — | 650 rubles |
| technut | TN05 | Stock: suit_mailjacket +1 total | — | 575 rubles |
| technut | TN06 | Stock: suit_mailjacket +2 total | — | 850 rubles |
| technut | TN07 | Stock: suit_anorak +3 total | — | 0 rubles |
| technut | TN08 | Purchase: suit_trenchcoat_black | — | 1050 rubles |
| technut | TN09 | Stock: suit_trenchcoat_black +1 total | — | 875 rubles |
| technut | TN10 | Stock: suit_trenchcoat_black +2 total | Latch's Find: workshop procedure | 1250 rubles |
| technut | TN11 | Purchase: suit_trenchcoat_brown; Stock: suit_trenchcoat_brown +1 total; repair discount: 5% | — | 0 rubles |
| technut | TN12 | — | — | 1450 rubles |
| technut | TN13 | existing suit painting | — | 1175 rubles |
| technut | TN14 | Stock: suit_trenchcoat_brown +2 total | — | 1650 rubles |
| technut | TN15 | Purchase: suit_trenchcoat_green; Stock: suit_trenchcoat_green +1 total | — | 0 rubles |
| technut | TN16 | — | — | 1850 rubles |
| technut | TN17 | Stock: suit_trenchcoat_green +2 total | — | 1475 rubles |
| technut | TN18 | Purchase: suit_trenchcoat_tan | — | 2050 rubles |
| technut | TN19 | Stock: suit_trenchcoat_tan +1 total | — | 0 rubles |
| technut | TN20 | Stock: suit_trenchcoat_tan +2 total | — | 2250 rubles |
| technut | TN21 | Purchase: suit_sunrise | — | 1775 rubles |
| technut | TN22 | Stock: suit_sunrise +1 total | — | 2450 rubles |
| technut | TN23 | Stock: suit_sunrise +2 total | — | 0 rubles |
| technut | TN24 | — | — | 2650 rubles; 500 repair credit at 'Technut' |
| technut | TN25 | Purchase: suit_wind; repair discount: 10% | — | 2000 rubles |
| technut | TN26 | Stock: suit_wind +1 total | — | 2850 rubles |
| technut | TN27 | Stock: suit_wind +2 total | — | 0 rubles |
| technut | TN28 | Purchase: suit_nbc | — | 3000 rubles; Recognition: Technut's trusted contact |
| vesper | VE01 | Conversion: suit_anorak_anarchist; Conversion: suit_berill_anarchist; Conversion: suit_cs1_ecologist; Conversion: suit_cs2_ecologist; Conversion: suit_cs3_ecologist; Conversion: suit_io7a_anarchist; Conversion: suit_mailjacket_anarchist; Conversion: suit_nbc_anarchist; Conversion: suit_ps5m_anarchist; Conversion: suit_seva_anarchist; Conversion: suit_skat10_anarchist; Conversion: suit_skat9_anarchist; Conversion: suit_sunrise_anarchist; Conversion: suit_wind_anarchist; Paid suit variant conversions; Purchase: suit_cs1 | — | 275 rubles |
| vesper | VE02 | Stock: suit_cs1 +1 total | — | 450 rubles |
| vesper | VE03 | Stock: suit_cs1 +2 total | — | 0 rubles |
| vesper | VE04 | — | — | 650 rubles |
| vesper | VE05 | Conversion: suit_io7a_authority | — | 575 rubles |
| vesper | VE06 | Conversion: suit_berill_authority; Conversion: suit_skat9_authority; Conversion: suit_sunrise_authority | — | 850 rubles |
| vesper | VE07 | Conversion: suit_anorak_authority; Conversion: suit_mailjacket_authority; Conversion: suit_ps5m_authority; Conversion: suit_seva_authority; Conversion: suit_skat10_authority; Stock: suit_cs1 +3 total | Record: field boundary observations | 0 rubles |
| vesper | VE08 | — | Record: detector preparation | 1050 rubles |
| vesper | VE09 | Conversion: suit_io7a_ecologist; Conversion: suit_wind_authority | Record: Marsh anomaly comparison | 875 rubles |
| vesper | VE10 | Conversion: suit_berill_ecologist; Conversion: suit_skat9_ecologist; Conversion: suit_sunrise_fanatic | Record: Garbage anomaly comparison | 1250 rubles |
| vesper | VE11 | Stock: suit_cs1 +4 total | — | 0 rubles |
| vesper | VE12 | — | Record: Waystation anomaly comparison | 1450 rubles |
| vesper | VE13 | Conversion: suit_anorak_ecologist; Conversion: suit_io7a_fanatic; Conversion: suit_mailjacket_ecologist; Conversion: suit_nbc_authority; Conversion: suit_ps5m_ecologist; Conversion: suit_seva_ecologist; Conversion: suit_skat10_ecologist; Purchase: suit_cs2 | — | 1175 rubles |
| vesper | VE14 | — | — | 1650 rubles |
| vesper | VE15 | Conversion: suit_berill_looted; Conversion: suit_skat9_fanatic; Conversion: suit_sunrise_looted; Stock: suit_cs2 +1 total | — | 0 rubles |
| vesper | VE16 | Conversion: suit_io7a_looted; Conversion: suit_wind_fanatic | — | 1850 rubles |
| vesper | VE17 | Stock: suit_cs2 +2 total | Record: Pripyat anomaly comparison | 1475 rubles |
| vesper | VE18 | Conversion: suit_anorak_mercenary; Conversion: suit_mailjacket_mercenary; Conversion: suit_ps5m_fanatic; Conversion: suit_seva_fanatic; Conversion: suit_skat10_looted | Record: weather and visibility | 2050 rubles |
| vesper | VE19 | Conversion: suit_berill_mercenary; Conversion: suit_skat9_looted; Conversion: suit_sunrise_mercenary; Stock: suit_cs2 +3 total | — | 0 rubles |
| vesper | VE20 | Conversion: suit_io7a_mercenary | Record: survey withdrawal criteria | 2250 rubles |
| vesper | VE21 | — | — | 1775 rubles |
| vesper | VE22 | — | Record: protective equipment checklist | 2450 rubles |
| vesper | VE23 | Stock: suit_cs2 +4 total | Record: artifact recovery notes | 0 rubles |
| vesper | VE24 | Conversion: suit_anorak_scavenger; Conversion: suit_berill_scavenger; Conversion: suit_cs1_scavenger; Conversion: suit_cs2_scavenger; Conversion: suit_io7a_scavenger; Conversion: suit_mailjacket_scavenger; Conversion: suit_nbc_fanatic; Conversion: suit_ps5m_mercenary; Conversion: suit_seva_mercenary; Conversion: suit_skat10_mercenary; Conversion: suit_skat9_scavenger; Conversion: suit_sunrise_scavenger; Conversion: suit_wind_looted; Purchase: suit_cs3 | — | 2650 rubles; Recognition: Vesper's trusted contact |
| wake | WA01 | Purchase: drug_caffeine; Purchase: medic_antirad_1; Purchase: medic_bandage_2; Purchase: medic_medkit_1 | — | 275 rubles |
| wake | WA02 | — | — | 450 rubles |
| wake | WA03 | Stock: medic_bandage_2 +1 total | — | 0 rubles |
| wake | WA04 | Stock: medic_medkit_1 +1 total | — | 650 rubles |
| wake | WA05 | — | — | 575 rubles |
| wake | WA06 | Stock: drug_caffeine +1 total | — | 850 rubles |
| wake | WA07 | Stock: medic_antirad_1 +1 total | Bring Back What You Can: standing exchange | 0 rubles |
| wake | WA08 | Purchase: drug_morphine; Purchase: medic_medkit_2 | Record: personal effects identification | 1050 rubles |
| wake | WA09 | Stock: medic_medkit_2 +1 total | Record: failed convoy account | 875 rubles |
| wake | WA10 | Stock: drug_morphine +1 total | Atlas' Missing Mark: standing exchange | 1250 rubles |
| wake | WA11 | Stock: medic_bandage_2 +2 total | — | 0 rubles |
| wake | WA12 | Stock: medic_medkit_1 +2 total | Record: Garbage recovery approaches | 1450 rubles |
| wake | WA13 | — | — | 1175 rubles |
| wake | WA14 | Stock: drug_caffeine +2 total | Record: Pripyat recovery approaches | 1650 rubles |
| wake | WA15 | Purchase: drug_marijuana; Purchase: medic_medkit_3; Stock: medic_medkit_3 +1 total | — | 0 rubles |
| wake | WA16 | Stock: drug_marijuana +1 total | Building the reserve: standing exchange | 1850 rubles |
| wake | WA17 | — | — | 1475 rubles |
| wake | WA18 | Stock: medic_medkit_2 +2 total | — | 2050 rubles |
| wake | WA19 | Stock: medic_antirad_1 +2 total | — | 0 rubles |
| wake | WA20 | Stock: medic_medkit_3 +2 total | — | 2250 rubles |
| wake | WA21 | — | — | 1775 rubles |
| wake | WA22 | Purchase: medic_antirad_2; Purchase: medic_bandage_1; Purchase: medic_medkit_4; Purchase: miscaid_swampbrew | — | 2450 rubles; Recognition: Wake's trusted contact |

## Purchase catalogue

| Item | Seller | Local milestone | Canonical tier owner |
| --- | --- | --- | --- |
| anomalydetector | atlas | AT15 | atlas |
| backpack_duffle | atlas | AT06 | atlas |
| backpack_sanitar | atlas | AT11 | atlas |
| backpack_sling | atlas | AT01 | atlas |
| backpack_tbag | atlas | AT17 | atlas |
| backpack_tourist | atlas | AT22 | atlas |
| binoculars_1 | atlas | AT08 | atlas |
| binoculars_2 | atlas | AT01 | atlas |
| binoculars_3 | atlas | AT22 | atlas |
| binoculars_4 | atlas | AT15 | atlas |
| compass | atlas | AT08 | atlas |
| geigercounter | atlas | AT01 | atlas |
| gpstracker | atlas | AT22 | atlas |
| bat | ballast | BA13 | ballast |
| crowbar | ballast | BA11 | ballast |
| drink_bottlebeer_1 | ballast | BA09 | ballast |
| drink_bottlebeer_2 | ballast | BA07 | ballast |
| drink_bottlebeer_3 | ballast | BA05 | ballast |
| drink_bottlebeer_4 | ballast | BA03 | ballast |
| drink_bottlebeer_5 | ballast | BA08 | ballast |
| drink_bottlebeer_6 | ballast | BA06 | ballast |
| drink_canbeer_1 | ballast | BA02 | ballast |
| drink_canbeer_2 | ballast | BA01 | ballast |
| drink_canbeer_3 | ballast | BA02 | ballast |
| drink_canbeer_4 | ballast | BA04 | ballast |
| drink_canbeer_5 | ballast | BA07 | ballast |
| drink_canbeer_6 | ballast | BA05 | ballast |
| drink_moonshine | ballast | BA09 | ballast |
| drink_spirit_1 | ballast | BA19 | ballast |
| drink_spirit_2 | ballast | BA20 | ballast |
| drink_spirit_3 | ballast | BA21 | ballast |
| drink_vodka_1 | ballast | BA12 | ballast |
| drink_vodka_2 | ballast | BA11 | ballast |
| drink_vodka_3 | ballast | BA14 | ballast |
| drink_vodka_4 | ballast | BA16 | ballast |
| drink_vodka_5 | ballast | BA19 | ballast |
| drink_vodka_6 | ballast | BA15 | ballast |
| drink_wine | ballast | BA14 | ballast |
| fireaxe | ballast | BA17 | ballast |
| fubar | ballast | BA21 | ballast |
| hidestasher_cleaningkit | ballast | BA18 | ballast |
| hidestasher_cutlery | ballast | BA10 | ballast |
| hidestasher_shovel | ballast | BA22 | ballast |
| sledgehammer | ballast | BA16 | ballast |
| 127x55 | beanstalk | BN20 | beanstalk |
| 22lr | beanstalk | BN03 | haggler |
| 22lrap | beanstalk | BN05 | beanstalk |
| 22lrhp | beanstalk | BN04 | beanstalk |
| 338lapua | beanstalk | BN17 | quartermaster |
| 338lapuaap | beanstalk | BN19 | beanstalk |
| 338lapuahp | beanstalk | BN18 | beanstalk |
| 357magnum | beanstalk | BN11 | haggler |
| 357magnumap | beanstalk | BN13 | beanstalk |
| 357magnumhp | beanstalk | BN12 | beanstalk |
| 44magnum | beanstalk | BN13 | haggler |
| 44magnumap | beanstalk | BN15 | brass |
| 44magnumhp | beanstalk | BN14 | brass |
| 45acp | beanstalk | BN02 | haggler |
| 45acpap | beanstalk | BN04 | brass |
| 45acphp | beanstalk | BN03 | brass |
| 500magnum | beanstalk | BN16 | haggler |
| 500magnumap | beanstalk | BN18 | beanstalk |
| 500magnumhp | beanstalk | BN17 | beanstalk |
| 50ae | beanstalk | BN18 | brass |
| 50aeap | beanstalk | BN20 | brass |
| 50aehp | beanstalk | BN19 | brass |
| 545x39 | beanstalk | BN04 | brass |
| 545x39ap | beanstalk | BN06 | brass |
| 545x39hp | beanstalk | BN05 | brass |
| 556x45 | beanstalk | BN08 | haggler |
| 556x45ap | beanstalk | BN10 | beanstalk |
| 556x45hp | beanstalk | BN09 | beanstalk |
| 57x28 | beanstalk | BN19 | brass |
| 57x28ap | beanstalk | BN21 | brass |
| 57x28hp | beanstalk | BN20 | brass |
| 762x25 | beanstalk | BN01 | haggler |
| 762x25ap | beanstalk | BN03 | brass |
| 762x25hp | beanstalk | BN02 | brass |
| 762x39 | beanstalk | BN07 | haggler |
| 762x39ap | beanstalk | BN09 | brass |
| 762x39hp | beanstalk | BN08 | brass |
| 762x51 | beanstalk | BN15 | haggler |
| 762x51ap | beanstalk | BN17 | beanstalk |
| 762x51hp | beanstalk | BN16 | beanstalk |
| 762x54 | beanstalk | BN10 | haggler |
| 762x54ap | beanstalk | BN12 | brass |
| 762x54hp | beanstalk | BN11 | brass |
| 93x64 | beanstalk | BN22 | beanstalk |
| 9x18 | beanstalk | BN09 | haggler |
| 9x18ap | beanstalk | BN11 | brass |
| 9x18hp | beanstalk | BN10 | brass |
| 9x19 | beanstalk | BN01 | haggler |
| 9x19ap | beanstalk | BN03 | brass |
| 9x19hp | beanstalk | BN02 | brass |
| 9x21 | beanstalk | BN14 | brass |
| 9x21ap | beanstalk | BN16 | brass |
| 9x21hp | beanstalk | BN15 | brass |
| 9x39 | beanstalk | BN12 | quartermaster |
| 9x39ap | beanstalk | BN14 | beanstalk |
| 9x39hp | beanstalk | BN13 | beanstalk |
| suit_seva | beanstalk | BN24 | beanstalk |
| suit_ssp99 | beanstalk | BN01 | beanstalk |
| suit_ssp99m | beanstalk | BN13 | beanstalk |
| detectorecho | boss | BO01 | boss |
| headwear_cs4 | boss | BO09 | boss |
| headwear_screen | boss | BO05 | boss |
| helm_operator_nato | boss | BO22 | boss |
| helm_operator_rus_1 | boss | BO01 | boss |
| helm_sphere08 | boss | BO14 | boss |
| helm_sphere12 | boss | BO18 | boss |
| mask_m40 | boss | BO15 | boss |
| mask_m50 | boss | BO22 | boss |
| mask_pmk3 | boss | BO01 | boss |
| mask_xm40 | boss | BO08 | boss |
| 44magnum | brass | BR13 | haggler |
| 44magnumap | brass | BR15 | brass |
| 44magnumhp | brass | BR14 | brass |
| 45acp | brass | BR02 | haggler |
| 45acpap | brass | BR04 | brass |
| 45acphp | brass | BR03 | brass |
| 50ae | brass | BR18 | brass |
| 50aeap | brass | BR20 | brass |
| 50aehp | brass | BR19 | brass |
| 545x39 | brass | BR04 | brass |
| 545x39ap | brass | BR06 | brass |
| 545x39hp | brass | BR05 | brass |
| 57x28 | brass | BR19 | brass |
| 57x28ap | brass | BR21 | brass |
| 57x28hp | brass | BR20 | brass |
| 762x25 | brass | BR01 | haggler |
| 762x25ap | brass | BR03 | brass |
| 762x25hp | brass | BR02 | brass |
| 762x39 | brass | BR07 | haggler |
| 762x39ap | brass | BR09 | brass |
| 762x39hp | brass | BR08 | brass |
| 762x54 | brass | BR10 | haggler |
| 762x54ap | brass | BR12 | brass |
| 762x54hp | brass | BR11 | brass |
| 9x18 | brass | BR09 | haggler |
| 9x18ap | brass | BR11 | brass |
| 9x18hp | brass | BR10 | brass |
| 9x19 | brass | BR01 | haggler |
| 9x19ap | brass | BR03 | brass |
| 9x19hp | brass | BR02 | brass |
| 9x21 | brass | BR14 | brass |
| 9x21ap | brass | BR16 | brass |
| 9x21hp | brass | BR15 | brass |
| accesscard_bunker | carbon | CA12 | carbon |
| attachment_aluframe | carbon | CA08 | carbon |
| attachment_carbonfibre | carbon | CA15 | carbon |
| attachment_steelframe | carbon | CA22 | carbon |
| headwear_pracs | carbon | CA01 | carbon |
| headwear_psz12 | carbon | CA22 | carbon |
| ak74 | cleaner | CL20 | cleaner |
| akm | cleaner | CL27 | cleaner |
| aks74u | cleaner | CL14 | cleaner |
| ar159mm | cleaner | CL24 | cleaner |
| deagle | cleaner | CL15 | cleaner |
| deagle44 | cleaner | CL16 | cleaner |
| fiveseven | cleaner | CL22 | cleaner |
| gepardpdw | cleaner | CL18 | cleaner |
| glock18 | cleaner | CL06 | cleaner |
| kiparis | cleaner | CL04 | cleaner |
| kp31 | cleaner | CL11 | cleaner |
| m1911chic | cleaner | CL28 | cleaner |
| m1928 | cleaner | CL25 | cleaner |
| mac11 | cleaner | CL03 | cleaner |
| mp18 | cleaner | CL09 | cleaner |
| mp34 | cleaner | CL05 | cleaner |
| mp40 | cleaner | CL07 | cleaner |
| mp5 | cleaner | CL15 | cleaner |
| mp5k | cleaner | CL10 | cleaner |
| mp9a1 | cleaner | CL13 | cleaner |
| p90 | cleaner | CL26 | cleaner |
| pp19 | cleaner | CL20 | cleaner |
| pp1901vityaz | cleaner | CL23 | cleaner |
| pp2000 | cleaner | CL17 | cleaner |
| ppsh | cleaner | CL02 | cleaner |
| saigasemi545 | cleaner | CL21 | cleaner |
| skorpion | cleaner | CL04 | cleaner |
| sr2 | cleaner | CL25 | cleaner |
| stechaps | cleaner | CL08 | cleaner |
| sten | cleaner | CL01 | cleaner |
| sterling | cleaner | CL12 | cleaner |
| ump45 | cleaner | CL19 | cleaner |
| uzi | cleaner | CL09 | cleaner |
| detectorbear | egghead | EG01 | egghead |
| detectorveles | egghead | EG26 | egghead |
| medic_antipsychotic_3 | egghead | EG01 | egghead |
| medic_bandage_3 | egghead | EG01 | egghead |
| medic_medkit_5 | egghead | EG01 | egghead |
| medic_medkit_6 | egghead | EG26 | egghead |
| medic_psyheal_2 | egghead | EG01 | egghead |
| medic_stimpak_1 | egghead | EG01 | egghead |
| medic_stimpak_2 | egghead | EG13 | egghead |
| medic_stimpak_3 | egghead | EG26 | egghead |
| flashlight | gasket | GK01 | gasket |
| headlamp | gasket | GK09 | gasket |
| hightiercooker | gasket | GK14 | gasket |
| lowtiercooker | gasket | GK18 | gasket |
| lowtiercookerfuel | gasket | GK05 | gasket |
| value_kerosene | gasket | GK22 | gasket |
| 22lr | haggler | HG04 | haggler |
| 357magnum | haggler | HG12 | haggler |
| 44magnum | haggler | HG14 | haggler |
| 45acp | haggler | HG03 | haggler |
| 45acp41 | haggler | HG07 | haggler |
| 500magnum | haggler | HG17 | haggler |
| 556x45 | haggler | HG09 | haggler |
| 762x25 | haggler | HG01 | haggler |
| 762x39 | haggler | HG08 | haggler |
| 762x51 | haggler | HG16 | haggler |
| 762x54 | haggler | HG11 | haggler |
| 9x18 | haggler | HG10 | haggler |
| 9x19 | haggler | HG02 | haggler |
| beretta92 | haggler | HG07 | haggler |
| brhp | haggler | HG04 | haggler |
| c96 | haggler | HG08 | haggler |
| c96carbine | haggler | HG13 | haggler |
| cz52 | haggler | HG05 | haggler |
| fort12 | haggler | HG06 | haggler |
| g2contender | haggler | HG02 | haggler |
| g2contender500 | haggler | HG16 | haggler |
| glock17 | haggler | HG11 | haggler |
| lax44 | haggler | HG25 | haggler |
| lugerp08 | haggler | HG09 | haggler |
| m1911 | haggler | HG12 | haggler |
| m1917 | haggler | HG03 | haggler |
| makarov | haggler | HG04 | haggler |
| mateba | haggler | HG22 | haggler |
| mosin | haggler | HG25 | haggler |
| mr96 | haggler | HG17 | haggler |
| nagantrev | haggler | HG01 | haggler |
| obrez | haggler | HG15 | haggler |
| obrezmalfunction | haggler | HG16 | haggler |
| p99 | haggler | HG09 | haggler |
| ruger1022 | haggler | HG13 | haggler |
| rugermini14 | haggler | HG19 | haggler |
| rugermk3 | haggler | HG07 | haggler |
| sako85 | haggler | HG26 | haggler |
| sako85nato | haggler | HG20 | haggler |
| sako85varmint | haggler | HG10 | haggler |
| sks | haggler | HG20 | haggler |
| sw500 | haggler | HG23 | haggler |
| swmodel29 | haggler | HG18 | haggler |
| swr8 | haggler | HG18 | haggler |
| taurusjudge | haggler | HG14 | haggler |
| taurusragingbull | haggler | HG21 | haggler |
| tokarev | haggler | HG02 | haggler |
| w1895 | haggler | HG23 | haggler |
| w9422 | haggler | HG11 | haggler |
| w9422357 | haggler | HG24 | haggler |
| 338lapua | intern | IN13 | quartermaster |
| 338lapuaap | intern | IN15 | beanstalk |
| 338lapuahp | intern | IN14 | beanstalk |
| 545x39 | intern | IN01 | brass |
| 545x39ap | intern | IN03 | brass |
| 545x39hp | intern | IN02 | brass |
| 556x45 | intern | IN04 | haggler |
| 556x45ap | intern | IN06 | beanstalk |
| 556x45hp | intern | IN05 | beanstalk |
| 762x39 | intern | IN03 | haggler |
| 762x39ap | intern | IN05 | brass |
| 762x39hp | intern | IN04 | brass |
| 762x51 | intern | IN11 | haggler |
| 762x51ap | intern | IN13 | beanstalk |
| 762x51hp | intern | IN12 | beanstalk |
| 762x54 | intern | IN06 | haggler |
| 762x54ap | intern | IN08 | brass |
| 762x54hp | intern | IN07 | brass |
| 9x39 | intern | IN08 | quartermaster |
| 9x39ap | intern | IN10 | beanstalk |
| 9x39hp | intern | IN09 | beanstalk |
| accesscard_laboratory | intern | IN24 | intern |
| drug_cigar | jitters | JT19 | jitters |
| drug_cigarette_1 | jitters | JT01 | jitters |
| drug_cigarette_2 | jitters | JT03 | jitters |
| drug_cigarette_3 | jitters | JT09 | jitters |
| drug_cigarette_4 | jitters | JT16 | jitters |
| drug_cigarette_5 | jitters | JT13 | jitters |
| drug_cigarette_6 | jitters | JT21 | jitters |
| drug_mints | jitters | JT06 | jitters |
| drug_painkillers | jitters | JT11 | jitters |
| drug_tobacco_1 | jitters | JT23 | jitters |
| drug_tobacco_2 | jitters | JT26 | jitters |
| medic_antirad_1 | jitters | JT01 | jitters |
| medic_bandage_1 | jitters | JT01 | jitters |
| medic_medkit_1 | jitters | JT01 | jitters |
| medic_medkit_2 | jitters | JT26 | jitters |
| attachment_ceramicplate_1 | latch | LA01 | latch |
| attachment_fabric_1 | latch | LA22 | latch |
| attachment_steelplate_1 | latch | LA11 | latch |
| mask_cloth | latch | LA01 | latch |
| mask_eo20 | latch | LA22 | latch |
| mask_gp5 | latch | LA17 | latch |
| mask_halfmask | latch | LA06 | latch |
| mask_respirator | latch | LA11 | latch |
| acog | ledger | LE19 | ledger |
| aimpoint | ledger | LE11 | ledger |
| backpack_1 | ledger | LE01 | ledger |
| backpack_1_large | ledger | LE14 | ledger |
| backpack_2 | ledger | LE09 | ledger |
| backpack_2_large | ledger | LE22 | ledger |
| backpack_3 | ledger | LE05 | ledger |
| backpack_3_large | ledger | LE18 | ledger |
| cmore | ledger | LE07 | ledger |
| cobrasuppressor | ledger | LE10 | ledger |
| eotech | ledger | LE05 | ledger |
| kingarmsmr | ledger | LE13 | ledger |
| kobra | ledger | LE03 | ledger |
| microt1 | ledger | LE04 | ledger |
| nightforce | ledger | LE22 | ledger |
| pbssuppressor | ledger | LE17 | ledger |
| pso1 | ledger | LE15 | ledger |
| sakersuppressor | ledger | LE21 | ledger |
| shortdot | ledger | LE16 | ledger |
| trijiconrmr | ledger | LE01 | ledger |
| tundrasuppressor | ledger | LE09 | ledger |
| hatchet | old-timer | OT19 | old-timer |
| helm_steel_arab | old-timer | OT10 | old-timer |
| helm_steel_ger | old-timer | OT19 | old-timer |
| helm_steel_rus | old-timer | OT28 | old-timer |
| helm_tanker | old-timer | OT01 | old-timer |
| knife2 | old-timer | OT01 | old-timer |
| knife3 | old-timer | OT14 | old-timer |
| knife4 | old-timer | OT28 | old-timer |
| machete | old-timer | OT28 | old-timer |
| sharpening_stone | old-timer | OT01 | old-timer |
| sharpening_stone_fine | old-timer | OT10 | old-timer |
| 338lapua | quartermaster | QM13 | quartermaster |
| 545x39 | quartermaster | QM01 | brass |
| 556x45 | quartermaster | QM04 | haggler |
| 762x39 | quartermaster | QM03 | haggler |
| 762x51 | quartermaster | QM11 | haggler |
| 762x54 | quartermaster | QM06 | haggler |
| 9a91 | quartermaster | QM15 | quartermaster |
| 9x39 | quartermaster | QM08 | quartermaster |
| aek971 | quartermaster | QM05 | quartermaster |
| ak12 | quartermaster | QM12 | quartermaster |
| an94k | quartermaster | QM10 | quartermaster |
| asval | quartermaster | QM20 | quartermaster |
| aug | quartermaster | QM08 | quartermaster |
| dp28 | quartermaster | QM17 | quartermaster |
| f2000 | quartermaster | QM09 | quartermaster |
| famas | quartermaster | QM03 | quartermaster |
| fnfal | quartermaster | QM17 | quartermaster |
| g36c | quartermaster | QM07 | quartermaster |
| g3a3 | quartermaster | QM14 | quartermaster |
| hk416 | quartermaster | QM11 | quartermaster |
| l115 | quartermaster | QM24 | quartermaster |
| l85 | quartermaster | QM06 | quartermaster |
| lr300 | quartermaster | QM03 | quartermaster |
| m14 | quartermaster | QM18 | quartermaster |
| m16a4 | quartermaster | QM01 | quartermaster |
| pkm | quartermaster | QM23 | quartermaster |
| rk95 | quartermaster | QM08 | quartermaster |
| rpk | quartermaster | QM16 | quartermaster |
| saigasemi | quartermaster | QM02 | quartermaster |
| sg552 | quartermaster | QM04 | quartermaster |
| sr3m | quartermaster | QM22 | quartermaster |
| sv98 | quartermaster | QM19 | quartermaster |
| svd | quartermaster | QM21 | quartermaster |
| svt40 | quartermaster | QM13 | quartermaster |
| trg42 | quartermaster | QM13 | quartermaster |
| vss | quartermaster | QM22 | quartermaster |
| drug_adrenaline | smartass | SM13 | smartass |
| drug_glucose | smartass | SM24 | smartass |
| food_mre_russia | smartass | SM07 | smartass |
| food_mre_ukraine | smartass | SM01 | smartass |
| food_mre_usa | smartass | SM18 | smartass |
| medic_antipsychotic_1 | smartass | SM01 | smartass |
| medic_antipsychotic_2 | smartass | SM24 | smartass |
| medic_antirad_2 | smartass | SM01 | wake |
| medic_bandage_2 | smartass | SM01 | wake |
| medic_medkit_3 | smartass | SM01 | wake |
| medic_medkit_4 | smartass | SM24 | wake |
| medic_psyheal_1 | smartass | SM01 | smartass |
| drink_bottletea | spicy-lemon | SL24 | spicy-lemon |
| drink_bottlewater | spicy-lemon | SL10 | spicy-lemon |
| drink_bottlewaterdirty | spicy-lemon | SL03 | spicy-lemon |
| drink_canwater | spicy-lemon | SL15 | spicy-lemon |
| drink_energydrink_1 | spicy-lemon | SL20 | spicy-lemon |
| drink_energydrink_2 | spicy-lemon | SL18 | spicy-lemon |
| drink_energydrink_3 | spicy-lemon | SL25 | spicy-lemon |
| drink_energydrink_4 | spicy-lemon | SL16 | spicy-lemon |
| drink_energydrink_5 | spicy-lemon | SL22 | spicy-lemon |
| drink_energydrink_6 | spicy-lemon | SL23 | spicy-lemon |
| drink_milk | spicy-lemon | SL19 | spicy-lemon |
| drink_milkold | spicy-lemon | SL03 | spicy-lemon |
| drink_orangejuice | spicy-lemon | SL24 | spicy-lemon |
| food_bread | spicy-lemon | SL04 | spicy-lemon |
| food_burger | spicy-lemon | SL01 | spicy-lemon |
| food_can_beans | spicy-lemon | SL06 | spicy-lemon |
| food_can_chilibeans | spicy-lemon | SL06 | spicy-lemon |
| food_can_corn | spicy-lemon | SL05 | spicy-lemon |
| food_can_olive | spicy-lemon | SL12 | spicy-lemon |
| food_can_sprats | spicy-lemon | SL17 | spicy-lemon |
| food_can_tomato | spicy-lemon | SL08 | spicy-lemon |
| food_can_tuna | spicy-lemon | SL10 | spicy-lemon |
| food_can_tushonka | spicy-lemon | SL13 | spicy-lemon |
| food_cheese_1 | spicy-lemon | SL13 | spicy-lemon |
| food_cheese_2 | spicy-lemon | SL17 | spicy-lemon |
| food_cheese_3 | spicy-lemon | SL21 | spicy-lemon |
| food_chocolate | spicy-lemon | SL26 | spicy-lemon |
| food_nuts_1 | spicy-lemon | SL11 | spicy-lemon |
| food_nuts_2 | spicy-lemon | SL14 | spicy-lemon |
| food_oldmeat | spicy-lemon | SL02 | spicy-lemon |
| food_raisins | spicy-lemon | SL21 | spicy-lemon |
| food_sausage_1 | spicy-lemon | SL07 | spicy-lemon |
| food_sausage_2 | spicy-lemon | SL09 | spicy-lemon |
| backpack_mbss | spool | SO09 | spool |
| backpack_pilgrim | spool | SO18 | spool |
| backpack_scavbackpack | spool | SO22 | spool |
| backpack_takedown_1 | spool | SO01 | spool |
| backpack_takedown_2 | spool | SO05 | spool |
| backpack_vkbo | spool | SO14 | spool |
| cassette_bandits | spool | SO14 | spool |
| cassette_barman | spool | SO17 | spool |
| cassette_firelake | spool | SO11 | spool |
| cassette_freedom | spool | SO09 | spool |
| cassette_merc | spool | SO19 | spool |
| cassette_standart | spool | SO06 | spool |
| cassette_true | spool | SO01 | spool |
| cassette_wickedrabbit | spool | SO04 | spool |
| walkman | spool | SO22 | spool |
| 12gauge | spoor | SP01 | spoor |
| 12gaugedt | spoor | SP02 | spoor |
| 12gaugemg | spoor | SP02 | spoor |
| 12gaugesg | spoor | SP02 | spoor |
| 12gaugetr | spoor | SP02 | spoor |
| 45acp41 | spoor | SP01 | haggler |
| headwear_cs1 | spoor | SP15 | spoor |
| headwear_cs2 | spoor | SP22 | spoor |
| headwear_riot | spoor | SP01 | spoor |
| helm_operator_rus_2 | spoor | SP08 | spoor |
| ij600 | spoor | SP04 | spoor |
| ithaca37 | spoor | SP17 | spoor |
| lax410 | spoor | SP12 | spoor |
| lax410s | spoor | SP13 | spoor |
| m1887 | spoor | SP10 | spoor |
| m3super90 | spoor | SP15 | spoor |
| m3supershort | spoor | SP06 | spoor |
| mossberg500 | spoor | SP11 | spoor |
| mp153 | spoor | SP14 | spoor |
| mp27 | spoor | SP05 | spoor |
| rem870ae | spoor | SP18 | spoor |
| saiga12 | spoor | SP19 | spoor |
| saiga410 | spoor | SP20 | spoor |
| stoegerdd | spoor | SP16 | spoor |
| stoegerddshort | spoor | SP11 | spoor |
| striker | spoor | SP22 | spoor |
| toz106 | spoor | SP01 | spoor |
| toz194 | spoor | SP09 | spoor |
| toz34 | spoor | SP07 | spoor |
| toz34short | spoor | SP02 | spoor |
| toz34special | spoor | SP21 | spoor |
| toz66 | spoor | SP08 | spoor |
| toz66short | spoor | SP03 | spoor |
| attachment_ceramicplate_2 | suture | SU05 | suture |
| attachment_ceramicplate_3 | suture | SU20 | suture |
| attachment_fabric_2 | suture | SU09 | suture |
| attachment_kevlar_1 | suture | SU13 | suture |
| attachment_kevlar_2 | suture | SU24 | suture |
| attachment_steelplate_2 | suture | SU01 | suture |
| attachment_steelplate_3 | suture | SU16 | suture |
| suit_berill | suture | SU13 | suture |
| suit_io7a | suture | SU01 | suture |
| suit_ps5m | suture | SU07 | suture |
| suit_skat10 | suture | SU18 | suture |
| suit_skat9 | suture | SU24 | suture |
| suit_anorak | technut | TN01 | technut |
| suit_mailjacket | technut | TN04 | technut |
| suit_nbc | technut | TN28 | technut |
| suit_sunrise | technut | TN21 | technut |
| suit_trenchcoat_black | technut | TN08 | technut |
| suit_trenchcoat_brown | technut | TN11 | technut |
| suit_trenchcoat_green | technut | TN15 | technut |
| suit_trenchcoat_tan | technut | TN18 | technut |
| suit_wind | technut | TN25 | technut |
| suit_cs1 | vesper | VE01 | vesper |
| suit_cs2 | vesper | VE13 | vesper |
| suit_cs3 | vesper | VE24 | vesper |
| drug_caffeine | wake | WA01 | wake |
| drug_marijuana | wake | WA15 | wake |
| drug_morphine | wake | WA08 | wake |
| medic_antirad_1 | wake | WA01 | jitters |
| medic_antirad_2 | wake | WA22 | wake |
| medic_bandage_1 | wake | WA22 | jitters |
| medic_bandage_2 | wake | WA01 | wake |
| medic_medkit_1 | wake | WA01 | jitters |
| medic_medkit_2 | wake | WA08 | jitters |
| medic_medkit_3 | wake | WA15 | wake |
| medic_medkit_4 | wake | WA22 | wake |
| miscaid_swampbrew | wake | WA22 | wake |

## Suit conversion unlocks

Both canonical base-suit and exact variant milestones are required.

| Variant | Contact | Milestone | Base suit |
| --- | --- | --- | --- |
| suit_anorak_anarchist | vesper | VE01 | suit_anorak |
| suit_anorak_authority | vesper | VE07 | suit_anorak |
| suit_anorak_ecologist | vesper | VE13 | suit_anorak |
| suit_anorak_mercenary | vesper | VE18 | suit_anorak |
| suit_anorak_scavenger | vesper | VE24 | suit_anorak |
| suit_berill_anarchist | vesper | VE01 | suit_berill |
| suit_berill_authority | vesper | VE06 | suit_berill |
| suit_berill_ecologist | vesper | VE10 | suit_berill |
| suit_berill_looted | vesper | VE15 | suit_berill |
| suit_berill_mercenary | vesper | VE19 | suit_berill |
| suit_berill_scavenger | vesper | VE24 | suit_berill |
| suit_cs1_ecologist | vesper | VE01 | suit_cs1 |
| suit_cs1_scavenger | vesper | VE24 | suit_cs1 |
| suit_cs2_ecologist | vesper | VE01 | suit_cs2 |
| suit_cs2_scavenger | vesper | VE24 | suit_cs2 |
| suit_cs3_ecologist | vesper | VE01 | suit_cs3 |
| suit_io7a_anarchist | vesper | VE01 | suit_io7a |
| suit_io7a_authority | vesper | VE05 | suit_io7a |
| suit_io7a_ecologist | vesper | VE09 | suit_io7a |
| suit_io7a_fanatic | vesper | VE13 | suit_io7a |
| suit_io7a_looted | vesper | VE16 | suit_io7a |
| suit_io7a_mercenary | vesper | VE20 | suit_io7a |
| suit_io7a_scavenger | vesper | VE24 | suit_io7a |
| suit_mailjacket_anarchist | vesper | VE01 | suit_mailjacket |
| suit_mailjacket_authority | vesper | VE07 | suit_mailjacket |
| suit_mailjacket_ecologist | vesper | VE13 | suit_mailjacket |
| suit_mailjacket_mercenary | vesper | VE18 | suit_mailjacket |
| suit_mailjacket_scavenger | vesper | VE24 | suit_mailjacket |
| suit_nbc_anarchist | vesper | VE01 | suit_nbc |
| suit_nbc_authority | vesper | VE13 | suit_nbc |
| suit_nbc_fanatic | vesper | VE24 | suit_nbc |
| suit_ps5m_anarchist | vesper | VE01 | suit_ps5m |
| suit_ps5m_authority | vesper | VE07 | suit_ps5m |
| suit_ps5m_ecologist | vesper | VE13 | suit_ps5m |
| suit_ps5m_fanatic | vesper | VE18 | suit_ps5m |
| suit_ps5m_mercenary | vesper | VE24 | suit_ps5m |
| suit_seva_anarchist | vesper | VE01 | suit_seva |
| suit_seva_authority | vesper | VE07 | suit_seva |
| suit_seva_ecologist | vesper | VE13 | suit_seva |
| suit_seva_fanatic | vesper | VE18 | suit_seva |
| suit_seva_mercenary | vesper | VE24 | suit_seva |
| suit_skat10_anarchist | vesper | VE01 | suit_skat10 |
| suit_skat10_authority | vesper | VE07 | suit_skat10 |
| suit_skat10_ecologist | vesper | VE13 | suit_skat10 |
| suit_skat10_looted | vesper | VE18 | suit_skat10 |
| suit_skat10_mercenary | vesper | VE24 | suit_skat10 |
| suit_skat9_anarchist | vesper | VE01 | suit_skat9 |
| suit_skat9_authority | vesper | VE06 | suit_skat9 |
| suit_skat9_ecologist | vesper | VE10 | suit_skat9 |
| suit_skat9_fanatic | vesper | VE15 | suit_skat9 |
| suit_skat9_looted | vesper | VE19 | suit_skat9 |
| suit_skat9_scavenger | vesper | VE24 | suit_skat9 |
| suit_sunrise_anarchist | vesper | VE01 | suit_sunrise |
| suit_sunrise_authority | vesper | VE06 | suit_sunrise |
| suit_sunrise_fanatic | vesper | VE10 | suit_sunrise |
| suit_sunrise_looted | vesper | VE15 | suit_sunrise |
| suit_sunrise_mercenary | vesper | VE19 | suit_sunrise |
| suit_sunrise_scavenger | vesper | VE24 | suit_sunrise |
| suit_wind_anarchist | vesper | VE01 | suit_wind |
| suit_wind_authority | vesper | VE09 | suit_wind |
| suit_wind_fanatic | vesper | VE16 | suit_wind |
| suit_wind_looted | vesper | VE24 | suit_wind |

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
