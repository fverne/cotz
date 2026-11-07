# Authored ammunition progression

Generated with `python3 docs/npc-overhaul/tools/ammo_progression.py --write`.

`PLUGIN.regularAmmoChain` contains every regular load, excluding AP, HP and special shotgun variants.
The manually authored regularAmmoChain is authoritative; gun first-use data is informational only.
This report never rewrites equipment chains, calibre order or contact allocations.
Brass owns regular-calibre and HP branches; Carbon owns the AP branch.
Each HP milestone requires its matching regular milestone; AP requires the matching HP milestone at Brass.
HP and AP have no town cash sale routes. Exchanges consume two or three regular boxes respectively.
Boxes are measured using their standard round counts; partial stacks can be combined.
Brass also starts with buckshot and slugs; special loads unlock in TR, DT, MG order after regular buckshot.
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
| 22lrap | 450 | 60 | 7.5000 | 22lr | carbon: v3/ap-ammo/22lrap (barter 3:1) |
| 22lrhp | 450 | 60 | 7.5000 | 22lr | brass: v3/hp-ammo/22lrhp (barter 2:1) |
| 762x25 | 500 | 60 | 8.3333 | 762x25 | brass: ungated; gasket: ungated; haggler: ungated |
| 762x25ap | 500 | 60 | 8.3333 | 762x25 | carbon: v3/ap-ammo/762x25ap (barter 3:1) |
| 762x25hp | 500 | 60 | 8.3333 | 762x25 | brass: v3/hp-ammo/762x25hp (barter 2:1) |
| 45acp41 | 600 | 20 | 30.0000 | 45acp41 | brass: ungated; haggler: ungated |
| 9x19 | 750 | 60 | 12.5000 | 9x19 | brass: ungated; haggler: ungated |
| 9x19ap | 750 | 60 | 12.5000 | 9x19 | carbon: v3/ap-ammo/9x19ap (barter 3:1) |
| 9x19hp | 750 | 60 | 12.5000 | 9x19 | brass: v3/hp-ammo/9x19hp (barter 2:1) |
| 45acp | 950 | 60 | 15.8333 | 45acp | brass: ungated; gasket: ungated; haggler: ungated |
| 45acpap | 950 | 60 | 15.8333 | 45acp | carbon: v3/ap-ammo/45acpap (barter 3:1) |
| 45acphp | 950 | 60 | 15.8333 | 45acp | brass: v3/hp-ammo/45acphp (barter 2:1) |
| 545x39 | 1500 | 60 | 25.0000 | 545x39 | brass: v3/regular-ammo/545x39 |
| 545x39ap | 1500 | 60 | 25.0000 | 545x39 | carbon: v3/ap-ammo/545x39ap (barter 3:1) |
| 545x39hp | 1500 | 60 | 25.0000 | 545x39 | brass: v3/hp-ammo/545x39hp (barter 2:1) |
| 12gaugedt | 600 | 30 | 20.0000 | 12gauge | brass: v3/shotgun-loads/12gaugedt |
| 12gaugesg | 700 | 30 | 23.3333 | 12gauge | brass: ungated |
| 12gaugemg | 750 | 30 | 25.0000 | 12gauge | brass: v3/shotgun-loads/12gaugemg |
| 12gaugetr | 750 | 30 | 25.0000 | 12gauge | brass: v3/shotgun-loads/12gaugetr |
| 12gauge | 800 | 30 | 26.6667 | 12gauge | brass: ungated |
| 762x39 | 1700 | 60 | 28.3333 | 762x39 | brass: v3/regular-ammo/762x39 |
| 762x39ap | 1700 | 60 | 28.3333 | 762x39 | carbon: v3/ap-ammo/762x39ap (barter 3:1) |
| 762x39hp | 1700 | 60 | 28.3333 | 762x39 | brass: v3/hp-ammo/762x39hp (barter 2:1) |
| 556x45 | 1650 | 60 | 27.5000 | 556x45 | brass: v3/regular-ammo/556x45 |
| 556x45ap | 1650 | 60 | 27.5000 | 556x45 | carbon: v3/ap-ammo/556x45ap (barter 3:1) |
| 556x45hp | 1650 | 60 | 27.5000 | 556x45 | brass: v3/hp-ammo/556x45hp (barter 2:1) |
| 9x18 | 600 | 60 | 10.0000 | 9x18 | brass: ungated; gasket: ungated; haggler: ungated |
| 9x18ap | 600 | 60 | 10.0000 | 9x18 | carbon: v3/ap-ammo/9x18ap (barter 3:1) |
| 9x18hp | 600 | 60 | 10.0000 | 9x18 | brass: v3/hp-ammo/9x18hp (barter 2:1) |
| 762x54 | 2100 | 60 | 35.0000 | 762x54 | brass: v3/regular-ammo/762x54 |
| 762x54ap | 2100 | 60 | 35.0000 | 762x54 | carbon: v3/ap-ammo/762x54ap (barter 3:1) |
| 762x54hp | 2100 | 60 | 35.0000 | 762x54 | brass: v3/hp-ammo/762x54hp (barter 2:1) |
| 357magnum | 1000 | 60 | 16.6667 | 357magnum | brass: v3/regular-ammo/357magnum |
| 357magnumap | 1000 | 60 | 16.6667 | 357magnum | carbon: v3/ap-ammo/357magnumap (barter 3:1) |
| 357magnumhp | 1000 | 60 | 16.6667 | 357magnum | brass: v3/hp-ammo/357magnumhp (barter 2:1) |
| 9x39 | 1900 | 60 | 31.6667 | 9x39 | brass: v3/regular-ammo/9x39 |
| 9x39ap | 1900 | 60 | 31.6667 | 9x39 | carbon: v3/ap-ammo/9x39ap (barter 3:1) |
| 9x39hp | 1900 | 60 | 31.6667 | 9x39 | brass: v3/hp-ammo/9x39hp (barter 2:1) |
| 44magnum | 1000 | 60 | 16.6667 | 44magnum | brass: v3/regular-ammo/44magnum |
| 44magnumap | 1000 | 60 | 16.6667 | 44magnum | carbon: v3/ap-ammo/44magnumap (barter 3:1) |
| 44magnumhp | 1000 | 60 | 16.6667 | 44magnum | brass: v3/hp-ammo/44magnumhp (barter 2:1) |
| 9x21 | 750 | 60 | 12.5000 | 9x21 | brass: v3/regular-ammo/9x21 |
| 9x21ap | 750 | 60 | 12.5000 | 9x21 | carbon: v3/ap-ammo/9x21ap (barter 3:1) |
| 9x21hp | 750 | 60 | 12.5000 | 9x21 | brass: v3/hp-ammo/9x21hp (barter 2:1) |
| 762x51 | 1950 | 60 | 32.5000 | 762x51 | brass: v3/regular-ammo/762x51 |
| 762x51ap | 1950 | 60 | 32.5000 | 762x51 | carbon: v3/ap-ammo/762x51ap (barter 3:1) |
| 762x51hp | 1950 | 60 | 32.5000 | 762x51 | brass: v3/hp-ammo/762x51hp (barter 2:1) |
| 500magnum | 1000 | 30 | 33.3333 | 500magnum | brass: v3/regular-ammo/500magnum |
| 500magnumap | 1000 | 30 | 33.3333 | 500magnum | carbon: v3/ap-ammo/500magnumap (barter 3:1) |
| 500magnumhp | 1000 | 30 | 33.3333 | 500magnum | brass: v3/hp-ammo/500magnumhp (barter 2:1) |
| 338lapua | 3500 | 60 | 58.3333 | 338lapua | brass: v3/regular-ammo/338lapua |
| 338lapuaap | 3500 | 60 | 58.3333 | 338lapua | carbon: v3/ap-ammo/338lapuaap (barter 3:1) |
| 338lapuahp | 3500 | 60 | 58.3333 | 338lapua | brass: v3/hp-ammo/338lapuahp (barter 2:1) |
| 50ae | 1750 | 60 | 29.1667 | 50ae | brass: v3/regular-ammo/50ae |
| 50aeap | 1750 | 60 | 29.1667 | 50ae | carbon: v3/ap-ammo/50aeap (barter 3:1) |
| 50aehp | 1750 | 60 | 29.1667 | 50ae | brass: v3/hp-ammo/50aehp (barter 2:1) |
| 57x28 | 850 | 60 | 14.1667 | 57x28 | brass: v3/regular-ammo/57x28 |
| 57x28ap | 850 | 60 | 14.1667 | 57x28 | carbon: v3/ap-ammo/57x28ap (barter 3:1) |
| 57x28hp | 850 | 60 | 14.1667 | 57x28 | brass: v3/hp-ammo/57x28hp (barter 2:1) |
| 127x55 | 3500 | 30 | 116.6667 | 127x55 | brass: v3/regular-ammo/127x55 |
| 145x114ap | 8000 | 60 | 133.3333 | 145x114 | carbon: v3/ap-ammo/145x114ap (barter 3:1) |
| 145x114hp | 8000 | 60 | 133.3333 | 145x114 | brass: v3/hp-ammo/145x114hp (barter 2:1) |
| 145x114 | 8000 | 30 | 266.6667 | 145x114 | brass: v3/regular-ammo/145x114 |
| 700nitro | 3500 | 16 | 218.7500 | 700nitro | brass: v3/regular-ammo/700nitro |
| 93x64 | 3500 | 30 | 116.6667 | 93x64 | brass: v3/regular-ammo/93x64 |
