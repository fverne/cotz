# Current progression unlock ledger

Generated from authoritative town definitions and their compiled purchase prerequisites.
Regenerate: `python3 docs/npc-overhaul/tools/progression_rewards.py --write`.
Verify: `python3 docs/npc-overhaul/tools/progression_rewards.py --check`.

**417 active steps; 416 have functional unlocks; 0 have TODO-only unlock plans;
17 have multiple assigned unlocks; 1 have no assigned unlock.**

Purchase access is local to the seller. Canonical owners define equipment tier dependencies, not shared shop access.
Medicine uses independent family branches. Listed starter supplies are available immediately.
Stock values are total bonuses above the future base capacity, not additive grants or automatic refills.
Default vendor quantities, prices and refill policy are outside this allocation pass.

TODO entries are authoring metadata only: no entitlement, menu, payout or system is implemented for them.
Their proposed terms require implementation and balance review before activation. Progression item gifts,
town service credits and discounts are disabled. Each active step grants an implemented unlock or completion cash.
TODO plans alone never satisfy reward coverage. Empty steps are reported without restoring excluded items. Each cosmetic finish remains appearance-only.

Validation passed.

## Coverage by contact

| Contact | Steps | Functional coverage | Placeholder-only | Multiple unlocks |
| --- | ---: | ---: | ---: | ---: |
| arena-master | 0 | 0 | 0 | 0 |
| atlas | 8 | 8 | 0 | 0 |
| ballast | 12 | 12 | 0 | 0 |
| beanstalk | 15 | 15 | 0 | 0 |
| boss | 8 | 8 | 0 | 0 |
| brass | 46 | 46 | 0 | 0 |
| carbon | 19 | 19 | 0 | 0 |
| cleaner | 12 | 12 | 0 | 0 |
| egghead | 3 | 3 | 0 | 0 |
| gasket | 37 | 37 | 0 | 0 |
| haggler | 19 | 19 | 0 | 0 |
| intern | 3 | 3 | 0 | 0 |
| jitters | 18 | 18 | 0 | 0 |
| latch | 12 | 12 | 0 | 0 |
| ledger | 12 | 12 | 0 | 0 |
| mute | 9 | 8 | 0 | 0 |
| old-timer | 9 | 9 | 0 | 3 |
| quartermaster | 13 | 13 | 0 | 0 |
| smartass | 26 | 26 | 0 | 0 |
| spicy-lemon | 30 | 30 | 0 | 0 |
| spool | 11 | 11 | 0 | 0 |
| spoor | 12 | 12 | 0 | 0 |
| suture | 27 | 27 | 0 | 13 |
| technut | 15 | 15 | 0 | 1 |
| the-original | 0 | 0 | 0 | 0 |
| vesper | 17 | 17 | 0 | 0 |
| wake | 24 | 24 | 0 | 0 |

## Every progression step

| Contact | Step | Functional unlocks | TODO unlocks | Supplementary rewards |
| --- | --- | --- | --- | --- |
| atlas | v3/binoculars/binoculars_2 | Purchase: binoculars_2 | — | 450 rubles |
| atlas | v3/binoculars/binoculars_1 | Purchase: binoculars_1 | — | 1300 rubles |
| atlas | v3/binoculars/binoculars_4 | Purchase: binoculars_4 | — | 2150 rubles |
| atlas | v3/binoculars/binoculars_3 | Purchase: binoculars_3 | — | 3000 rubles |
| atlas | v3/instruments/geigercounter | Purchase: geigercounter | — | 450 rubles |
| atlas | v3/instruments/gpstracker | Purchase: gpstracker | — | 3000 rubles |
| atlas | v3/anomaly-detector/anomalydetector | Purchase: anomalydetector | — | 450 rubles |
| atlas | v3/headlamp/headlamp | Purchase: headlamp | — | 450 rubles |
| ballast | v3/hideout/01 | Hideout improvements 1 | — | 450 rubles |
| ballast | v3/hideout/02 | Hideout improvements 2 | — | 650 rubles |
| ballast | v3/hideout/03 | Hideout improvements 3 | — | 900 rubles |
| ballast | v3/hideout/04 | Hideout improvements 4 | — | 1100 rubles |
| ballast | v3/hideout/05 | Hideout improvements 5 | — | 1350 rubles |
| ballast | v3/hideout/06 | Hideout improvements 6 | — | 1600 rubles |
| ballast | v3/hideout/07 | Hideout improvements 7 | — | 1800 rubles |
| ballast | v3/hideout/08 | Hideout improvements 8 | — | 2050 rubles |
| ballast | v3/hideout/09 | Hideout improvements 9 | — | 2300 rubles |
| ballast | v3/hideout/10 | Hideout improvements 10 | — | 2500 rubles |
| ballast | v3/hideout/11 | Hideout improvements 11 | — | 2750 rubles |
| ballast | v3/hideout/12 | Hideout improvements 12 | — | 3000 rubles |
| beanstalk | v3/suppressors/tundrasuppressor | Purchase: tundrasuppressor | — | 450 rubles |
| beanstalk | v3/suppressors/cobrasuppressor | Purchase: cobrasuppressor | — | 1300 rubles |
| beanstalk | v3/suppressors/pbssuppressor | Purchase: pbssuppressor | — | 2150 rubles |
| beanstalk | v3/suppressors/sakersuppressor | Purchase: sakersuppressor | — | 3000 rubles |
| beanstalk | v3/red-dots/trijiconrmr | Purchase: trijiconrmr | — | 450 rubles |
| beanstalk | v3/red-dots/kobra | Purchase: kobra | — | 950 rubles |
| beanstalk | v3/red-dots/microt1 | Purchase: microt1 | — | 1450 rubles |
| beanstalk | v3/red-dots/eotech | Purchase: eotech | — | 1950 rubles |
| beanstalk | v3/red-dots/cmore | Purchase: cmore | — | 2450 rubles |
| beanstalk | v3/red-dots/aimpoint | Purchase: aimpoint | — | 3000 rubles |
| beanstalk | v3/optics/kingarmsmr | Purchase: kingarmsmr | — | 450 rubles |
| beanstalk | v3/optics/pso1 | Purchase: pso1 | — | 1050 rubles |
| beanstalk | v3/optics/shortdot | Purchase: shortdot | — | 1700 rubles |
| beanstalk | v3/optics/acog | Purchase: acog | — | 2350 rubles |
| beanstalk | v3/optics/nightforce | Purchase: nightforce | — | 3000 rubles |
| boss | v3/helmets/helm_operator_rus_1 | Purchase: helm_operator_rus_1 | — | 450 rubles |
| boss | v3/helmets/headwear_cs4 | Purchase: headwear_cs4 | — | 800 rubles |
| boss | v3/helmets/headwear_screen | Purchase: headwear_screen | — | 1150 rubles |
| boss | v3/helmets/helm_sphere08 | Purchase: helm_sphere08 | — | 1500 rubles |
| boss | v3/helmets/helm_sphere12 | Purchase: helm_sphere12 | — | 1900 rubles |
| boss | v3/helmets/helm_operator_nato | Purchase: helm_operator_nato | — | 2250 rubles |
| boss | v3/helmets/headwear_pracs | Purchase: headwear_pracs | — | 2600 rubles |
| boss | v3/helmets/headwear_psz12 | Purchase: headwear_psz12 | — | 3000 rubles |
| brass | v3/regular-ammo/22lr | Stock: 22lr +1 total | — | 450 rubles |
| brass | v3/regular-ammo/762x25 | Stock: 762x25 +1 total | — | 550 rubles |
| brass | v3/regular-ammo/45acp41 | Stock: 45acp41 +1 total | — | 650 rubles |
| brass | v3/regular-ammo/9x19 | Stock: 9x19 +1 total | — | 750 rubles |
| brass | v3/regular-ammo/45acp | Stock: 45acp +1 total | — | 850 rubles |
| brass | v3/regular-ammo/545x39 | Purchase: 545x39 | — | 1000 rubles |
| brass | v3/regular-ammo/12gauge | Stock: 12gauge +1 total | — | 1100 rubles |
| brass | v3/regular-ammo/762x39 | Purchase: 762x39 | — | 1200 rubles |
| brass | v3/regular-ammo/556x45 | Purchase: 556x45 | — | 1300 rubles |
| brass | v3/regular-ammo/9x18 | Stock: 9x18 +1 total | — | 1400 rubles |
| brass | v3/regular-ammo/762x54 | Purchase: 762x54 | — | 1550 rubles |
| brass | v3/regular-ammo/357magnum | Purchase: 357magnum | — | 1650 rubles |
| brass | v3/regular-ammo/9x39 | Purchase: 9x39 | — | 1750 rubles |
| brass | v3/regular-ammo/44magnum | Purchase: 44magnum | — | 1850 rubles |
| brass | v3/regular-ammo/9x21 | Purchase: 9x21 | — | 2000 rubles |
| brass | v3/regular-ammo/762x51 | Purchase: 762x51 | — | 2100 rubles |
| brass | v3/regular-ammo/500magnum | Purchase: 500magnum | — | 2200 rubles |
| brass | v3/regular-ammo/338lapua | Purchase: 338lapua | — | 2300 rubles |
| brass | v3/regular-ammo/50ae | Purchase: 50ae | — | 2400 rubles |
| brass | v3/regular-ammo/57x28 | Purchase: 57x28 | — | 2550 rubles |
| brass | v3/regular-ammo/127x55 | Purchase: 127x55 | — | 2650 rubles |
| brass | v3/regular-ammo/145x114 | Purchase: 145x114 | — | 2750 rubles |
| brass | v3/regular-ammo/700nitro | Purchase: 700nitro | — | 2850 rubles |
| brass | v3/regular-ammo/93x64 | Purchase: 93x64 | — | 3000 rubles |
| brass | v3/hp-ammo/22lrhp | Barter: 2 boxes 22lr for one box 22lrhp | — | 450 rubles |
| brass | v3/hp-ammo/762x25hp | Barter: 2 boxes 762x25 for one box 762x25hp | — | 550 rubles |
| brass | v3/hp-ammo/9x19hp | Barter: 2 boxes 9x19 for one box 9x19hp | — | 700 rubles |
| brass | v3/hp-ammo/45acphp | Barter: 2 boxes 45acp for one box 45acphp | — | 850 rubles |
| brass | v3/hp-ammo/545x39hp | Barter: 2 boxes 545x39 for one box 545x39hp | — | 1000 rubles |
| brass | v3/hp-ammo/762x39hp | Barter: 2 boxes 762x39 for one box 762x39hp | — | 1150 rubles |
| brass | v3/hp-ammo/556x45hp | Barter: 2 boxes 556x45 for one box 556x45hp | — | 1300 rubles |
| brass | v3/hp-ammo/9x18hp | Barter: 2 boxes 9x18 for one box 9x18hp | — | 1400 rubles |
| brass | v3/hp-ammo/762x54hp | Barter: 2 boxes 762x54 for one box 762x54hp | — | 1550 rubles |
| brass | v3/hp-ammo/357magnumhp | Barter: 2 boxes 357magnum for one box 357magnumhp | — | 1700 rubles |
| brass | v3/hp-ammo/9x39hp | Barter: 2 boxes 9x39 for one box 9x39hp | — | 1850 rubles |
| brass | v3/hp-ammo/44magnumhp | Barter: 2 boxes 44magnum for one box 44magnumhp | — | 2000 rubles |
| brass | v3/hp-ammo/9x21hp | Barter: 2 boxes 9x21 for one box 9x21hp | — | 2150 rubles |
| brass | v3/hp-ammo/762x51hp | Barter: 2 boxes 762x51 for one box 762x51hp | — | 2250 rubles |
| brass | v3/hp-ammo/500magnumhp | Barter: 2 boxes 500magnum for one box 500magnumhp | — | 2400 rubles |
| brass | v3/hp-ammo/338lapuahp | Barter: 2 boxes 338lapua for one box 338lapuahp | — | 2550 rubles |
| brass | v3/hp-ammo/50aehp | Barter: 2 boxes 50ae for one box 50aehp | — | 2700 rubles |
| brass | v3/hp-ammo/57x28hp | Barter: 2 boxes 57x28 for one box 57x28hp | — | 2850 rubles |
| brass | v3/hp-ammo/145x114hp | Barter: 2 boxes 145x114 for one box 145x114hp | — | 3000 rubles |
| brass | v3/shotgun-loads/12gaugetr | Purchase: 12gaugetr | — | 450 rubles |
| brass | v3/shotgun-loads/12gaugedt | Purchase: 12gaugedt | — | 1700 rubles |
| brass | v3/shotgun-loads/12gaugemg | Purchase: 12gaugemg | — | 3000 rubles |
| carbon | v3/ap-ammo/22lrap | Barter: 3 boxes 22lr for one box 22lrap | — | 450 rubles |
| carbon | v3/ap-ammo/762x25ap | Barter: 3 boxes 762x25 for one box 762x25ap | — | 550 rubles |
| carbon | v3/ap-ammo/9x19ap | Barter: 3 boxes 9x19 for one box 9x19ap | — | 700 rubles |
| carbon | v3/ap-ammo/45acpap | Barter: 3 boxes 45acp for one box 45acpap | — | 850 rubles |
| carbon | v3/ap-ammo/545x39ap | Barter: 3 boxes 545x39 for one box 545x39ap | — | 1000 rubles |
| carbon | v3/ap-ammo/762x39ap | Barter: 3 boxes 762x39 for one box 762x39ap | — | 1150 rubles |
| carbon | v3/ap-ammo/556x45ap | Barter: 3 boxes 556x45 for one box 556x45ap | — | 1300 rubles |
| carbon | v3/ap-ammo/9x18ap | Barter: 3 boxes 9x18 for one box 9x18ap | — | 1400 rubles |
| carbon | v3/ap-ammo/762x54ap | Barter: 3 boxes 762x54 for one box 762x54ap | — | 1550 rubles |
| carbon | v3/ap-ammo/357magnumap | Barter: 3 boxes 357magnum for one box 357magnumap | — | 1700 rubles |
| carbon | v3/ap-ammo/9x39ap | Barter: 3 boxes 9x39 for one box 9x39ap | — | 1850 rubles |
| carbon | v3/ap-ammo/44magnumap | Barter: 3 boxes 44magnum for one box 44magnumap | — | 2000 rubles |
| carbon | v3/ap-ammo/9x21ap | Barter: 3 boxes 9x21 for one box 9x21ap | — | 2150 rubles |
| carbon | v3/ap-ammo/762x51ap | Barter: 3 boxes 762x51 for one box 762x51ap | — | 2250 rubles |
| carbon | v3/ap-ammo/500magnumap | Barter: 3 boxes 500magnum for one box 500magnumap | — | 2400 rubles |
| carbon | v3/ap-ammo/338lapuaap | Barter: 3 boxes 338lapua for one box 338lapuaap | — | 2550 rubles |
| carbon | v3/ap-ammo/50aeap | Barter: 3 boxes 50ae for one box 50aeap | — | 2700 rubles |
| carbon | v3/ap-ammo/57x28ap | Barter: 3 boxes 57x28 for one box 57x28ap | — | 2850 rubles |
| carbon | v3/ap-ammo/145x114ap | Barter: 3 boxes 145x114 for one box 145x114ap | — | 3000 rubles |
| cleaner | v3/hideout/01 | Hideout improvements 1 | — | 450 rubles |
| cleaner | v3/hideout/02 | Hideout improvements 2 | — | 650 rubles |
| cleaner | v3/hideout/03 | Hideout improvements 3 | — | 900 rubles |
| cleaner | v3/hideout/04 | Hideout improvements 4 | — | 1100 rubles |
| cleaner | v3/hideout/05 | Hideout improvements 5 | — | 1350 rubles |
| cleaner | v3/hideout/06 | Hideout improvements 6 | — | 1600 rubles |
| cleaner | v3/hideout/07 | Hideout improvements 7 | — | 1800 rubles |
| cleaner | v3/hideout/08 | Hideout improvements 8 | — | 2050 rubles |
| cleaner | v3/hideout/09 | Hideout improvements 9 | — | 2300 rubles |
| cleaner | v3/hideout/10 | Hideout improvements 10 | — | 2500 rubles |
| cleaner | v3/hideout/11 | Hideout improvements 11 | — | 2750 rubles |
| cleaner | v3/hideout/12 | Hideout improvements 12 | — | 3000 rubles |
| egghead | v3/science-suits/suit_ssp99 | Purchase: suit_ssp99 | — | 450 rubles |
| egghead | v3/science-suits/suit_ssp99m | Purchase: suit_ssp99m | — | 1700 rubles |
| egghead | v3/science-suits/suit_seva | Purchase: suit_seva | — | 3000 rubles |
| gasket | v3/sidearms/tokarev | Purchase: tokarev | — | 450 rubles |
| gasket | v3/sidearms/makarov | Purchase: makarov | — | 550 rubles |
| gasket | v3/sidearms/lugerp08 | Purchase: lugerp08 | — | 650 rubles |
| gasket | v3/sidearms/cz52 | Purchase: cz52 | — | 750 rubles |
| gasket | v3/sidearms/c96 | Purchase: c96 | — | 850 rubles |
| gasket | v3/sidearms/lax410s | Purchase: lax410s | — | 950 rubles |
| gasket | v3/sidearms/fort12 | Purchase: fort12 | — | 1050 rubles |
| gasket | v3/sidearms/brhp | Purchase: brhp | — | 1150 rubles |
| gasket | v3/sidearms/beretta92 | Purchase: beretta92 | — | 1250 rubles |
| gasket | v3/sidearms/p99 | Purchase: p99 | — | 1350 rubles |
| gasket | v3/sidearms/glock17 | Purchase: glock17 | — | 1450 rubles |
| gasket | v3/sidearms/m1911 | Purchase: m1911 | — | 1550 rubles |
| gasket | v3/sidearms/stechaps | Purchase: stechaps | — | 1650 rubles |
| gasket | v3/sidearms/glock18 | Purchase: glock18 | — | 1750 rubles |
| gasket | v3/sidearms/g2contender500 | Purchase: g2contender500 | — | 1850 rubles |
| gasket | v3/sidearms/mr96 | Purchase: mr96 | — | 1950 rubles |
| gasket | v3/sidearms/swr8 | Purchase: swr8 | — | 2050 rubles |
| gasket | v3/sidearms/taurusjudge | Purchase: taurusjudge | — | 2150 rubles |
| gasket | v3/sidearms/swmodel29 | Purchase: swmodel29 | — | 2250 rubles |
| gasket | v3/sidearms/taurusragingbull | Purchase: taurusragingbull | — | 2350 rubles |
| gasket | v3/sidearms/mateba | Purchase: mateba | — | 2450 rubles |
| gasket | v3/sidearms/deagle44 | Purchase: deagle44 | — | 2550 rubles |
| gasket | v3/sidearms/m1911chic | Purchase: m1911chic | — | 2650 rubles |
| gasket | v3/sidearms/fiveseven | Purchase: fiveseven | — | 2750 rubles |
| gasket | v3/sidearms/deagle | Purchase: deagle | — | 2850 rubles |
| gasket | v3/sidearms/sw500 | Purchase: sw500 | — | 3000 rubles |
| gasket | v3/strong-alcohol/drink_moonshine | Purchase: drink_moonshine | — | 450 rubles |
| gasket | v3/strong-alcohol/drink_vodka_2 | Purchase: drink_vodka_2 | — | 700 rubles |
| gasket | v3/strong-alcohol/drink_vodka_1 | Purchase: drink_vodka_1 | — | 950 rubles |
| gasket | v3/strong-alcohol/drink_vodka_3 | Purchase: drink_vodka_3 | — | 1200 rubles |
| gasket | v3/strong-alcohol/drink_wine | Purchase: drink_wine | — | 1450 rubles |
| gasket | v3/strong-alcohol/drink_vodka_6 | Purchase: drink_vodka_6 | — | 1700 rubles |
| gasket | v3/strong-alcohol/drink_vodka_4 | Purchase: drink_vodka_4 | — | 1950 rubles |
| gasket | v3/strong-alcohol/drink_spirit_1 | Purchase: drink_spirit_1 | — | 2200 rubles |
| gasket | v3/strong-alcohol/drink_vodka_5 | Purchase: drink_vodka_5 | — | 2450 rubles |
| gasket | v3/strong-alcohol/drink_spirit_2 | Purchase: drink_spirit_2 | — | 2700 rubles |
| gasket | v3/strong-alcohol/drink_spirit_3 | Purchase: drink_spirit_3 | — | 3000 rubles |
| haggler | v3/pact-cqb/toz106 | Purchase: toz106 | — | 450 rubles |
| haggler | v3/pact-cqb/mp27 | Purchase: mp27 | — | 550 rubles |
| haggler | v3/pact-cqb/toz66short | Purchase: toz66short | — | 700 rubles |
| haggler | v3/pact-cqb/skorpion | Purchase: skorpion | — | 850 rubles |
| haggler | v3/pact-cqb/toz34short | Purchase: toz34short | — | 1000 rubles |
| haggler | v3/pact-cqb/kiparis | Purchase: kiparis | — | 1150 rubles |
| haggler | v3/pact-cqb/toz66 | Purchase: toz66 | — | 1300 rubles |
| haggler | v3/pact-cqb/ppsh | Purchase: ppsh | — | 1400 rubles |
| haggler | v3/pact-cqb/toz34 | Purchase: toz34 | — | 1550 rubles |
| haggler | v3/pact-cqb/pp2000 | Purchase: pp2000 | — | 1700 rubles |
| haggler | v3/pact-cqb/toz194 | Purchase: toz194 | — | 1850 rubles |
| haggler | v3/pact-cqb/pp1901vityaz | Purchase: pp1901vityaz | — | 2000 rubles |
| haggler | v3/pact-cqb/saiga410 | Purchase: saiga410 | — | 2150 rubles |
| haggler | v3/pact-cqb/gepardpdw | Purchase: gepardpdw | — | 2250 rubles |
| haggler | v3/pact-cqb/pp19 | Purchase: pp19 | — | 2400 rubles |
| haggler | v3/pact-cqb/mp153 | Purchase: mp153 | — | 2550 rubles |
| haggler | v3/pact-cqb/sr2 | Purchase: sr2 | — | 2700 rubles |
| haggler | v3/pact-cqb/toz34special | Purchase: toz34special | — | 2850 rubles |
| haggler | v3/pact-cqb/saiga12 | Purchase: saiga12 | — | 3000 rubles |
| intern | v3/artifact-detectors/detectorecho | Purchase: detectorecho | — | 450 rubles |
| intern | v3/artifact-detectors/detectorbear | Purchase: detectorbear | — | 1700 rubles |
| intern | v3/artifact-detectors/detectorveles | Purchase: detectorveles | — | 3000 rubles |
| jitters | v3/antipsychotics/medic_antipsychotic_1 | Purchase: medic_antipsychotic_1 | — | 450 rubles |
| jitters | v3/antipsychotics/medic_antipsychotic_2 | Purchase: medic_antipsychotic_2 | — | 1700 rubles |
| jitters | v3/antipsychotics/medic_antipsychotic_3 | Purchase: medic_antipsychotic_3 | — | 3000 rubles |
| jitters | v3/psy-healing/medic_psyheal_1 | Purchase: medic_psyheal_1 | — | 450 rubles |
| jitters | v3/psy-healing/medic_psyheal_2 | Purchase: medic_psyheal_2 | — | 3000 rubles |
| jitters | v3/stimpaks/medic_stimpak_1 | Purchase: medic_stimpak_1 | — | 450 rubles |
| jitters | v3/stimpaks/medic_stimpak_2 | Purchase: medic_stimpak_2 | — | 1700 rubles |
| jitters | v3/stimpaks/medic_stimpak_3 | Purchase: medic_stimpak_3 | — | 3000 rubles |
| jitters | v3/medkits/medic_medkit_1 | Stock: medic_medkit_1 +1 total | — | 450 rubles |
| jitters | v3/medkits/medic_medkit_2 | Purchase: medic_medkit_2 | — | 950 rubles |
| jitters | v3/medkits/medic_medkit_3 | Purchase: medic_medkit_3 | — | 1450 rubles |
| jitters | v3/medkits/medic_medkit_4 | Purchase: medic_medkit_4 | — | 1950 rubles |
| jitters | v3/medkits/medic_medkit_5 | Purchase: medic_medkit_5 | — | 2450 rubles |
| jitters | v3/medkits/medic_medkit_6 | Purchase: medic_medkit_6 | — | 3000 rubles |
| jitters | v3/bandages/medic_bandage_2 | Purchase: medic_bandage_2 | — | 450 rubles |
| jitters | v3/bandages/medic_bandage_3 | Purchase: medic_bandage_3 | — | 3000 rubles |
| jitters | v3/antirad/medic_antirad_1 | Purchase: medic_antirad_1 | — | 450 rubles |
| jitters | v3/antirad/medic_antirad_2 | Purchase: medic_antirad_2 | — | 3000 rubles |
| latch | v3/masks-headwear/mask_cloth | Purchase: mask_cloth | — | 450 rubles |
| latch | v3/masks-headwear/mask_halfmask | Purchase: mask_halfmask | — | 650 rubles |
| latch | v3/masks-headwear/mask_respirator | Purchase: mask_respirator | — | 900 rubles |
| latch | v3/masks-headwear/mask_gp5 | Purchase: mask_gp5 | — | 1100 rubles |
| latch | v3/masks-headwear/mask_eo20 | Purchase: mask_eo20 | — | 1350 rubles |
| latch | v3/masks-headwear/helm_operator_rus_2 | Purchase: helm_operator_rus_2 | — | 1600 rubles |
| latch | v3/masks-headwear/headwear_cs1 | Purchase: headwear_cs1 | — | 1800 rubles |
| latch | v3/masks-headwear/mask_pmk3 | Purchase: mask_pmk3 | — | 2050 rubles |
| latch | v3/masks-headwear/headwear_cs2 | Purchase: headwear_cs2 | — | 2300 rubles |
| latch | v3/masks-headwear/mask_xm40 | Purchase: mask_xm40 | — | 2500 rubles |
| latch | v3/masks-headwear/mask_m40 | Purchase: mask_m40 | — | 2750 rubles |
| latch | v3/masks-headwear/mask_m50 | Purchase: mask_m50 | — | 3000 rubles |
| ledger | v3/hideout/01 | Hideout improvements 1 | — | 450 rubles |
| ledger | v3/hideout/02 | Hideout improvements 2 | — | 650 rubles |
| ledger | v3/hideout/03 | Hideout improvements 3 | — | 900 rubles |
| ledger | v3/hideout/04 | Hideout improvements 4 | — | 1100 rubles |
| ledger | v3/hideout/05 | Hideout improvements 5 | — | 1350 rubles |
| ledger | v3/hideout/06 | Hideout improvements 6 | — | 1600 rubles |
| ledger | v3/hideout/07 | Hideout improvements 7 | — | 1800 rubles |
| ledger | v3/hideout/08 | Hideout improvements 8 | — | 2050 rubles |
| ledger | v3/hideout/09 | Hideout improvements 9 | — | 2300 rubles |
| ledger | v3/hideout/10 | Hideout improvements 10 | — | 2500 rubles |
| ledger | v3/hideout/11 | Hideout improvements 11 | — | 2750 rubles |
| ledger | v3/hideout/12 | Hideout improvements 12 | — | 3000 rubles |
| mute | v3/stalkernet/networkSearch | STALKERnet search | — | 450 rubles |
| mute | v3/stalkernet/networkSquads | STALKERnet squad filter | — | 750 rubles |
| mute | v3/stalkernet/networkRanking | STALKERnet ranks and reputation | — | 1050 rubles |
| mute | v3/stalkernet/emissionWarnings | Emission warnings | — | 1400 rubles |
| mute | v3/stalkernet/networkActivity | STALKERnet activity counters | — | 1700 rubles |
| mute | v3/stalkernet/eventBroadcasts | Event broadcasts | — | 2000 rubles |
| mute | v3/stalkernet/networkLocation | STALKERnet location tracking | — | 2350 rubles |
| mute | v3/stalkernet/networkRemote | — | — | 2650 rubles |
| mute | v3/stalkernet/networkDossier | STALKERnet full career dossier | — | 3000 rubles |
| old-timer | v3/knives/knife2 | Purchase: knife2 | — | 450 rubles |
| old-timer | v3/knives/knife3 | Purchase: knife3 | — | 1700 rubles |
| old-timer | v3/knives/knife4 | Purchase: knife4 | — | 3000 rubles |
| old-timer | v3/melee/crowbar | Purchase: bat; Purchase: crowbar | — | 450 rubles |
| old-timer | v3/melee/hatchet | Purchase: hatchet; Purchase: machete | — | 1700 rubles |
| old-timer | v3/melee/sledgehammer | Purchase: fireaxe; Purchase: fubar; Purchase: sledgehammer | — | 3000 rubles |
| old-timer | v3/cooking/hightiercooker | Purchase: hightiercooker | — | 450 rubles |
| old-timer | v3/hidestashers/hidestasher_cleaningkit | Purchase: hidestasher_cleaningkit | — | 450 rubles |
| old-timer | v3/hidestashers/hidestasher_shovel | Purchase: hidestasher_shovel | — | 3000 rubles |
| quartermaster | v3/nato-rifles/rugermini14 | Purchase: rugermini14 | — | 450 rubles |
| quartermaster | v3/nato-rifles/famas | Purchase: famas | — | 650 rubles |
| quartermaster | v3/nato-rifles/l85 | Purchase: l85 | — | 850 rubles |
| quartermaster | v3/nato-rifles/m16a4 | Purchase: m16a4 | — | 1050 rubles |
| quartermaster | v3/nato-rifles/lr300 | Purchase: lr300 | — | 1300 rubles |
| quartermaster | v3/nato-rifles/sg552 | Purchase: sg552 | — | 1500 rubles |
| quartermaster | v3/nato-rifles/g36c | Purchase: g36c | — | 1700 rubles |
| quartermaster | v3/nato-rifles/aug | Purchase: aug | — | 1900 rubles |
| quartermaster | v3/nato-rifles/f2000 | Purchase: f2000 | — | 2150 rubles |
| quartermaster | v3/nato-rifles/hk416 | Purchase: hk416 | — | 2350 rubles |
| quartermaster | v3/nato-rifles/g3a3 | Purchase: g3a3 | — | 2550 rubles |
| quartermaster | v3/nato-rifles/fnfal | Purchase: fnfal | — | 2750 rubles |
| quartermaster | v3/nato-rifles/m14 | Purchase: m14 | — | 3000 rubles |
| smartass | v3/nato-cqb/c96carbine | Purchase: c96carbine | — | 450 rubles |
| smartass | v3/nato-cqb/stoegerddshort | Purchase: stoegerddshort | — | 550 rubles |
| smartass | v3/nato-cqb/sten | Purchase: sten | — | 650 rubles |
| smartass | v3/nato-cqb/stoegerdd | Purchase: stoegerdd | — | 750 rubles |
| smartass | v3/nato-cqb/mac11 | Purchase: mac11 | — | 850 rubles |
| smartass | v3/nato-cqb/mp34 | Purchase: mp34 | — | 1000 rubles |
| smartass | v3/nato-cqb/m3supershort | Purchase: m3supershort | — | 1100 rubles |
| smartass | v3/nato-cqb/mp40 | Purchase: mp40 | — | 1200 rubles |
| smartass | v3/nato-cqb/kp31 | Purchase: kp31 | — | 1300 rubles |
| smartass | v3/nato-cqb/mossberg500 | Purchase: mossberg500 | — | 1400 rubles |
| smartass | v3/nato-cqb/ar159mm | Purchase: ar159mm | — | 1550 rubles |
| smartass | v3/nato-cqb/mp5k | Purchase: mp5k | — | 1650 rubles |
| smartass | v3/nato-cqb/uzi | Purchase: uzi | — | 1750 rubles |
| smartass | v3/nato-cqb/ithaca37 | Purchase: ithaca37 | — | 1850 rubles |
| smartass | v3/nato-cqb/sterling | Purchase: sterling | — | 2000 rubles |
| smartass | v3/nato-cqb/mp5 | Purchase: mp5 | — | 2100 rubles |
| smartass | v3/nato-cqb/m1887 | Purchase: m1887 | — | 2200 rubles |
| smartass | v3/nato-cqb/ump45 | Purchase: ump45 | — | 2300 rubles |
| smartass | v3/nato-cqb/rem870ae | Purchase: rem870ae | — | 2400 rubles |
| smartass | v3/nato-cqb/m3super90 | Purchase: m3super90 | — | 2550 rubles |
| smartass | v3/nato-cqb/mp9a1 | Purchase: mp9a1 | — | 2650 rubles |
| smartass | v3/nato-cqb/m1928 | Purchase: m1928 | — | 2750 rubles |
| smartass | v3/nato-cqb/p90 | Purchase: p90 | — | 2850 rubles |
| smartass | v3/nato-cqb/striker | Purchase: striker | — | 3000 rubles |
| smartass | v3/access-cards/accesscard_bunker | Purchase: accesscard_bunker | — | 450 rubles |
| smartass | v3/access-cards/accesscard_laboratory | Purchase: accesscard_laboratory | — | 3000 rubles |
| spicy-lemon | v3/weak-drugs/drug_cigarette_1 | Stock: drug_cigarette_1 +1 total | — | 450 rubles |
| spicy-lemon | v3/weak-drugs/drug_cigarette_2 | Purchase: drug_cigarette_2 | — | 650 rubles |
| spicy-lemon | v3/weak-drugs/drug_mints | Purchase: drug_mints | — | 900 rubles |
| spicy-lemon | v3/weak-drugs/drug_cigarette_3 | Purchase: drug_cigarette_3 | — | 1100 rubles |
| spicy-lemon | v3/weak-drugs/drug_painkillers | Purchase: drug_painkillers | — | 1350 rubles |
| spicy-lemon | v3/weak-drugs/drug_cigarette_5 | Purchase: drug_cigarette_5 | — | 1600 rubles |
| spicy-lemon | v3/weak-drugs/drug_caffeine | Purchase: drug_caffeine | — | 1800 rubles |
| spicy-lemon | v3/weak-drugs/drug_cigarette_4 | Purchase: drug_cigarette_4 | — | 2050 rubles |
| spicy-lemon | v3/weak-drugs/drug_cigar | Purchase: drug_cigar | — | 2300 rubles |
| spicy-lemon | v3/weak-drugs/drug_cigarette_6 | Purchase: drug_cigarette_6 | — | 2500 rubles |
| spicy-lemon | v3/weak-drugs/drug_tobacco_1 | Purchase: drug_tobacco_1 | — | 2750 rubles |
| spicy-lemon | v3/weak-drugs/drug_tobacco_2 | Purchase: drug_tobacco_2 | — | 3000 rubles |
| spicy-lemon | v3/weak-alcohol/drink_canbeer_2 | Purchase: drink_canbeer_2 | — | 450 rubles |
| spicy-lemon | v3/weak-alcohol/drink_canbeer_3 | Purchase: drink_canbeer_3 | — | 650 rubles |
| spicy-lemon | v3/weak-alcohol/drink_canbeer_1 | Purchase: drink_canbeer_1 | — | 900 rubles |
| spicy-lemon | v3/weak-alcohol/drink_bottlebeer_4 | Purchase: drink_bottlebeer_4 | — | 1100 rubles |
| spicy-lemon | v3/weak-alcohol/drink_canbeer_4 | Purchase: drink_canbeer_4 | — | 1350 rubles |
| spicy-lemon | v3/weak-alcohol/drink_canbeer_6 | Purchase: drink_canbeer_6 | — | 1600 rubles |
| spicy-lemon | v3/weak-alcohol/drink_bottlebeer_3 | Purchase: drink_bottlebeer_3 | — | 1800 rubles |
| spicy-lemon | v3/weak-alcohol/drink_bottlebeer_6 | Purchase: drink_bottlebeer_6 | — | 2050 rubles |
| spicy-lemon | v3/weak-alcohol/drink_canbeer_5 | Purchase: drink_canbeer_5 | — | 2300 rubles |
| spicy-lemon | v3/weak-alcohol/drink_bottlebeer_2 | Purchase: drink_bottlebeer_2 | — | 2500 rubles |
| spicy-lemon | v3/weak-alcohol/drink_bottlebeer_5 | Purchase: drink_bottlebeer_5 | — | 2750 rubles |
| spicy-lemon | v3/weak-alcohol/drink_bottlebeer_1 | Purchase: drink_bottlebeer_1 | — | 3000 rubles |
| spicy-lemon | v3/energy-drinks/drink_energydrink_4 | Stock: drink_energydrink_4 +1 total | — | 450 rubles |
| spicy-lemon | v3/energy-drinks/drink_energydrink_2 | Purchase: drink_energydrink_2 | — | 950 rubles |
| spicy-lemon | v3/energy-drinks/drink_energydrink_1 | Purchase: drink_energydrink_1 | — | 1450 rubles |
| spicy-lemon | v3/energy-drinks/drink_energydrink_5 | Purchase: drink_energydrink_5 | — | 1950 rubles |
| spicy-lemon | v3/energy-drinks/drink_energydrink_6 | Purchase: drink_energydrink_6 | — | 2450 rubles |
| spicy-lemon | v3/energy-drinks/drink_energydrink_3 | Purchase: drink_energydrink_3 | — | 3000 rubles |
| spool | v3/steel-headwear/helm_tanker | Purchase: helm_tanker | — | 450 rubles |
| spool | v3/steel-headwear/helm_steel_arab | Purchase: helm_steel_arab | — | 1050 rubles |
| spool | v3/steel-headwear/helm_steel_ger | Purchase: helm_steel_ger | — | 1700 rubles |
| spool | v3/steel-headwear/helm_steel_rus | Purchase: helm_steel_rus | — | 2350 rubles |
| spool | v3/steel-headwear/headwear_riot | Purchase: headwear_riot | — | 3000 rubles |
| spool | v3/strong-drugs/drug_adrenaline | Purchase: drug_adrenaline | — | 450 rubles |
| spool | v3/strong-drugs/drug_morphine | Purchase: drug_morphine | — | 950 rubles |
| spool | v3/strong-drugs/drug_marijuana | Purchase: drug_marijuana | — | 1450 rubles |
| spool | v3/strong-drugs/miscaid_swampbrew | Purchase: miscaid_swampbrew | — | 1950 rubles |
| spool | v3/strong-drugs/drug_glucose | Purchase: drug_glucose | — | 2450 rubles |
| spool | v3/strong-drugs/drug_cocaine | Purchase: drug_cocaine | — | 3000 rubles |
| spoor | v3/slow-rifles/mp18 | Purchase: mp18 | — | 450 rubles |
| spoor | v3/slow-rifles/sako85nato | Purchase: sako85nato | — | 650 rubles |
| spoor | v3/slow-rifles/obrez | Purchase: obrez | — | 900 rubles |
| spoor | v3/slow-rifles/w9422357 | Purchase: w9422357 | — | 1100 rubles |
| spoor | v3/slow-rifles/mosin | Purchase: mosin | — | 1350 rubles |
| spoor | v3/slow-rifles/sako85 | Purchase: sako85 | — | 1600 rubles |
| spoor | v3/slow-rifles/w1895 | Purchase: w1895 | — | 1800 rubles |
| spoor | v3/slow-rifles/obrezmalfunction | Purchase: obrezmalfunction | — | 2050 rubles |
| spoor | v3/slow-rifles/sv98 | Purchase: sv98 | — | 2300 rubles |
| spoor | v3/slow-rifles/lax44 | Purchase: lax44 | — | 2500 rubles |
| spoor | v3/slow-rifles/l115 | Purchase: l115 | — | 2750 rubles |
| spoor | v3/slow-rifles/trg42 | Purchase: trg42 | — | 3000 rubles |
| suture | v3/suit-attachments/attachment_ceramicplate_1 | Purchase: attachment_ceramicplate_1 | — | 450 rubles |
| suture | v3/suit-attachments/attachment_steelplate_1 | Purchase: attachment_steelplate_1 | — | 650 rubles |
| suture | v3/suit-attachments/attachment_fabric_1 | Purchase: attachment_fabric_1 | — | 850 rubles |
| suture | v3/suit-attachments/attachment_steelplate_2 | Purchase: attachment_steelplate_2 | — | 1050 rubles |
| suture | v3/suit-attachments/attachment_ceramicplate_2 | Purchase: attachment_ceramicplate_2 | — | 1300 rubles |
| suture | v3/suit-attachments/attachment_fabric_2 | Purchase: attachment_fabric_2 | — | 1500 rubles |
| suture | v3/suit-attachments/attachment_kevlar_1 | Purchase: attachment_kevlar_1 | — | 1700 rubles |
| suture | v3/suit-attachments/attachment_aluframe | Purchase: attachment_aluframe | — | 1900 rubles |
| suture | v3/suit-attachments/attachment_steelplate_3 | Purchase: attachment_steelplate_3 | — | 2150 rubles |
| suture | v3/suit-attachments/attachment_carbonfibre | Purchase: attachment_carbonfibre | — | 2350 rubles |
| suture | v3/suit-attachments/attachment_steelframe | Purchase: attachment_steelframe | — | 2550 rubles |
| suture | v3/suit-attachments/attachment_ceramicplate_3 | Purchase: attachment_ceramicplate_3 | — | 2750 rubles |
| suture | v3/suit-attachments/attachment_kevlar_2 | Purchase: attachment_kevlar_2 | — | 3000 rubles |
| suture | v3/suit-variants/suit_anorak | Conversion: suit_anorak_anarchist; Conversion: suit_anorak_authority; Conversion: suit_anorak_ecologist; Conversion: suit_anorak_mercenary; Conversion: suit_anorak_scavenger | — | 450 rubles |
| suture | v3/suit-variants/suit_mailjacket | Conversion: suit_mailjacket_anarchist; Conversion: suit_mailjacket_authority; Conversion: suit_mailjacket_ecologist; Conversion: suit_mailjacket_mercenary; Conversion: suit_mailjacket_scavenger | — | 600 rubles |
| suture | v3/suit-variants/suit_sunrise | Conversion: suit_sunrise_anarchist; Conversion: suit_sunrise_authority; Conversion: suit_sunrise_fanatic; Conversion: suit_sunrise_mercenary; Conversion: suit_sunrise_scavenger | — | 900 rubles |
| suture | v3/suit-variants/suit_io7a | Conversion: suit_io7a_anarchist; Conversion: suit_io7a_authority; Conversion: suit_io7a_ecologist; Conversion: suit_io7a_fanatic; Conversion: suit_io7a_mercenary; Conversion: suit_io7a_scavenger | — | 1050 rubles |
| suture | v3/suit-variants/suit_cs1 | Conversion: suit_cs1_ecologist; Conversion: suit_cs1_scavenger | — | 1200 rubles |
| suture | v3/suit-variants/suit_wind | Conversion: suit_wind_anarchist; Conversion: suit_wind_authority; Conversion: suit_wind_fanatic | — | 1550 rubles |
| suture | v3/suit-variants/suit_ps5m | Conversion: suit_ps5m_anarchist; Conversion: suit_ps5m_authority; Conversion: suit_ps5m_ecologist; Conversion: suit_ps5m_fanatic; Conversion: suit_ps5m_mercenary | — | 1700 rubles |
| suture | v3/suit-variants/suit_cs2 | Conversion: suit_cs2_ecologist; Conversion: suit_cs2_scavenger | — | 1850 rubles |
| suture | v3/suit-variants/suit_nbc | Conversion: suit_nbc_anarchist; Conversion: suit_nbc_authority; Conversion: suit_nbc_fanatic | — | 2000 rubles |
| suture | v3/suit-variants/suit_berill | Conversion: suit_berill_anarchist; Conversion: suit_berill_authority; Conversion: suit_berill_ecologist; Conversion: suit_berill_mercenary; Conversion: suit_berill_scavenger | — | 2200 rubles |
| suture | v3/suit-variants/suit_cs3 | Conversion: suit_cs3_ecologist | — | 2350 rubles |
| suture | v3/suit-variants/suit_seva | Conversion: suit_seva_anarchist; Conversion: suit_seva_authority; Conversion: suit_seva_ecologist; Conversion: suit_seva_fanatic; Conversion: suit_seva_mercenary | — | 2650 rubles |
| suture | v3/suit-variants/suit_skat10 | Conversion: suit_skat10_anarchist; Conversion: suit_skat10_authority; Conversion: suit_skat10_ecologist; Conversion: suit_skat10_mercenary | — | 2800 rubles |
| suture | v3/suit-variants/suit_skat9 | Conversion: suit_skat9_anarchist; Conversion: suit_skat9_authority; Conversion: suit_skat9_ecologist; Conversion: suit_skat9_fanatic; Conversion: suit_skat9_scavenger | — | 3000 rubles |
| technut | v3/suits/suit_anorak | Stock: suit_anorak +1 total | — | 450 rubles |
| technut | v3/suits/suit_mailjacket | Purchase: suit_mailjacket | — | 600 rubles |
| technut | v3/suits/suit_trenchcoat_black | Purchase: suit_trenchcoat_black; Purchase: suit_trenchcoat_brown; Purchase: suit_trenchcoat_green; Purchase: suit_trenchcoat_tan | — | 800 rubles |
| technut | v3/suits/suit_sunrise | Purchase: suit_sunrise | — | 1000 rubles |
| technut | v3/suits/suit_io7a | Purchase: suit_io7a | — | 1200 rubles |
| technut | v3/suits/suit_cs1 | Purchase: suit_cs1 | — | 1400 rubles |
| technut | v3/suits/suit_wind | Purchase: suit_wind | — | 1600 rubles |
| technut | v3/suits/suit_ps5m | Purchase: suit_ps5m | — | 1800 rubles |
| technut | v3/suits/suit_cs2 | Purchase: suit_cs2 | — | 2000 rubles |
| technut | v3/suits/suit_nbc | Purchase: suit_nbc | — | 2200 rubles |
| technut | v3/suits/suit_berill | Purchase: suit_berill | — | 2400 rubles |
| technut | v3/suits/suit_cs3 | Purchase: suit_cs3 | — | 2600 rubles |
| technut | v3/suits/suit_skat10 | Purchase: suit_skat10 | — | 2800 rubles |
| technut | v3/suits/suit_skat9 | Purchase: suit_skat9 | — | 3000 rubles |
| technut | v3/painting/painting | Suit painting | — | 450 rubles |
| vesper | v3/pact-rifles/saigasemi545 | Purchase: saigasemi545 | — | 450 rubles |
| vesper | v3/pact-rifles/saigasemi | Purchase: saigasemi | — | 600 rubles |
| vesper | v3/pact-rifles/aks74u | Purchase: aks74u | — | 750 rubles |
| vesper | v3/pact-rifles/sks | Purchase: sks | — | 900 rubles |
| vesper | v3/pact-rifles/ak74 | Purchase: ak74 | — | 1050 rubles |
| vesper | v3/pact-rifles/an94k | Purchase: an94k | — | 1200 rubles |
| vesper | v3/pact-rifles/akm | Purchase: akm | — | 1400 rubles |
| vesper | v3/pact-rifles/aek971 | Purchase: aek971 | — | 1550 rubles |
| vesper | v3/pact-rifles/ak12 | Purchase: ak12 | — | 1700 rubles |
| vesper | v3/pact-rifles/rk95 | Purchase: rk95 | — | 1850 rubles |
| vesper | v3/pact-rifles/svt40 | Purchase: svt40 | — | 2000 rubles |
| vesper | v3/pact-rifles/vss | Purchase: vss | — | 2200 rubles |
| vesper | v3/pact-rifles/rpk | Purchase: rpk | — | 2350 rubles |
| vesper | v3/pact-rifles/9a91 | Purchase: 9a91 | — | 2500 rubles |
| vesper | v3/pact-rifles/asval | Purchase: asval | — | 2650 rubles |
| vesper | v3/pact-rifles/svd | Purchase: svd | — | 2800 rubles |
| vesper | v3/pact-rifles/dp28 | Purchase: dp28 | — | 3000 rubles |
| wake | v3/backpacks/backpack_sling | Purchase: backpack_sling | — | 450 rubles |
| wake | v3/backpacks/backpack_duffle | Purchase: backpack_duffle | — | 600 rubles |
| wake | v3/backpacks/backpack_sanitar | Purchase: backpack_sanitar | — | 750 rubles |
| wake | v3/backpacks/backpack_tbag | Purchase: backpack_tbag | — | 900 rubles |
| wake | v3/backpacks/backpack_tourist | Purchase: backpack_tourist | — | 1050 rubles |
| wake | v3/backpacks/backpack_takedown_1 | Purchase: backpack_takedown_1 | — | 1200 rubles |
| wake | v3/backpacks/backpack_takedown_2 | Purchase: backpack_takedown_2 | — | 1400 rubles |
| wake | v3/backpacks/backpack_mbss | Purchase: backpack_mbss | — | 1550 rubles |
| wake | v3/backpacks/backpack_vkbo | Purchase: backpack_vkbo | — | 1700 rubles |
| wake | v3/backpacks/backpack_pilgrim | Purchase: backpack_pilgrim | — | 1850 rubles |
| wake | v3/backpacks/backpack_scavbackpack | Purchase: backpack_scavbackpack | — | 2000 rubles |
| wake | v3/backpacks/backpack_1 | Purchase: backpack_1 | — | 2200 rubles |
| wake | v3/backpacks/backpack_3 | Purchase: backpack_3 | — | 2350 rubles |
| wake | v3/backpacks/backpack_2 | Purchase: backpack_2 | — | 2500 rubles |
| wake | v3/backpacks/backpack_1_large | Purchase: backpack_1_large | — | 2650 rubles |
| wake | v3/backpacks/backpack_3_large | Purchase: backpack_3_large | — | 2800 rubles |
| wake | v3/backpacks/backpack_2_large | Purchase: backpack_2_large | — | 3000 rubles |
| wake | v3/carry-weight/01 | Carried capacity: +1 weight | — | 450 rubles |
| wake | v3/carry-weight/02 | Carried capacity: +1 weight | — | 1050 rubles |
| wake | v3/carry-weight/03 | Carried capacity: +1 weight | — | 1700 rubles |
| wake | v3/carry-weight/04 | Carried capacity: +1 weight | — | 2350 rubles |
| wake | v3/carry-weight/05 | Carried capacity: +1 weight | — | 3000 rubles |
| wake | v3/inventory-rows/01 | Carried capacity: +1 rows | — | 450 rubles |
| wake | v3/inventory-rows/02 | Carried capacity: +1 rows | — | 3000 rubles |

## Purchase catalogue

| Item | Seller | Local milestone | Canonical tier owner |
| --- | --- | --- | --- |
| anomalydetector | atlas | v3/anomaly-detector/anomalydetector | atlas |
| binoculars_1 | atlas | v3/binoculars/binoculars_1 | atlas |
| binoculars_2 | atlas | v3/binoculars/binoculars_2 | atlas |
| binoculars_3 | atlas | v3/binoculars/binoculars_3 | atlas |
| binoculars_4 | atlas | v3/binoculars/binoculars_4 | atlas |
| geigercounter | atlas | v3/instruments/geigercounter | atlas |
| gpstracker | atlas | v3/instruments/gpstracker | atlas |
| headlamp | atlas | v3/headlamp/headlamp | atlas |
| acog | beanstalk | v3/optics/acog | beanstalk |
| aimpoint | beanstalk | v3/red-dots/aimpoint | beanstalk |
| cmore | beanstalk | v3/red-dots/cmore | beanstalk |
| cobrasuppressor | beanstalk | v3/suppressors/cobrasuppressor | beanstalk |
| eotech | beanstalk | v3/red-dots/eotech | beanstalk |
| kingarmsmr | beanstalk | v3/optics/kingarmsmr | beanstalk |
| kobra | beanstalk | v3/red-dots/kobra | beanstalk |
| microt1 | beanstalk | v3/red-dots/microt1 | beanstalk |
| nightforce | beanstalk | v3/optics/nightforce | beanstalk |
| pbssuppressor | beanstalk | v3/suppressors/pbssuppressor | beanstalk |
| pso1 | beanstalk | v3/optics/pso1 | beanstalk |
| sakersuppressor | beanstalk | v3/suppressors/sakersuppressor | beanstalk |
| shortdot | beanstalk | v3/optics/shortdot | beanstalk |
| trijiconrmr | beanstalk | v3/red-dots/trijiconrmr | beanstalk |
| tundrasuppressor | beanstalk | v3/suppressors/tundrasuppressor | beanstalk |
| headwear_cs4 | boss | v3/helmets/headwear_cs4 | boss |
| headwear_pracs | boss | v3/helmets/headwear_pracs | boss |
| headwear_psz12 | boss | v3/helmets/headwear_psz12 | boss |
| headwear_screen | boss | v3/helmets/headwear_screen | boss |
| helm_operator_nato | boss | v3/helmets/helm_operator_nato | boss |
| helm_operator_rus_1 | boss | v3/helmets/helm_operator_rus_1 | boss |
| helm_sphere08 | boss | v3/helmets/helm_sphere08 | boss |
| helm_sphere12 | boss | v3/helmets/helm_sphere12 | boss |
| 127x55 | brass | v3/regular-ammo/127x55 | brass |
| 12gaugedt | brass | v3/shotgun-loads/12gaugedt | brass |
| 12gaugemg | brass | v3/shotgun-loads/12gaugemg | brass |
| 12gaugetr | brass | v3/shotgun-loads/12gaugetr | brass |
| 145x114 | brass | v3/regular-ammo/145x114 | brass |
| 338lapua | brass | v3/regular-ammo/338lapua | brass |
| 357magnum | brass | v3/regular-ammo/357magnum | brass |
| 44magnum | brass | v3/regular-ammo/44magnum | brass |
| 500magnum | brass | v3/regular-ammo/500magnum | brass |
| 50ae | brass | v3/regular-ammo/50ae | brass |
| 545x39 | brass | v3/regular-ammo/545x39 | brass |
| 556x45 | brass | v3/regular-ammo/556x45 | brass |
| 57x28 | brass | v3/regular-ammo/57x28 | brass |
| 700nitro | brass | v3/regular-ammo/700nitro | brass |
| 762x39 | brass | v3/regular-ammo/762x39 | brass |
| 762x51 | brass | v3/regular-ammo/762x51 | brass |
| 762x54 | brass | v3/regular-ammo/762x54 | brass |
| 93x64 | brass | v3/regular-ammo/93x64 | brass |
| 9x21 | brass | v3/regular-ammo/9x21 | brass |
| 9x39 | brass | v3/regular-ammo/9x39 | brass |
| suit_seva | egghead | v3/science-suits/suit_seva | egghead |
| suit_ssp99 | egghead | v3/science-suits/suit_ssp99 | egghead |
| suit_ssp99m | egghead | v3/science-suits/suit_ssp99m | egghead |
| beretta92 | gasket | v3/sidearms/beretta92 | gasket |
| brhp | gasket | v3/sidearms/brhp | gasket |
| c96 | gasket | v3/sidearms/c96 | gasket |
| cz52 | gasket | v3/sidearms/cz52 | gasket |
| deagle | gasket | v3/sidearms/deagle | gasket |
| deagle44 | gasket | v3/sidearms/deagle44 | gasket |
| drink_moonshine | gasket | v3/strong-alcohol/drink_moonshine | gasket |
| drink_spirit_1 | gasket | v3/strong-alcohol/drink_spirit_1 | gasket |
| drink_spirit_2 | gasket | v3/strong-alcohol/drink_spirit_2 | gasket |
| drink_spirit_3 | gasket | v3/strong-alcohol/drink_spirit_3 | gasket |
| drink_vodka_1 | gasket | v3/strong-alcohol/drink_vodka_1 | gasket |
| drink_vodka_2 | gasket | v3/strong-alcohol/drink_vodka_2 | gasket |
| drink_vodka_3 | gasket | v3/strong-alcohol/drink_vodka_3 | gasket |
| drink_vodka_4 | gasket | v3/strong-alcohol/drink_vodka_4 | gasket |
| drink_vodka_5 | gasket | v3/strong-alcohol/drink_vodka_5 | gasket |
| drink_vodka_6 | gasket | v3/strong-alcohol/drink_vodka_6 | gasket |
| drink_wine | gasket | v3/strong-alcohol/drink_wine | gasket |
| fiveseven | gasket | v3/sidearms/fiveseven | gasket |
| fort12 | gasket | v3/sidearms/fort12 | gasket |
| g2contender500 | gasket | v3/sidearms/g2contender500 | gasket |
| glock17 | gasket | v3/sidearms/glock17 | gasket |
| glock18 | gasket | v3/sidearms/glock18 | gasket |
| lax410s | gasket | v3/sidearms/lax410s | gasket |
| lugerp08 | gasket | v3/sidearms/lugerp08 | gasket |
| m1911 | gasket | v3/sidearms/m1911 | gasket |
| m1911chic | gasket | v3/sidearms/m1911chic | gasket |
| makarov | gasket | v3/sidearms/makarov | gasket |
| mateba | gasket | v3/sidearms/mateba | gasket |
| mr96 | gasket | v3/sidearms/mr96 | gasket |
| p99 | gasket | v3/sidearms/p99 | gasket |
| stechaps | gasket | v3/sidearms/stechaps | gasket |
| sw500 | gasket | v3/sidearms/sw500 | gasket |
| swmodel29 | gasket | v3/sidearms/swmodel29 | gasket |
| swr8 | gasket | v3/sidearms/swr8 | gasket |
| taurusjudge | gasket | v3/sidearms/taurusjudge | gasket |
| taurusragingbull | gasket | v3/sidearms/taurusragingbull | gasket |
| tokarev | gasket | v3/sidearms/tokarev | gasket |
| gepardpdw | haggler | v3/pact-cqb/gepardpdw | haggler |
| kiparis | haggler | v3/pact-cqb/kiparis | haggler |
| mp153 | haggler | v3/pact-cqb/mp153 | haggler |
| mp27 | haggler | v3/pact-cqb/mp27 | haggler |
| pp19 | haggler | v3/pact-cqb/pp19 | haggler |
| pp1901vityaz | haggler | v3/pact-cqb/pp1901vityaz | haggler |
| pp2000 | haggler | v3/pact-cqb/pp2000 | haggler |
| ppsh | haggler | v3/pact-cqb/ppsh | haggler |
| saiga12 | haggler | v3/pact-cqb/saiga12 | haggler |
| saiga410 | haggler | v3/pact-cqb/saiga410 | haggler |
| skorpion | haggler | v3/pact-cqb/skorpion | haggler |
| sr2 | haggler | v3/pact-cqb/sr2 | haggler |
| toz106 | haggler | v3/pact-cqb/toz106 | haggler |
| toz194 | haggler | v3/pact-cqb/toz194 | haggler |
| toz34 | haggler | v3/pact-cqb/toz34 | haggler |
| toz34short | haggler | v3/pact-cqb/toz34short | haggler |
| toz34special | haggler | v3/pact-cqb/toz34special | haggler |
| toz66 | haggler | v3/pact-cqb/toz66 | haggler |
| toz66short | haggler | v3/pact-cqb/toz66short | haggler |
| detectorbear | intern | v3/artifact-detectors/detectorbear | intern |
| detectorecho | intern | v3/artifact-detectors/detectorecho | intern |
| detectorveles | intern | v3/artifact-detectors/detectorveles | intern |
| medic_antipsychotic_1 | jitters | v3/antipsychotics/medic_antipsychotic_1 | jitters |
| medic_antipsychotic_2 | jitters | v3/antipsychotics/medic_antipsychotic_2 | jitters |
| medic_antipsychotic_3 | jitters | v3/antipsychotics/medic_antipsychotic_3 | jitters |
| medic_antirad_1 | jitters | v3/antirad/medic_antirad_1 | jitters |
| medic_antirad_2 | jitters | v3/antirad/medic_antirad_2 | jitters |
| medic_bandage_2 | jitters | v3/bandages/medic_bandage_2 | jitters |
| medic_bandage_3 | jitters | v3/bandages/medic_bandage_3 | jitters |
| medic_medkit_2 | jitters | v3/medkits/medic_medkit_2 | jitters |
| medic_medkit_3 | jitters | v3/medkits/medic_medkit_3 | jitters |
| medic_medkit_4 | jitters | v3/medkits/medic_medkit_4 | jitters |
| medic_medkit_5 | jitters | v3/medkits/medic_medkit_5 | jitters |
| medic_medkit_6 | jitters | v3/medkits/medic_medkit_6 | jitters |
| medic_psyheal_1 | jitters | v3/psy-healing/medic_psyheal_1 | jitters |
| medic_psyheal_2 | jitters | v3/psy-healing/medic_psyheal_2 | jitters |
| medic_stimpak_1 | jitters | v3/stimpaks/medic_stimpak_1 | jitters |
| medic_stimpak_2 | jitters | v3/stimpaks/medic_stimpak_2 | jitters |
| medic_stimpak_3 | jitters | v3/stimpaks/medic_stimpak_3 | jitters |
| headwear_cs1 | latch | v3/masks-headwear/headwear_cs1 | latch |
| headwear_cs2 | latch | v3/masks-headwear/headwear_cs2 | latch |
| helm_operator_rus_2 | latch | v3/masks-headwear/helm_operator_rus_2 | latch |
| mask_cloth | latch | v3/masks-headwear/mask_cloth | technut |
| mask_eo20 | latch | v3/masks-headwear/mask_eo20 | latch |
| mask_gp5 | latch | v3/masks-headwear/mask_gp5 | latch |
| mask_halfmask | latch | v3/masks-headwear/mask_halfmask | latch |
| mask_m40 | latch | v3/masks-headwear/mask_m40 | latch |
| mask_m50 | latch | v3/masks-headwear/mask_m50 | latch |
| mask_pmk3 | latch | v3/masks-headwear/mask_pmk3 | latch |
| mask_respirator | latch | v3/masks-headwear/mask_respirator | latch |
| mask_xm40 | latch | v3/masks-headwear/mask_xm40 | latch |
| bat | old-timer | v3/melee/crowbar | old-timer |
| crowbar | old-timer | v3/melee/crowbar | old-timer |
| fireaxe | old-timer | v3/melee/sledgehammer | old-timer |
| fubar | old-timer | v3/melee/sledgehammer | old-timer |
| hatchet | old-timer | v3/melee/hatchet | old-timer |
| hidestasher_cleaningkit | old-timer | v3/hidestashers/hidestasher_cleaningkit | old-timer |
| hidestasher_shovel | old-timer | v3/hidestashers/hidestasher_shovel | old-timer |
| hightiercooker | old-timer | v3/cooking/hightiercooker | old-timer |
| knife2 | old-timer | v3/knives/knife2 | old-timer |
| knife3 | old-timer | v3/knives/knife3 | old-timer |
| knife4 | old-timer | v3/knives/knife4 | old-timer |
| machete | old-timer | v3/melee/hatchet | old-timer |
| sledgehammer | old-timer | v3/melee/sledgehammer | old-timer |
| aug | quartermaster | v3/nato-rifles/aug | quartermaster |
| f2000 | quartermaster | v3/nato-rifles/f2000 | quartermaster |
| famas | quartermaster | v3/nato-rifles/famas | quartermaster |
| fnfal | quartermaster | v3/nato-rifles/fnfal | quartermaster |
| g36c | quartermaster | v3/nato-rifles/g36c | quartermaster |
| g3a3 | quartermaster | v3/nato-rifles/g3a3 | quartermaster |
| hk416 | quartermaster | v3/nato-rifles/hk416 | quartermaster |
| l85 | quartermaster | v3/nato-rifles/l85 | quartermaster |
| lr300 | quartermaster | v3/nato-rifles/lr300 | quartermaster |
| m14 | quartermaster | v3/nato-rifles/m14 | quartermaster |
| m16a4 | quartermaster | v3/nato-rifles/m16a4 | quartermaster |
| rugermini14 | quartermaster | v3/nato-rifles/rugermini14 | quartermaster |
| sg552 | quartermaster | v3/nato-rifles/sg552 | quartermaster |
| accesscard_bunker | smartass | v3/access-cards/accesscard_bunker | smartass |
| accesscard_laboratory | smartass | v3/access-cards/accesscard_laboratory | smartass |
| ar159mm | smartass | v3/nato-cqb/ar159mm | smartass |
| c96carbine | smartass | v3/nato-cqb/c96carbine | smartass |
| ithaca37 | smartass | v3/nato-cqb/ithaca37 | smartass |
| kp31 | smartass | v3/nato-cqb/kp31 | smartass |
| m1887 | smartass | v3/nato-cqb/m1887 | smartass |
| m1928 | smartass | v3/nato-cqb/m1928 | smartass |
| m3super90 | smartass | v3/nato-cqb/m3super90 | smartass |
| m3supershort | smartass | v3/nato-cqb/m3supershort | smartass |
| mac11 | smartass | v3/nato-cqb/mac11 | smartass |
| mossberg500 | smartass | v3/nato-cqb/mossberg500 | smartass |
| mp34 | smartass | v3/nato-cqb/mp34 | smartass |
| mp40 | smartass | v3/nato-cqb/mp40 | smartass |
| mp5 | smartass | v3/nato-cqb/mp5 | smartass |
| mp5k | smartass | v3/nato-cqb/mp5k | smartass |
| mp9a1 | smartass | v3/nato-cqb/mp9a1 | smartass |
| p90 | smartass | v3/nato-cqb/p90 | smartass |
| rem870ae | smartass | v3/nato-cqb/rem870ae | smartass |
| sten | smartass | v3/nato-cqb/sten | smartass |
| sterling | smartass | v3/nato-cqb/sterling | smartass |
| stoegerdd | smartass | v3/nato-cqb/stoegerdd | smartass |
| stoegerddshort | smartass | v3/nato-cqb/stoegerddshort | smartass |
| striker | smartass | v3/nato-cqb/striker | smartass |
| ump45 | smartass | v3/nato-cqb/ump45 | smartass |
| uzi | smartass | v3/nato-cqb/uzi | smartass |
| drink_bottlebeer_1 | spicy-lemon | v3/weak-alcohol/drink_bottlebeer_1 | spicy-lemon |
| drink_bottlebeer_2 | spicy-lemon | v3/weak-alcohol/drink_bottlebeer_2 | spicy-lemon |
| drink_bottlebeer_3 | spicy-lemon | v3/weak-alcohol/drink_bottlebeer_3 | spicy-lemon |
| drink_bottlebeer_4 | spicy-lemon | v3/weak-alcohol/drink_bottlebeer_4 | spicy-lemon |
| drink_bottlebeer_5 | spicy-lemon | v3/weak-alcohol/drink_bottlebeer_5 | spicy-lemon |
| drink_bottlebeer_6 | spicy-lemon | v3/weak-alcohol/drink_bottlebeer_6 | spicy-lemon |
| drink_canbeer_1 | spicy-lemon | v3/weak-alcohol/drink_canbeer_1 | spicy-lemon |
| drink_canbeer_2 | spicy-lemon | v3/weak-alcohol/drink_canbeer_2 | spicy-lemon |
| drink_canbeer_3 | spicy-lemon | v3/weak-alcohol/drink_canbeer_3 | spicy-lemon |
| drink_canbeer_4 | spicy-lemon | v3/weak-alcohol/drink_canbeer_4 | spicy-lemon |
| drink_canbeer_5 | spicy-lemon | v3/weak-alcohol/drink_canbeer_5 | spicy-lemon |
| drink_canbeer_6 | spicy-lemon | v3/weak-alcohol/drink_canbeer_6 | spicy-lemon |
| drink_energydrink_1 | spicy-lemon | v3/energy-drinks/drink_energydrink_1 | spicy-lemon |
| drink_energydrink_2 | spicy-lemon | v3/energy-drinks/drink_energydrink_2 | spicy-lemon |
| drink_energydrink_3 | spicy-lemon | v3/energy-drinks/drink_energydrink_3 | spicy-lemon |
| drink_energydrink_5 | spicy-lemon | v3/energy-drinks/drink_energydrink_5 | spicy-lemon |
| drink_energydrink_6 | spicy-lemon | v3/energy-drinks/drink_energydrink_6 | spicy-lemon |
| drug_caffeine | spicy-lemon | v3/weak-drugs/drug_caffeine | spicy-lemon |
| drug_cigar | spicy-lemon | v3/weak-drugs/drug_cigar | spicy-lemon |
| drug_cigarette_2 | spicy-lemon | v3/weak-drugs/drug_cigarette_2 | spicy-lemon |
| drug_cigarette_3 | spicy-lemon | v3/weak-drugs/drug_cigarette_3 | spicy-lemon |
| drug_cigarette_4 | spicy-lemon | v3/weak-drugs/drug_cigarette_4 | spicy-lemon |
| drug_cigarette_5 | spicy-lemon | v3/weak-drugs/drug_cigarette_5 | spicy-lemon |
| drug_cigarette_6 | spicy-lemon | v3/weak-drugs/drug_cigarette_6 | spicy-lemon |
| drug_mints | spicy-lemon | v3/weak-drugs/drug_mints | spicy-lemon |
| drug_painkillers | spicy-lemon | v3/weak-drugs/drug_painkillers | spicy-lemon |
| drug_tobacco_1 | spicy-lemon | v3/weak-drugs/drug_tobacco_1 | spicy-lemon |
| drug_tobacco_2 | spicy-lemon | v3/weak-drugs/drug_tobacco_2 | spicy-lemon |
| drug_adrenaline | spool | v3/strong-drugs/drug_adrenaline | spool |
| drug_cocaine | spool | v3/strong-drugs/drug_cocaine | spool |
| drug_glucose | spool | v3/strong-drugs/drug_glucose | spool |
| drug_marijuana | spool | v3/strong-drugs/drug_marijuana | spool |
| drug_morphine | spool | v3/strong-drugs/drug_morphine | spool |
| headwear_riot | spool | v3/steel-headwear/headwear_riot | spool |
| helm_steel_arab | spool | v3/steel-headwear/helm_steel_arab | spool |
| helm_steel_ger | spool | v3/steel-headwear/helm_steel_ger | spool |
| helm_steel_rus | spool | v3/steel-headwear/helm_steel_rus | spool |
| helm_tanker | spool | v3/steel-headwear/helm_tanker | haggler |
| miscaid_swampbrew | spool | v3/strong-drugs/miscaid_swampbrew | spool |
| l115 | spoor | v3/slow-rifles/l115 | spoor |
| lax44 | spoor | v3/slow-rifles/lax44 | spoor |
| mosin | spoor | v3/slow-rifles/mosin | spoor |
| mp18 | spoor | v3/slow-rifles/mp18 | spoor |
| obrez | spoor | v3/slow-rifles/obrez | spoor |
| obrezmalfunction | spoor | v3/slow-rifles/obrezmalfunction | spoor |
| sako85 | spoor | v3/slow-rifles/sako85 | spoor |
| sako85nato | spoor | v3/slow-rifles/sako85nato | spoor |
| sv98 | spoor | v3/slow-rifles/sv98 | spoor |
| trg42 | spoor | v3/slow-rifles/trg42 | spoor |
| w1895 | spoor | v3/slow-rifles/w1895 | spoor |
| w9422357 | spoor | v3/slow-rifles/w9422357 | spoor |
| attachment_aluframe | suture | v3/suit-attachments/attachment_aluframe | suture |
| attachment_carbonfibre | suture | v3/suit-attachments/attachment_carbonfibre | suture |
| attachment_ceramicplate_1 | suture | v3/suit-attachments/attachment_ceramicplate_1 | suture |
| attachment_ceramicplate_2 | suture | v3/suit-attachments/attachment_ceramicplate_2 | suture |
| attachment_ceramicplate_3 | suture | v3/suit-attachments/attachment_ceramicplate_3 | suture |
| attachment_fabric_1 | suture | v3/suit-attachments/attachment_fabric_1 | suture |
| attachment_fabric_2 | suture | v3/suit-attachments/attachment_fabric_2 | suture |
| attachment_kevlar_1 | suture | v3/suit-attachments/attachment_kevlar_1 | suture |
| attachment_kevlar_2 | suture | v3/suit-attachments/attachment_kevlar_2 | suture |
| attachment_steelframe | suture | v3/suit-attachments/attachment_steelframe | suture |
| attachment_steelplate_1 | suture | v3/suit-attachments/attachment_steelplate_1 | suture |
| attachment_steelplate_2 | suture | v3/suit-attachments/attachment_steelplate_2 | suture |
| attachment_steelplate_3 | suture | v3/suit-attachments/attachment_steelplate_3 | suture |
| suit_berill | technut | v3/suits/suit_berill | technut |
| suit_cs1 | technut | v3/suits/suit_cs1 | technut |
| suit_cs2 | technut | v3/suits/suit_cs2 | technut |
| suit_cs3 | technut | v3/suits/suit_cs3 | technut |
| suit_io7a | technut | v3/suits/suit_io7a | technut |
| suit_mailjacket | technut | v3/suits/suit_mailjacket | technut |
| suit_nbc | technut | v3/suits/suit_nbc | technut |
| suit_ps5m | technut | v3/suits/suit_ps5m | technut |
| suit_skat10 | technut | v3/suits/suit_skat10 | technut |
| suit_skat9 | technut | v3/suits/suit_skat9 | technut |
| suit_sunrise | technut | v3/suits/suit_sunrise | technut |
| suit_trenchcoat_black | technut | v3/suits/suit_trenchcoat_black | technut |
| suit_trenchcoat_brown | technut | v3/suits/suit_trenchcoat_black | technut |
| suit_trenchcoat_green | technut | v3/suits/suit_trenchcoat_black | technut |
| suit_trenchcoat_tan | technut | v3/suits/suit_trenchcoat_black | technut |
| suit_wind | technut | v3/suits/suit_wind | technut |
| 9a91 | vesper | v3/pact-rifles/9a91 | vesper |
| aek971 | vesper | v3/pact-rifles/aek971 | vesper |
| ak12 | vesper | v3/pact-rifles/ak12 | vesper |
| ak74 | vesper | v3/pact-rifles/ak74 | vesper |
| akm | vesper | v3/pact-rifles/akm | vesper |
| aks74u | vesper | v3/pact-rifles/aks74u | vesper |
| an94k | vesper | v3/pact-rifles/an94k | vesper |
| asval | vesper | v3/pact-rifles/asval | vesper |
| dp28 | vesper | v3/pact-rifles/dp28 | vesper |
| rk95 | vesper | v3/pact-rifles/rk95 | vesper |
| rpk | vesper | v3/pact-rifles/rpk | vesper |
| saigasemi | vesper | v3/pact-rifles/saigasemi | vesper |
| saigasemi545 | vesper | v3/pact-rifles/saigasemi545 | vesper |
| sks | vesper | v3/pact-rifles/sks | vesper |
| svd | vesper | v3/pact-rifles/svd | vesper |
| svt40 | vesper | v3/pact-rifles/svt40 | vesper |
| vss | vesper | v3/pact-rifles/vss | vesper |
| backpack_1 | wake | v3/backpacks/backpack_1 | wake |
| backpack_1_large | wake | v3/backpacks/backpack_1_large | wake |
| backpack_2 | wake | v3/backpacks/backpack_2 | wake |
| backpack_2_large | wake | v3/backpacks/backpack_2_large | wake |
| backpack_3 | wake | v3/backpacks/backpack_3 | wake |
| backpack_3_large | wake | v3/backpacks/backpack_3_large | wake |
| backpack_duffle | wake | v3/backpacks/backpack_duffle | wake |
| backpack_mbss | wake | v3/backpacks/backpack_mbss | wake |
| backpack_pilgrim | wake | v3/backpacks/backpack_pilgrim | wake |
| backpack_sanitar | wake | v3/backpacks/backpack_sanitar | wake |
| backpack_scavbackpack | wake | v3/backpacks/backpack_scavbackpack | wake |
| backpack_sling | wake | v3/backpacks/backpack_sling | wake |
| backpack_takedown_1 | wake | v3/backpacks/backpack_takedown_1 | wake |
| backpack_takedown_2 | wake | v3/backpacks/backpack_takedown_2 | wake |
| backpack_tbag | wake | v3/backpacks/backpack_tbag | wake |
| backpack_tourist | wake | v3/backpacks/backpack_tourist | wake |
| backpack_vkbo | wake | v3/backpacks/backpack_vkbo | wake |

## Suit conversion unlocks

Both canonical base-suit and exact variant milestones are required.

| Variant | Contact | Milestone | Base suit |
| --- | --- | --- | --- |
| suit_anorak_anarchist | suture | v3/suit-variants/suit_anorak | suit_anorak |
| suit_anorak_authority | suture | v3/suit-variants/suit_anorak | suit_anorak |
| suit_anorak_ecologist | suture | v3/suit-variants/suit_anorak | suit_anorak |
| suit_anorak_mercenary | suture | v3/suit-variants/suit_anorak | suit_anorak |
| suit_anorak_scavenger | suture | v3/suit-variants/suit_anorak | suit_anorak |
| suit_berill_anarchist | suture | v3/suit-variants/suit_berill | suit_berill |
| suit_berill_authority | suture | v3/suit-variants/suit_berill | suit_berill |
| suit_berill_ecologist | suture | v3/suit-variants/suit_berill | suit_berill |
| suit_berill_mercenary | suture | v3/suit-variants/suit_berill | suit_berill |
| suit_berill_scavenger | suture | v3/suit-variants/suit_berill | suit_berill |
| suit_cs1_ecologist | suture | v3/suit-variants/suit_cs1 | suit_cs1 |
| suit_cs1_scavenger | suture | v3/suit-variants/suit_cs1 | suit_cs1 |
| suit_cs2_ecologist | suture | v3/suit-variants/suit_cs2 | suit_cs2 |
| suit_cs2_scavenger | suture | v3/suit-variants/suit_cs2 | suit_cs2 |
| suit_cs3_ecologist | suture | v3/suit-variants/suit_cs3 | suit_cs3 |
| suit_io7a_anarchist | suture | v3/suit-variants/suit_io7a | suit_io7a |
| suit_io7a_authority | suture | v3/suit-variants/suit_io7a | suit_io7a |
| suit_io7a_ecologist | suture | v3/suit-variants/suit_io7a | suit_io7a |
| suit_io7a_fanatic | suture | v3/suit-variants/suit_io7a | suit_io7a |
| suit_io7a_mercenary | suture | v3/suit-variants/suit_io7a | suit_io7a |
| suit_io7a_scavenger | suture | v3/suit-variants/suit_io7a | suit_io7a |
| suit_mailjacket_anarchist | suture | v3/suit-variants/suit_mailjacket | suit_mailjacket |
| suit_mailjacket_authority | suture | v3/suit-variants/suit_mailjacket | suit_mailjacket |
| suit_mailjacket_ecologist | suture | v3/suit-variants/suit_mailjacket | suit_mailjacket |
| suit_mailjacket_mercenary | suture | v3/suit-variants/suit_mailjacket | suit_mailjacket |
| suit_mailjacket_scavenger | suture | v3/suit-variants/suit_mailjacket | suit_mailjacket |
| suit_nbc_anarchist | suture | v3/suit-variants/suit_nbc | suit_nbc |
| suit_nbc_authority | suture | v3/suit-variants/suit_nbc | suit_nbc |
| suit_nbc_fanatic | suture | v3/suit-variants/suit_nbc | suit_nbc |
| suit_ps5m_anarchist | suture | v3/suit-variants/suit_ps5m | suit_ps5m |
| suit_ps5m_authority | suture | v3/suit-variants/suit_ps5m | suit_ps5m |
| suit_ps5m_ecologist | suture | v3/suit-variants/suit_ps5m | suit_ps5m |
| suit_ps5m_fanatic | suture | v3/suit-variants/suit_ps5m | suit_ps5m |
| suit_ps5m_mercenary | suture | v3/suit-variants/suit_ps5m | suit_ps5m |
| suit_seva_anarchist | suture | v3/suit-variants/suit_seva | suit_seva |
| suit_seva_authority | suture | v3/suit-variants/suit_seva | suit_seva |
| suit_seva_ecologist | suture | v3/suit-variants/suit_seva | suit_seva |
| suit_seva_fanatic | suture | v3/suit-variants/suit_seva | suit_seva |
| suit_seva_mercenary | suture | v3/suit-variants/suit_seva | suit_seva |
| suit_skat10_anarchist | suture | v3/suit-variants/suit_skat10 | suit_skat10 |
| suit_skat10_authority | suture | v3/suit-variants/suit_skat10 | suit_skat10 |
| suit_skat10_ecologist | suture | v3/suit-variants/suit_skat10 | suit_skat10 |
| suit_skat10_mercenary | suture | v3/suit-variants/suit_skat10 | suit_skat10 |
| suit_skat9_anarchist | suture | v3/suit-variants/suit_skat9 | suit_skat9 |
| suit_skat9_authority | suture | v3/suit-variants/suit_skat9 | suit_skat9 |
| suit_skat9_ecologist | suture | v3/suit-variants/suit_skat9 | suit_skat9 |
| suit_skat9_fanatic | suture | v3/suit-variants/suit_skat9 | suit_skat9 |
| suit_skat9_scavenger | suture | v3/suit-variants/suit_skat9 | suit_skat9 |
| suit_sunrise_anarchist | suture | v3/suit-variants/suit_sunrise | suit_sunrise |
| suit_sunrise_authority | suture | v3/suit-variants/suit_sunrise | suit_sunrise |
| suit_sunrise_fanatic | suture | v3/suit-variants/suit_sunrise | suit_sunrise |
| suit_sunrise_mercenary | suture | v3/suit-variants/suit_sunrise | suit_sunrise |
| suit_sunrise_scavenger | suture | v3/suit-variants/suit_sunrise | suit_sunrise |
| suit_wind_anarchist | suture | v3/suit-variants/suit_wind | suit_wind |
| suit_wind_authority | suture | v3/suit-variants/suit_wind | suit_wind |
| suit_wind_fanatic | suture | v3/suit-variants/suit_wind | suit_wind |

## Unimplemented unlock terms

Every entry has an adjacent TODO in its contact definition.

| ID | Kind | Intended effect | Proposed terms |
| --- | --- | --- | --- |
