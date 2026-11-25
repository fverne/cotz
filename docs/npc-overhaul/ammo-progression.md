# Authored ammunition progression

Generated with `python3 docs/npc-overhaul/tools/ammo_progression.py --write`.

`PLUGIN.regularAmmoChain` contains every regular load, excluding AP, HP and special shotgun variants.
The manually authored regularAmmoChain is authoritative; gun first-use data is informational only.
This report never rewrites equipment chains, calibre order or contact allocations.
Brass owns regular-calibre and HP branches; Carbon owns the AP branch.
Each HP milestone requires its matching regular milestone; AP requires the matching HP milestone at Brass.
HP and AP have no town cash sale routes. Their exchanges each consume two regular boxes.
Boxes are measured using their standard round counts; partial stacks can be combined.
Brass also starts with buckshot and slugs; special loads unlock as exchanges in TR, DT, MG order after regular buckshot.
Listed starter ammunition is ungated. Box prices, round counts and damage values are unchanged.

The legacy ID `45acp41` is .410 bore, a separate cartridge rather than a .45 ACP upgrade.

## Regular chain

22lr → 762x25 → 45acp41 → 9x19 → 45acp → 545x39 → 12gauge → 762x39 → 556x45 → 9x18 → 762x54 → 357magnum → 9x39 → 44magnum → 9x21 → 762x51 → 500magnum → 338lapua → 50ae → 57x28 → 127x55 → 145x114 → 700nitro → 93x64

| Regular load | First gun | Position |
| --- | --- | ---: |
| 22lr | No gun in upgrade chains | — |
| 762x25 | tokarev | 1 |
| 45acp41 | mp27 | 2 |
| 9x19 | sten | 3 |
| 45acp | toz106 | 1 |
| 545x39 | saigasemi545 | 1 |
| 12gauge | stoegerddshort | 2 |
| 762x39 | saigasemi | 2 |
| 556x45 | rugermini14 | 1 |
| 9x18 | makarov | 2 |
| 762x54 | mp18 | 1 |
| 357magnum | w9422357 | 4 |
| 9x39 | vss | 12 |
| 44magnum | lax44 | 10 |
| 9x21 | gepardpdw | 14 |
| 762x51 | sako85 | 6 |
| 500magnum | g2contender500 | 15 |
| 338lapua | l115 | 11 |
| 50ae | deagle | 25 |
| 57x28 | p90 | 23 |
| 127x55 | No gun in upgrade chains | — |
| 145x114 | No gun in upgrade chains | — |
| 700nitro | No gun in upgrade chains | — |
| 93x64 | No gun in upgrade chains | — |

## Seller allocations

| Item | Box price | Rounds | Price per round | Regular counterpart | Seller: milestone |
| --- | ---: | ---: | ---: | --- | --- |
| 22lr | 450 | 60 | 7.5000 | 22lr | brass: ungated; gasket: ungated; haggler: ungated |
| 22lrap | 450 | 60 | 7.5000 | 22lr | carbon: v3/ap-ammo/22lrap (barter 2:1) |
| 22lrhp | 450 | 60 | 7.5000 | 22lr | brass: v3/hp-ammo/22lrhp (barter 2:1) |
| 762x25 | 500 | 60 | 8.3333 | 762x25 | smartass: v3/nato-cqb/c96carbine/ammo; brass: ungated; gasket: ungated; haggler: ungated |
| 762x25ap | 500 | 60 | 8.3333 | 762x25 | carbon: v3/ap-ammo/762x25ap (barter 2:1) |
| 762x25hp | 500 | 60 | 8.3333 | 762x25 | brass: v3/hp-ammo/762x25hp (barter 2:1) |
| 45acp41 | 600 | 20 | 30.0000 | 45acp41 | brass: ungated; haggler: ungated |
| 9x19 | 750 | 60 | 12.5000 | 9x19 | gasket: v3/sidearms/lugerp08/ammo; smartass: v3/nato-cqb/sten/ammo; brass: ungated; haggler: ungated |
| 9x19ap | 750 | 60 | 12.5000 | 9x19 | carbon: v3/ap-ammo/9x19ap (barter 2:1) |
| 9x19hp | 750 | 60 | 12.5000 | 9x19 | brass: v3/hp-ammo/9x19hp (barter 2:1) |
| 45acp | 950 | 60 | 15.8333 | 45acp | smartass: v3/nato-cqb/ump45/ammo; brass: ungated; gasket: ungated; haggler: ungated |
| 45acpap | 950 | 60 | 15.8333 | 45acp | carbon: v3/ap-ammo/45acpap (barter 2:1) |
| 45acphp | 950 | 60 | 15.8333 | 45acp | brass: v3/hp-ammo/45acphp (barter 2:1) |
| 545x39 | 1005 | 60 | 16.7500 | 545x39 | brass: v3/regular-ammo/545x39; vesper: v3/pact-rifles/saigasemi545/ammo |
| 545x39ap | 1005 | 60 | 16.7500 | 545x39 | carbon: v3/ap-ammo/545x39ap (barter 2:1) |
| 545x39hp | 1005 | 60 | 16.7500 | 545x39 | brass: v3/hp-ammo/545x39hp (barter 2:1) |
| 12gaugedt | 600 | 30 | 20.0000 | 12gauge | brass: v3/shotgun-loads/12gaugedt (barter 2:1) |
| 12gaugesg | 700 | 30 | 23.3333 | 12gauge | brass: ungated |
| 12gaugemg | 750 | 30 | 25.0000 | 12gauge | brass: v3/shotgun-loads/12gaugemg (barter 2:1) |
| 12gaugetr | 750 | 30 | 25.0000 | 12gauge | brass: v3/shotgun-loads/12gaugetr (barter 1 12gauge + 1 12gaugesg → 1) |
| 12gauge | 800 | 30 | 26.6667 | 12gauge | haggler: v3/pact-cqb/toz66short/ammo; smartass: v3/nato-cqb/stoegerddshort/ammo; brass: ungated |
| 762x39 | 1139 | 60 | 18.9833 | 762x39 | brass: v3/regular-ammo/762x39; vesper: v3/pact-rifles/saigasemi/ammo |
| 762x39ap | 1139 | 60 | 18.9833 | 762x39 | carbon: v3/ap-ammo/762x39ap (barter 2:1) |
| 762x39hp | 1139 | 60 | 18.9833 | 762x39 | brass: v3/hp-ammo/762x39hp (barter 2:1) |
| 556x45 | 1106 | 60 | 18.4333 | 556x45 | brass: v3/regular-ammo/556x45; quartermaster: v3/nato-rifles/rugermini14/ammo; spoor: v3/slow-rifles/sako85nato/ammo |
| 556x45ap | 1106 | 60 | 18.4333 | 556x45 | carbon: v3/ap-ammo/556x45ap (barter 2:1) |
| 556x45hp | 1106 | 60 | 18.4333 | 556x45 | brass: v3/hp-ammo/556x45hp (barter 2:1) |
| 9x18 | 600 | 60 | 10.0000 | 9x18 | brass: ungated; gasket: ungated; haggler: ungated |
| 9x18ap | 600 | 60 | 10.0000 | 9x18 | carbon: v3/ap-ammo/9x18ap (barter 2:1) |
| 9x18hp | 600 | 60 | 10.0000 | 9x18 | brass: v3/hp-ammo/9x18hp (barter 2:1) |
| 762x54 | 1407 | 60 | 23.4500 | 762x54 | brass: v3/regular-ammo/762x54; spoor: v3/slow-rifles/mp18/ammo; vesper: v3/pact-rifles/svt40/ammo |
| 762x54ap | 1407 | 60 | 23.4500 | 762x54 | carbon: v3/ap-ammo/762x54ap (barter 2:1) |
| 762x54hp | 1407 | 60 | 23.4500 | 762x54 | brass: v3/hp-ammo/762x54hp (barter 2:1) |
| 357magnum | 1000 | 60 | 16.6667 | 357magnum | brass: v3/regular-ammo/357magnum; gasket: v3/sidearms/mr96/ammo; spoor: v3/slow-rifles/w9422357/ammo |
| 357magnumap | 1000 | 60 | 16.6667 | 357magnum | carbon: v3/ap-ammo/357magnumap (barter 2:1) |
| 357magnumhp | 1000 | 60 | 16.6667 | 357magnum | brass: v3/hp-ammo/357magnumhp (barter 2:1) |
| 9x39 | 1273 | 60 | 21.2167 | 9x39 | brass: v3/regular-ammo/9x39; vesper: v3/pact-rifles/vss/ammo |
| 9x39ap | 1273 | 60 | 21.2167 | 9x39 | carbon: v3/ap-ammo/9x39ap (barter 2:1) |
| 9x39hp | 1273 | 60 | 21.2167 | 9x39 | brass: v3/hp-ammo/9x39hp (barter 2:1) |
| 44magnum | 1000 | 60 | 16.6667 | 44magnum | brass: v3/regular-ammo/44magnum; gasket: v3/sidearms/swmodel29/ammo; spoor: v3/slow-rifles/lax44/ammo |
| 44magnumap | 1000 | 60 | 16.6667 | 44magnum | carbon: v3/ap-ammo/44magnumap (barter 2:1) |
| 44magnumhp | 1000 | 60 | 16.6667 | 44magnum | brass: v3/hp-ammo/44magnumhp (barter 2:1) |
| 9x21 | 750 | 60 | 12.5000 | 9x21 | brass: v3/regular-ammo/9x21; haggler: v3/pact-cqb/gepardpdw/ammo |
| 9x21ap | 750 | 60 | 12.5000 | 9x21 | carbon: v3/ap-ammo/9x21ap (barter 2:1) |
| 9x21hp | 750 | 60 | 12.5000 | 9x21 | brass: v3/hp-ammo/9x21hp (barter 2:1) |
| 762x51 | 1307 | 60 | 21.7833 | 762x51 | brass: v3/regular-ammo/762x51; quartermaster: v3/nato-rifles/g3a3/ammo; spoor: v3/slow-rifles/sako85/ammo |
| 762x51ap | 1307 | 60 | 21.7833 | 762x51 | carbon: v3/ap-ammo/762x51ap (barter 2:1) |
| 762x51hp | 1307 | 60 | 21.7833 | 762x51 | brass: v3/hp-ammo/762x51hp (barter 2:1) |
| 500magnum | 1000 | 30 | 33.3333 | 500magnum | brass: v3/regular-ammo/500magnum; gasket: v3/sidearms/g2contender500/ammo |
| 500magnumap | 1000 | 30 | 33.3333 | 500magnum | carbon: v3/ap-ammo/500magnumap (barter 2:1) |
| 500magnumhp | 1000 | 30 | 33.3333 | 500magnum | brass: v3/hp-ammo/500magnumhp (barter 2:1) |
| 338lapua | 2345 | 60 | 39.0833 | 338lapua | brass: v3/regular-ammo/338lapua; spoor: v3/slow-rifles/l115/ammo |
| 338lapuaap | 2345 | 60 | 39.0833 | 338lapua | carbon: v3/ap-ammo/338lapuaap (barter 2:1) |
| 338lapuahp | 2345 | 60 | 39.0833 | 338lapua | brass: v3/hp-ammo/338lapuahp (barter 2:1) |
| 50ae | 1750 | 60 | 29.1667 | 50ae | brass: v3/regular-ammo/50ae; gasket: v3/sidearms/deagle/ammo |
| 50aeap | 1750 | 60 | 29.1667 | 50ae | carbon: v3/ap-ammo/50aeap (barter 2:1) |
| 50aehp | 1750 | 60 | 29.1667 | 50ae | brass: v3/hp-ammo/50aehp (barter 2:1) |
| 57x28 | 850 | 60 | 14.1667 | 57x28 | brass: v3/regular-ammo/57x28; gasket: v3/sidearms/fiveseven/ammo; smartass: v3/nato-cqb/p90/ammo |
| 57x28ap | 850 | 60 | 14.1667 | 57x28 | carbon: v3/ap-ammo/57x28ap (barter 2:1) |
| 57x28hp | 850 | 60 | 14.1667 | 57x28 | brass: v3/hp-ammo/57x28hp (barter 2:1) |
| 127x55 | 2345 | 30 | 78.1667 | 127x55 | brass: v3/regular-ammo/127x55 |
| 145x114ap | 5360 | 60 | 89.3333 | 145x114 | carbon: v3/ap-ammo/145x114ap (barter 2:1) |
| 145x114hp | 5360 | 60 | 89.3333 | 145x114 | brass: v3/hp-ammo/145x114hp (barter 2:1) |
| 145x114 | 5360 | 30 | 178.6667 | 145x114 | brass: v3/regular-ammo/145x114 |
| 700nitro | 2345 | 16 | 146.5625 | 700nitro | brass: v3/regular-ammo/700nitro |
| 93x64 | 2345 | 30 | 78.1667 | 93x64 | brass: v3/regular-ammo/93x64 |
